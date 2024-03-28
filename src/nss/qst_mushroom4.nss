//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_DEMONBRAIN");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

CreateItemOnObject("spectralelixir2", oPC);
//AddPersistentJournalQuestEntry("QST_MUSHROOM", 4, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MUSHROOM", 4, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}
