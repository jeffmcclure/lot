//#include "pqj_inc"
#include "nw_i0_tool"
string sDeny;
void main()
{

object oPC = GetLastKiller();

while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WATERSUPPLY");

if (!(nInt < 3))
   {
   sDeny="You have already done this quest";

   SendMessageToPC(oPC, sDeny);

   return;
   }

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WATERSUPPLY");

if (!(nInt > 0))
   {
   sDeny="You have not fulfilled the requirements of this quest.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oArea = GetArea(OBJECT_SELF);
//object oDst = GetWaypointByTag("WP_WATERSUPPLY");

while (oPC != OBJECT_INVALID)
    {
    if (GetArea(oPC) == oArea)
        {
        RewardPartyXP(750, oPC, TRUE);
        //RewardPartyGP(500, oPC, TRUE);
        //AddPersistentJournalQuestEntry("QST_WATERSUPPLY", 2, oPC, FALSE, FALSE);
        AddJournalQuestEntry("QST_WATERSUPPLY", 2, oPC, TRUE, FALSE);
        SendMessageToPC(oPC, "The underground spring has been purified!");
        //ExecuteScript("sav_lastkilled", OBJECT_SELF);
        //AssignCommand(oPC, ClearAllActions());
        //AssignCommand(oPC, JumpToObject(oDst));
        }
    oPC = GetNextPC();
    }

object oTarget;
oTarget = GetObjectByTag("WP_WATERFX1");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

effect eEffect;
eEffect = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_WATERFX2");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(2.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_WATERFX3");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(3.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_WATERFX4");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(4.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(4.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

oTarget = GetObjectByTag("WP_WATERFX5");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

nInt = GetObjectType(oTarget);

eEffect = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

if (nInt != OBJECT_TYPE_WAYPOINT)
   DelayCommand(5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget));
else
   DelayCommand(5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, GetLocation(oTarget)));

}
