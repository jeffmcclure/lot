#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nakrulnote003", oPC);
SetPartyInt(oPC, "nakrulnote3", 1);

}

