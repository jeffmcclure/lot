string sDeny;
void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = OBJECT_SELF;

SetLocked(oTarget, FALSE);

ExecuteScript("loot_unique", OBJECT_SELF);

oTarget = OBJECT_SELF;

DelayCommand(15.0, SetLocked(oTarget, TRUE));

}
