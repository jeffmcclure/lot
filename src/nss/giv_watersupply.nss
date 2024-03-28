#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();

SetPartyInt(oPC, "watersupplyquest", 1);

//AddPersistentJournalQuestEntry("QST_WATERSUPPLY", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_WATERSUPPLY", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);
object oTarget;
oTarget = GetObjectByTag("CHURCH2_2DPASSAGE");
SetLocked(oTarget, FALSE);

}
