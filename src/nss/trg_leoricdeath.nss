#include "nw_i0_tool"
void main()
{

object oPC = GetFirstPC();

RewardPartyXP(500, oPC, TRUE);
AddJournalQuestEntry("QST_LEORIC", 2, oPC, TRUE, FALSE);
//FloatingTextStringOnCreature("Rest well, Leoric.  I'll find your son...", oPC);
AssignCommand(oPC, ActionSpeakString("Rest well, Leoric.  I'll find your son."));

object oTarget;
oTarget = GetObjectByTag("DOOR_LEORICLOOT");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("");
MusicBackgroundStop(GetArea(oPC));

}
