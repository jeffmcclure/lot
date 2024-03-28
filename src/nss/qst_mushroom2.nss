#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");
if (!(nInt >= 1))
   {
   sDeny="You can find nothing useful here...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");
if (!(nInt < 2))
   {
   sDeny="You can find nothing useful here...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

CreateItemOnObject("blackmushroom", oPC);
//AddPersistentJournalQuestEntry("QST_MUSHROOM", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MUSHROOM", 2, oPC, TRUE, FALSE);

}

