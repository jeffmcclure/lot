void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_COW");
if (nInt >= 1)
   {
   SetLocalInt(oPC, "password", 1);

   SetLocalInt(oPC, "cowtalk", 1);

   }
}
