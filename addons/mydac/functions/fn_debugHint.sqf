_zones = allMissionObjects "EmptyDetector" select {_x getVariable ["md_var_isZoneCreated", false]};
_camps = allMissionObjects "EmptyDetector" select {_x getVariable ["md_var_isCampCreated", false]};
_groups = allGroups select {{alive _x} count (units _x) > 0 && _x getVariable ["md_var_dynamicReady", false]};
_reducedGroups = allGroups select {{alive _x} count (units _x) > 0 && _x getVariable ["md_var_dynamicReady", false] && _x getVariable ["md_var_isGroupReduced", false]};
_builtGroups = allGroups select {{alive _x} count (units _x) > 0 && _x getVariable ["md_var_dynamicReady", false] && !(_x getVariable ["md_var_isGroupReduced", false])};

_text = [];

_text pushBack parseText "<t align='center'>MyDAC Debug Info</t><br/><br/>";

_text pushBack parseText "<t align='center'>----Zones----</t><br/>";

{
    _text pushBack format ["Zone %1, isEnabled - %2", _forEachIndex, _x getVariable ["md_var_isZoneEnabled", false]];
    _text pushBack parseText "<br/>";
    _text pushBack format ["Inf - %1, ", {{alive _x} count (units _x) > 0 && _x getVariable ["md_var_isInfGroup", false]} count (_x getVariable ["md_var_assignedGroups", []])];
    _text pushBack format ["Vehicles - %1", {alive _x} count (_x getVariable ["md_var_assignedVehicles", []])];
    _text pushBack parseText "<br/><br/>";
} forEach _zones;

_text pushBack parseText "<t align='center'>----Camps----</t><br/>";

{
    _text pushBack format ["Camp %1, isEnabled - %2", _forEachIndex, _x getVariable ["md_var_isCampEnabled", false]];
    _text pushBack parseText "<br/>";
    _text pushBack format ["Zones - %1, Respawns - %2", count (_x getVariable ["md_var_campZones", []]), _x getVariable ["md_var_respawns", []]];
    _text pushBack parseText "<br/><br/>";
} forEach _camps;

_text pushBack parseText "<t align='center'>----Groups----</t><br/>";

_text pushBack parseText format ["Dynamic Units - %1", {(group _x) getVariable ["md_var_dynamicReady", false]} count allUnits];
_text pushBack parseText "<br/>";
_text pushBack parseText format ["Dynamic Groups - %1", count _groups];
_text pushBack parseText "<br/>";
_text pushBack parseText format ["Reduced - %1", count _reducedGroups];
_text pushBack parseText "<br/>";
_text pushBack parseText format ["Built - %1", count _builtGroups];
_text pushBack parseText "<br/>";

//hintSilent composeText _text;

{
    _zoneMarker = format ["md_marker_zone_%1", _x];

    if !(_zoneMarker in allMapMarkers) then {
        createMarkerLocal [_zoneMarker, getPos _x];
    };

    (triggerArea _x) params ["_triggerX", "_triggerY", "_triggerAngle", "_triggerIsRectangle"];

    if (_triggerIsRectangle) then {
        _zoneMarker setMarkerShapeLocal "RECTANGLE";
    } else {
        _zoneMarker setMarkerShapeLocal "ELLIPSE";
    };

    _zoneMarker setMarkerBrushLocal "SolidBorder";

    _zoneMarker setMarkerSizeLocal [_triggerX, _triggerY];
    _zoneMarker setMarkerDirLocal _triggerAngle;

    if (_x getVariable ["md_var_isZoneEnabled", false]) then {
        _zoneMarker setMarkerColorLocal "ColorGreen";
    } else {
        _zoneMarker setMarkerColorLocal "ColorRed";
    };

    _zoneMarkerText = format ["md_marker_zoneText_%1", _x];

    if !(_zoneMarkerText in allMapMarkers) then {
        createMarkerLocal [_zoneMarkerText, getPos _x];
    };

    _zoneMarkerText setMarkerShapeLocal "ICON";
    _zoneMarkerText setMarkerTypeLocal "mil_circle";
    _zoneMarkerText setMarkerSizeLocal [1, 1];

    if (_x getVariable ["md_var_isZoneEnabled", false]) then {
        _zoneMarkerText setMarkerColorLocal "ColorGreen";
    } else {
        _zoneMarkerText setMarkerColorLocal "ColorRed";
    };

    _zoneMarkerText setMarkerTextLocal format ["Zone %1", _forEachIndex];
} forEach _zones;

{
    _camp = _x;
    _campMarker = format ["md_marker_camp_%1", _x];

    if !(_campMarker in allMapMarkers) then {
        createMarkerLocal [_campMarker, getPos _x];
    };

    (triggerArea _x) params ["_triggerX", "_triggerY", "_triggerAngle", "_triggerIsRectangle"];

    if (_triggerIsRectangle) then {
        _campMarker setMarkerShapeLocal "RECTANGLE";
    } else {
        _campMarker setMarkerShapeLocal "ELLIPSE";
    };

    _campMarker setMarkerBrushLocal "SolidBorder";

    _campMarker setMarkerSizeLocal [_triggerX, _triggerY];
    _campMarker setMarkerDirLocal _triggerAngle;

    if (_x getVariable ["md_var_isCampEnabled", false]) then {
        _campMarker setMarkerColorLocal "ColorGreen";
    } else {
        _campMarker setMarkerColorLocal "ColorRed";
    };

    _campMarkerText = format ["md_marker_campText_%1", _x];

    if !(_campMarkerText in allMapMarkers) then {
        createMarkerLocal [_campMarkerText, getPos _x];
    };

    _campMarkerText setMarkerShapeLocal "ICON";
    _campMarkerText setMarkerTypeLocal "mil_circle";
    _campMarkerText setMarkerSizeLocal [1, 1];

    if (_x getVariable ["md_var_isCampEnabled", false]) then {
        _campMarkerText setMarkerColorLocal "ColorGreen";
    } else {
        _campMarkerText setMarkerColorLocal "ColorRed";
    };

    _campMarkerText setMarkerTextLocal format ["Camp %1", _forEachIndex];

    {
        if (_x getVariable ["md_var_isZoneCreated", false]) then {
            _zoneConnectMarker = format ["md_marker_zoneConnect_%1_%2", _camp, _x];

            if !(_zoneConnectMarker in allMapMarkers) then {
                _midPos = [];

                _posCamp = getPos _camp;
                _posZone = getPos _x;

                _midPos set [0, ((_posCamp select 0) + (_posZone select 0)) / 2];
                _midPos set [1, ((_posCamp select 1) + (_posZone select 1)) / 2];

                createMarkerLocal [_zoneConnectMarker, _midPos];
            };

            _zoneConnectMarker setMarkerShapeLocal "RECTANGLE";
            _zoneConnectMarker setMarkerSizeLocal [(_camp distance2D _x) / 2, 5];
            _zoneConnectMarker setMarkerDirLocal (_camp getRelDir _x) + 90;

            if (_camp getVariable ["md_var_isCampEnabled", false]) then {
                _zoneConnectMarker setMarkerColorLocal "ColorGreen";
            } else {
                _zoneConnectMarker setMarkerColorLocal "ColorRed";
            };
        };
    } forEach (_x getVariable ["md_var_campZones", []]);
} forEach _camps;
