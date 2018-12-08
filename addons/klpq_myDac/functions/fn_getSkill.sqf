params [["_difficulty", ""], ["_type", ""], ["_subType", ""]];

private _behavConf = missionConfigFile >> "KLPQ_MyDAC" >> "Behavior" >> _difficulty;

private _internalBehavConf = configFile >> "KLPQ_MyDAC" >> "Behavior" >> _difficulty;

if (isClass _internalBehavConf) then {
    _behavConf = _internalBehavConf;
};

private _skillConf = configNull;

switch (_type) do {
    case "Infantry": {
        _skillConf = _behavConf >> _type >> "skill";
    };
    case "Vehicles": {
        _skillConf = _behavConf >> _type >> _subType >> "skill";
    };
};

getArray _skillConf
