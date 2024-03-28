void main()
{

object oPC = GetPCSpeaker();

//object oTarget;
//oTarget = GetObjectByTag("MELLO");

//AssignCommand(oTarget, ClearAllActions());
//AssignCommand(oTarget, ActionMoveAwayFromObject(oPC));
//AssignCommand(oTarget, ActionWait(3.0f));
//AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("POST_MELLO")));
//ClearAllActions();
//ActionMoveAwayFromObject(oPC);
//ActionWait(3.0f);
ActionJumpToObject(GetObjectByTag("INVIS_MELLO"));

}

