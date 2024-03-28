#include "inc_party"
//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

SetPartyInt(oPC, "deese", 1);
//AddPersistentJournalQuestEntry("QST_LOSTBOYS", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LOSTBOYS", 1, oPC, TRUE, FALSE);
//AddJournalQuestEntry("QST_LIGHTS", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

object oTarget;

oTarget = GetObjectByTag("CRSD_BOULDER_01");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRSD_BOULDER_02");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRSD_BOULDER_03");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRSD_BOULDER_04");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRSD_BOULDER_05");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRSD_BOULDER_06");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("CRSD_BOULDER_07");
DestroyObject(oTarget, 0.0);

}

