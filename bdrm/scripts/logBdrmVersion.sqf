_bdrmVersion = getText(getMissionConfig "BDRMConfig" >> "version");

[format ["BDRM Version: %1", _bdrmVersion]] call BDRM_fnc_diag_log;