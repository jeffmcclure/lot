#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
SetPartyInt(oPC, "nakruljournal1", 1);
AddJournalQuestEntry("QST_NAKRUL", 1, oPC, TRUE, FALSE);

object oTarget;

oTarget = GetObjectByTag("DOOR_CRYPTS1");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_CRYPTS2");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_CRYPTS3");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

}
