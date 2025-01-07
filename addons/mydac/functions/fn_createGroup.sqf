params [["_wpPool", []], ["_infPool", []], ["_count", 0]];
_infPool params [["_leaderUnit", ""]];

if (count _wpPool == 0) exitWith {
    grpNull
};

if (count _infPool < 2) exitWith {
    grpNull
};

private _groupMembers = _infPool select [1, count _infPool];

private _side = [_leaderUnit] call klpq_myDac_fnc_getSide;

if (_side == sideEmpty) exitWith {
    grpNull
};

private _startPos = selectRandom _wpPool;

private _grp = createGroup _side;
[_startPos, _grp, _leaderUnit] call klpq_myDac_fnc_createUnit;

_grp setVariable ["md_var_groupMembers", _groupMembers];
_grp setVariable ["md_var_unitCount", _count];
_grp setVariable ["md_var_dynamicReady", true];

_grp setVariable ["md_var_isGroupReduced", true];

systemChat format ["%1: group created.", _grp];

_grp
