void main()
{
object oClicker = GetClickingObject();
object oTarget = OBJECT_SELF;
AssignCommand(oTarget, ActionStartConversation(oClicker, "", TRUE));
}
