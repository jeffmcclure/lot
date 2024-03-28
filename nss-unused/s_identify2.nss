////////////////////////////////////////////////////////////////////////////////
// conversation action
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC   = GetPCSpeaker();
  object oItem = GetFirstItemInInventory(oPC);

  // identify all unidentified items in oPC's inventory
  while (GetIsObjectValid(oItem))
  {
    if (!GetIdentified(oItem))
    {
      SetIdentified(oItem,TRUE);
      SendMessageToPC(oPC,GetName(oItem));
    }
    oItem = GetNextItemInInventory(oPC);
  }
}
