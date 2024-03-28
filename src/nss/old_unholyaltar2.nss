void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

SetLocalInt(oPC, "lazarus", 2);

object oTarget;
oTarget = GetObjectByTag("INVIS_UNHOLYALTAR");
AssignCommand(oTarget, ActionStartConversation(oPC, "con_lazarus"));

}

