void main()
{

object oPC = GetPCSpeaker();

object oCaster;
oCaster = OBJECT_SELF;

object oTarget;
oTarget = oPC;

ActionPauseConversation();
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
ActionResumeConversation();

}

