params ["_loadout", "_vehicle"];
_loadout params ["_classes", "_amounts"];

clearBackpackCargoGlobal _vehicle;

for "_i" from 0 to count _classes -1 do {
	_vehicle addBackpackCargoGlobal [_classes select _i, _amounts select _i];
};
