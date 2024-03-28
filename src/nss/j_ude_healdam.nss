/************************ [User Defined: When healed: Damaged] *****************
    Filename: j_ude_healdam
************************* [User Defined: When healed: Damaged] *****************
    User defined event: Healed: Damage
************************* [History] ********************************************
    1.3 - Example of User Defined Event
************************* [Workings] *******************************************
    This is a easy one, and only requires that the NPC be set to Plot before they
    are attacked.

    Basically, the default healing spells, which will normally heal the target,
    will be the only ones to damage it - it will do Max damage for that spell -
    so, say, cure moderate wounds is max of 2d8 + (Max of) 10 = 16 + 10 = 26
    damage done to us. It means, unless the character is unlucky, at least 50%
    of the spells healing it does will be re-done in damage.

    In the moderate wounds case, if we rolled 6 on 2d8, as a caster level of 10,
    so 16 in total. This script does 26 damage to self, so a net gain of 10
    damage done.

    We cannot get how much healing was done, so this can't be exact without spell
    editing...

    Ideas:
    - Change the spell scripts (NW_S0_Cure***) so that it sets on the target
      how much it heals, so this script can react to that.
    - Make it so that other spells heal the creature (and as it is plot, it won't
      know how much it is damaged, so needs a large workaround).
************************* [User Defined: When healed: Damaged] ****************/

//  This contains a lot of useful things.
//  - Combat starting
//  - Constant values
//  - Get/Set spawn in values.
#include "j_inc_other_ai"
//  This contains some useful things to get NPC's to attack and so on.
#include "j_inc_npc_attack"

void main()
{
    // Get the user defined number.
    int iEvent = GetUserDefinedEventNumber();
    // Events.
    switch(iEvent)
    {
        case EVENT_SPELL_CAST_AT_EVENT:
        {
            // This fires after the rest of the Spell Cast At End file does

            // Was it harmful? (healing spells are NOT)
            if(GetLastSpellHarmful() == FALSE)
            {
                int nSpellCast = GetLastSpell();
                int nSpellPower = -1;
                int nDam;

                // Heal: Takes us down to 1d4HP!
                if(nSpellCast == SPELL_HEAL)
                {
                    nDam = GetCurrentHitPoints() - d4();
                }
                // Other spells
                else
                {
                    if(nSpellCast == SPELL_CURE_CRITICAL_WOUNDS)
                    {
                        nSpellPower = 4;
                    }
                    else if(nSpellCast == SPELL_CURE_SERIOUS_WOUNDS)
                    {
                        nSpellPower = 3;
                    }
                    else if(nSpellCast == SPELL_CURE_MODERATE_WOUNDS)
                    {
                        nSpellPower = 2;
                    }
                    else if(nSpellCast == SPELL_CURE_LIGHT_WOUNDS)
                    {
                        nSpellPower = 1;
                    }
                    else if(nSpellCast == SPELL_CURE_MINOR_WOUNDS)
                    {
                        nSpellPower = 0;
                    }
                }
                // Cure minor wounds
                if(nSpellPower == 0)
                {
                    nDam = 4;
                }
                else if(nSpellPower >= 1)
                {
                    // 1d8 * power
                    nDam = 8 * nSpellPower;
                    // Add 5 per spell power point, for "Up to +10 caster level"
                    nDam += 5 * nSpellPower;
                }
                // nDam must be > 0
                if(nDam > 0)
                {
                    SetPlotFlag(OBJECT_SELF, FALSE);
                    // Do damage to self
                    effect eDam = EffectDamage(nDam);
                    // Do it
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, OBJECT_SELF);
                    // Re-set plot flag
                    SetPlotFlag(OBJECT_SELF, TRUE);
                }
            }
        }
        break;
    }
}
