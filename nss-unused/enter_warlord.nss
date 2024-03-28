void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WARLORD");

if (!(nInt == 4))
   return;

SetLocalInt(oPC, "rackarmor", 1);

SetLocalInt(oPC, "rackweapon", 1);

}
