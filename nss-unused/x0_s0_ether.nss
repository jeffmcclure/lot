//Change these setting to alter the spell's characteristics
//Spell duration (in rounds)
int nDuration = 4;
//Spell Time Lock duration (in seconds, use float values)
float iLockTimer = 240.0;
//Defining time variables
float f120togo = ( 120 - iLockTimer ) * -1;
float f60togo = ( 60 - iLockTimer ) * -1;
float f10togo = ( 10 - iLockTimer ) * -1;

//Checking spell's caster
object oTarget = GetSpellTargetObject();
//Checking if he used GS recently
int iTimer = GetLocalInt(oTarget, "GSTimer");
void main()
{
    if (iTimer == 0)
    {
    SetLocalInt(oTarget, "GSTimer", 1);
    //Change: Checking target's area
    object oArea = GetArea(oTarget);
    //Declaring other major variables
    effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSanc = EffectEthereal();

    effect eLink = EffectLinkEffects(eVis, eSanc);
    eLink = EffectLinkEffects(eLink, eDur);

    //Enter Metamagic conditions
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
    nDuration = nDuration *2; //Duration is +100%
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ETHEREALNESS, FALSE));
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    //Send message to DMs about spell usage
    SendMessageToAllDMs("Player "+ObjectToString(oTarget)+" has just cast Greater Sanctuary. He is currently in "+ObjectToString(oArea)+".");
    SendMessageToPC(oTarget, "Greater Sanctuary has a timer of "+FloatToString(iLockTimer, 3, 1)+" seconds. You may not use GS again for this period of time. Attempting to do so will spend the spell while producing no effect.");
    DelayCommand(f120togo, SendMessageToPC(oTarget, "You have two minutes left on your Greater Sanctuary Lock Timer."));
    DelayCommand(f60togo, SendMessageToPC(oTarget, "You have one minute left on your Greater Sanctuary Lock Timer."));
    DelayCommand(f10togo, SendMessageToPC(oTarget, "You have 10 seconds left on your Greater Sanctuary Lock Timer."));
    DelayCommand(iLockTimer, SendMessageToPC(oTarget, "Greater Sanctuary is once again available for use."));
    DelayCommand(iLockTimer, SetLocalInt(oTarget, "GSTimer", 0));
    }
    else
    {
    SendMessageToPC(oTarget, "You have used Greater Sanctuary too recently, the effect has been cancelled");
    }
}
