params ["_args", "_handle"];
_args params ["_camp"];

private _respawns = _camp getVariable ["md_var_respawns", []];
_respawns params [["_infRespawns", 0], ["_whlRespawns", 0], ["_trcRespawns", 0], ["_airRespawns", 0], ["_nvlRespawns", 0]];
_campRadius = _camp getVariable ["md_var_campRadius", 0];
_campZones = _camp getVariable ["md_var_campZones", []];

if ({_x > 0} count _respawns == 0) exitWith {};

if !(_camp getVariable ["md_var_isCampEnabled", false]) exitWith {};

if ({_x distance2d _camp < _campRadius} count allPlayers > 0) exitWith {};

_campZones = _campZones select {_x getVariable ["md_var_isZoneEnabled", false]};

{
    (_x getVariable ["md_var_zoneInfConf", []]) params [["_infGroupsCount", 0], ["_infGroupCount", 0], ["_infWpCount", 0]];
    (_x getVariable ["md_var_zoneWhlConf", []]) params [["_whlGroupsCount", 0], ["_whlGroupCount", 0], ["_whlWpCount", 0]];
    (_x getVariable ["md_var_zoneTrcConf", []]) params [["_trcGroupsCount", 0], ["_trcGroupCount", 0], ["_trcWpCount", 0]];
    (_x getVariable ["md_var_zoneAirConf", []]) params [["_airGroupsCount", 0], ["_airGroupCount", 0], ["_airWpCount", 0]];
    (_x getVariable ["md_var_zoneNvlConf", []]) params [["_nvlGroupsCount", 0], ["_nvlGroupCount", 0], ["_nvlWpCount", 0]];

    _assignedInfGroups = (_x getVariable ["md_var_assignedGroups", []]) select {_x getVariable ["md_var_isInfGroup", false]};
    _assignedWhlVehicles = (_x getVariable ["md_var_assignedVehicles", []]) select {_x getVariable ["md_var_isWhlVeh", false]};
    _assignedTrcVehicles = (_x getVariable ["md_var_assignedVehicles", []]) select {_x getVariable ["md_var_isTrcVeh", false]};
    _assignedAirVehicles = (_x getVariable ["md_var_assignedVehicles", []]) select {_x getVariable ["md_var_isAirVeh", false]};
    _assignedNvlVehicles = (_x getVariable ["md_var_assignedVehicles", []]) select {_x getVariable ["md_var_isNvlVeh", false]};

    if (_x getVariable ["md_var_infCampReady", false] && _infRespawns > 0 && {{alive _x} count units _x > 0} count _assignedInfGroups < _infGroupsCount) then {
        [_camp, _x] spawn klpq_myDac_fnc_zoneCreateInfGroup;

        _respawns set [0, _infRespawns - 1];

        systemChat format ["%1: Group respawned.", _camp];
    };

    if (_x getVariable ["md_var_whlCampReady", false] && _whlRespawns > 0 && {canMove _x && !isNull (driver _x)} count _assignedWhlVehicles < _whlGroupsCount) then {
        [_camp, _x] spawn klpq_myDac_fnc_zoneCreateWhlGroup;

        _respawns set [1, _whlRespawns - 1];

        systemChat format ["%1: Wheeled respawned.", _camp];
    };

    if (_x getVariable ["md_var_trcCampReady", false] && _trcRespawns > 0 && {canMove _x && !isNull (driver _x)} count _assignedTrcVehicles < _trcGroupsCount) then {
        [_camp, _x] spawn klpq_myDac_fnc_zoneCreateTrcGroup;

        _respawns set [2, _trcRespawns - 1];

        systemChat format ["%1: Armored respawned.", _camp];
    };

    if (_x getVariable ["md_var_airCampReady", false] && _airRespawns > 0 && {canMove _x && !isNull (driver _x)} count _assignedAirVehicles < _airGroupsCount) then {
        [_camp, _x] spawn klpq_myDac_fnc_zoneCreateAirGroup;

        _respawns set [3, _airRespawns - 1];

        systemChat format ["%1: Air respawned.", _camp];
    };

    if (_x getVariable ["md_var_nvlCampReady", false] && _nvlRespawns > 0 && {canMove _x && !isNull (driver _x)} count _assignedNvlVehicles < _nvlGroupsCount) then {
        [_camp, _x] spawn klpq_myDac_fnc_zoneCreateNvlGroup;

        _respawns set [4, _nvlRespawns - 1];

        systemChat format ["%1: Naval respawned.", _camp];
    };
} forEach _campZones;

_camp setVariable ["md_var_respawns", _respawns];
