params ["_group", ["_wpCount", 0], ["_wpPool", []], ["_behavConf", configNull]];

_behavior = getArray (_behavConf >> "behavior");
_combatMode = getArray (_behavConf >> "combatMode");
_speed = getArray (_behavConf >> "speed");
_formation = getArray (_behavConf >> "formation");

if (count _wpPool == 0) exitWith {false};

{
    [_group, _x, 0, "MOVE", selectRandom _behavior, selectRandom _combatMode, selectRandom _speed, selectRandom _formation] call CBA_fnc_addWaypoint;
} forEach _wpPool;

[_group, selectRandom _wpPool, 0, "CYCLE"] call CBA_fnc_addWaypoint;

systemChat format ["%1: patrol generated.", _group];

true
