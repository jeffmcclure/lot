void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

ExploreAreaForPlayer(GetArea(oPC), oPC);

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

FloatingTextStringOnCreature("The way is made clear when viewed from above...", oPC);
DelayCommand(8.0, ExecuteScript("rdm_shrine1e", OBJECT_SELF));
oTarget = OBJECT_SELF;
DelayCommand(10.0, DestroyObject(oTarget, 0.0));

}
