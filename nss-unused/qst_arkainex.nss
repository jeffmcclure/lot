object oTarget;
//#include "pqj_inc"
#include "nw_i0_tool"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");
if (!(nInt >= 2))
   {
   sDeny="You need to talk to Cain first...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");
if (!(nInt < 3))
   {
   sDeny="Nothing happened...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

if (!GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT, oPC))
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("arkainesvalor2", oPC);
   //AddPersistentJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AssignCommand(oPC, ActionSpeakString("May the spirit of Arkaine protect me!"));
   //ExecuteScript("sav_lastused", OBJECT_SELF);

   oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

   nInt = GetObjectType(oTarget);

   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), GetLocation(oTarget));

   }
else if (!GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM, oPC))
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("arkainesvalor3", oPC);
   //AddPersistentJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AssignCommand(oPC, ActionSpeakString("May the spirit of Arkaine protect me!"));
   //ExecuteScript("sav_lastused", OBJECT_SELF);

   oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

   nInt = GetObjectType(oTarget);

   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), GetLocation(oTarget));

   }
else if (!GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY, oPC))
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("arkainesvalor", oPC);
   //AddPersistentJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AssignCommand(oPC, ActionSpeakString("May the spirit of Arkaine protect me!"));
   //ExecuteScript("sav_lastused", OBJECT_SELF);

   oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

   nInt = GetObjectType(oTarget);

   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), GetLocation(oTarget));

   }
else
   {
   RewardPartyXP(1500, oPC, TRUE);
   RewardPartyGP(1000, oPC, FALSE);
   CreateItemOnObject("arkainesvalor3", oPC);
   //AddPersistentJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AddJournalQuestEntry("QST_ARKAINE", 3, oPC, FALSE, FALSE);
   AssignCommand(oPC, ActionSpeakString("May the spirit of Arkaine protect me!"));
   //ExecuteScript("sav_lastused", OBJECT_SELF);

   oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

   nInt = GetObjectType(oTarget);

   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), GetLocation(oTarget));

   }

}
