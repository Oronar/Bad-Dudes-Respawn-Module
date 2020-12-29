params ["_player"];

_minimumDistance = getNumber(getMissionConfig "BDRMConfig" >> "respawnDistanceMinimum");
_maximumDistance = getNumber(getMissionConfig "BDRMConfig" >> "respawnDistanceMaximum");
_aboveTerrainLevel = getNumber(getMissionConfig "BDRMConfig" >> "ParachuteRespawn" >> "aboveTerrainLevel");

_pos = call BDRM_fnc_getRespawnPosition;
_pos = [_pos, _minimumDistance, _maximumDistance] call BIS_fnc_findSafePos;


if (_aboveTerrainLevel == 0) then {
	_player setPos _pos;
} else {
	_parachuteVehicleType = getText(getMissionConfig "BDRMConfig" >> "ParachuteRespawn" >> "vehicleType");
	_chute = _parachuteVehicleType createVehicle _pos;
	[_chute, _aboveTerrainLevel, _pos, "ATL"] call BIS_fnc_setHeight;
	_player moveInAny _chute;
}
