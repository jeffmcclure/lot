#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nakrultornnote01", oPC);
SetPartyInt(oPC, "tornjournal1", 1);

object oTarget;
oTarget = GetObjectByTag("journalnote1");
DelayCommand(3.0, DestroyObject(oTarget, 0.0));

}

