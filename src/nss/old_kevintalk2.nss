void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_TECILDEFENDER");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "tecildefender", lTarget);
oTarget = oSpawn;
ActionStartConversation(oPC, "con_defender1");
//AssignCommand(oTarget, ActionStartConversation(oPC, ""));

}

