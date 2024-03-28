void main()
{

object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("DOOR_LAZARUS2");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

//SendMessageToPC(oPC, "You hear a door opening somewhere in this area...");
AssignCommand(oPC, ActionSpeakString("I hear a door opening somewhere in this area..."));

}
