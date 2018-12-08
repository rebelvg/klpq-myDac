private _toDelete = allDead select {_x getVariable ["md_var_mdUnit", false]};

private _collectionTime = getNumber (missionConfigFile >> "KLPQ_MyDAC" >> "Settings" >> "garbageCollectionTime");
private _collectionRadius = getNumber (missionConfigFile >> "KLPQ_MyDAC" >> "Settings" >> "garbageCollectionRadius");

{
    _unit = _x;

    if ((CBA_missionTime - (_unit getVariable ["md_var_killedTime", 0])) > _collectionTime || {_x distance2d _unit < _collectionRadius} count allPlayers == 0) then {
        deleteVehicle _unit;
        systemChat format ["Deleted %1.", _unit];
    };
} forEach _toDelete;
