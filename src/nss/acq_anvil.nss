#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ANVIL");
if (!(nInt >= 1))
   {
   sDeny="This forge looks like it is used to make weapons.  Perhaps you should ask Griswold about it.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_ANVIL");
if (!(nInt < 3))
   {
   sDeny="You have already taken the anvil from this forge.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

if (GetItemPossessedBy(oPC, "D1_ANVILOFFURY")!= OBJECT_INVALID)
   {
   sDeny="You have already taken the anvil from this forge.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

CreateItemOnObject("theanviloffury", oPC);
//AddPersistentJournalQuestEntry("QST_ANVIL", 2, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_ANVIL", 2, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastused", OBJECT_SELF);
AssignCommand(oPC, ActionSpeakString("I should get this to Griswold!"));

effect eEffect;
eEffect = EffectDamage(25, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_FIREBALL), GetLocation(oTarget));

oTarget = GetObjectByTag("PLC_ANVILOFFURY");
DelayCommand(2.0, DestroyObject(oTarget, 0.0));

}
