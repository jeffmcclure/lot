void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

SendMessageToPC(oPC, "Ahhhh, fresh meat!");

DelayCommand(10.0, ActionCloseDoor(OBJECT_SELF));

}

