void main()
{

object oPC = GetFirstPC();

AddJournalQuestEntry("QST_IZUAL", 3, oPC, TRUE, FALSE);
ActionSpeakString("N-No!  NO!  I will not be sent back to the void!  I will not!  Nooo!!!");

object oTarget;
oTarget = GetObjectByTag("PORTAL_IZUAL");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), GetLocation(oTarget));

oTarget = GetObjectByTag("PORTAL_IZUAL");
DestroyObject(oTarget, 3.0);

}
