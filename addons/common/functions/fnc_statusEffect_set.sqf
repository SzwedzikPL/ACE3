/*
 * Author: PabstMirror
 * Adds or removes an id to a status effect and then updates the value
 *
 * Arguments:
 * 0: vehicle that it will be attached to (player or vehicle) <OBJECT>
 * 1: Effect Name <STRING>
 * 2: Unique Reason ID <STRING>
 * 3: Is Set (true adds/false removes) <BOOL>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player, "setCaptive", "reason1", true] call ace_common_fnc_statusEffect_set
 *
 * Public: Yes
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_object", objNull, [objNull]], ["_effectName", "", [""]], ["_ID", "", [""]], ["_set", true, [false]]];
TRACE_4("params",_object,_effectName,_ID,_set);

//Only run this after the settings are initialized
if !(GVAR(settingsInitFinished)) exitWith {
    TRACE_1("pushing to runAtSettingsInitialized", _this);
    GVAR(runAtSettingsInitialized) pushBack [FUNC(statusEffect_set), _this];
};

if (isNull _object) exitWith {ACE_LOGERROR_1("setStatusEffect - Bad Input %1", _this)};

[_object, true] call FUNC(statusEffect_resetVariables); //Check for mismatch, and set object ref

//check ID case and set globaly if not already set:
_ID = toLower _ID;
private _statusReasons = missionNamespace getVariable [(format [QGVAR(statusEffects_%1), _effectName]), []];
private _statusIndex = _statusReasons find _ID;
if (_statusIndex == -1) then {
    TRACE_2("ID not in global reasons, adding",_statusReasons,_ID);
    _statusIndex = _statusReasons pushBack _ID;
    missionNamespace setVariable [(format [QGVAR(statusEffects_%1), _effectName]), _statusReasons, true];
};

private _effectVarName = format [QGVAR(effect_%1), _effectName];
private _effectNumber = _object getVariable [_effectVarName, -1];
TRACE_2("current",_effectVarName,_effectNumber);

if ((_effectNumber == -1) && {!_set}) exitWith {
    //Optimization for modules that always set an ID to false even if never set true
    TRACE_2("Set False on nil array, exiting",_set,_effectNumber);
};

if (_effectNumber == -1) then {_effectNumber = 0};

private _effectBoolArray = [_effectNumber, count _statusReasons] call FUNC(binarizeNumber);
TRACE_3("Setting New Value", _set, _statusIndex, _effectBoolArray);
_effectBoolArray set [_statusIndex, _set];
_effectNumber = _effectBoolArray call FUNC(toBitmask);

TRACE_2("Saving globaly",_effectVarName,_effectNumber);
_object setVariable [_effectVarName, _effectNumber, true];

[_object, _effectName] call FUNC(statusEffect_sendEffects);
