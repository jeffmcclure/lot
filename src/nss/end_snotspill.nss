#include "NW_I0_GENERIC"
void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_OGDENSIGN");
if (nInt == 1)
   {
    AddJournalQuestEntry("QST_MAGICBANNER", 2, oPC, TRUE, FALSE);
    //AddJournalQuestEntry("QST_OGDENSIGN", 3, oPC, TRUE, FALSE);
    object oTarget;
    oTarget = OBJECT_SELF;
    ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);
    SetIsTemporaryEnemy(GetPCSpeaker());
    DetermineCombatRound();

   }
else
   {
    AddJournalQuestEntry("QST_MAGICBANNER", 2, oPC, TRUE, FALSE);
    object oTarget;
    oTarget = OBJECT_SELF;
    ChangeToStandardFaction(oTarget, STANDARD_FACTION_HOSTILE);
    SetIsTemporaryEnemy(GetPCSpeaker());
    DetermineCombatRound();

   }

}

