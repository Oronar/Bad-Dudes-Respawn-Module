params ["_vehicle", ["_initFunction", {}]];

_vehicle setVariable ["isRegistered", 1];
_vehicle setVariable ["startingPostion", getPos _vehicle];
_vehicle setVariable ["startingDirection", direction _vehicle];
_vehicle setVariable ["itemCargo", getItemCargo _vehicle];
_vehicle setVariable ["magazineCargo", getMagazineCargo _vehicle];
_vehicle setVariable ["weaponCargo", getWeaponCargo _vehicle];
_vehicle setVariable ["backpackCargo", getBackpackCargo _vehicle];
_vehicle setVariable ["initFunction", _initFunction];

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