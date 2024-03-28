//#include "pqj_inc"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_CHAMBER");
if (!(nInt < 3))
   return;

if (GetItemPossessedBy(oPC, "D1_CALCIUMCRYSTAL")== OBJECT_INVALID)
   {
   sDeny="You must possess a white crystal to make this lever work.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

//AddPersistentJournalQuestEntry("QST_CHAMBER", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_CHAMBER", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastused", OBJECT_SELF);

object oTarget;

oTarget = GetObjectByTag("DOOR_BONE4");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_BONE5");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

SendMessageToPC(oPC, "You hear the sound of doors opening up somewhere...");

}

