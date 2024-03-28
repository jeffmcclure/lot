void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_BROWNSUIT");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

AddJournalQuestEntry("QST_COW", 2, oPC, TRUE, FALSE);

}

