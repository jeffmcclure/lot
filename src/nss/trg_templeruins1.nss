int nInt;
location lTarget;
object oTarget;
#include "pqj_inc"
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");

if (GetHitDice(oPC) <= 13)
   {
   SendMessageToPC(oPC, "Your character level is too low to be in this area.");

   oTarget = GetWaypointByTag("WP_CURSEDFOREST");

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
else if (nInt < 1)
   {
   SendMessageToPC(oPC, "You have no reason to be in the place.  Perhaps you need a quest first?");

   oTarget = GetWaypointByTag("WP_CURSEDFOREST");

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
else
   {
   SendMessageToPC(oPC, "This place reeks of blood and death...");

   }

}
