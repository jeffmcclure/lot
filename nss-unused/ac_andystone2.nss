void main()
{

object oPC = GetModuleItemAcquiredBy();
object oItem;
oItem = GetModuleItemAcquired();
if (!GetIsPC(oPC)) return;
if (GetLocalInt(oPC, "ac_"+GetTag(oItem))) return;
SetLocalInt(oPC, "ac_"+GetTag(oItem), TRUE);

int nInt;
nInt=GetLocalInt(oPC, "rune002");
if (nInt == 0)
   {
   SetLocalInt(oPC, "rune002", 1);
   DelayCommand(2.0, AssignCommand(oPC, ActionSpeakString("Hmm, a runestone.  It seems to be a part of three separate runestones, based on the etches on its side.  Maybe all three of them together is supposed to do something...")));

   }
}
