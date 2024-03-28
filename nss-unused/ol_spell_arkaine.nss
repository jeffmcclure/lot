void main()
{

object oPC = GetPCItemLastUnequippedBy();

object oItem;
oItem = GetPCItemLastUnequipped();

if (!GetIsPC(oPC)) return;

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_DISPELLING, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_DISPELLING, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oCaster = oPC;

oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_DISPELLING, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
