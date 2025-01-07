params ["_campTrigger", ["_campInit", []], ["_campConf", []], ["_campZones", []]];
_campInit params [["_isCampEnabled", false], ["_campRadius", 150], ["_respawnTimeout", 20]];

if (typeOf _campTrigger find "EmptyDetector" != 0) exitWith {
    systemChat format ["%1: not a trigger.", _campTrigger];
    false
};

if (_campTrigger getVariable ["md_var_isCampCreated", false]) exitWith {
    systemChat format ["%1: camp already created.", _campTrigger];
    false
};

_campTrigger setVariable ["md_var_isCampCreated", true];
_campTrigger setVariable ["md_var_respawns", _campConf];
_campTrigger setVariable ["md_var_campZones", _campZones];

_campTrigger setVariable ["md_var_isCampEnabled", _isCampEnabled];
_campTrigger setVariable ["md_var_campRadius", _campRadius];

[klpq_myDac_fnc_campLoop, _respawnTimeout, [_campTrigger]] call CBA_fnc_addPerFrameHandler;

systemChat format ["%1: camp is ready.", _campTrigger];

true
