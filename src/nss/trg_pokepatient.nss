void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

effect eEffect;
eEffect = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, GetObjectByTag("PATIENT1"));

eEffect = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, GetObjectByTag("PATIENT2"));

eEffect = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, GetObjectByTag("PATIENT3"));

}
