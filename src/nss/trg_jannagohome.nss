void main()
{

object oPC = GetPCSpeaker();

//object oTarget;
//oTarget = GetObjectByTag("JANNA");

//AssignCommand(oTarget, ClearAllActions());
//AssignCommand(oTarget, ActionMoveAwayFromObject(oPC));
//AssignCommand(oTarget, ActionWait(3.0f));
//AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("INVIS_JANNA")));
//ClearAllActions();
//ActionMoveAwayFromObject(oPC);
//ActionWait(3.0f);
ActionJumpToObject(GetObjectByTag("INVIS_JANNA"));

}

