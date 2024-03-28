int GetItemInInventory(object oMyItem, object oTarget = OBJECT_SELF)
{
 object oItem = GetFirstItemInInventory(oTarget);
 while(oItem != OBJECT_INVALID)
 {
  if(oMyItem == oItem)
  {
   return TRUE;
   break;
  }
  GetNextItemInInventory(oTarget);
 }
 return FALSE;
}

int StartingConditional()
{
  return GetItemInInventory(GetObjectByTag("NW_IT_MPOTION016"), OBJECT_SELF);
}
