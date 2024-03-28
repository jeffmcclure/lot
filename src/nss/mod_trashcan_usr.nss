////////////////////////////////////////////////////////////////////////////////
// Module Event: OnUserDefined
////////////////////////////////////////////////////////////////////////////////

float DESTROY_DELAY = 10.0 * 60.0; // destroy loot bags after DESTROY_DELAY seconds

void main()
{
  if (GetUserDefinedEventNumber() == 9000)
  {
    int    i        = 0;
    object oBodyBag = GetObjectByTag("Body Bag",i);

    while (GetIsObjectValid(oBodyBag))
    {
      if (!GetLocalInt(oBodyBag,"DestroyFlag"))
      {
        SetLocalInt(oBodyBag,"DestroyFlag",TRUE);
      }
      else
      {
        object o = GetFirstItemInInventory(oBodyBag);
        while (GetIsObjectValid(o))
        {
          if (GetTag(o) != "ITM_HellForgeHammer") DestroyObject(o);
          o = GetNextItemInInventory(oBodyBag);
        }
        DeleteLocalInt(oBodyBag,"DestroyFlag");
        DestroyObject(oBodyBag);
      }
      oBodyBag = GetObjectByTag("Body Bag",++i);
    }

    DelayCommand(DESTROY_DELAY,
      SignalEvent(OBJECT_SELF,EventUserDefined(9000)));
  }
}
