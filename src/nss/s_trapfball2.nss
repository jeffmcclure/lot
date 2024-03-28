void main()
{

object oPC = GetFirstPC();
//object oPC = GetLastKiller();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;

object oCaster;
oCaster = GetObjectByTag("INVIS_TRAP2");

object oTarget;
oTarget = oPC;

AssignCommand(oCaster, ActionCastSpellAtObject(SPELL_FIREBALL, oTarget, METAMAGIC_ANY, TRUE, 1, PROJECTILE_PATH_TYPE_DEFAULT, TRUE));

oTarget = GetObjectByTag("INVIS_TRAP2");
DelayCommand(3.0, DestroyObject(oTarget, 0.0));

}
