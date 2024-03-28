////////////////////////////////////////////////////////////////////////////////
// Module Event: OnClientLeave
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oExitingPC  = GetExitingObject();
  object oTownPortal = GetLocalObject(oExitingPC,"TownPortal");

  // check if exiting player has an active town portal
  if (GetIsObjectValid(oTownPortal))
  {
    // check if there is another active portal
    object oPC = GetFirstPC(); if (oPC == oExitingPC) oPC = GetNextPC();
    int    bNoOtherPortal = TRUE;

    while (GetIsObjectValid(oPC) && bNoOtherPortal)
    {
      // check if oPC has an active town portal
      if (GetIsObjectValid(GetLocalObject(oPC,"TownPortal"))) bNoOtherPortal = FALSE;
      oPC = GetNextPC(); if (oPC == oExitingPC) oPC = GetNextPC();
    }

    // delete oExitingPC's town portal
    DestroyObject(oTownPortal);

    // if this was the last portal
    // destroy the portal in Tristram as well
    if (bNoOtherPortal)
    {
      DestroyObject(GetLocalObject(OBJECT_SELF,"TownPortal"));
      DeleteLocalObject(OBJECT_SELF,"TownPortal");
    }
  }
ExecuteScript("mod_cleanstore", OBJECT_SELF);
}
