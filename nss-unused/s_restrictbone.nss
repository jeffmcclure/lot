string sDeny;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "bonechamber");

if (!(nInt == 5))
   {
   sDeny="The smell of the undead is strong here...";

   SendMessageToPC(oPC, sDeny);

   return;
   }

SendMessageToPC(oPC, "You have already been to the Chamber of Bone. Time to move on.");

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("WP_BONEENTRANCE");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

}

