#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
if (GetItemPossessedBy(oPC, "andystone1")!= OBJECT_INVALID)
   return;

int nInt;
nInt=GetLocalInt(oPC, "andystone1");
if (!(nInt == 0))
   return;

DelayCommand(1.0, AssignCommand(oPC, ActionSpeakString("This door has a small groove near the handle. I need something to place inside it to unlock it.")));
SetPartyInt(oPC, "andystone1", 1);

}

