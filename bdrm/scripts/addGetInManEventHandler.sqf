params ["_player"];

_player addEventHandler ["GetInMan", {
	params ["_unit", "_role", "_vehicle", "_turret"];

	_vehicleTypeActionRespawnActive = getNumber(getMissionConfig "BDRMConfig" >> "EnterVehicleTypeRespawn" >> "active");
	if (_vehicleTypeActionRespawnActive == 1) then {
		_vehicleType = getText(getMissionConfig "BDRMConfig" >> "EnterVehicleTypeRespawn" >> "vehicleType");
		
		if (typeOf _vehicle == _vehicleType) then {
			_newPos = getPos _vehicle;
			[getPos _vehicle] call BDRM_fnc_setRespawnMarkerPosition;
			[format ["EnterVehicleTypeRespawn position update triggered"]] call BDRM_fnc_diag_log;
		};
	};
}];
