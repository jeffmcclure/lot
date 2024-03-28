string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WARLORD");

if (!(nInt >= 3))
   {
   sDeny="You cannot access this rack until you have killed the Warlord of Blood";

   SendMessageToPC(oPC, sDeny);

   return;
   }

nInt=GetLocalInt(oPC, "rackweapon");

if (!(nInt == 0))
   {
   sDeny="You cannot access this rack again at this time...";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oTarget;
oTarget = OBJECT_SELF;

SetLocked(oTarget, FALSE);

//AssignCommand(oTarget, ActionOpenDoor(oTarget));

ExecuteScript("loot_unique", OBJECT_SELF);

//SetLocalInt(oPC, "bonechest1", 1);

//oTarget = OBJECT_SELF;

//DelayCommand(10.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));

//DelayCommand(10.0, SetLocked(oTarget, TRUE));

}
