object oTarget;
void main()
{

object oPC = GetModuleItemAcquiredBy();

object oItem;
oItem = GetModuleItemAcquired();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "tornjournal1")!= OBJECT_INVALID)
   {
   if (GetItemPossessedBy(oPC, "tornjournal3")!= OBJECT_INVALID)
       {
          oTarget = GetObjectByTag("tornjournal1");
          DestroyObject(oTarget, 0.0);
          oTarget = GetObjectByTag("tornjournal2");
          DestroyObject(oTarget, 0.0);
          oTarget = GetObjectByTag("tornjournal3");
          DestroyObject(oTarget, 0.0);
          CreateItemOnObject("constructednote", oPC);
          oTarget = GetObjectByTag("D1_RECONSTRUCTEDNOTE2");
          AssignCommand(oTarget, ActionStartConversation(oPC, "con_journalnote"));
          AddJournalQuestEntry("QST_NAKRUL", 3, oPC, TRUE, FALSE);
       }
   }
}
