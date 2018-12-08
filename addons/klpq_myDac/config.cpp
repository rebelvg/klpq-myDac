class CfgPatches
{
    class klpq_myDac
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1;
        requiredAddons[] = {};
        version = "1.0.0";
        name = "KLPQ MyDAC";
        author = "KLPQ";
        url = "http://arma.klpq.men/";
    };
};

class CfgFunctions
{
    class klpq_myDac
    {
        #include "CfgFunctions.hpp"
    };
};

class KLPQ_MyDAC {
    class Behavior {
        class NORMAL {
            class Infantry {
                //"aimingAccuracy", "aimingShake", "aimingSpeed", "endurance", "spotDistance", "spotTime", "courage", "reloadSpeed", "commanding", "general"
                skill[] = {{0.01, 0.01}, {0.01, 0.01}, {0.01, 0.01}, {0.3, 0.3}, {0.1, 0.1}, {0.1, 0.1}, {0.5, 0.5}, {0.1, 0.1}, {0.5, 0.5}, {0.3, 0.3}};
            };

            class Vehicles {
                class Wheeled {
                    skill[] = {{0.01, 0.01}, {0.01, 0.01}, {0.01, 0.01}, {0.3, 0.3}, {0.1, 0.1}, {0.1, 0.1}, {0.5, 0.5}, {0.1, 0.1}, {0.5, 0.5}, {0.3, 0.3}};
                };
                class Armored: Wheeled {};
                class Air: Wheeled {};
                class Naval: Wheeled {};
            };
        };

        class LOW: NORMAL {};

        class HIGH: NORMAL {};
    };
};
