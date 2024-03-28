#include "inc_party"
string sDeny;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");
if (!(nInt == 2))
   return;

if ((GetGender(oPC)!=GENDER_MALE))
   {
   sDeny="You are unaffected by Andariel's evil power...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

SendMessageToPC(oPC, "You are touched by Andariel's evil power!");

object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectAbilityDecrease(ABILITY_CHARISMA, 1);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

oTarget = oPC;
eEffect = EffectAbilityDecrease(ABILITY_CONSTITUTION, 1);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

oTarget = oPC;
eEffect = EffectAbilityDecrease(ABILITY_DEXTERITY, 1);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

oTarget = oPC;
eEffect = EffectAbilityDecrease(ABILITY_INTELLIGENCE, 1);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

oTarget = oPC;
eEffect = EffectAbilityDecrease(ABILITY_STRENGTH, 1);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

oTarget = oPC;
eEffect = EffectAbilityDecrease(ABILITY_WISDOM, 1);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

oTarget = oPC;
eEffect = EffectACDecrease(1);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

oTarget = oPC;
eEffect = EffectAttackDecrease(1);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

//oTarget = oPC;
//eEffect = EffectBlindness();
//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

//oTarget = oPC;
//eEffect = EffectCharmed();
//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

//oTarget = oPC;
//eEffect = EffectDeaf();
//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

//oTarget = oPC;
//eEffect = EffectMovementSpeedDecrease(5);
//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

//oTarget = oPC;
//eEffect = EffectNegativeLevel(1);
//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

//oTarget = oPC;
//eEffect = EffectSlow();
//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

oTarget = oPC;
eEffect = EffectSpellResistanceDecrease(5);
ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}
