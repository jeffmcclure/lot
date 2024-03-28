void main()
{

object oPC = GetLastKiller();
if (!GetIsPC(oPC)) return;

AdjustAlignment(oPC, ALIGNMENT_EVIL, 2);

}
