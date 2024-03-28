#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
if (GetItemPossessedBy(oPC, "D1_FUNGALTOME")!= OBJECT_INVALID)
   {
   sDeny="There is nothing else useful here.";
   SendMessageToPC(oPC, sDeny);
   return;
   }

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");

if (!(nInt < 1))
   return;

CreateItemOnObject("fungaltome", oPC);
AssignCommand(oPC, ActionSpeakString("Hmmm, a fungal tome.  Maybe someone in town might know what this is for..."));
//SendMessageToPC(oPC, "You picked up a fungal tome.  Maybe someone in town might know what it does...");
//ExecuteScript("sav_lastused", OBJECT_SELF);

}
