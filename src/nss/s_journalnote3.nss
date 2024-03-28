#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nakrultornnote03", oPC);
SetPartyInt(oPC, "tornjournal3", 1);

object oTarget;
oTarget = GetObjectByTag("journalnote3");
DelayCommand(3.0, DestroyObject(oTarget, 0.0));

}

