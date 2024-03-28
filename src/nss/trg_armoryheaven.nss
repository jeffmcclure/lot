#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ISLAND");

if (!(nInt >= 4))
   {
   sDeny="This thing is locked.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

object oTarget;
oTarget = OBJECT_SELF;
SetLocked(oTarget, FALSE);
ExecuteScript("loot_unique", OBJECT_SELF);

}

