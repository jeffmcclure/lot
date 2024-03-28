#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

SetPartyInt(oPC, "cathedral2", 1);

}
