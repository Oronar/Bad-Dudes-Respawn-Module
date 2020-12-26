#include "..\constants.sqf";

params ["_vehicle", ["_initFunction", {}]];

_vehicle setVariable [BDRM_VEHICLE_RESPAWN_IS_REGISTERED, 1];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_STARTING_POSITION, getPos _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_STARTING_DIRECTION, direction _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_ITEM_CARGO, getItemCargo _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_MAGAZINE_CARGO, getMagazineCargo _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_WEAPON_CARGO, getWeaponCargo _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_BACKPACK_CARGO, getBackpackCargo _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_INIT_FUNCTION, _initFunction];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_UNMOVED, true];

_vehicle call _initFunction;

_invulnerabilitySafety = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "invulnerabilitySafety");

if(_invulnerabilitySafety == 1) then {
	[format ["(%1) Vehicle respawn invulnerability set.", typeOf _vehicle]] call BDRM_fnc_diag_log;
	_vehicle allowDamage false;
};

_killedEventHandler = {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	[format ["(%1) Respawn registered vehicle killed.", typeOf _unit]] call BDRM_fnc_diag_log;

	_unit spawn {
		_vehicleRespawnTimer = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnTime");
		[format ["(%1) Vehicle respawn timer triggered, %2 seconds.", typeOf _this, _vehicleRespawnTimer]] call BDRM_fnc_diag_log;
		sleep _vehicleRespawnTimer;
		[_this] call BDRM_fnc_respawnVehicle;
	};
};

_getInEventHandler = {
	params ["_vehicle", "_role", "_unit", "_turret"];

	_vehicle allowDamage true;
	_vehicle setVariable [BDRM_VEHICLE_RESPAWN_UNMOVED, false];

	[format ["(%1) Vehicle respawn invulnerability removed.", typeOf _vehicle]] call BDRM_fnc_diag_log;
};

_vehicle addEventHandler ["Killed", _killedEventHandler];
_vehicle addEventHandler ["GetIn", _getInEventHandler];

[format ["(%1) Vehicle registered for respawn.", typeOf _vehicle]] call BDRM_fnc_diag_log;