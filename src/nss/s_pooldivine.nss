void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oCaster;
oCaster = OBJECT_SELF;

object oTarget;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_BLESS, oTarget, METAMAGIC_ANY, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
oCaster = OBJECT_SELF;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_AID, oTarget, METAMAGIC_ANY, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
oCaster = OBJECT_SELF;
oTarget = oPC;
AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oTarget, METAMAGIC_ANY, TRUE, 8, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
FloatingTextStringOnCreature("Your spirit has been reinforced in battle.", oPC);

}
