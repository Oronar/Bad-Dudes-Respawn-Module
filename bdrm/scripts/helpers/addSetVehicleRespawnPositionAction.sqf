#include "..\..\constants.sqf";

params ["_object", "_position", ["_actionText", "Claim vehicle depot"], ["_radius", 25], ["_flagTexture", ""]];

setMarkerPosition = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_position", "_flagTexture"];

	_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnMarkerName");

	if (_position distance getMarkerPos _respawnMarkerName < BDRM_RESPAWN_SET_POSITION_MIN_DELTA) exitWith {
		["ObjectActionVehicleRespawn position update aborted due to minimum distance delta."] call BDRM_fnc_diag_log;
	};

	[_position] call BDRM_fnc_setVehicleRespawnMarkerPosition;
	[format ["ObjectActionVehicleRespawn position update triggered", _position]] call BDRM_fnc_diag_log;

	if (_flagTexture != "") then {
		_target forceFlagTexture _flagTexture;
	};
};

_eventArguments = [_position, _flagTexture];

_object addAction [_actionText,
	setMarkerPosition,
	_eventArguments,
	1.5,     // priority
	true,    // showWindow
	true,    // hideOnUse
	"",      // shortcut
	"true",  // condition
	_radius, // radius
	false,   // unconscious
	"",      // selection
	""       // memoryPoint
];
