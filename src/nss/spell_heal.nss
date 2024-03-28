void main()
{
object oPC;

if ((GetObjectType(GetItemActivatedTarget())!=OBJECT_TYPE_CREATURE)
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();

object oCaster;
oCaster = oPC;

object oTarget;
oTarget = GetItemActivatedTarget();

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_HEAL, oTarget, METAMAGIC_ANY, TRUE, 15, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

}
