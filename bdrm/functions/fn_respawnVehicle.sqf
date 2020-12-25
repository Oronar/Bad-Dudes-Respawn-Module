params ["_originalVehicle"];

_minimumWreckDistance = 100;
_deleteWrecks = 0;

_isRegistered = _originalVehicle getVariable ["isRegistered", 0];

if (_isRegistered == 0) exitWith {
	 [format ["(%1) Unable to respawn vehicle, vehicle not registered for respawn", typeOf _originalVehicle]] call BDRM_fnc_diag_log;
};

_respawnPostion = _originalVehicle getVariable "startingPostion";
_respawnDirection = _originalVehicle getVariable "startingDirection";
_itemCargo = _originalVehicle getVariable "itemCargo";
_magazineCargo = _originalVehicle getVariable "magazineCargo";
_weaponCargo = _originalVehicle getVariable "weaponCargo";
_backpackCargo = _originalVehicle getVariable "backpackCargo";
_initFunction = _originalVehicle getVariable "initFunction";

_vehicleType = typeOf _originalVehicle;
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
["TaskSucceeded", ["","Vehicle Respawned Temp Msg"]] remoteExec ["BIS_fnc_showNotification", 0];
