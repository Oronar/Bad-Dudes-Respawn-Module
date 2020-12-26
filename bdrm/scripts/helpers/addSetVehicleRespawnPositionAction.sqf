params ["_object", "_position", ["_actionText", "Claim vehicle depot"], ["_radius", 25], ["_flagTexture", ""]];

setMarkerPosition = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_position", "_flagTexture"];

	[_position] call BDRM_fnc_setVehicleRespawnMarkerPosition;
	[format ["ObjectActionVehicleRespawn position update triggered", _position]] call BDRM_fnc_diag_log;

	if (_flagTexture != "") then {
		_target forceFlagTexture _flagTexture;
	};

	_target removeAction _actionId;
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