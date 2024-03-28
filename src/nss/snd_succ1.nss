void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;

oTarget = GetObjectByTag("SND_SUCC1");
SoundObjectStop(oTarget);

oTarget = GetObjectByTag("SND_SUCC2");
SoundObjectStop(oTarget);

}
