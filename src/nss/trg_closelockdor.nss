void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = OBJECT_SELF;

DelayCommand(600.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));

DelayCommand(600.0, SetLocked(oTarget, TRUE));

}
