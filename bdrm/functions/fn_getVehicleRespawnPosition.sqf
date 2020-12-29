#include "..\constants.sqf";

params ["_vehicle"];

_useMarker = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "markerActive");

if (_useMarker == 0) exitWith {
	_vehicle getVariable BDRM_VEHICLE_RESPAWN_STARTING_POSITION;
};

_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnMarkerName");

if (getMarkerType _respawnMarkerName == "") exitWith {
	[format ["BDRM vehicle respawn marker %1 not found.", _respawnMarkerName]] call BDRM_fnc_diag_log;
	getPos _vehicle;
};

_minimumDistance = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnDistanceMinimum");
_maximumDistance = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnDistanceMaximum");
[getMarkerPos _respawnMarkerName, _minimumDistance, _maximumDistance] call BIS_fnc_findSafePos;
