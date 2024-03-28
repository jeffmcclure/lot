#include "pqj_inc"
location lTarget;
object oTarget;
void main()
{

object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "EPIC_EPICTOTEM")== OBJECT_INVALID)
   {
   CreateItemOnObject("epictotem", oPC);
   AddPersistentJournalQuestEntry("QST_CORNERSTONE", 1, oPC, FALSE, FALSE);
   //AddJournalQuestEntry("QST_CORNERSTONE", 1, oPC, FALSE, FALSE);
   ExecuteScript("sav_speaker", OBJECT_SELF);

   oTarget = GetWaypointByTag("WP_CORNERSTONE");

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
   oTarget = GetWaypointByTag("WP_CORNERSTONE");

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
