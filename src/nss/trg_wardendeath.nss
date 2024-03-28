#include "nw_i0_tool"
void main()
{

object oPC = GetFirstPC();
object oTarget;

//oTarget = GetObjectByTag("CRSDCAVERNS2_2JUNCTION");
//SetLocked(oTarget, FALSE);
//AssignCommand(oTarget, ActionOpenDoor(oTarget));
//
oTarget = GetObjectByTag("CRSDFOREST_2TEMPLE1");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("CRSDFOREST_2TEMPLE2");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

//oTarget = GetObjectByTag("LOWERTEMPLE1_2CRSDCRYPTS1");
//SetLocked(oTarget, FALSE);
//AssignCommand(oTarget, ActionOpenDoor(oTarget));
//
//oTarget = GetObjectByTag("LOWERTEMPLE2_2CRSDCRYPTS2");
//SetLocked(oTarget, FALSE);
//AssignCommand(oTarget, ActionOpenDoor(oTarget));
//
//oTarget = GetObjectByTag("CRYPTS_BOULDER_01");
//DestroyObject(oTarget, 0.0);
//
//oTarget = GetObjectByTag("CRYPTS_BOULDER_02");
//DestroyObject(oTarget, 0.0);
//
//oTarget = GetObjectByTag("CRYPTS_BOULDER_03");
//DestroyObject(oTarget, 0.0);
//
//oTarget = GetObjectByTag("CRYPTS_BOULDER_04");
//DestroyObject(oTarget, 0.0);
//
oTarget = GetObjectByTag("2TEMPLE1_BOULDER1");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE1_BOULDER2");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE1_BOULDER3");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE1_BOULDER4");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE2_BOULDER1");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE2_BOULDER2");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE2_BOULDER3");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("2TEMPLE2_BOULDER4");
DestroyObject(oTarget, 0.0);

RewardPartyXP(750, oPC, TRUE);
ActionSpeakString("Hahaha, my mistress Andariel will deal with you soon!");
AddJournalQuestEntry("QST_ANDARIEL", 1, oPC, TRUE, FALSE);
DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("A-Andariel?")));

}
