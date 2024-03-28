#include "inc_party"
void main()
{

object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ISLAND");
if (!(nInt == 2))
   return;

nInt=GetPartyInt(oPC, "gettrinity");
if (!(nInt == 0))
   return;

SetPartyInt(oPC, "gettrinity", 1);
CreateItemOnObject("infernaltotem", OBJECT_SELF);

}

