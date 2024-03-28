void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("NPC_DIABLO");

effect eEffect;
eEffect = EffectHeal(1000);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);
}
