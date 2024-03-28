void main()
{

object oPC = GetPCSpeaker();

//object oTarget;
//oTarget = GetObjectByTag("TKRON");

//AssignCommand(oTarget, ClearAllActions());
//AssignCommand(oTarget, ActionMoveAwayFromObject(oPC));
//AssignCommand(oTarget, ActionWait(3.0f));
//AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("POST_TKRON")));
//ClearAllActions();
//ActionMoveAwayFromObject(oPC);
//ActionWait(3.0f);
ActionJumpToObject(GetObjectByTag("INVIS_TKRON"));

}

