//::///////////////////////////////////////////////
//:: [Inflict Wounds]
//:: [X0_S0_Inflict.nss]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
//:: This script is used by all the inflict spells
//::
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: July 2002
//:: Modified: 69MEH60 JUL2003
//:://////////////////////////////////////////////
//:: VFX Pass By:
//#include "69_i0_henchman"
#include "X0_I0_SPELLS" // * this is the new spells include for expansion packs

void main()
{
    int nSpellID = GetSpellId();
    object oTarget = GetSpellTargetObject();
    string sTag = GetTag(oTarget);
    object oArea = GetArea(oTarget);
    int nCHP = GetLocalInt(oArea, "nCHP" +sTag);
    int nCure;
    switch (nSpellID)
    {
/*Minor*/     case 431: spellsInflictTouchAttack(1, 0, 1, 246, VFX_IMP_HEALING_G, nSpellID);
                        nCure = 1;
                        if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                        {
                            SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
                        }
                        break;
/*Light*/     case 432: case 609: spellsInflictTouchAttack(d8(), 5, 8, 246, VFX_IMP_HEALING_G, nSpellID);
                                  nCure = d8(1);
                                  if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                                  {
                                    SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
                                  }
                                  break;
/*Moderate*/  case 433: case 610: spellsInflictTouchAttack(d8(2), 10, 16, 246, VFX_IMP_HEALING_G, nSpellID);
                                  nCure = d8(2);
                                  if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                                  {
                                    SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
                                  }
                                  break;
/*Serious*/   case 434: case 611: spellsInflictTouchAttack(d8(3), 15, 24, 246, VFX_IMP_HEALING_G, nSpellID);
                                  nCure = d8(3);
                                  if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                                  {
                                    SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
                                  }
                                  break;
/*Critical*/  case 435: case 612: spellsInflictTouchAttack(d8(4), 20, 32, 246, VFX_IMP_HEALING_G, nSpellID);
                                  nCure = d8(4);
                                  if(GetIsHenchmanDying(oTarget) && GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
                                  {
                                    SetLocalInt(oArea, "nCHP" +sTag, nCHP + nCure);
                                  }
                                  break;

    }
}
