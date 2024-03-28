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

CreateItemOnObject("nw_it_mpotion012", oPC);
CreateItemOnObject("nw_it_mpotion012", oPC);
CreateItemOnObject("nw_it_mpotion012", oPC);
CreateItemOnObject("nw_it_mpotion012", oPC);
CreateItemOnObject("nw_it_mpotion012", oPC);

object oCaster;
oCaster = OBJECT_SELF;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oTarget, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
FloatingTextStringOnCreature("Drink and be refreshed...", oPC);

DelayCommand(8.0, ExecuteScript("rdm_shrine1e", OBJECT_SELF));
oTarget = OBJECT_SELF;
DelayCommand(10.0, DestroyObject(oTarget, 0.0));

}
