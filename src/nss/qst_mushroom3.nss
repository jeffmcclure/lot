//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_BLACKMUSHROOM");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

//AddPersistentJournalQuestEntry("QST_MUSHROOM", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MUSHROOM", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
