#include "script_component.hpp"
/*
 * Author: Dani (TCVM)
 * SACLOS seeker
 *
 * Arguments:
 * 1: Guidance Arg Array <ARRAY>
 * 2: Seeker State <ARRAY>
 *
 * Return Value:
 * Position of wanted missile pos relative to the camera direction <ARRAY>
 *
 * Example:
 * [] call ace_missileguidance_fnc_seekerType_SACLOS
 *
 * Public: No
 */
params ["", "_args"];
_args params ["_firedEH", "", "_flightParams"];
_firedEH params ["","","","","","","_projectile","_gunner"];
_flightParams params ["_pitchRate", "_yawRate"];

private _projectilePos = getPosASLVisual _projectile;

private _accelerationDirection = _projectile vectorModelToWorldVisual (_gunner getVariable [QGVAR(MCLOS_direction), [0, 0, 0]]);
private _returnPos = _projectilePos vectorAdd (_accelerationDirection vectorMultiply (_pitchRate max _yawRate));

_targetData set [0, _projectilePos vectorFromTo _returnPos];
_targetData set [2, _returnPos distance _projectilePos];

_returnPos

