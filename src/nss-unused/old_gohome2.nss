effect eEffect;
object oTarget;
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "andariel");

if (nInt == 5)
   {
    RewardPartyXP(500, oPC, TRUE);
    RewardPartyGP(10000, oPC, TRUE);

    object oTarget;
    oTarget = GetObjectByTag("DOOR_ANDARIEL");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("PORTAL_TRISTRAM2");

    //Visual effects can't be applied to waypoints, so if it is a WP
    //apply to the WP's location instead

    int nInt;
    nInt = GetObjectType(oTarget);

    if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
    else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

    oTarget = GetObjectByTag("WP_TEMPLERUINS");

    DestroyObject(oTarget, 3.0);

    ExecuteScript("trg_teleportall", OBJECT_SELF);
   }
else
   {
   SendMessageToPC(oPC, "You cannot use this portal because you did not kill Andariel...");
   }
}
