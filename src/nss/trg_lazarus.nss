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

   SendMessageToPC(oPC, "Abandon your foolish quest! All that awaits you is the wrath of my master!");

   SendMessageToPC(oPC, "You are too late to save the child...  Now you will join him - in hell!");

   }
else
   {
   SendMessageToPC(oPC, "You must return during the night time to face Lazarus...");

   }

}

