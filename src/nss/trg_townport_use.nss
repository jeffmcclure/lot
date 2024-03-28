////////////////////////////////////////////////////////////////////////////////
// Placeable Object Event: OnUse
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPCPortalUser = GetLastUsedBy();

  //----------------------------------------------------------------------------

  if (GetTag(GetArea(oPCPortalUser)) == "TRISTRAM")
  {
    if (!IsInConversation(OBJECT_SELF))
    {
      // dialog box init

      // define custom tokens as player names (9000 == oPCPortalUser)
      // and store all current destination portals on the oPCPortalUser object
      object oPC        = GetFirstPC();
      int    nToken     = 9001;

      while (GetIsObjectValid(oPC))
      {
        // check if oPC has an active town portal
        object oTownPortal = GetLocalObject(oPC,"TownPortal");
        if (GetIsObjectValid(oTownPortal))
        {
          if (oPC == oPCPortalUser) // set oPCPortalUser to the first position
          {
            SetCustomToken(9000,GetName(oPC));
            SetLocalObject(oPCPortalUser,"9000",oTownPortal);
          }
          else
          {
            SetCustomToken(nToken,GetName(oPC));
            SetLocalObject(oPCPortalUser,IntToString(nToken),oTownPortal);
            nToken++;
          }
        }
        oPC = GetNextPC();
      }

      // hint: token 9000 could be unused
      // this means oPCPortalUser does not have a portal
      SetLocalInt(oPCPortalUser,"TokenMax",nToken-1);
      SetLocalInt(oPCPortalUser,"TokenCounter",9000);

      // activate the dialog box
      //ActionStartConversation(oPCPortalUser,"",TRUE);

      //new code:  automatically teleport player if single player version
      SetLocalInt(GetPCSpeaker(),"Token",9001);
    }
    else
    {
      SendMessageToPC(oPCPortalUser,"The town portal is in use.");
    }
  }

  //----------------------------------------------------------------------------

  else
  {
    // teleport to Tristram
    object oTownPortal = GetLocalObject(GetModule(),"TownPortal");
    if (GetIsObjectValid(oTownPortal)) // this should always be TRUE
    {
      AssignCommand(oPCPortalUser,JumpToObject(oTownPortal));
    }
  }

  //----------------------------------------------------------------------------

}
