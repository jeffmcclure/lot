//trapdoor_yes script by Kerico 7/7/02
//jumps the using PC to target waypoint and closes the trapdoor for next use
//place in action taken scipt in trapdoor conversation
//in 'yes' end dialog of the trapdoor

void main()
{

//get the pc who used the trapdoor
object oPC = GetLastUsedBy();

//get the target waypoint destination
object oDrop = GetWaypointByTag("WP_HIVE1");

//jump the PC to the destination
AssignCommand (oPC,JumpToObject(oDrop));

//close the trapdoor
PlayAnimation (ANIMATION_PLACEABLE_CLOSE);

}
