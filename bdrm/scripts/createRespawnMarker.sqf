_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "respawnMarkerName");
_sideRespawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "sideRespawnMarkerName");

if (getMarkerType _respawnMarkerName == "") then {
	[format ["Respawn marker/object %1 not found, creating at respawn position.", _respawnMarkerName]] call BDRM_fnc_diag_log;

	if (getMarkerType _sideRespawnMarkerName == "") then {
		[format ["Side respawn marker %1 not found.", _sideRespawnMarkerName]] call BDRM_fnc_diag_log;
	} else {
		createMarker [_respawnMarkerName, getMarkerPos _sideRespawnMarkerName];
		_respawnMarkerName setMarkerType "respawn_inf";
	};
};
