params ["_player"];

_loadoutVariableName = getText(getMissionConfig "BDRMConfig" >> "loadoutVariableName");
_player setUnitLoadout (_player getVariable [_loadoutVariableName, []]);
