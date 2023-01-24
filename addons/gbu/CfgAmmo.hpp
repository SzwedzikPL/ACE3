class CfgAmmo {
    class Bo_GBU12_LGB;
    class GVAR(12): Bo_GBU12_LGB {
        maneuvrability = 0; // no maneuvrability so that default guidance doesnt work
        airFriction = 0.25; // bombs have high drag who woulda thunk
        class ace_missileguidance {
            enabled = 1;

            pitchRate = 5;
            yawRate = 5;

            bangBangGuidance = 1;
            stabilityCoefficient = 0.4; // how much this projectile likes to "weathervane" (keep direction toward velocity)

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = { "SALH" };

            defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };

            defaultNavigationType = "ProportionalNavigation";
            navigationTypes[] = { "ProportionalNavigation" };

            seekLastTargetPos = 0;      // seek last target position [if seeker loses LOS of target, continue to last known pos]
            seekerAngle = 60;           // Angle from the shooter's view that can track the missile
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 5;
            seekerMaxRange = 4000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "DIR";
            attackProfiles[] = {"DIR"};
        };
    };

    class Bomb_03_F;
    class GVAR(FAB250): Bomb_03_F {
        maneuvrability = 0; // no maneuvrability so that default guidance doesnt work
        airFriction = 0.25; // bombs have high drag who woulda thunk
        class ace_missileguidance {
            enabled = 1;

            pitchRate = 8;
            yawRate = 8;

            bangBangGuidance = 1;
            stabilityCoefficient = 0.4; // how much this projectile likes to "weathervane" (keep direction toward velocity)

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = { "SALH" };

            defaultSeekerLockMode = "LOAL";
            seekerLockModes[] = { "LOAL" };

            defaultNavigationType = "ProportionalNavigation";
            navigationTypes[] = { "ProportionalNavigation" };

            seekLastTargetPos = 0;      // seek last target position [if seeker loses LOS of target, continue to last known pos]
            seekerAngle = 60;           // Angle from the shooter's view that can track the missile
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 5;
            seekerMaxRange = 4000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "DIR";
            attackProfiles[] = {"DIR"};
        };
    };
};

