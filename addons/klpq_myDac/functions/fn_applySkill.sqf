params ["_group", "_skill"];

if !(_skill params [["_aimingAccuracy", []], ["_aimingShake", []], ["_aimingSpeed", []], ["_endurance", []], ["_spotDistance", []], ["_spotTime", []], ["_courage", []], ["_reloadSpeed", []], ["_commanding", []], ["_general", []]]) exitWith {false};

{
    _x setSkill ["aimingAccuracy", _aimingAccuracy call BIS_fnc_randomNum];
    _x setSkill ["aimingShake", _aimingShake call BIS_fnc_randomNum];
    _x setSkill ["aimingSpeed", _aimingSpeed call BIS_fnc_randomNum];
    _x setSkill ["endurance", _endurance call BIS_fnc_randomNum];
    _x setSkill ["spotDistance", _spotDistance call BIS_fnc_randomNum];
    _x setSkill ["spotTime", _spotTime call BIS_fnc_randomNum];
    _x setSkill ["courage", _courage call BIS_fnc_randomNum];
    _x setSkill ["reloadSpeed", _reloadSpeed call BIS_fnc_randomNum];
    _x setSkill ["commanding", _commanding call BIS_fnc_randomNum];
    _x setSkill ["general", _general call BIS_fnc_randomNum];

    _x allowFleeing 0;
} forEach (units _group);

systemChat format ["%1: skill applied.", _group];

true
