private _respawnPosition = nil;

_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "respawnMarkerName");
_respawnObject = missionNamespace getVariable [_respawnMarkerName , objNull];

if (not isNull _respawnObject ) then {
   _respawnPosition = getPos _respawnObject;
} else {
	if (getMarkerType _respawnMarkerName != "") then {
		_respawnPosition = getMarkerPos _respawnMarkerName;
	} else {		
		[format ["BDRM respawn marker/object %1 not found", _respawnMarkerName]] call BDRM_fnc_diag_log;
	};
};

_respawnPosition
