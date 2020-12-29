#include "..\constants.sqf";

params ["_newPos"];

_respawnMarkerName = getText(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnMarkerName");

if (getMarkerType _respawnMarkerName == "") exitWith {
	[format ["BDRM vehicle respawn marker %1 not found.", _respawnMarkerName]] call BDRM_fnc_diag_log;
};

_respawnMarkerName setMarkerPos _newPos;

[format ["Vehicle respawn position update (%1)", _newPos]] call BDRM_fnc_diag_log;

_respawnOnMarkerPositionUpdate = getNumber(getMissionConfig "BDRMConfig" >> "VehicleRespawn" >> "respawnOnMarkerPositionUpdate");

if (_respawnOnMarkerPositionUpdate == 1) then {
	{
		_isUntouched = _x getVariable [BDRM_VEHICLE_RESPAWN_UNMOVED, false] && alive _x;

		if (_isUntouched) then {
			[format ["(%1) Respawn vehicle due to marker position update", _respawnMarkerName]] call BDRM_fnc_diag_log;
			[_x, true, true] remoteExec ["BDRM_fnc_respawnVehicle", 2];
		};
	} forEach vehicles;
};

_showRespawnNotification = getNumber(getMissionConfig "BDRMConfig" >> "showRespawnNotification");

if (_showRespawnNotification == 1) then {
	["BDRMVehicleRespawn", []] remoteExec ["BIS_fnc_showNotification", 0];
};
