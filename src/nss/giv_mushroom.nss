#include "inc_party"
//#include "pqj_inc"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_BLACKMUSHROOM")!= OBJECT_INVALID)
   {
   sDeny="You already have a black mushroom!";
   SendMessageToPC(oPC, sDeny);
   return;
   }

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");
if (!(nInt == 1))
   return;

CreateItemOnObject("blackmushroom", oPC);
SendMessageToPC(oPC, "You obtained a black mushroom!");
//AddPersistentJournalQuestEntry("QST_MUSHROOM", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MUSHROOM", 2, oPC, TRUE, FALSE);
AssignCommand(oPC, ActionSpeakString("Now that's one BIG mushroom!"));
//ExecuteScript("sav_lastused", OBJECT_SELF);
object oTarget;
oTarget = GetObjectByTag("PLC_BLACKMUSHROOM");
DelayCommand(2.0, DestroyObject(oTarget, 0.0));

}
