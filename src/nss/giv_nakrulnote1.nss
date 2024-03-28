#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nakrulnote001", oPC);
SetPartyInt(oPC, "nakrulnote1", 1);

}

