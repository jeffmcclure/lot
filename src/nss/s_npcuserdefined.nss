void main()
{
  int nEvent = GetUserDefinedEventNumber();
  if (nEvent == 1002) // OnPerceive event
  {
    object oPC = GetLastPerceived();
    if(GetIsPC(oPC) && GetLocalInt(oPC, "Dlg_Init_" + GetTag(OBJECT_SELF)) == FALSE && !IsInConversation(OBJECT_SELF))
    {
      ClearAllActions();
      AssignCommand(oPC, ClearAllActions());
      ActionMoveToObject(oPC);
      ActionStartConversation(oPC);
    }
  }
}
