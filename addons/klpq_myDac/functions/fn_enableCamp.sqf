{
    [_x] call {
        params ["_camp"];

        if !(_camp getVariable ["md_var_isCampCreated", false]) exitWith {false};

        if (_camp getVariable ["md_var_isCampEnabled", false]) exitWith {false};
        _camp setVariable ["md_var_isCampEnabled", true];

        systemChat format ["%1: camp enabled.", _camp];
    };
} forEach _this;

true
