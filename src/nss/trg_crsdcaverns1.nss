int nInt;
location lTarget;
object oTarget;
#include "pqj_inc"
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");

if (GetHitDice(oPC) <= 7)
   {
   SendMessageToPC(oPC, "Your character level is too low to be in this area.");

   oTarget = GetWaypointByTag("WP_CURSEDCAVERNS");

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

   oTarget = GetWaypointByTag("WP_CURSEDCAVERNS");

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
else if (nInt == 1)
   {
   SendMessageToPC(oPC, "This place reeks strongly of blood and death.");
   //AddPersistentJournalQuestEntry("QST_LOSTBOYS", 2, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_LOSTBOYS", 2, oPC, TRUE, FALSE);
   ExecuteScript("sav_lastenter", OBJECT_SELF);

   }
else
   {
   SendMessageToPC(oPC, "This place reeks of blood and death...");

   }

}
