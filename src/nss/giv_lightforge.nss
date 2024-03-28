#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
CreateItemOnObject("lightforgex", oPC);
SetPartyInt(oPC, "lightforge", 1);

}

