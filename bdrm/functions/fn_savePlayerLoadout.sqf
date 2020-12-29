params ["_player"];

_loadoutVariableName = getText(getMissionConfig "BDRMConfig" >> "loadoutVariableName");
_player setVariable [_loadoutVariableName, getUnitLoadout _player];
