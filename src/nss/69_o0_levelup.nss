//::///////////////////////////////////////////////
//:: 69_O0_LevelUp.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
 This script fires whenever a player levels up.
 If the henchmen is capable of going up a level, they do.
 Place in the OnPlayerLevelUp event in Module Properties
*/
//:://////////////////////////////////////////////
//:: Created By:     Brent
//:: Created On:     2002
//:: Modified By: 69MEH69
//:://////////////////////////////////////////////
#include "69_i0_henchman"
void main()
{
    object oPC = GetPCLevellingUp();
    int nPC = GetHitDice(oPC);
    object oHench = GetHenchman(oPC);
    int nNewClass, nHenchLag, nHenchMax, nHench;

      while(GetIsObjectValid(oHench))
        {
         nHenchLag = GetLocalInt(OBJECT_SELF, "nHenchLag");
         nHenchMax = GetLocalInt(OBJECT_SELF, "nHenchMax");
         nHench = GetHitDice(oHench);

            if(nPC > (nHench + nHenchLag))
            {
              AssignCommand(oHench, SpeakString("Leveling Up"));
              nNewClass = GetLocalInt(oHench, "NewClass");
              if(nNewClass == 0)
              {
                nNewClass = GetClassByPosition(1, oHench);
              }
              if(nNewClass == CLASS_TYPE_ARCANE_ARCHER)
              {
                 if (GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oHench) == 10)
                   SetLocalInt(oHench, "NewClass", GetClassByPosition(1, oHench));
              }
              if(nNewClass == CLASS_TYPE_ASSASSIN)
              {
                 if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oHench) == 10)
                   SetLocalInt(oHench, "NewClass", GetClassByPosition(1, oHench));
              }
              if(nNewClass == CLASS_TYPE_BLACKGUARD)
              {
                 if (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oHench) == 10)
                   SetLocalInt(oHench, "NewClass", GetClassByPosition(1, oHench));
              }
              if(nNewClass == CLASS_TYPE_HARPER)
              {
                 if (GetLevelByClass(CLASS_TYPE_HARPER, oHench) == 5)
                   SetLocalInt(oHench, "NewClass", GetClassByPosition(1, oHench));
              }
              if(nNewClass == CLASS_TYPE_SHADOWDANCER)
              {
                 if (GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oHench) == 10)
                   SetLocalInt(oHench, "NewClass", GetClassByPosition(1, oHench));
              }

              LevelUpHenchman(oHench, nNewClass, TRUE);
              //DoLevelUp(oPC, oHench);
            }
            oHench = GetHenchman(oHench);
        }

}
