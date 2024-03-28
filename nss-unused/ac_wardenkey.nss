void main()
{

object oPC = GetModuleItemAcquiredBy();
object oItem;
oItem = GetModuleItemAcquired();
if (!GetIsPC(oPC)) return;
if (GetLocalInt(GetModule(), "ac_"+GetTag(oItem))) return;
SetLocalInt(GetModule(), "ac_"+GetTag(oItem), TRUE);

DelayCommand(2.0, AssignCommand(oPC, ActionSpeakString("This key looks like it's supposed to be for a jailroom of some kind.  Maybe I can use this to open a door in this area...")));

}
