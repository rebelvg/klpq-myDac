params ["_zoneTrigger", ["_zoneInit", []], ["_zoneConf", []]];
_zoneInit params [["_isZoneEnabled", false]];
_zoneConf params [["_unitsConf", ""], ["_behavConf", ""]];

if (typeOf _zoneTrigger find "EmptyDetector" != 0) exitWith {
    systemChat format ["%1: not a trigger.", _zoneTrigger];
    false
};

if (_zoneTrigger getVariable ["md_var_isZoneCreated", false]) exitWith {
    systemChat format ["%1: zone already created.", _zoneTrigger];
    false
};

if !(isClass (missionConfigFile >> "KLPQ_MyDAC" >> "Units" >> _unitsConf)) exitWith {
    systemChat format ["%1: units config %2 not found.", _zoneTrigger, _unitsConf];
    false
};

if !(isClass (missionConfigFile >> "KLPQ_MyDAC" >> "Behavior" >> _behavConf)) exitWith {
    systemChat format ["%1: behavior config %2 not found.", _zoneTrigger, _behavConf];
    false
};

_zoneTrigger setVariable ["md_var_isZoneCreated", true];
_zoneTrigger setVariable ["md_var_isZoneEnabled", _isZoneEnabled];

_zoneTrigger setVariable ["md_var_unitsConf", missionConfigFile >> "KLPQ_MyDAC" >> "Units" >> _unitsConf];
_zoneTrigger setVariable ["md_var_behavConfName", _behavConf];
_zoneTrigger setVariable ["md_var_behavConf", missionConfigFile >> "KLPQ_MyDAC" >> "Behavior" >> _behavConf];

systemChat format ["%1: zone is ready.", _zoneTrigger];

true
