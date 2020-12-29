params ["_vehicle", "_pylons"];

{
	_vehicle setPylonLoadout [_forEachIndex, _x];
} forEach _pylons;
