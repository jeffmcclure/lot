#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nakrultornnote02", oPC);
SetPartyInt(oPC, "tornjournal2", 1);

object oTarget;
oTarget = GetObjectByTag("journalnote2");
DelayCommand(3.0, DestroyObject(oTarget, 0.0));

}

