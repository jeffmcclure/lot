#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_FLESHDOOM");
if (!(nInt >= 1))
   return;

nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_FLESHDOOM");
if (!(nInt < 3))
   return;

nInt=GetPartyInt(oPC, "fleshspawn1");
if (!(nInt == 0))
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("WP_FLESHDOOM1");

lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "fleshdoom_dummy", lTarget);

SetPartyInt(oPC, "fleshspawn1", 1);
AddJournalQuestEntry("QST_FLESHDOOM", 2, oPC, TRUE, FALSE);

AssignCommand(GetObjectByTag("NPC_FLESHDOOM"), ActionSpeakString("Hahaha, my name is Fleshdoom!  Catch me if you can!"));

oTarget = GetObjectByTag("NPC_FLESHDOOM1");
AssignCommand(oTarget, ClearAllActions());
AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("FADE_FLESHDOOM1")));

oTarget = GetObjectByTag("NPC_FLESHDOOM1");
AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("WP_GENERICJUMP")));

}
