params ["_object", "_textures"];

{
	_object setObjectTexture [_forEachIndex, _x];
} forEach _textures;
