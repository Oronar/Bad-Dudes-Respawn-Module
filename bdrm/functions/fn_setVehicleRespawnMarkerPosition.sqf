params ["_newPos"];

_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnMarkerName");

if(getMarkerType _respawnMarkerName == "") exitWith {
	[format ["BDRM vehicle respawn marker %1 not found.", _respawnMarkerName]] call BDRM_fnc_diag_log;
};

_respawnMarkerName setMarkerPos _newPos;

_showRespawnNotification = getNumber(getMissionConfig "BDRMConfig" >> "showRespawnNotification");

if ( _showRespawnNotification == 1) then {
	["BDRMVehicleRespawn", []] remoteExec ["BIS_fnc_showNotification", 0];
};