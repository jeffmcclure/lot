#include "inc_party"
object oTarget;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_CHAMBER");
if (nInt == 2)
   {
   oTarget = GetObjectByTag("CHAMBER_2CATACOMBS2");
   AssignCommand(oTarget, ActionCloseDoor(oTarget));
   SetLocked(oTarget, TRUE);
   //SendMessageToPC(oPC, "You are trapped in this chamber!");
   FloatingTextStringOnCreature("You are trapped in this chamber!", oPC);

   }
else
   {
   oTarget = GetObjectByTag("CHAMBER_2CATACOMBS2");
   SetLocked(oTarget, FALSE);
   AssignCommand(oTarget, ActionOpenDoor(oTarget));
   //SendMessageToPC(oPC, "You hear a door unlock and open up somewhere...");

   }

}
