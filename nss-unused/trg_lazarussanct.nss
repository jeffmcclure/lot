location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetIsNight())
   {
   oTarget = GetObjectByTag("DOOR_LAZARUS1");

   SetLocked(oTarget, FALSE);

   AssignCommand(oTarget, ActionOpenDoor(oTarget));

//   SetLocalInt(oPC, "lazarus", 1);

   }
else
   {
   SendMessageToPC(oPC, "You must return during the night time for the doors to open");

   }

}

