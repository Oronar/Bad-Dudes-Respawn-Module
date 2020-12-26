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

_vehicle call _initFunction;

_killedEventHandler = {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	[format ["(%1) Respawn registered vehicle killed.", typeOf _unit]] call BDRM_fnc_diag_log;

	_unit spawn {
		sleep 5; // Respawn time
		[_this] call BDRM_fnc_respawnVehicle;
	};
};

_vehicle addEventHandler ["Killed", _killedEventHandler];

[format ["(%1) Vehicle registered for respawn.", typeOf _vehicle]] call BDRM_fnc_diag_log;