params [["_wpPool", []], ["_vehPool", []], ["_isFlying", false]];

if (count _wpPool == 0) exitWith {
    objNull
};

if (count _vehPool == 0) exitWith {
    objNull
};

private _startPos = selectRandom _wpPool;

private _vehicleClass = selectRandom _vehPool;

if !(isClass (configFile >> "CfgVehicles" >> _vehicleClass)) exitWith {
    systemChat format ["%1 - Class doesn't exist.", _vehicleClass];
    objNull
};

private _state = ["FORM", "FLY"] select _isFlying;
private _radius = [0, 100] select _isFlying;

private _vehicle = createVehicle [_vehicleClass, _startPos, [], _radius, _state];

if (_isFlying) then {
    _vehicle flyInHeight (selectRandom [100, 150]);
};

systemChat format ["%1: vehicle created.", typeOf _vehicle];

_vehicle
