//#include "pqj_inc"
#include "nw_i0_tool"
string sDeny;
void main()
{

object oPC = GetLastKiller();

while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LEORIC");

if (!(nInt >= 1))
   return;

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_LEORIC");

if (!(nInt < 2))
   {
   sDeny="You have already done this quest!";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oArea = GetArea(OBJECT_SELF);

while (oPC != OBJECT_INVALID)
    {
    if (GetArea(oPC) == oArea)
        {
        RewardPartyXP(750, oPC, TRUE);
        //RewardPartyGP(200, oPC, TRUE);
        //CreateItemOnObject("undeadcrown", oPC);
        //AddPersistentJournalQuestEntry("QST_LEORIC", 2, oPC, FALSE, FALSE);
        AddJournalQuestEntry("QST_LEORIC", 2, oPC, FALSE, FALSE);
        SendMessageToPC(oPC, "Rest well, Leoric.  I'll find your son...");
        //ExecuteScript("sav_lastkilled", OBJECT_SELF);
        }
    oPC = GetNextPC();
    }

}
