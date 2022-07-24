#include "script_component.hpp"
/*
 * Author: Dani (TCVM)
 * Determine path for projectile to take in accordance to proportional navigation, takes target acceleration into account
 *
 * Arguments:
 * Guidance Arg Array <ARRAY>
 *
 * Return Value:
 * Commanded acceleration normal to LOS in world space <ARRAY>
 *
 * Example:
 * [] call ace_missileguidance_fnc_navigationType_augmentedProNav
 *
 * Public: No
 */
params ["_args", "_timestep", "_seekerTargetPos", "_profileAdjustedTargetPos"];
_args params ["_firedEH", "", "", "", "_stateParams", "_targetData"];
_firedEH params ["","","","","","","_projectile"];
_stateParams params ["", "", "", "","_navigationParams"];
_navigationParams params ["_lastMissileFrame", "_navigationGain"];
_lastMissileFrame params ["_lastLineOfSight"];
_targetData params ["_targetDirection", "_attackProfileDirection", "", "_targetVelocity", "_targetAcceleration"];

// Proportional navigation implemented via "Fundamentals of proportional navigation" by Stephen Murtaugh and Harry Criel
private _closingVelocity = _targetVelocity vectorDiff velocity _projectile;

private _targetAccelerationProjected = _attackProfileDirection vectorMultiply (_targetAcceleration vectorDotProduct _attackProfileDirection);
_targetAcceleration = _targetAcceleration vectorDiff _targetAccelerationProjected;

private _losDelta = (vectorNormalized _attackProfileDirection) vectorDiff (vectorNormalized _lastLineOfSight);
private _losRate = if (_timestep == 0) then {
    0
} else {
    1 * (vectorMagnitude _losDelta) / _timestep; 
};

private _lateralAcceleration = _navigationGain * _losRate;
private _commandedAcceleration = _closingVelocity vectorMultiply _lateralAcceleration;
_commandedAcceleration = _commandedAcceleration vectorAdd (_losDelta vectorMultiply (0.5 * _navigationGain * vectorMagnitude _targetAcceleration));

// we need acceleration normal to our LOS
private _commandedAccelerationProjected = _attackProfileDirection vectorMultiply (_commandedAcceleration vectorDotProduct _attackProfileDirection);
_commandedAcceleration = _commandedAcceleration vectorDiff _commandedAccelerationProjected;

if (accTime > 0) then {
    _navigationParams set [0, [_seekerTargetPos, _targetVelocity, _attackProfileDirection]];
};

_commandedAcceleration vectorMultiply _timestep
