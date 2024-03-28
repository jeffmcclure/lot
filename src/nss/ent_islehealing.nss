void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

object oCaster;
oCaster = GetObjectByTag("INVIS_HEALING");

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}

