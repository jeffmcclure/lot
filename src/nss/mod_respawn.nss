////////////////////////////////////////////////////////////////////////////////
// Module Event: OnPlayerRespawn
////////////////////////////////////////////////////////////////////////////////

#include "nw_i0_plot"

// * Applies an XP and GP penalty
// * to the player respawning
void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nPenalty = 50 * GetHitDice(oDead);
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);
    int nGoldToTake =    FloatToInt(0.10 * GetGold(oDead));
    // * a cap of 10 000gp taken from you
    if (nGoldToTake > 10000)
    {
        nGoldToTake = 10000;
    }
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.5, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
}

// -----------------------------------------------------------------------------

void main()
{
    object oPC         = GetLastRespawnButtonPresser();
    int    iDeathCount = GetLocalInt(oPC,"DeathCount");

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPC)),oPC);
    RemoveEffects(oPC);
    ApplyPenalty(oPC);
    SetLocalInt(oPC,"DeathCount",++iDeathCount);
    DelayCommand(5.0,FloatingTextStringOnCreature("Death Count: "+IntToString(iDeathCount),oPC,FALSE));
    SetLocalInt(oPC,"ModuleOnRest_nTimeLastRested",0);

    if (!GetLocalInt(GetModule(),"OPTION_RespawnWhereDied"))
        AssignCommand(oPC,JumpToObject(GetObjectByTag("WP_TownPortal")));
}
