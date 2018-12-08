params ["_class"];
private ["_side"];

if (!isNumber (configFile >> "CfgVehicles" >> _class >> "side")) exitWith {
    sideEmpty
};

private _sideNumber = getNumber (configFile >> "CfgVehicles" >> _class >> "side");

switch (_sideNumber) do {
case 0: {
        _side = EAST;
    };
case 1: {
        _side = WEST;
    };
case 2: {
        _side = RESISTANCE;
    };
case 3: {
        _side = CIVILIAN;
    };
    default {
        _side = sideEmpty;
    };
};

_side
