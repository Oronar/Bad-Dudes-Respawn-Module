params ["_vehicle", "_pylons"];

{
	_vehicle setPylonLoadout [_forEachIndex + 1, _x];
} forEach _pylons;
