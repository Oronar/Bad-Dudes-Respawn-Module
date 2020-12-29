params ["_newPos"];

_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "respawnMarkerName");

if (getMarkerType _respawnMarkerName != "") then {
	[format ["Respawn position update (%1)", _newPos]] call BDRM_fnc_diag_log;
	_respawnMarkerName setMarkerPos _newPos;

	_showRespawnNotification = getNumber(getMissionConfig "BDRMConfig" >> "showRespawnNotification");

	if (_showRespawnNotification == 1) then {
		["BDRMRespawn", []] remoteExec ["BIS_fnc_showNotification", 0];
	};
} else {		
	[format ["Respawn marker/object %1 not found", _respawnMarkerName]] call BDRM_fnc_diag_log;
}
