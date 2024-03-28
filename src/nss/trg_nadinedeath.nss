#include "nw_i0_tool"
void main()
{

object oPC = GetFirstPC();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;
object oTarget;

ActionSpeakString("Hahaha, my mistress will deal with you soon!");
DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("Your 'mistress' eh?  We shall see...")));

}
