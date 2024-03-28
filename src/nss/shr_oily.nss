void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

object oCaster;
oCaster = OBJECT_SELF;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FIREBALL, oTarget, METAMAGIC_ANY, TRUE, 1, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = OBJECT_SELF;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_BULLS_STRENGTH, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = OBJECT_SELF;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_ENDURANCE, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = OBJECT_SELF;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_MAGE_ARMOR, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

FloatingTextStringOnCreature("That which does not kill you...", oPC);

DelayCommand(8.0, ExecuteScript("rdm_shrine1a", OBJECT_SELF));
oTarget = OBJECT_SELF;
DelayCommand(10.0, DestroyObject(oTarget, 0.0));

}
