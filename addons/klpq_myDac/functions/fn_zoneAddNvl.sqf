_this spawn {
    params ["_zone", ["_conf", []], ["_init", []]];
    _init params [["_isEmpty", false]];

    waitUntil {time > 0};

    if !(_zone getVariable ["md_var_isZoneCreated", false]) exitWith {
        systemChat format ["%1: zone is not created.", _zone];
        false
    };

    if (count (_zone getVariable ["md_var_zoneNvlConf", []]) != 0) exitWith {
        systemChat format ["%1: naval already added.", _zone];
        false
    };

    _zone setVariable ["md_var_zoneNvlConf", _conf];
    _zone setVariable ["md_var_zoneNvlInit", _init];

    if !(_zone getVariable ["md_var_isZoneEnabled", false]) exitWith {true};

    [_zone] call klpq_myDac_fnc_zoneCreateNvlGroups;
};

true
