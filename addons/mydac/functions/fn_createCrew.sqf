params ["_vehicle", "_driver", "_crew", ["_count", 0], ["_isAirCrew", false]];

_side = [_driver] call klpq_myDac_fnc_getSide;

if (_side == sideEmpty) exitWith {
    grpNull
};

private _grp = createGroup _side;
private _pos = getPos _vehicle;

if (_vehicle emptyPositions "driver" > 0) then
{
    _unit = [_pos, _grp, _driver] call klpq_myDac_fnc_createUnit;
    _unit moveInDriver _vehicle;
};

if (_vehicle emptyPositions "commander" > 0) then
{
    _unit = [_pos, _grp, _crew] call klpq_myDac_fnc_createUnit;
    _unit moveInCommander _vehicle;
};

if (_vehicle emptyPositions "gunner" > 0) then
{
    _unit = [_pos, _grp, _crew] call klpq_myDac_fnc_createUnit;
    _unit moveInGunner _vehicle;
};

{
    if (_forEachIndex < (_count min 1) * (count fullCrew [_vehicle, "turret", true])) then {
        _unit = [_pos, _grp, _crew] call klpq_myDac_fnc_createUnit;
        _unit moveInTurret [_vehicle, (_x select 3)];
    }
} forEach (fullCrew [_vehicle, "turret", true]);

{
    if (_forEachIndex < ((_count min 2) - 1) * (count fullCrew [_vehicle, "cargo", true])) then {
        _unit = [_pos, _grp, _crew] call klpq_myDac_fnc_createUnit;
        _unit moveInCargo _vehicle;
    }
} forEach (fullCrew [_vehicle, "cargo", true]);

if (_isAirCrew) then {
    {
        removeBackpack _x;
        _x addBackpack "B_Parachute";
    } forEach (units _grp);
};

systemChat format ["%1: crew created.", _grp];

_grp
