void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
object oCaster;
oCaster = OBJECT_SELF;

object oTarget;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_CURE_CRITICAL_WOUNDS, oTarget, METAMAGIC_ANY, TRUE, 10, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
FloatingTextStringOnCreature("You feel refreshed.", oPC);

}

