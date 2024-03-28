//#include "pqj_inc"
string sDeny;
void main()
{

object oPC = GetLastSpeaker();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_STEELTOME")!= OBJECT_INVALID)
   {
   sDeny="You already have the steel tome...";
   SendMessageToPC(oPC, sDeny);

   return;
   }

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WARLORD");

if (!(nInt < 2))
   {
   sDeny="Nothing happens...";

   SendMessageToPC(oPC, sDeny);

   return;
   }

CreateItemOnObject("thesteeltome", oPC);
//AddPersistentJournalQuestEntry("QST_WARLORD", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_WARLORD", 1, oPC, FALSE, FALSE);
//ExecuteScript("sav_lastused", OBJECT_SELF);

}
