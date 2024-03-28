effect eEffect;
object oTarget;
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "diablokill");

if (nInt == 5)
   {
    RewardPartyGP(25000, oPC, TRUE);

    object oTarget;
    oTarget = GetObjectByTag("DOOR_QUADRANT2A");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT2B");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT2C");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT3A");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT3B");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT3C");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT3D");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT4A");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT4B");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT4C");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("DOOR_QUADRANT4D");

    AssignCommand(oTarget, ActionCloseDoor(oTarget));

    SetLocked(oTarget, TRUE);

    oTarget = GetObjectByTag("PORTAL_TRISTRAM");

    //Visual effects can't be applied to waypoints, so if it is a WP
    //apply to the WP's location instead

    int nInt;
    nInt = GetObjectType(oTarget);

    if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), oTarget);
    else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_UNSUMMON), GetLocation(oTarget));

    oTarget = GetObjectByTag("PORTAL_TRISTRAM");

    DestroyObject(oTarget, 3.0);

    ExecuteScript("trg_teleportall", OBJECT_SELF);
   }
else
   {
   SendMessageToPC(oPC, "You cannot use this portal because you did not kill Diablo...");
   }
}
