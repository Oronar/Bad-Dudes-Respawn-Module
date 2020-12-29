spectatorEventHandler = {
	params ["_isSpectator", "_player"];
	
	if (!_isSpectator) then {
		[_player] call BDRM_fnc_respawnPlayer;
	}
};

["ace_spectatorSet", spectatorEventHandler] call CBA_fnc_addEventHandler;
