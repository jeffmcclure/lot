object oTarget;
//#include "pqj_inc"
//#include "nw_i0_tool"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");
if (!(nInt >= 2))
   {
   sDeny="You need to talk to Cain first...";
   SendMessageToPC(oPC, sDeny);
   return;
   }

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_ARKAINE");
if (!(nInt < 3))
   {
   sDeny="There is nothing else interesting in this vault.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY, oPC))
   {
   CreateItemOnObject("arkainesvalor", oPC);
   ExecuteScript("trg_arkaine", OBJECT_SELF);

   }
else if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM, oPC))
   {
   CreateItemOnObject("arkainesvalor3", oPC);
   ExecuteScript("trg_arkaine", OBJECT_SELF);

   }
else if (GetHasFeat(FEAT_ARMOR_PROFICIENCY_LIGHT, oPC))
   {
   CreateItemOnObject("arkainesvalor2", oPC);
   ExecuteScript("trg_arkaine", OBJECT_SELF);

   }
else
   {
   CreateItemOnObject("arkainesvalor4", oPC);
   ExecuteScript("trg_arkaine", OBJECT_SELF);

   }

}
