void main()
{

object oPC = GetExitingObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
oTarget = GetObjectByTag("OUTSKIRTS_CORPSE1");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("OUTSKIRTS_CORPSE2");
DestroyObject(oTarget, 0.0);

}
