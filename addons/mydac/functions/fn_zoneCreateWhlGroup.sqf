params ["_startTrigger", "_destTrigger"];

private _conf = _destTrigger getVariable ["md_var_zoneWhlConf", []];
_conf params [["_groupsCount", 0], ["_groupCount", 0], ["_wpCount", 0]];

private _crew = getArray (_destTrigger getVariable ["md_var_unitsConf", configNull] >> "crew");
_crew params [["_crewUnit", ""], ["_pilotUnit", ""]];
private _pool = getArray (_destTrigger getVariable ["md_var_unitsConf", configNull] >> "wheeled");
private _behavName = _destTrigger getVariable ["md_var_behavConfName", ""];
private _behav = (_destTrigger getVariable ["md_var_behavConf", configNull] >> "Vehicles" >> "Wheeled");

private _startPool = [_startTrigger, 1, 0, 3, true] call klpq_myDac_fnc_generateWaypoints;
private _wpPool = [_destTrigger, _wpCount, 0, 3, true] call klpq_myDac_fnc_generateWaypoints;

_vehicle = [_startPool, _pool] call klpq_myDac_fnc_createVehicle;
_group = [_vehicle, _crewUnit, _crewUnit, _groupCount] call klpq_myDac_fnc_createCrew;

[_group, _behavName, "Vehicles", "Wheeled"] call klpq_myDac_fnc_applySkillType;

if (_startTrigger != _destTrigger) then {
    [_group, selectRandom _wpPool, 0, "MOVE", "AWARE", "YELLOW", "NORMAL"] call CBA_fnc_addWaypoint;
};

[_group, _wpCount, _wpPool, _behav] call klpq_myDac_fnc_generatePatrol;

_group setVariable ["md_var_isWhlCrew", true];
_vehicle setVariable ["md_var_isWhlVeh", true];

_vehicle setDir ((_vehicle getRelDir (_wpPool select 0)) + getDir _vehicle);

_destTrigger setVariable ["md_var_assignedGroups", ((_destTrigger getVariable ["md_var_assignedGroups", []]) + [_group])];
_destTrigger setVariable ["md_var_assignedVehicles", ((_destTrigger getVariable ["md_var_assignedVehicles", []]) + [_vehicle])];

_group
