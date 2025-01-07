if (!isServer) exitWith {};

[{[] spawn klpq_myDac_fnc_dynamicLoop}, 10, []] call CBA_fnc_addPerFrameHandler;
[{[] spawn klpq_myDac_fnc_garbageCollectionLoop}, 30, []] call CBA_fnc_addPerFrameHandler;

if (!hasInterface) exitWith {};

if (klpq_myDac_enableDebugHint) then {
    [{[] spawn klpq_myDac_fnc_debugHint}, 1, []] call CBA_fnc_addPerFrameHandler;
};
