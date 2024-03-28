string sDeny;
void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "blind");

if (!(nInt <= 4))
   {
   sDeny="You have already used this chest before. Time to move on.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

//SetLocalInt(oPC, "blind", 5);

object oTarget;
oTarget = OBJECT_SELF;

SetLocked(oTarget, FALSE);

ExecuteScript("loot_unique", OBJECT_SELF);

oTarget = OBJECT_SELF;

DelayCommand(10.0, SetLocked(oTarget, TRUE));

}
