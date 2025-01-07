params ["_group"];

if !(_group getVariable ["md_var_isGroupReduced", false]) exitWith {false};
_group setVariable ["md_var_isGroupReduced", false];

_groupMembers = _group getVariable ["md_var_groupMembers", []];
_count = _group getVariable ["md_var_unitCount", 0];

if (count _groupMembers == 0) exitWith {true};

[_count, _group, _groupMembers] spawn {
    params ["_count", "_group", "_groupMembers"];

    private _behavName = _group getVariable ["md_var_groupBehavName", ""];

    for "_i" from 1 to _count do
    {
        sleep 0.3;

        private _pos = getPos leader _group;
        _groupMember = [(_pos getPos [3, random 360]), _group, selectRandom _groupMembers] call klpq_myDac_fnc_createUnit;
    };

    [_group, _behavName, "Infantry"] call klpq_myDac_fnc_applySkillType;

    systemChat format ["Group built up - %1.", _group];
};

true
