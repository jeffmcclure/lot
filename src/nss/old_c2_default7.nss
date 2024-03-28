//::///////////////////////////////////////////////
//:: Default:On Death
//:: NW_C2_DEFAULT7
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Shouts to allies that they have been killed
   The default setting uses the BIOWARE default XP, simply
    adjust the XP slider in Module Properties.
   Change the variable NPC_XP to 1 to allow for XP per
    3rd Ed DMG and adjustments for multiplayer and/or henchmen.
    Adjust the XP slider to 0 in Module Properties.
*/
//:://////////////////////////////////////////////
//:: Created By: E.G. Hornbostel, aka Whyteshadow
//:: Modified by 69MEH69   June 2003
//:: Created On: 7/11/2002
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{
    //Set NPC_XP = 1 to initiate modified XP code
    //Set NPC_XP = 0 to initiate default XP
    int NPC_XP = 0;
    int BASEXP = 300; //You may need to adjust this value
    int BONUSXP = 0;

    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
      AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

 if(NPC_XP == 1)
 {
    float fCR = GetChallengeRating(OBJECT_SELF);
    int nMonsterXP;


// Get number of party members, and average Party Level

    int nPartyMembers;
    int nPartyLevelSum;
    float fAvgPartyLevel;

    object oPC = GetFirstFactionMember(oKiller, TRUE);
    object oKilledArea = GetArea(OBJECT_SELF);
    object oHench;
    while(GetIsObjectValid(oPC))
    {
     if(oKilledArea == GetArea(oPC))
     {
        nPartyMembers++;
        nPartyLevelSum += GetHitDice(oPC);
        oHench = GetHenchman(oPC);
        while(GetIsObjectValid(oHench))
        {
         if(oKilledArea == GetArea(oHench))
         {
           nPartyMembers++;
           nPartyLevelSum += GetHitDice(oHench);
         }
         oHench =GetHenchman(oHench);
        }

     }
       oPC = GetNextFactionMember(oKiller, TRUE);
    }
    string sPartyMembers = IntToString(nPartyMembers);
    //SendMessageToPC(oKiller, "Party Members = " +sPartyMembers);
    if (nPartyMembers == 0)
    return;

    fAvgPartyLevel = IntToFloat(nPartyLevelSum) / IntToFloat(nPartyMembers);

    // Bring partylevel up to 3 if less than 3
    //if (FloatToInt(fAvgPartyLevel) < 3) fAvgPartyLevel = 3.0;

    // Get the base Monster XP
    if ((FloatToInt(fAvgPartyLevel) <= 6) && (fCR < 1.5))
        nMonsterXP = BASEXP;
    else
    {
        nMonsterXP = BASEXP * FloatToInt(fAvgPartyLevel);
        int nDiff = FloatToInt(((fCR < 1.0) ? 1.0 : fCR) - fAvgPartyLevel);
        switch (nDiff)
        {
        case -7:
            nMonsterXP /= 12;
            break;
        case -6:
            nMonsterXP /= 8;
            break;
        case -5:
            nMonsterXP = nMonsterXP * 3 / 16;
            break;
        case -4:
            nMonsterXP /= 4;
            break;
        case -3:
            nMonsterXP /= 3;
            break;
        case -2:
            nMonsterXP /= 2;
            break;
        case -1:
            nMonsterXP = nMonsterXP * 2 / 3;
            break;
        case 0:
            break;
        case 1:
            nMonsterXP = nMonsterXP * 3 / 2;
            break;
        case 2:
            nMonsterXP *= 2;
            break;
        case 3:
            nMonsterXP *= 3;
            break;
        case 4:
            nMonsterXP *= 4;
            break;
        case 5:
            nMonsterXP *= 6;
            break;
        case 6:
            nMonsterXP *= 8;
            break;
        case 7:
            nMonsterXP *= 12;
            break;
        default:
            nMonsterXP = 0;
        }
    } // if ((FloatToInt(fAvgPartyLevel) < 6) && (fCR < 1.5)) {...} else {

    // Calculations for CR < 1
    if (fCR < 0.76 && nMonsterXP)
    {
        if (fCR <= 0.11)
            nMonsterXP = nMonsterXP / 10;
        else if (fCR <= 0.13)
            nMonsterXP = nMonsterXP / 8;
        else if (fCR <= 0.18)
            nMonsterXP = nMonsterXP / 6;
        else if (fCR <= 0.28)
            nMonsterXP = nMonsterXP / 4;
        else if (fCR <= 0.4)
            nMonsterXP = nMonsterXP / 3;
        else if (fCR <= 0.76)
            nMonsterXP = nMonsterXP /2;
        // Only the CR vs Avg Level table could set nMonsterXP to 0... to fix any
        // round downs that result in 0:

        if (nMonsterXP == 0) nMonsterXP = 1;
    }


    nMonsterXP += BONUSXP;


    int nCharXP = nMonsterXP / nPartyMembers;

    oPC = GetFirstFactionMember(oKiller);
    while(GetIsObjectValid(oPC))
    {
        if (oKilledArea == GetArea(oPC))
             GiveXPToCreature(oPC, nCharXP);
        oPC = GetNextFactionMember(oKiller, TRUE);
    }
 }
 if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
 {
   SignalEvent(OBJECT_SELF, EventUserDefined(1007));
 }
}

