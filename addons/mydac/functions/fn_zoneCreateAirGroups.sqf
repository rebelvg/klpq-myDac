params ["_zone"];

private _conf = _zone getVariable ["md_var_zoneAirConf", []];
_conf params [["_groupsCount", 0], ["_groupCount", 0], ["_wpCount", 0]];

private _init = _zone getVariable ["md_var_zoneAirInit", []];
_init params [["_isEmpty", false]];

if (!_isEmpty) then {
    for "_i" from 1 to _groupsCount do
    {
        [_zone, _zone] call klpq_myDac_fnc_zoneCreateAirGroup;
    };
};

_zone setVariable ["md_var_airCampReady", true];

true
