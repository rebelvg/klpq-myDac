{
    [_x] call {
        params ["_zone"];

        if !(_zone getVariable ["md_var_isZoneCreated", false]) exitWith {false};

        if !(_zone getVariable ["md_var_isZoneEnabled", false]) exitWith {false};
        _zone setVariable ["md_var_isZoneEnabled", false];

        {
            {
                deleteVehicle _x;
            } forEach (units _x);

            deleteGroup _x;
        } forEach (_zone getVariable ["md_var_assignedGroups", []]);

        {
            {
                deleteVehicle _x;
            } forEach (crew _x);

            deleteVehicle _x;
        } forEach (_zone getVariable ["md_var_assignedVehicles", []]);

        _zone setVariable ["md_var_assignedGroups", []];
        _zone setVariable ["md_var_assignedVehicles", []];

        _zone setVariable ["md_var_infCampReady", false];
        _zone setVariable ["md_var_whlCampReady", false];
        _zone setVariable ["md_var_trcCampReady", false];
        _zone setVariable ["md_var_airCampReady", false];
        _zone setVariable ["md_var_nvlCampReady", false];

        systemChat format ["%1: zone disabled.", _zone];
    };
} forEach _this;

true
