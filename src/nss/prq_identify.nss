////////////////////////////////////////////////////////////////////////////////
// conversation condition
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC                 = GetPCSpeaker();
  object oItem               = GetFirstItemInInventory(oPC);
  int    bAllItemsIdentified = TRUE;

  // check if there is an unidentified item in oPC's inventory
  while (GetIsObjectValid(oItem) && bAllItemsIdentified)
  {
    bAllItemsIdentified = GetIdentified(oItem);
    oItem = GetNextItemInInventory(oPC);
  }
  return !bAllItemsIdentified;
}
