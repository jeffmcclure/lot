#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();

CreateItemOnObject("staffoflazarus", oPC);
SetPartyInt(oPC, "lazarus", 1);
AssignCommand(oPC, ActionSpeakString("I need to show this staff to Cain!"));
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

