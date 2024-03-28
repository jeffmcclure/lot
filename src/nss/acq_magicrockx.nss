//#include "pqj_inc"
#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICROCK");
if (!(nInt >= 1))
   {
   sDeny="There is nothing useful here...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICROCK");
if (!(nInt < 3))
   {
   sDeny="There is nothing useful here...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

if (GetItemPossessedBy(oPC, "D1_HEAVENSTONE")!= OBJECT_INVALID)
   {
   sDeny="There is nothing useful here...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

CreateItemOnObject("heavenstone", oPC);
//AddPersistentJournalQuestEntry("QST_MAGICROCK", 2, oPC, FALSE, FALSE);
FloatingTextStringOnCreature("You have obtained the heaven stone!", oPC);
AddJournalQuestEntry("QST_MAGICROCK", 2, oPC, TRUE, FALSE);
AssignCommand(oPC, ActionSpeakString("I should get this to Griswold!"));
//ExecuteScript("sav_lastused", OBJECT_SELF);

}
