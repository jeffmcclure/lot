#include "inc_party"

int GetNumItems(object oTarget,string sItem)
{
int nNumItems = 0;
object oItem = GetFirstItemInInventory(oTarget);
while (GetIsObjectValid(oItem) == TRUE)
{
if (GetTag(oItem) == sItem)
{
nNumItems = nNumItems + GetNumStackedItems(oItem);
}
oItem = GetNextItemInInventory(oTarget);
}
return nNumItems;
}

int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetNumItems(oPC, "D1_CORPSEROOF") < 1)) return FALSE;
if (!(GetNumItems(oPC, "D1_CORPSEINNEAS") < 1)) return FALSE;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LOSTBOYS");

if (!(nInt == 3))
   return FALSE;

return TRUE;
}
