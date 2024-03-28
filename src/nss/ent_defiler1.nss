#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int DoOnce = GetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetPartyInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
oTarget = GetObjectByTag("INVIS_DEFILER1");
AssignCommand(oTarget, ActionStartConversation(oPC, "con_defiler1"));

AddJournalQuestEntry("QST_DEFILER", 1, oPC, TRUE, FALSE);

}

