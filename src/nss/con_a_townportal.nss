////////////////////////////////////////////////////////////////////////////////
// conversation action
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC         = GetPCSpeaker();
  int    nToken      = GetLocalInt(oPC,"Token");
  object oTownPortal = GetLocalObject(oPC,IntToString(nToken));

  // oTownPortal is invalid when oPC has selected "Cancel" or
  // has aborted the dialog (nToken == 0)
  if (GetIsObjectValid(oTownPortal))
  {
    AssignCommand(oPC,JumpToObject(oTownPortal));
  }

  // delete local variables
  int nTokenMax = GetLocalInt(oPC,"TokenMax");
  int nTokenCounter;
  for (nTokenCounter = 9000; nTokenCounter <= nTokenMax; nTokenCounter++)
  {
    DeleteLocalObject(oPC,IntToString(nTokenCounter));
  }
  DeleteLocalInt(oPC,"TokenMax");
  DeleteLocalInt(oPC,"TokenCounter");
  DeleteLocalInt(oPC,"Token");

  if (nToken == 9000) // 9000 == portal from oPC == his own town portal
  {
    // destroy town portal
    DestroyObject(oTownPortal,0.1);
    DeleteLocalObject(oPC,"TownPortal");

    if (nTokenMax == 9000)
    {
      DestroyObject(GetLocalObject(GetModule(),"TownPortal"),0.1);
      DeleteLocalObject(GetModule(),"TownPortal");
    }
  }
}
