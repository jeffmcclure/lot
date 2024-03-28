//#include "pqj_inc"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_GOLDENELIXIR")!= OBJECT_INVALID)
   {
   sDeny="You already have the golden elixir!";
   SendMessageToPC(oPC, sDeny);
   return;
   }

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LACHDANAN");
if (!(nInt >= 1))
   {
   sDeny="There is nothing important inside this chest...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LACHDANAN");
if (!(nInt < 2))
   {
   sDeny="There is nothing important inside this chest...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

CreateItemOnObject("goldenelixir", oPC);
SendMessageToPC(oPC, "You obtained a golden elixir from the chest!");
//AddPersistentJournalQuestEntry("QST_LACHDANAN", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_LACHDANAN", 2, oPC, TRUE, FALSE);
AssignCommand(oPC, ActionSpeakString("I should get this to Lachdanan!"));
//ExecuteScript("sav_lastused", OBJECT_SELF);

}

