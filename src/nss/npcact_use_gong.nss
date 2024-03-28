/////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - OnUse Gong
//--------------------------------------------------
// By Deva Bryson Winblood.
/////////////////////////////////////////////////////
// SCRIPT: npcact_use_gong
/////////////////////////////////////////////////////

void main()
{
    object oUser=GetLastUsedBy();
    object oMe=OBJECT_SELF;
    AssignCommand(oUser,ClearAllActions());
    AssignCommand(oUser,ActionAttack(oMe,TRUE));
    DelayCommand(5.0,AssignCommand(oUser,ClearAllActions()));
    DelayCommand(1.0,ActionSpeakString("* DONG *"));
    DelayCommand(1.0,PlaySound("as_cv_bell2"));
    DelayCommand(1.0,ActionWait(1.0f));
}
