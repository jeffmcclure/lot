/////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - OnUse Anvil
//--------------------------------------------------
// By Deva Bryson Winblood.
/////////////////////////////////////////////////////
// SCRIPT: npcact_use_anvil
/////////////////////////////////////////////////////

void MainAction(object oUser)
{ // do action
  effect eSpark=EffectVisualEffect(VFX_COM_SPARKS_PARRY);
  object oMe=GetNearestObjectByTag("Anvil",oUser,1);
  AssignCommand(oUser,ActionAttack(oMe,TRUE));
  DelayCommand(4.0,AssignCommand(oUser,ActionAttack(oMe,TRUE)));
  DelayCommand(15.8,AssignCommand(oUser,ClearAllActions()));
  DelayCommand(16.0,AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0,4.0)));
} // do action


void main()
{
  object oUser=GetLastUsedBy();
  object oPrimary=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oUser);
  int nHasHammer=FALSE;
  effect eDom=EffectCutsceneDominated();
  if (TestStringAgainstPattern("(**hammer**|**Hammer**)",GetName(oPrimary))) nHasHammer=TRUE;
  if (oUser!=OBJECT_INVALID&&nHasHammer)
  { //!OI
    if (GetIsPC(oUser))
    { // PC
      MainAction(oUser);
    } // PC
    else
    { // NPC
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDom,oUser,18.0);
      AssignCommand(oUser,ClearAllActions());
      SetLocalInt(oUser,"nGNBDisabled",TRUE);
      MainAction(oUser);
      DelayCommand(18.0,SetLocalInt(oUser,"nGNBDisabled",FALSE));
    } // NPC
  } //!OI
  else if (!nHasHammer)
  {
    AssignCommand(oUser,ActionSpeakString("Trying to work an anvil without a hammer is fools play!"));
  }
}
