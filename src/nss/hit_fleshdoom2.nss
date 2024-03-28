void main()
{

//object oPC = GetLastDamager();
//
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("NPC_FLESHDOOM2");

AssignCommand(oTarget, ClearAllActions());
AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("INVIS_JUMPPOINT")));

}

