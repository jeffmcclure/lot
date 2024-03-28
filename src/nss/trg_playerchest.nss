void main()
{

object oPC = GetLastOpenedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

AssignCommand(oPC, ActionSpeakString("Hmm, this chest is empty, but I think I can safely put items here for safekeeping..."));

}
