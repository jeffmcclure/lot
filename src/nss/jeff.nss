#include "nw_i0_plot"

//::///////////////////////////////////////////////
//:: jeffAppraiseOpenStore
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Opens a store, modifying the store prices
    by the Appraise skill of the PCspeaker
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:: 2003-05-26: Updated from XP1 sources - Georg
//:://////////////////////////////////////////////
void jeffAppraiseOpenStore(object oStore, object oPC, int nBonusMarkUp = 0, int nBonusMarkDown = 0, int alwaysRole = 1, int hardCap = 100) {
    string sTag = ObjectToString(OBJECT_SELF);

    int nPlayerSkillRank = GetSkillRank(SKILL_APPRAISE, oPC);
    int nNPCSkillRank = GetSkillRank(SKILL_APPRAISE, OBJECT_SELF) - GetNPCEasyMark(OBJECT_SELF);

    if (nNPCSkillRank < 0 )
        nNPCSkillRank = 0;

    int nAdjust = 0;

    /*
      New System:

        An opposed skill check (a d10 roll instead). Your appraise skill versus the shopkeepers appraise skill.

        Possible Results:

        Percentage Rebate/Penalty: The 'difference'

        Feedback: [Appraise Skill]: Merchant's reaction is unfavorable.
                  [Appraise Skill]: Merchant's reaction is neutral.
                  [Appraise Skill]: Merchant's reaction is favorable.

        Additional: Remember last reaction for this particular skill.
        When the player gets a new skill rank in this skill they'll get a
        reroll against this merchant.

    */

    int nState = 0;
    int nPreviousRank = GetLocalInt(oPC, "X0_APPRAISERANK"+ sTag);

    // * if the player's rank has improved, let them have another appraise check
    // * against this merchant

    if ( alwaysRole || (nPlayerSkillRank > nPreviousRank) || !GetLocalInt(oPC, "X0_APPRAISEVISITED"+sTag) ) {
       SetLocalInt(oPC, "X0_APPRAISERANK"+ sTag, nPlayerSkillRank);
       SetLocalInt(oPC, "X0_APPRAISEVISITED"+sTag, 1);

        int playerAppraiseRole = d10();
        int playerWeight = playerAppraiseRole + 2 * nPlayerSkillRank; // skill is twice the weight of roll
        SendMessageToPC(oPC, "Player: (D10 Roll " + IntToString(playerAppraiseRole) + ") + 2 * (Appraise Skill " + IntToString(nPlayerSkillRank) + ") = " + IntToString(playerWeight));

        int npcAppraiseRole = d10();
        int npcWeight = npcAppraiseRole + 2 * nNPCSkillRank; // skill is twice the weight of roll
        SendMessageToPC(oPC, "Merchant (D10 Roll " + IntToString(npcAppraiseRole) + ") + 2 * (Appraise Skill " + IntToString(nNPCSkillRank) + ") = " + IntToString(npcWeight));

        nAdjust = npcWeight - playerWeight;

        // Dude Perfect achievement
        if (playerAppraiseRole == 10 && npcAppraiseRole == 1)
            AddJournalQuestEntry("ACH_DUDE_PERFECT", 1, oPC, FALSE, FALSE); // only give to player not party
        else if (playerAppraiseRole == 1 && npcAppraiseRole == 10)
            AddJournalQuestEntry("ACH_RAW_DEAL", 1, oPC, FALSE, FALSE); // only give to player not party

        /*
         * Charisma Adjustment
         */
        int iCha = GetAbilityModifier(ABILITY_CHARISMA, oPC) * 2;
        if (iCha > 0) {
          SendMessageToPC(oPC, "Charisma Adjust = -" + IntToString(iCha));
          nAdjust = nAdjust - iCha;
        }

    } else {
        // * recover last reaction
        nAdjust  = GetLocalInt(oPC, "X0_APPRAISEADJUST" + sTag);
        SendMessageToPC(oPC, "Loaded Final Adjust = " + IntToString(nAdjust) + "%");
    }

    // apply Hard cap
    if (nAdjust > hardCap) {
        SendMessageToPC(oPC, "[Appraise Skill]: hardCap high");
        nAdjust = hardCap;
    }

    if (nAdjust < (hardCap * -1)) {
        SendMessageToPC(oPC, "[Appraise Skill]: hardCap low");
        nAdjust = hardCap * -1;
    }

    if (nAdjust < 0) {
        SendMessageToPC(oPC, "[Appraise Skill]: Player Advantage by " + IntToString(-1*nAdjust) + "%");
    } else if (nAdjust > 0) {
        SendMessageToPC(oPC, "[Appraise Skill]: Merchant Advantage by " + IntToString(nAdjust) + "%");
    } else {
        SendMessageToPC(oPC, "[Appraise Skill]: No Advantage");
    }

    // only seems to have effect with both markUp and markDown are set
    nBonusMarkDown = nBonusMarkDown + nAdjust;
    nBonusMarkUp = nBonusMarkUp + nAdjust;

    SetLocalInt(oPC, "X0_APPRAISEADJUST"+ sTag, nAdjust);
    OpenStore(oStore, oPC, nBonusMarkUp, -1*nBonusMarkDown);
}
