//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_FUNGALTOME");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

//AddPersistentJournalQuestEntry("QST_MUSHROOM", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MUSHROOM", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

