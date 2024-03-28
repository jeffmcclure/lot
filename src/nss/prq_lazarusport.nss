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

if (!(GetNumItems(oPC, "KEY_LAZARUS_STAFF") >= 1)) return FALSE;

return TRUE;
}
