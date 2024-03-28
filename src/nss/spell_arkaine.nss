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
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_NEGATIVE_ENERGY_PROTECTION, oTarget, METAMAGIC_ANY, TRUE, 1, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_WORD_OF_FAITH, oTarget, METAMAGIC_ANY, TRUE, 2, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FREEDOM_OF_MOVEMENT, oTarget, METAMAGIC_ANY, TRUE, 3, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_HASTE, oTarget, METAMAGIC_ANY, TRUE, 3, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
