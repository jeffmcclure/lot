void debug(string dstring)
{
int isdebug = 0;
if (isdebug == 1)
SendMessageToPC(GetFirstPC(), dstring);
}



void TrashObject(object oObject)
{
debug(GetTag(oObject) + " is in trashobject");
if (GetObjectType(oObject) == OBJECT_TYPE_PLACEABLE) {
object oItem = GetFirstItemInInventory(oObject);
while (GetIsObjectValid(oItem))
{
debug(GetTag(oItem) + " is in trashobject");
TrashObject(oItem);
oItem = GetNextItemInInventory(oObject);
}
}
else
debug(GetTag(oObject) + " failed to pass as inventory type placeable is getting destroyed");
AssignCommand(oObject, SetIsDestroyable(TRUE, FALSE, FALSE));
DestroyObject(oObject);
}

void main()
{
object oPC;
oPC = GetFirstPC();
object tPC = oPC;
debug("We're starting area cleanup");
while (oPC != OBJECT_INVALID)
{
if (OBJECT_SELF == GetArea(oPC))
return;
else oPC = GetNextPC();
}
object oObject = GetFirstObjectInArea(OBJECT_SELF);
while (oObject != OBJECT_INVALID)
{
debug(GetTag(oObject));
if (GetIsEncounterCreature(oObject) && FindSubString(GetTag(oObject), "_BOSS") > -1)
DestroyObject(oObject);
int iObjectType = GetObjectType(oObject);
if(iObjectType == OBJECT_TYPE_ITEM)
{
TrashObject(oObject);
}
else if(iObjectType == OBJECT_TYPE_PLACEABLE && GetTag(oObject) == "BodyBag")
{
TrashObject(oObject);
}
oObject = GetNextObjectInArea(OBJECT_SELF);
}

/* onexit script:
This script would normally be placed in the onexit event handler for each area. However, I recommond keeping it in one universtal script.
Its purpose is to check for the presence of remaining pc's in
and area and if it finds none then it activates a delayed call
to an areacleanup script which cleans the area
*/

{
float cleanupdelay = 120.0; //if you change this it alters how long before
// the area cleans up, if you do change it INCLUDE THE DECIMAL, or it won't
// work
if(!GetIsPC(GetExitingObject()) ) {
return; }
object oPC = GetExitingObject();
if (!GetIsPC(oPC))
return;
oPC = GetFirstPC();
while (oPC != OBJECT_INVALID)
{
if (OBJECT_SELF == GetArea(oPC))
return;
else oPC = GetNextPC();
}
DelayCommand(cleanupdelay, ExecuteScript("areacleanup", OBJECT_SELF));
}
object oTarget;
oTarget = GetObjectByTag("DOOR_QUADRANT2A");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT2B");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT3A");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT3B");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT3C");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT3D");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT4A");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT4B");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT4C");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);

oTarget = GetObjectByTag("DOOR_QUADRANT4D");

AssignCommand(oTarget, ActionCloseDoor(oTarget));

SetLocked(oTarget, TRUE);
}
