/////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - OnUse Turn Light OFF/ON
//--------------------------------------------------
// By Deva Bryson Winblood.
/////////////////////////////////////////////////////
// SCRIPT: npcact_use_light
/////////////////////////////////////////////////////

void main()
{
  object oUser=GetLastUsedBy();
  if (oUser!=OBJECT_INVALID)
  { // !OI
    int nOffOn=GetLocalInt(oUser,"nOffOn");
    AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0,2.0));
    if (nOffOn==0) // off
    { // Off
      ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0);
    } // off
    else
    { // on
      ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
    } // on
  } // !OI
}
