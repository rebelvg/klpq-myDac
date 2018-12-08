params ["_group", "_difficulty", "_type", ["_subtype", ""]];

private _skill = [_difficulty, _type, _subtype] call klpq_myDac_fnc_getSkill;

private _return = [_group, _skill] call klpq_myDac_fnc_applySkill;

_return
