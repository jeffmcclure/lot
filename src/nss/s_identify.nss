////////////////////////////////////////////////////////////////////////////////
// conversation action
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC   = GetPCSpeaker();
  object oItem = GetFirstItemInInventory(oPC);

  AssignCommand(oPC, TakeGoldFromCreature(100, oPC, TRUE));

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
