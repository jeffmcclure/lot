string sDeny;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (!(GetHitDice(oPC) >= 35))
   {
   sDeny="Your level is too high to repeat this quest.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");

if (!(nInt >= 3))
   {
   sDeny="Your level is too high to repeat this quest.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("WP_HOMEBASE");

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
