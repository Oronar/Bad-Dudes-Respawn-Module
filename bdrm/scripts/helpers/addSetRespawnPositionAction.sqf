params ["_object", ["_actionText", "Claim flag"], ["_radius", 25], ["_flagTexture", ""]];

setMarkerPosition = {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_flagTexture"];

	_newPos = getPos _target;
	[_newPos] call BDRM_fnc_setRespawnMarkerPosition;
	[format ["ObjectActionRespawn position update triggered", _newPos]] call BDRM_fnc_diag_log;

	if (_flagTexture != "") then {
		_target forceFlagTexture _flagTexture;
	};
};

_eventArguments = [_flagTexture];

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