//#include "pqj_inc"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

//SetLocalInt(oPC, "LastRestMinute",  GetTimeMinute());
//SetLocalInt(oPC, "LastRestSec", GetTimeSecond());

//RebuildJournalQuestEntries(GetEnteringObject());

//AddPersistentJournalQuestEntry("QST_UPDATE_042004", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_FLESHDOOM", 2, oPC, TRUE, FALSE);
//SetLocalInt(oPC, "caverns1", 1);
//SetLocalInt(oPC, "catacombs1", 1);

//ExecuteScript("ent_lazarus", OBJECT_SELF);
//ExecuteScript("ent_cow", OBJECT_SELF);

//SendMessageToPC(oPC, "Welcome to the Diablo Campaign Module 0.8.7 Beta!");
//SendMessageToPC(oPC, "Check your journal for other latest updates to this module!");
//SendMessageToPC(oPC, "Visit our module web site at http://nwn.tolitz.com!");

//object oTarget;
//location lTarget;
//oTarget = GetWaypointByTag("WP_MODENTRANCE");

//lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

//if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
//AssignCommand(oPC, ClearAllActions());
//AssignCommand(oPC, ActionJumpToLocation(lTarget));
//ExecuteScript("mod_jail", OBJECT_SELF);

}
