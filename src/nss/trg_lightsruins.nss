#include "inc_party"
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_LIGHTS");
if (!(nInt >= 1))
   return;

nInt=GetPartyInt(oPC, "ruinslights");
if (!(nInt == 0))
   return;

nInt=GetPartyInt(oPC, "northlights");
if (nInt == 1)
   {
   AssignCommand(oPC, ActionSpeakString("These lights are also strong in this place... I should go inside and investigate, but I must be careful - I feel the foes here are much stronger..."));
   SetPartyInt(oPC, "ruinslights", 1);

   }
else
   {
   AssignCommand(oPC, ActionSpeakString("The strange lights Gillian mentioned are emanating from this place... Perhaps I can find the answers inside these ruins, but I must be careful..."));
   SetPartyInt(oPC, "ruinslights", 1);

   }

}
