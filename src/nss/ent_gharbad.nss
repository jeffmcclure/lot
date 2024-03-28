void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_GHARBAD");

if (!(nInt == 1))
   return;

//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_GHARBAD");

//if (!(nInt < 2))
//   return;

nInt = GetLocalInt(oPC, "gharbad");
nInt += 1;
SetLocalInt(oPC, "gharbad", nInt);

}
