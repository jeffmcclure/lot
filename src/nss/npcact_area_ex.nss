////////////////////////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - On Area Exit  (required for LAG and some other commands)
//=============================================================================
//  By Deva Bryson Winblood.  02/2003
//=============================================================================
// This script decrease count of PCs in area and IF there are 0 NPCs it will
// check NPCs to see if any are set to LAG4.  If they are it will add their
// ResRef to the Stack for the area and then it will Destroy them.
////////////////////////////////////////////////////////////////////////////////

#include "npcactstackh"

void main()
{
  object oPC=GetExitingObject();
  int nGNBPCs=GetLocalInt(OBJECT_SELF,"nGNBPCs");
  object oNPC;
  struct StackHeader stack;
  string sResRef;
  object oFOA=GetFirstObjectInArea(OBJECT_SELF);
  int nLM;
  int nC=1;
  stack=fnGetLocalStack("stLAG4");
  if (GetIsPC(oPC))
  { // it was a PC that exited
    nGNBPCs--;
    if (nGNBPCs<1) nGNBPCs=0;
    SetLocalInt(OBJECT_SELF,"nGNBPCs",nGNBPCs);
    if (nGNBPCs==0)
    { // all PCs are gone check for LAG4 NPCs
      oNPC=GetNearestObject(OBJECT_TYPE_CREATURE,oFOA,nC);
      while(oNPC!=OBJECT_INVALID)
      { // !OI
        nLM=GetLocalInt(oNPC,"nGNBLagMeth");
        if (nLM==4)
        { // LAG 4
          sResRef=GetResRef(oNPC);
          if (GetStringLength(sResRef)>1)
          { // ResRef captured successfully
            stack=fnPushStack(stack,sResRef); // increase stack
            DestroyObject(oNPC);
          } // ResRef captured successfully
          else
          { // no ResRef
            SendMessageToPC(oPC,"ERROR: NPC ACTIVITIES 5.0: Could not get ResRef for NPC:"+GetName(oNPC)+" in AREA:"+GetName(OBJECT_SELF));
          } // no ResRef
        } // LAG 4
        nC++;
        oNPC=GetNearestObject(OBJECT_TYPE_CREATURE,oFOA,nC);
      } // !OI
      if (GetObjectType(oFOA)==OBJECT_TYPE_CREATURE)
      { // don't forget that first object
       oNPC=oFOA;
       nLM=GetLocalInt(oNPC,"nGNBLagMeth");
        if (nLM==4)
        { // LAG 4
          sResRef=GetResRef(oNPC);
          if (GetStringLength(sResRef)>1)
          { // ResRef captured successfully
            stack=fnPushStack(stack,sResRef); // increase stack
            DestroyObject(oNPC);
          } // ResRef captured successfully
          else
          { // no ResRef
            SendMessageToPC(oPC,"ERROR: NPC ACTIVITIES 5.0: Could not get ResRef for NPC:"+GetName(oNPC)+" in AREA:"+GetName(OBJECT_SELF));
          } // no ResRef
        } // LAG 4
      } // don't forget that first object
    } // all PCs are gone check for LAG4 NPCs
  } // it was a PC that exited
  fnSetLocalStack(stack);
}
