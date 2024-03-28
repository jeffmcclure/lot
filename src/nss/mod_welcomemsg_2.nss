#include "pqj_inc"
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

SetLocalInt(oPC, "cursedforest", 0);

RebuildJournalQuestEntries(GetEnteringObject());

SendMessageToPC(oPC, "Welcome to the Diablo Campaign Module 0.7.6 Beta!");

SendMessageToPC(oPC, "Check your journal for other latest updates to this module!");

SendMessageToPC(oPC, "Visit our module web site at http://nwn.tolitz.com!");

ExecuteScript("s_changebelts", OBJECT_SELF);

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("WP_MODENTRANCE");

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
