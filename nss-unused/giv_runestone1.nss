string sDeny;
#include "inc_party"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_RUNESTONE1")!= OBJECT_INVALID)
   {
   sDeny="There are no more runestones in this altar.  You can probably find more runestones in altars like this somewhere else.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

int nInt;
nInt=GetPartyInt(oPC, "rune001");
if (!(nInt == 0))
   {
   sDeny="There are no more runestones in this altar.  You can probably find more runestones in altars like this somewhere else.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

CreateItemOnObject("rune001", oPC);
SetPartyInt(oPC, "rune001", 1);
FloatingTextStringOnCreature("You have obtained a runestone...", oPC);
DelayCommand(2.0, AssignCommand(oPC, ActionSpeakString("Hmm, a runestone.   It seems to be a part of three separate runestones, based on the etches on its side.  Maybe all three of them together is supposed to do something...")));

}
