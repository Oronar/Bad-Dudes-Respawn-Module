params ["_player", "_didJIP"];

[_player] call BDRM_fnc_savePlayerLoadout;
[_player] execVM "bdrm\scripts\addGetInManEventHandler.sqf";
