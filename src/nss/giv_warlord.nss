//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_STEELTOME");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

//AddPersistentJournalQuestEntry("QST_WARLORD", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_WARLORD", 2, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);
object oTarget;
oTarget = GetObjectByTag("HELL3_2ARMORY");
SetLocked(oTarget, FALSE);

}

