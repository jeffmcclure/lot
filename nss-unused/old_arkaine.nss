void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), GetLocation(oTarget));

oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(oTarget));

}
