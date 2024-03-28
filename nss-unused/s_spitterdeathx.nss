//::///////////////////////////////////////////////
//:: Spitter Death
//::
//::
//:://////////////////////////////////////////////
/*
    Acid splash does 20 damage to all within
    20ft
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 9, 2002
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    object oCaster = OBJECT_SELF;
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID);
    effect eVis = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetLocation(OBJECT_SELF);
    //Limit Caster level for the purposes of damage
    //Apply the fireball explosion at the location captured above.
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget))
    {
       //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ACID_SPLASH));
        //Get the distance between the explosion and the target to calculate delay
        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
        if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
        {
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamage = GetReflexAdjustedDamage(20, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ACID);
            //Set the damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_ACID);
            if(nDamage > 0)
            {
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
         }
       //Select the next target within the spell shape.
       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR);
    }
//Start PartyXP script
    /*Gets who last killed and what area they are in*/
    object oMember = GetLastKiller();
    object oAreaKilled = GetArea(oMember);

    /*
    Adds up the number of players in that players party that are in the same area.
    */
    int iCounter = 0;
    object oPartyMember = GetFirstFactionMember(oMember, TRUE);
    while (GetIsObjectValid(oPartyMember) == TRUE)
        {
        object oPartyArea = GetArea(oPartyMember);
        if(oAreaKilled == oPartyArea)
            {
            iCounter = iCounter + 1;
            }
        oPartyMember = GetNextFactionMember(oMember, TRUE);
        }

        /*
        If there is more then just the killer in the party,
        it then calculates the extra amount of experience to be awarded
        */
        if(iCounter > 1)
            {
            float fCR = GetChallengeRating(OBJECT_SELF);
            float fCounter = IntToFloat(iCounter);

            /*
            This is the multiplier.
            Change this number to increase/decrease
            the experience awarded for being in a party.
            */
            float fMultiplier = 13.0;

            float fBonus = (fCR * fMultiplier) / fCounter;
            int iBonus = FloatToInt(fBonus);

            object oPartyMember = GetFirstFactionMember(oMember, TRUE);
            /*
            Distributes the extra experience to the party members in the area
            */
            while (GetIsObjectValid(oPartyMember) == TRUE)
                {
                object oPartyArea = GetArea(oPartyMember);
                if(GetIsPC(oPartyMember) == TRUE && oAreaKilled == oPartyArea && GetCurrentHitPoints(oPartyMember) > 0)
                    {
                    SendMessageToPC(oPartyMember, "You gain "+IntToString(iBonus)+" party experience points.");
                    GiveXPToCreature(oPartyMember, iBonus);
                    }
                oPartyMember = GetNextFactionMember(oMember, TRUE);
                }
            }
//End PartyXP script
}
