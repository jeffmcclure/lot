void main()
{

object oPC = GetLastUnlocked();
if (!GetIsPC(oPC)) return;

AdjustAlignment(oPC, ALIGNMENT_EVIL, 2);

}
