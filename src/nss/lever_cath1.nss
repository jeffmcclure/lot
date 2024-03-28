#include "x3_inc_string"

void main()
{
    string sTag=StringReplace(GetTag(OBJECT_SELF), "_chain", "");

    object door = GetObjectByTag(sTag);
    if (!GetIsObjectValid(door)) return;
    ActionUnlockObject(door);
    ActionOpenDoor(door);
    SetPlotFlag(door, 0);
    SetLockKeyRequired(door, 0);
    SetLocked(door, 0);
}
