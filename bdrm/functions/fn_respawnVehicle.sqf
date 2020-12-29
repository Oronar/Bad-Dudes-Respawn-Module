#include "..\constants.sqf";

params ["_originalVehicle", ["_forceWreckDeletion", false], ["_suppressNotifications", false]];

if (!isServer) exitWith {};

_isRegistered = _originalVehicle getVariable [BDRM_VEHICLE_RESPAWN_IS_REGISTERED, 0];
_vehicleType = typeOf _originalVehicle;

if (_isRegistered == 0) exitWith {
	 [format ["(%1) Unable to respawn vehicle, vehicle not registered for respawn", _vehicleType]] call BDRM_fnc_diag_log;
};

_vehicleRespawnTimer = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnTime");
[format ["(%1) Vehicle respawn timer triggered, %2 seconds.", _vehicleType, _vehicleRespawnTimer]] call BDRM_fnc_diag_log;
sleep _vehicleRespawnTimer;

_respawnPostion = [_originalVehicle] call BDRM_fnc_getVehicleRespawnPosition;
_respawnDirection = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_STARTING_DIRECTION;
_itemCargo = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_ITEM_CARGO;
_magazineCargo = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_MAGAZINE_CARGO;
_weaponCargo = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_WEAPON_CARGO;
_backpackCargo = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_BACKPACK_CARGO;
_animationState = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_ANIMATION_STATE;
_textures = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_TEXTURES;
_pylons = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_PYLONS;
_initFunction = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_INIT_FUNCTION;

_vehicleName = getText (configFile >> "cfgVehicles" >> _vehicleType >> "displayName");
_deleteWrecks = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "deleteWrecks");
_wreckInRespawnRange = _respawnPostion distance getPos _originalVehicle < BDRM_VEHICLE_RESPAWN_MIN_WRECK_DISTANCE;

if (_deleteWrecks == 1 or _wreckInRespawnRange or _forceWreckDeletion) then {
	[format ["(%1) Removing respawn vehicle wreckage.", _vehicleType]] call BDRM_fnc_diag_log;
	deleteVehicle _originalVehicle;
};

_newVehicle = createVehicle [_vehicleType, _respawnPostion];
_newVehicle setPos _respawnPostion;
_newVehicle setDir _respawnDirection;

[_itemcargo, _newVehicle] call BDRM_fnc_setItemCargoGlobal;
[_weaponCargo, _newVehicle] call BDRM_fnc_setWeaponCargoGlobal;
[_magazineCargo, _newVehicle] call BDRM_fnc_setMagazineCargoGlobal;
[_backpackCargo, _newVehicle] call BDRM_fnc_setBackpackCargoGlobal;

[_newVehicle, _animationState] call BDRM_fnc_setAnimationState;
[_newVehicle, _textures] remoteExec ["BDRM_fnc_setObjectTextures", 0, true];
[_newVehicle, _pylons] remoteExec ["BDRM_fnc_setPylonState", 0, true];

[_newVehicle, _initFunction] remoteExec ["BDRM_fnc_registerVehicleRespawn", 0, true];

[format ["(%1) Vehicle respawned.", _vehicleType]] call BDRM_fnc_diag_log;

_showRespawnNotification = getNumber(getMissionConfig "BDRMConfig" >> "showRespawnNotification");

if (_showRespawnNotification == 1 && !_suppressNotifications) then {
	["BDRMVehicleRespawned", [_vehicleName]] remoteExec ["BIS_fnc_showNotification", 0];
};
