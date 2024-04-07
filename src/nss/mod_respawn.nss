////////////////////////////////////////////////////////////////////////////////
// Module Event: OnPlayerRespawn
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"

// * Applies an XP and GP penalty
// * to the player respawning
void ApplyPenalty(object oDead, object soulsDeath)
{
    int nXP = GetXP(oDead);
    int nHD = GetHitDice(oDead);

    // Starting XP of current level
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;
    //SendMessageToPC(GetFirstPC(), "nHD:" + IntToString(nHD) + " nMin:" + IntToString(nMin));
    SetLocalInt(soulsDeath, "DEATH_XP_PENALTY", nXP - nMin);
    SetXP(oDead, nMin);

    int nGoldToTake = FloatToInt(0.33 * GetGold(oDead));
    if (nGoldToTake < 1000) {
        nGoldToTake = GetGold(oDead);
        if (nGoldToTake > 1000) nGoldToTake = 1000;
    }
    SetLocalInt(soulsDeath, "DEATH_GOLD_PENALTY", nGoldToTake);

    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.5, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
}

// -----------------------------------------------------------------------------

void main() {
    object oPC         = GetLastRespawnButtonPresser();
    int    iDeathCount = GetLocalInt(oPC,"DeathCount");

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)),oPC);
    RemoveEffects(oPC);
    object soulsDeath = GetLocalObject(oPC, "DEATH_LOCATION");
    ApplyPenalty(oPC, soulsDeath);
    SetLocalInt(oPC,"DeathCount",++iDeathCount);
    DelayCommand(5.0,FloatingTextStringOnCreature("Death Count: "+IntToString(iDeathCount),oPC,FALSE));
    SetLocalInt(oPC,"ModuleOnRest_nTimeLastRested",0);

    if (!GetLocalInt(GetModule(),"OPTION_RespawnWhereDied"))
        AssignCommand(oPC,JumpToObject(GetObjectByTag("WP_TownPortal")));

    location lTarget = GetLocation(soulsDeath);
    //AssignCommand(oPC, DelayCommand(1.0, JumpToLocation(lTarget)));
}
