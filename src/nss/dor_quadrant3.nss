#include "nw_i0_generic"
#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();

SetPartyInt(oPC, "diablokill", 1);

SendMessageToPC(oPC, "You need to pull one more lever to open up the remaining quadrant!");

}
