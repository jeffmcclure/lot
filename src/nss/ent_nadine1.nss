#include "inc_party"
location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "nadine");

if (!(nInt == 0))
   return;

if ((GetGender(oPC)!=GENDER_FEMALE))
   {
   oTarget = GetWaypointByTag("WP_NADINE_SPAWN");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "nadine", lTarget);
   oTarget = oSpawn;
   AssignCommand(oTarget, ActionStartConversation(oPC, ""));
   AssignCommand(GetObjectByTag("NADINE"), ActionSpeakString("Help!  Please help me!!"));
   SetPartyInt(oPC, "nadine", 1);
   }
else
   {
   SetPartyInt(oPC, "nadine", 1);
   }

}
