//::///////////////////////////////////////////////
//:: Join as Henchman
//:: nw_ch_join.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Adds the current object as a henchman
    to the PC speaking in conversation.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: October 22, 2001
//:: Modified By: 69MEH69 AUG2003 Added LevelUp option at hire
//:://////////////////////////////////////////////
#include "69_inc_henai"

void main()
{
 //Set nLevelUp to 1 if you wish the henchman to automattically
 //level up at hire
 int nLevelUp = 1;

 if (GetLocalInt(OBJECT_SELF, "nXPLevelUp") == 1)
  {
    object oPC = GetPCSpeaker();
    int nXP = GetXP(oPC);
    if (GetLocalInt(OBJECT_SELF, "nMasterXP") == 0)
    {
      if (GetLocalInt(oPC, GetTag(OBJECT_SELF)) != TRUE)
      {
        SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);
        SetLocalInt(OBJECT_SELF, "nMasterXP", nXP);
      }
    }
  }

    SetAssociateListenPatterns();
    bkSetListeningPatterns();
    // * Companions, come in, by default with Attack Nearest Enemy && Follow Master modes
    SetLocalInt(OBJECT_SELF,"NW_COM_MODE_COMBAT",ASSOCIATE_COMMAND_ATTACKNEAREST);
    SetLocalInt(OBJECT_SELF,"NW_COM_MODE_MOVEMENT",ASSOCIATE_COMMAND_FOLLOWMASTER);

 object oSpeaker = GetPCSpeaker();
 object oMaster = oSpeaker;
 int nHench = GetLocalInt(oSpeaker, "nHench");
 while(GetIsObjectValid(GetHenchman(oMaster)) == TRUE)
 {
    oMaster = GetHenchman(oMaster);
 }
    //SetWorkingForPlayer and SetBeenHired added for ondeath conversation
    SetWorkingForPlayer(GetPCSpeaker());
    SetBeenHired();
    SetLocalObject(OBJECT_SELF, "PCMaster", oSpeaker);
    SetLocalInt(oSpeaker, "nHench", nHench +1);
    AddHenchman(oMaster);
    if(nLevelUp == 1)
    {
      DoLevelUp(GetPCSpeaker());
    }
//ExecuteScript("giv_henchhealkit", OBJECT_SELF);
}
