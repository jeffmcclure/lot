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
oTarget = GetObjectByTag("NPC_FLESHDOOM1");

AssignCommand(oTarget, ClearAllActions());
AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("INVIS_JUMPPOINT")));

}

