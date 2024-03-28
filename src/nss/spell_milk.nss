void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();
object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_HEAL, oTarget, METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oTarget, METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_BULLS_STRENGTH, oTarget, METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_ENDURANCE, oTarget, METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_CATS_GRACE, oTarget, METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_STONESKIN, oTarget, METAMAGIC_ANY, TRUE, 5, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

AssignCommand(oPC, ActionSpeakString("BURP"));

}
