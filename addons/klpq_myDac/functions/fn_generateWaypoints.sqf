params ["_trigger", ["_waypointCount", 0], ["_water", 0], ["_radius", 3], ["_findRoads", false]];

private _waypoints = [];

private _i = 0;

while {_i < _waypointCount * 100 && count _waypoints < _waypointCount} do {
    private _randomPos = [_trigger] call BIS_fnc_randomPosTrigger;
    private _safePos = [];

    if (!_findRoads) then {
        _safePos = _randomPos isFlatEmpty [_radius, -1, -1, 1, _water, false];
    } else {
        private _roads = _randomPos nearRoads 50;

        if (count _roads != 0) then {
            _safePos = getPos (selectRandom _roads);
        };
    };

    if (count _safePos != 0) then {
        _safePos = _safePos select [0, 2];
        _waypoints pushBackUnique _safePos;
    };

    _i = _i + 1;

    sleep 0.016;
};

if (count _waypoints == 0) then {
    _waypoints pushBackUnique (getPos _trigger);
};

_waypoints
