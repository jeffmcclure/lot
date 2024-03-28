string sDeny;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "D1_CALCIUMCRYSTAL")== OBJECT_INVALID)
   {
   sDeny="You must possess a white crystal to make this lever work.";

   SendMessageToPC(oPC, sDeny);

   return;
   }

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_CALCIUMCRYSTAL");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

SetLocalInt(oPC, "bonechamber", 5);

object oTarget;
oTarget = GetObjectByTag("DOOR_BONE4");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_BONE5");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

SendMessageToPC(oPC, "You hear the sound of doors unlocking from a distance...");

}
