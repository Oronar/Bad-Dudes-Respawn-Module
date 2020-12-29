params ["_entity"];

_animationState = [];

{
	_animationState pushBack [_x, _entity animationPhase _x];
} forEach animationNames _entity;

_animationState;
