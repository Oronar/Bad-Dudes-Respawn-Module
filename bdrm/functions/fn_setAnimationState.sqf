params ["_entity", "_animationState"];

{
	_entity animate _x;
	diag_log str _x;
} forEach _animationState;
