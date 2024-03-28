void main()
{

object oPC = GetLastKiller();

while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ANDARIEL");
if (nInt < 3)
   {
    ExecuteScript("xp_partyextra", OBJECT_SELF);
    ExecuteScript("vfx_andydeath", OBJECT_SELF);
    ExecuteScript("trg_andydeath", OBJECT_SELF);
    ExecuteScript("trg_andydethport", OBJECT_SELF);
    ExecuteScript("loot_unique", OBJECT_SELF);

   }
else
   {
    ExecuteScript("xp_partyextra", OBJECT_SELF);
    ExecuteScript("vfx_andydeath", OBJECT_SELF);
    ExecuteScript("trg_andydethport", OBJECT_SELF);
    ExecuteScript("loot_normal_boss", OBJECT_SELF);

   }

}
