string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_CHAMBER");

if (!(nInt >= 3))
   {
   sDeny="You have not fulfilled the quest requirements...";

   SendMessageToPC(oPC, sDeny);

   return;
   }

nInt=GetLocalInt(oPC, "bonechest2");

if (!(nInt == 0))
   {
   sDeny="You have already accessed this chest...";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oTarget;
oTarget = OBJECT_SELF;

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

ExecuteScript("loot_unique", OBJECT_SELF);

//SetLocalInt(oPC, "bonechest2", 1);

//oTarget = OBJECT_SELF;

//DelayCommand(10.0, AssignCommand(oTarget, ActionCloseDoor(oTarget)));

//DelayCommand(10.0, SetLocked(oTarget, TRUE));

}
