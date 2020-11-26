params ["_object", ["_actionText", "Claim flag"], ["_radius", 25]];

setMarkerPosition = {
	params ["_target", "_caller", "_actionId", "_arguments"];

	_newPos = getPos _target;
	[_newPos] call BDRM_fnc_setRespawnMarkerPosition;
	[format ["ObjectActionRespawn position update triggered", _newPos]] call BDRM_fnc_diag_log;
};

_object addAction [_actionText,
	setMarkerPosition,
	nil,     // arguments
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