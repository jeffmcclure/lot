#include "nw_i0_2q4luskan"
void main()
{

object oPC = GetFirstPC();

AddJournalQuestEntry("QST_DIABLO", 2, oPC, TRUE, FALSE);

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("WP_END");

lTarget = GetLocation(oTarget);
DelayCommand(3.0, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "d1_soulstone", lTarget));

effect eEffect;
eEffect = EffectVisualEffect(VFX_FNF_SUMMON_GATE);

DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, lTarget));

oTarget = GetWaypointByTag("WP_END");
lTarget = GetLocation(oTarget);
DelayCommand(3.0, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "corpsealbrecht", lTarget));

eEffect = EffectVisualEffect(VFX_IMP_DEATH);

DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, lTarget));

oTarget = GetObjectByTag("");
MusicBackgroundStop(GetArea(oPC));

}
