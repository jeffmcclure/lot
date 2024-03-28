//#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "cathedral1");

if (!(nInt == 0))
   return;

AssignCommand(oPC, ActionSpeakString("The sanctity of this place has been fouled..."));
SetLocalInt(oPC, "cathedral1", 1);

}
