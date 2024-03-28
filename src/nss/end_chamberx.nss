#include "inc_party"
//#include "pqj_inc"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "bonelever3");
if (!(nInt == 0))
   return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_CHAMBER");
if (!(nInt < 3))
   return;

//if (GetItemPossessedBy(oPC, "D1_CALCIUMCRYSTAL")== OBJECT_INVALID)
//   {
//   sDeny="You must possess a white crystal to make this lever work.";
//   SendMessageToPC(oPC, sDeny);
//   return;
//   }

//AddPersistentJournalQuestEntry("QST_CHAMBER", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_CHAMBER", 3, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastused", OBJECT_SELF);

//object oTarget;

    if (GetPartyInt(OBJECT_SELF, "bPulled3") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetPartyInt(OBJECT_SELF, "bPulled3", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetPartyInt(OBJECT_SELF, "bPulled3", FALSE);
    }

SetPartyInt(oPC, "bonechamber", 5);
SetPartyInt(oPC, "bonelever3", 1);

object oTarget;
oTarget = GetObjectByTag("DOOR_BONE4");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_BONE5");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

//AssignCommand(oPC, ActionSpeakString("I hear doors opening up somewhere in this chamber!"));
FloatingTextStringOnCreature("The treasure room doors and the chamber exit have been unlocked!", oPC);
DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("I am now free to leave this chamber!  But I must check out the treasure room first...")));

}

