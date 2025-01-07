params ["_startTrigger", "_destTrigger"];

private _conf = _destTrigger getVariable ["md_var_zoneInfConf", []];
_conf params [["_groupsCount", 0], ["_groupCount", 0], ["_wpCount", 0]];

private _inf = getArray (_destTrigger getVariable ["md_var_unitsConf", configNull] >> "infantry");
private _behavName = _destTrigger getVariable ["md_var_behavConfName", ""];
private _behav = (_destTrigger getVariable ["md_var_behavConf", configNull] >> "Infantry");

private _startPool = [_startTrigger, 1, 0, 1] call klpq_myDac_fnc_generateWaypoints;
private _wpPool = [_destTrigger, _wpCount, 0, 1] call klpq_myDac_fnc_generateWaypoints;

_group = [_startPool, _inf, _groupCount] call klpq_myDac_fnc_createGroup;

[_group, _behavName, "Infantry"] call klpq_myDac_fnc_applySkillType;

if (_startTrigger != _destTrigger) then {
    [_group, selectRandom _wpPool, 0, "MOVE", "AWARE", "YELLOW", "FULL"] call CBA_fnc_addWaypoint;
};

[_group, _wpCount, _wpPool, _behav] call klpq_myDac_fnc_generatePatrol;

_group setVariable ["md_var_isInfGroup", true];
_group setVariable ["md_var_groupBehavName", _behavName];

_destTrigger setVariable ["md_var_assignedGroups", ((_destTrigger getVariable ["md_var_assignedGroups", []]) + [_group])];

_group
