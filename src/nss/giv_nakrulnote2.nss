#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("nakrulnote002", oPC);
SetPartyInt(oPC, "nakrulnote2", 1);

}

