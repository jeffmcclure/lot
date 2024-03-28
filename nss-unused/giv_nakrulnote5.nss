#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nakrulnote005", oPC);
SetPartyInt(oPC, "nakrulnote5", 1);

}

