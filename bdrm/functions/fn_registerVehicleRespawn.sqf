#include "..\constants.sqf";

params ["_vehicle", ["_initFunction", {}]];

_vehicle setVariable [BDRM_VEHICLE_RESPAWN_IS_REGISTERED, 1];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_STARTING_POSITION, getPos _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_STARTING_DIRECTION, direction _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_ITEM_CARGO, getItemCargo _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_MAGAZINE_CARGO, getMagazineCargo _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_WEAPON_CARGO, getWeaponCargo _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_BACKPACK_CARGO, getBackpackCargo _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_ANIMATION_STATE, [_vehicle] call BDRM_fnc_getAnimationState];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_TEXTURES, getObjectTextures _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_PYLONS, getPylonMagazines _vehicle];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_INIT_FUNCTION, _initFunction];
_vehicle setVariable [BDRM_VEHICLE_RESPAWN_UNMOVED, true];

_vehicle call _initFunction;

_invulnerabilitySafety = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "invulnerabilitySafety");

if (_invulnerabilitySafety == 1) then {
	[format ["(%1) Vehicle respawn invulnerability set.", typeOf _vehicle]] call BDRM_fnc_diag_log;
	_vehicle allowDamage false;
};

_killedEventHandler = {
	params ["_unit", "_killer", "_instigator", "_useEffects"];

	[format ["(%1) Respawn registered vehicle killed.", typeOf _unit]] call BDRM_fnc_diag_log;
	[_unit] remoteExec ["BDRM_fnc_respawnVehicle", 2];
};

_getInEventHandler = {
	params ["_vehicle", "_role", "_unit", "_turret"];

	_vehicle allowDamage true;
	_vehicle setVariable [BDRM_VEHICLE_RESPAWN_UNMOVED, false];

	[format ["(%1) Vehicle respawn invulnerability removed.", typeOf _vehicle]] call BDRM_fnc_diag_log;
};

_addAbandonAction = {
	params ["_vehicle"];

	_abandonVehicle = {
		params ["_target", "_player", "_params"];

		if (count crew _target == 0) then {
			_target setVariable ["ace_cookoff_enableAmmoCookoff", false, true];
			_target setVariable [BDRM_VEHICLE_RESPAWN_UNMOVED, false];
			_target allowDamage true;
			_target setDamage [1, false];
		};
	};

	_interactMenu = ["Abandon", "Abandon", "", {}, {true}] call ace_interact_menu_fnc_createAction;
	_interactionAction = ["AbandonVehicle", "Abandon Vehicle", "", _abandonVehicle, {true}] call ace_interact_menu_fnc_createAction;
	[_vehicle, 0, ["ACE_MainActions"], _interactMenu] call ace_interact_menu_fnc_addActionToObject;
	[_vehicle, 0, ["ACE_MainActions", "Abandon"], _interactionAction] call ace_interact_menu_fnc_addActionToObject;
};

_vehicle addEventHandler ["Killed", _killedEventHandler];
_vehicle addEventHandler ["GetIn", _getInEventHandler];
_vehicle call _addAbandonAction;

[format ["(%1) Vehicle registered for respawn.", typeOf _vehicle]] call BDRM_fnc_diag_log;
