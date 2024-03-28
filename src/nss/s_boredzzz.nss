void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("FARNHAM");
AssignCommand(oTarget, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 5.0f));

}

