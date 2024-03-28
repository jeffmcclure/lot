location lTarget;
object oTarget;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "ITEM_JAIL1")!= OBJECT_INVALID)
   {
   oTarget = GetWaypointByTag("WP_JAIL1");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
else if (GetItemPossessedBy(oPC, "ITEM_JAIL2")!= OBJECT_INVALID)
   {
   oTarget = GetWaypointByTag("WP_JAIL2");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
else if (GetItemPossessedBy(oPC, "ITEM_JAIL3")!= OBJECT_INVALID)
   {
   oTarget = GetWaypointByTag("WP_JAIL3");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
else if (GetItemPossessedBy(oPC, "ITEM_JAIL4")!= OBJECT_INVALID)
   {
   oTarget = GetWaypointByTag("WP_JAIL4");

   lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   AssignCommand(oPC, ClearAllActions());

   AssignCommand(oPC, ActionJumpToLocation(lTarget));

   }
}
