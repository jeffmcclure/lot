#include "inc_party"
void main()
{

object oPC = GetPCSpeaker();
SetPartyInt(oPC, "butcherquest", 2);
AdjustAlignment(oPC, ALIGNMENT_EVIL, 2);

}
