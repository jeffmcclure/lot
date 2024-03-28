//:::::::::::::::::::::::::::::::::::::::::::::::::::
//::69_henchtrans  By: 69MEH69 Date: Jan2003
//::Place this script in the AreaOnTransitonClick
//::event for any in area transition, a transition
//::which takes the PC to another location within
//::the same area. This script will insure that any
//::henchman, familiar, animal companion, summoned
//::and/or dominated creature will also make the
//::transition.
//::Put a check in for whether the associate is
//::standing their ground, If the henchman is they will
//::NOT transition
//:::::::::::::::::::::::::::::::::::::::::::::::::::
#include "69_inc_henai"
void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  location lLoc = GetLocation(oTarget);
  object oHench = GetHenchman(oClicker);
  object oFamiliar, oAnimal, oSummoned, oDominated;
  float fFace = GetFacingFromLocation(lLoc);
  AssignCommand(oClicker,JumpToLocation(lLoc));
  AssignCommand(oClicker, SetFacing(fFace));

  if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oClicker) != OBJECT_INVALID)
  {
    oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oClicker);
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oFamiliar))
    {
     AssignCommand(oFamiliar, JumpToLocation(lLoc));
    }
  }
  if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oClicker) != OBJECT_INVALID)
  {
    oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oClicker);
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oAnimal))
    {
     AssignCommand(oAnimal, JumpToLocation(lLoc));
    }
  }
  if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oClicker) != OBJECT_INVALID)
  {
    oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oClicker);
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oSummoned))
    {
     AssignCommand(oSummoned, JumpToLocation(lLoc));
    }
  }
  if(GetAssociate(ASSOCIATE_TYPE_DOMINATED, oClicker) != OBJECT_INVALID)
  {
    oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oClicker);
    if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oDominated))
    {
     AssignCommand(oDominated, JumpToLocation(lLoc));
    }
  }
  while(GetHenchman(oClicker) != OBJECT_INVALID)
  {
   if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND, oHench))
   {
    AssignCommand(oHench, JumpToLocation(lLoc));

    if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oHench) != OBJECT_INVALID)
    {
      oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oHench);
      AssignCommand(oFamiliar, JumpToLocation(lLoc));
    }
    if(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oHench) != OBJECT_INVALID)
    {
      oAnimal = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oHench);
      AssignCommand(oAnimal, JumpToLocation(lLoc));
    }
    if(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oHench) != OBJECT_INVALID)
    {
      oSummoned = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oHench);
      AssignCommand(oSummoned, JumpToLocation(lLoc));
    }
    if(GetAssociate(ASSOCIATE_TYPE_DOMINATED, oHench) != OBJECT_INVALID)
    {
      oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oHench);
      AssignCommand(oDominated, JumpToLocation(lLoc));
    }
   }
    oClicker = oHench;
    oHench = GetHenchman(oClicker);
   }
}
