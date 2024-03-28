#include "inc_party"
string sDeny;
void main()
{

object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_DEMONBRAIN")!= OBJECT_INVALID)
   {
   sDeny="You already have a demon brain!";
   SendMessageToPC(oPC, sDeny);
   return;
   }

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MUSHROOM");
if (!(nInt == 3))
   return;

CreateItemOnObject("demonbrainx", oPC);
FloatingTextStringOnCreature("You obtained a demon brain!", oPC);
AssignCommand(oPC, ActionSpeakString("A demon brain!  I need to get this back to Pepin!"));
//SendMessageToPC(oPC, "You acquired a demon brain!");
//ecuteScript("sav_lastkilled", OBJECT_SELF);

}
