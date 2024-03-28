object oTarget;
#include "nw_i0_tool"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

   RewardPartyXP(1500, oPC, FALSE);
   RewardPartyGP(1000, oPC, FALSE);
   AddJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AssignCommand(oPC, ActionSpeakString("May the spirit of our king protect me!"));

   oTarget = oPC;

   //Visual effects can't be applied to waypoints, so if it is a WP
   //apply to the WP's location instead

   int nInt;
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), GetLocation(oTarget));
}
