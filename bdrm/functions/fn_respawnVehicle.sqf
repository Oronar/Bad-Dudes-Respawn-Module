#include "..\constants.sqf";

params ["_originalVehicle"];

_minimumWreckDistance = 100;
_deleteWrecks = 0;

_isRegistered = _originalVehicle getVariable [BDRM_VEHICLE_RESPAWN_IS_REGISTERED, 0];
_vehicleType = typeOf _originalVehicle;

if (_isRegistered == 0) exitWith {
	 [format ["(%1) Unable to respawn vehicle, vehicle not registered for respawn", _vehicleType]] call BDRM_fnc_diag_log;
};

_respawnPostion = [_originalVehicle] call BDRM_fnc_getVehicleRespawnPosition;
_respawnDirection = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_STARTING_DIRECTION;
_itemCargo = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_ITEM_CARGO;
_magazineCargo = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_MAGAZINE_CARGO;
_weaponCargo = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_WEAPON_CARGO;
_backpackCargo = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_BACKPACK_CARGO;
_initFunction = _originalVehicle getVariable BDRM_VEHICLE_RESPAWN_INIT_FUNCTION;

_vehicleName = getText (configFile >> "cfgVehicles" >> _vehicleType >> "displayName");
_wreckInRespawnRange = _respawnPostion distance getPos _originalVehicle < _minimumWreckDistance;

if (_deleteWrecks == 1 or _wreckInRespawnRange) then {
	[format ["(%1) Removing respawn vehicle wreckage.", _vehicleType]] call BDRM_fnc_diag_log;
	deleteVehicle _originalVehicle;
};

if (_wreckInRespawnRange) then {
	sleep 5; // Add an additional 5 seconds to avoid secondary explosions
	// TODO: Replace with invulnerability?
};

_newVehicle = createVehicle [_vehicleType, _respawnPostion];
_newVehicle setPos _respawnPostion;
_newVehicle setDir _respawnDirection;

[_itemcargo, _newVehicle] call BDRM_fnc_setItemCargoGlobal;
[_weaponCargo, _newVehicle] call BDRM_fnc_setWeaponCargoGlobal;
[_magazineCargo, _newVehicle] call BDRM_fnc_setMagazineCargoGlobal;
[_backpackCargo, _newVehicle] call BDRM_fnc_setBackpackCargoGlobal;

[_newVehicle, _initFunction] call BDRM_fnc_registerVehicleRespawn;

[format ["(%1) Vehicle respawned.", _vehicleType]] call BDRM_fnc_diag_log;

_showRespawnNotification = getNumber(getMissionConfig "BDRMConfig" >> "showRespawnNotification");

if ( _showRespawnNotification == 1) then {
	["BDRMVehicleRespawn", [_vehicleName]] remoteExec ["BIS_fnc_showNotification", 0];
};
