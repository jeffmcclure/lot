void main()
{

object oPC = GetLastKiller();
while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("DOOR_LAZARUS3");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

oTarget = GetObjectByTag("DOOR_LAZARUS4");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));

//SendMessageToPC(oPC, "You hear the doors opening somewhere in this area...");
AssignCommand(oPC, ActionSpeakString("I hear doors opening somewhere in this area..."));

}
