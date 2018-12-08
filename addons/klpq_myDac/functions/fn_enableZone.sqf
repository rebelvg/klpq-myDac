{
    [_x] call {
        params ["_zone"];

        if !(_zone getVariable ["md_var_isZoneCreated", false]) exitWith {false};

        if (_zone getVariable ["md_var_isZoneEnabled", false]) exitWith {false};
        _zone setVariable ["md_var_isZoneEnabled", true];

        [_zone] spawn klpq_myDac_fnc_zoneCreateInfGroups;
        [_zone] spawn klpq_myDac_fnc_zoneCreateWhlGroups;
        [_zone] spawn klpq_myDac_fnc_zoneCreateTrcGroups;
        [_zone] spawn klpq_myDac_fnc_zoneCreateAirGroups;
        [_zone] spawn klpq_myDac_fnc_zoneCreateNvlGroups;

        systemChat format ["%1: zone enabled.", _zone];
    };
} forEach _this;

true
