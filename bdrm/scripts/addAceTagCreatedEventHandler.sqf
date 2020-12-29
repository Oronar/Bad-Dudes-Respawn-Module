addTagCreatedEventHandler = {
	params ["_tagObject", "_texture", "_tagAttachedTo", "_unitThatCreated"];

	_aceTaggingRespawnActive = getNumber(getMissionConfig "BDRMConfig" >> "ACETaggingRespawn" >> "active");

	if (_aceTaggingRespawnActive == 1) then {
		_aceTaggingTexture = getText(getMissionConfig "BDRMConfig" >> "ACETaggingRespawn" >> "respawnTexture");

		if (_texture find _aceTaggingTexture != -1) then {
			_newPos = getPos _tagObject;
			[format ["AceTagCreatedRespawn position update triggered", _newPos]] call BDRM_fnc_diag_log;
			[_newPos] call BDRM_fnc_setRespawnMarkerPosition
		};
	};	
};

["ace_tagCreated", addTagCreatedEventHandler] call CBA_fnc_addEventHandler;
