params ["_group"];

if (_group getVariable ["md_var_isGroupReduced", false]) exitWith {false};
_group setVariable ["md_var_isGroupReduced", true];

_units = units _group;
_leader = leader _group;

{
    deleteVehicle _x;
} forEach (_units - [_leader]);

systemChat format ["Group reduced - %1.", _group];

true
