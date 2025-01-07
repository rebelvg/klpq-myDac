params ["_camp", ["_respawnsCount", 0]];

private _respawns = _camp getVariable ["md_var_respawns", []];
_respawns params [["_infRespawns", 0], ["_whlRespawns", 0], ["_trcRespawns", 0], ["_airRespawns", 0], ["_nvlRespawns", 0]];

_respawns set [3, _airRespawns + _respawnsCount];

_camp setVariable ["md_var_respawns", _respawns];
