private _isReduceEnabled = getNumber (missionConfigFile >> "KLPQ_MyDAC" >> "Settings" >> "isReduceEnabled");

private _dynamicGroups = allGroups select {_x getVariable ["md_var_dynamicReady", false] && {alive _x} count (units _x) > 0};

private _reduceDistance = getNumber (missionConfigFile >> "KLPQ_MyDAC" >> "Settings" >> "reduceDistance");

{
    _group = _x;

    if ({leader _group distance2d _x < _reduceDistance} count allPlayers > 0 || _isReduceEnabled == 0) then {
        [_group] call klpq_myDac_fnc_buildGroup;
    } else {
        [_group] call klpq_myDac_fnc_reduceGroup;
    };
} forEach _dynamicGroups;
