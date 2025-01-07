params ["_class"];
private ["_side"];

if (!isNumber (configFile >> "CfgVehicles" >> _class >> "side")) exitWith {
    sideEmpty
};

private _sideNumber = getNumber (configFile >> "CfgVehicles" >> _class >> "side");

switch (_sideNumber) do {
case 0: {
        _side = "east";
    };
case 1: {
        _side = "west";
    };
case 2: {
        _side = "resistance";
    };
case 3: {
        _side = "civilian";
    };
    default {
        _side = sideEmpty;
    };
};

_side
