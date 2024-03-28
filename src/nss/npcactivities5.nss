///////////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 -  CORE FUNCTIONS - Main program
//=================================================================
// By Deva Bryson Winblood.   01/2003
//=================================================================
// This is the main script that is called by the gennpc scripts.
// This script will handle situations where NPC ACTIVITIES is
// disabled, if the NPC is in Conversation, and will make calls
// to the appropriate external programs.  NPC Activities 5.0 has
// been broken into smaller parts to facilitate the growing number
// of commands and abilities.
//-----------------------------------------------------------------
// This script will either exit or make a call to npcact_states
////////////////////////////////////////////////////////////////////
// This script was only slightly modified from Version 4.0
////////////////////////////////////////////////////////////////////

#include "NPCACTIVITIESH"

////////////////////////////////////////// MAIN ////////////////////
void main()
{
  //// define variables
  object oAttacker=GetLastAttacker();
  float fDistAttk=-1.0;
  object oErrors=GetFirstPC(); // handle used for error reporting
  struct stNPCLocals stGNB; // holds the info
  int nDelay; // Used in conjunction with ANTI-LAG commands
  int nPCs; // Count of number of PCs in area
  int nLMin=GetLocalInt(OBJECT_SELF,"nGNBLMin");  // Make sure accurate
  int nLSec=GetLocalInt(OBJECT_SELF,"nGNBLSec");  // measurement of
  int nCMin=GetTimeMinute(); // number of 6 second heartbeats have passed
  int nCSec=GetTimeSecond(); // since this function was last called
  int nLTotal=nLMin*60+nLSec;// This will offset situations where the
  int nCTotal=nCMin*60+nCSec;// heartbeat is not called as often.
  int nHBAdd=(nCTotal-nLTotal)/6;
  if (nHBAdd<1) nHBAdd=1;
  SetLocalInt(OBJECT_SELF,"nGNBHBAdd",nHBAdd);
  SetLocalInt(OBJECT_SELF,"nGNBLMin",nCMin);
  SetLocalInt(OBJECT_SELF,"nGNBLSec",nCSec);
  object oArea; // area handle
  //// end define variables
  if (oAttacker!=OBJECT_INVALID) fDistAttk=GetDistanceToObject(oAttacker);
  if (oAttacker==OBJECT_INVALID)
  {
    oAttacker=GetLocalObject(OBJECT_SELF,"oEnemy");
    if (oAttacker!=OBJECT_INVALID) fDistAttk=GetDistanceToObject(oAttacker);
  }
  if (GetLocalInt(OBJECT_SELF,"nGNBDisabled")==TRUE&&DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" DISABLED");
  if (GetLocalInt(OBJECT_SELF,"nGNBDisabled")!=TRUE&&!IsInConversation(OBJECT_SELF)&&(fDistAttk>30.0||fDistAttk==-1.0)&&(GetLocalInt(OBJECT_SELF,"nGNBSleeping")!=TRUE))
  { // NPC Activities is not disabled, NPC is not in conversation, NPC is not in combat
   if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" ACTIVE");
   if(stGNB.nGNBLagMeth==0)
   { // no lag control
     ExecuteScript("NPCACT_STATES",OBJECT_SELF); // call state program
     stGNB=GNBGetLocals(); // retrieve any updates
   } // no lag control
   else if (stGNB.nGNBLagMeth==1||stGNB.nGNBLagMeth==2)
   { // delayed heartbeat lag control
    nDelay=2;
    if (stGNB.nGNBLagMeth==2) nDelay=4;
    stGNB.nGNBLagCount++;
    if (stGNB.nGNBLagCount>=nDelay)
    { // process a command
      stGNB.nGNBLagCount=0;  // reset delay
      GNBSetLocals(stGNB); // prep for state program
      ExecuteScript("NPCACT_STATES",OBJECT_SELF); // call state programs
      stGNB=GNBGetLocals(); // retrieve any updates
    } // process a command
   } // delayed heartbeat lag control
   else if (stGNB.nGNBLagMeth>2)
   { // operate only if PCs present lag control 4=destroy when no PCS
     oArea=GetArea(OBJECT_SELF);
     nPCs=GetLocalInt(oArea,"nGNBPCs");
     if (nPCs>0)
     { // process commands
       ExecuteScript("NPCACT_STATES",OBJECT_SELF); // call state program
       stGNB=GNBGetLocals(); // retrieve any updates
     } // process commands
   } // operate only if PCs present lag control 4=destroy when no PCs
   GNBSetLocals(stGNB); // store the data for next time
  } // NPC Activities is not disabled, NPC is not in conversation, NPC is not in combat
}
////////////////////////////////////////////////////////////////////
