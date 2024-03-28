void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

object oCaster;
oCaster = OBJECT_SELF;

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_DARKVISION, oTarget, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

SendMessageToPC(oPC, "You can see better now...");

}

