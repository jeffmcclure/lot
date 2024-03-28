#include "inc_party"
void main()
{

object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "zhar");
if (!(nInt == 2))
   return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ZHAR");
if (!(nInt < 2))
   return;

object oTarget;
oTarget = GetObjectByTag("ZHAR");
AssignCommand(oTarget, ActionStartConversation(oPC, ""));

}

