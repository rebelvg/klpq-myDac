params ["_pos", "_grp", "_class"];

if !(isClass (configFile >> "CfgVehicles" >> _class)) exitWith {
    systemChat format ["%1 - Class doesn't exist.", _class];
    objNull
};

private _unit = _grp createUnit [_class, _pos, [], 0, "NONE"];

_unit setVariable ["md_var_mdUnit", true];

_unit addEventHandler ["killed", {
    params ["_unit"];

    _unit setVariable ["md_var_killedTime", CBA_missionTime];
}];

_unit
