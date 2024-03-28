object oTarget;
object oCaster;
#include "inc_party"
#include "nw_i0_tool"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BLIND");
if (nInt < 3)
   {
   RewardPartyXP(750, oPC, TRUE);
   RewardPartyGP(1000, oPC, TRUE);
   AddJournalQuestEntry("QST_BLIND", 3, oPC, TRUE, FALSE);
   ExecuteScript("loot_unique", OBJECT_SELF);

   oCaster = OBJECT_SELF;
   oTarget = oPC;
   AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_TRUE_SEEING, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

   }
else
   {
   ExecuteScript("loot_unique", OBJECT_SELF);
   }

}
