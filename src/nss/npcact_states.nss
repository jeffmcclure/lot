//////////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - STATES for the CORE functions
//================================================================
// By Deva Bryson Winblood.   01/2003
//================================================================
// This is the state machine for the NPCs.  It handles the different
// states of the core functions AND calls the parsers, preparsers,
// and interpretters.
//////////////////////////////////////////////////////////////////
/*
    This script breaks up the activities done on heartbeats into
    actions (states).  Some states call this script again recursively
    to eliminate lag that would occur if it had to wait for a heartbeat
    to be processed.  The functions that do this have been carefully
    scrutinized so, as to balance well and not impose too much stress
    on the game engine.
                                                                 */
#include "npcactivitiesh"

////////////////////////////////
// PROTOTYPES
////////////////////////////////
object GetNPCWaypoint(int nTime,string sIn);
int GetGNBTime();
void MoveNPCToDestination(int nMethod,object oD);
void HandleAntiStuckMove(int nAS,object oD,int nHB,int MaxHB);
void GetUnstuck(object oD);
string PreprocessHeader(string sHdr);
int GetIsNPCACT4(string sHdr);
string ParseGNBDest(string sIn,int nMode=0);
int fnSetMovementType(string sIn);
int fnOperational(string sIn);
string fnParseDestination(string sIn);


///////////////////////////////////////////////// MAIN /////////////////////
void main()
{
  struct stNPCLocals stGNB=GNBGetLocals(); // get parameters
  int nHBAdd=GetLocalInt(OBJECT_SELF,"nGNBHBAdd"); // how much to add
  stGNB.nGNBHBCount=stGNB.nGNBHBCount+nHBAdd;
  SetLocalInt(OBJECT_SELF,"nGNBHBCount",stGNB.nGNBHBCount);
  object oErrors=GetFirstPC();  // Error output handle for SendMessageToPC
  object oDest; // Destination to move to
  float fDist; // used for distance measurements
  int nBreak;
  string sHeader="";
  string sWork; // Work variable used as a buffer for several operations
  switch (stGNB.nGNBState)
  { // switch for states
    case 0: { /////////////////// MOVE STATE /////////////////////
    /* This state process finding the waypoint to move to and starting
       the movement. */
       oDest=GetNPCWaypoint(GetGNBTime(),stGNB.sGNBDTag);
       stGNB.sGNBDTag=GetTag(oDest);
       GNBErrorReport("");
       fDist=GetDistanceToObject(oDest);
       if (fDist==-1.0||fDist>1.5)
       { // not there
       ClearAllActions();
       stGNB.nWaitFullHB=0;
       stGNB.sGNBActions="";
       // do move here
       MoveNPCToDestination(stGNB.nGNBRun,oDest);
       // end move
       stGNB.nGNBHBCount=0;
       switch(stGNB.nASMethod)
       { // set Anti-stuck control
         case 0:
         case 1:
         case 2: {     // default & pause & teleport @ 17
          stGNB.nGNBMaxHB=12;
         break; }      // default & pause & teleport @ 17
         case 3: {     // quick
          stGNB.nGNBMaxHB=5;
         break; }      // quick
         case 4:
         case 5: {     // slow & long teleport wait
          stGNB.nGNBMaxHB=20;
         break; }      // slow & long teleport wait
         default: break;
       } // set Anti-stuck control
       stGNB.nGNBState=1;
       stGNB.fDist=0.0;
       } // not there
       else
       {
        stGNB.nGNBState=2;
        stGNB.nGNBHBCount=0;
       }
       GNBSetLocals(stGNB);
    } /////////////////////////// MOVE STATE /////////////////////
    case 1: { /////////////////// MOVING STATE ///////////////////
    /* This state insures that the NPC reaches the destination they are
     going to.  It also uses the method of ANTI-STUCK specified for the
     NPC to handle the time it takes to reach a waypoint. */
     GNBErrorReport("");
     oDest=GetNearestObjectByTag(stGNB.sGNBDTag);
     if (oDest==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oDest=GetObjectByTag(stGNB.sGNBDTag);
     nBreak=TRUE;
     if (oDest!=OBJECT_INVALID)
     { // !OI
       fDist=GetDistanceToObject(oDest);
       if (DEEP_DEBUG_ON) GNBErrorReport(" Distance to:"+GetTag(oDest)+" is "+FloatToString(fDist));
       if (fDist==-1.0)
       { // just started moving or is in another area
         HandleAntiStuckMove(stGNB.nASMethod,oDest,stGNB.nGNBHBCount,
               stGNB.nGNBMaxHB);
         stGNB.fDist=fDist;
       } // just started moving or is in another area
       else
       { // been moving before
        if(fDist==stGNB.fDist&&fDist>1.5)
        { // stuck
           if(stGNB.nGNBHBCount<stGNB.nGNBMaxHB)
           { // do anti-stuck movement
             /* This is code to use nearby objects in an attempt to get
                the NPC out of a stuck corner and such.  It will also
                keep them at least moving around rather than just standing
                there looking dumb. */
              GetUnstuck(oDest);
           } // do anti-stuck movement
           else
             HandleAntiStuckMove(stGNB.nASMethod,oDest,stGNB.nGNBHBCount,
               stGNB.nGNBMaxHB);
           stGNB.fDist=fDist;
        } // stuck
        else if (fDist>1.5)
        { // not stuck
          HandleAntiStuckMove(stGNB.nASMethod,oDest,stGNB.nGNBHBCount,
               stGNB.nGNBMaxHB);
          stGNB.fDist=fDist;
        } // not stuck
        else
        { // should be there
          stGNB.nGNBState=2; // process header state
          SetFacing(GetFacing(oDest)); // Make NPC face direction of WP
          nBreak=FALSE; // don't break
        } // should be there
       } // been moving before
     } // !OI
     else
     { // the waypoint vanished - could occur with a patch
      stGNB.nGNBState=0;   // make the NPC find a different
      stGNB.sGNBDTag="";   // waypoint
      GNBErrorReport(GetTag(OBJECT_SELF)+" Waypoint missing in area: "+GetName(GetArea(OBJECT_SELF))+" WP:"+stGNB.sGNBDTag);
     } // the waypoint vanished - could occur with a patch
     GNBSetLocals(stGNB);
     if (nBreak) break;
    } /////////////////////////// MOVING STATE ///////////////////
    case 2: { /////////////////// HEADER STATE ///////////////////
    /* This state grabs the header information from a waypoint and
       processes variable setup and preparation for command completion */
     GNBErrorReport("");
     oDest=GetNearestObjectByTag(stGNB.sGNBDTag);
     if (oDest==OBJECT_INVALID&&NPCACT_ONLY_NEAREST==FALSE) oDest=GetObjectByTag(stGNB.sGNBDTag);
     sHeader=GetName(oDest);
     if (GetTag(oDest)=="POST_"+GetTag(OBJECT_SELF))
     {
       stGNB.nGNBLDest=1;
       if ((GetIsNight()||GetIsDusk())&&GetObjectByTag("NIGHT_"+GetTag(OBJECT_SELF))==OBJECT_INVALID)
         stGNB.nGNBLDest=2;
     }
     else if (GetTag(oDest)=="NIGHT_"+GetTag(OBJECT_SELF)) stGNB.nGNBLDest=2;
     SetFacing(GetFacing(oDest)); // Make NPC face direction of WP
     if (GetStringLeft(sHeader,2)=="3_") // parse out version 3.0 "3_"
      sHeader=GetStringRight(sHeader,GetStringLength(sHeader)-2);
     if(GetIsNPCACT4(sHeader)==TRUE) sHeader=PreprocessHeader(sHeader);
     sWork=fnParseDestination(sHeader); // get destination
     sHeader=fnStripStringSize(sHeader,sWork);
     sWork=GetLocalString(OBJECT_SELF,"sGNBDTag");
     //SendMessageToPC(GetFirstPC(),"Destination grabbed:"+sWork);
     stGNB.sGNBDTag=sWork;
     sWork=fnParsePeriod(sHeader); // grab pause amount in seconds
     sHeader=fnStripStringSize(sHeader,sWork); // strip pause off header
     stGNB.fGNBPause=IntToFloat(StringToInt(sWork)); // set pause amount
     sWork=fnParsePeriod(sHeader); // Get movement type
     sHeader=fnStripStringSize(sHeader,sWork); // strip movement off header
     stGNB.nGNBRun=fnSetMovementType(sWork); // set the movement flags
     sWork=fnParsePeriod(sHeader); // Get Hours of operation
     sHeader=fnStripStringSize(sHeader,sWork); // clean hours off header
     stGNB.sGNBHours=sWork; // Set Hours of operation
     sWork=fnParsePeriod(sHeader); // check for Anti-stuck method
     if ((GetIsDawn()||GetIsDay())&&stGNB.nGNBLDest==2)
        stGNB.sGNBDTag="00";
     else if ((GetIsDusk()||GetIsNight())&&stGNB.nGNBLDest==1)
        stGNB.sGNBDTag="00";
     if (sWork=="D"||sWork=="P"||sWork=="N"||sWork=="Q"||sWork=="S"||sWork=="L")
     { // has an anti-stuck command
       sHeader=fnStripStringSize(sHeader,sWork); // remove AS method
       if (sWork=="D") stGNB.nASMethod=0;
       else if (sWork=="P") stGNB.nASMethod=1;
       else if (sWork=="N") stGNB.nASMethod=2;
       else if (sWork=="Q") stGNB.nASMethod=3;
       else if (sWork=="L") stGNB.nASMethod=4;
     } // has an anti-stuck command
     stGNB.nGNBState=3; // go to commands
     stGNB.sGNBActions=sHeader; // store the command section
     GNBSetLocals(stGNB); // write the information
    } /////////////////////////// HEADER STATE ///////////////////
    case 3: { /////////////////// ACTION STATE ///////////////////
    /* This state gets the next command available and calls the interpretter
       to process it. */
       GNBErrorReport("");
       //SendMessageToPC(GetFirstPC(),"ACTION_INVALID="+IntToString(ACTION_INVALID));
       stGNB=GNBGetLocals(); // get stored information
       sHeader=stGNB.sGNBActions; // set sHeader string to current action list
       if (GetStringLength(sHeader)>0&&fnOperational(stGNB.sGNBHours))
       { // there is a command left
         ExecuteScript("npcact_interp",OBJECT_SELF); // launch the interpreter
         stGNB=GNBGetLocals(); // capture variables after calling interpreter
         stGNB.nGNBState=4; // acting state
         stGNB.nGNBHBCount=0; // HB = 0
       } // there is a command left
       else
       {
         stGNB.nGNBState=0; // no commands left
       }
       GNBSetLocals(stGNB); // write the information
    } /////////////////////////// ACTION STATE ///////////////////
    case 4: { /////////////////// ACTING STATE ///////////////////
    /* This state is used to track the completion of a command and handle
       the ANTI-STUCK techniques to keep a command from never ending */
       stGNB=GNBGetLocals(); // read in values
       if(stGNB.nGNBState==4)
       { // 4
       GNBErrorReport("");
       if (stGNB.nGNBCState==1||stGNB.nGNBCState==4)
       { // wait full heartbeat
         if (stGNB.nGNBHBCount>=stGNB.nGNBMaxHB||!fnOperational(stGNB.sGNBHours))
         { // wake them up - they are stuck
           AssignCommand(OBJECT_SELF,ClearAllActions());
           if(GetStringLength(stGNB.sGNBActions)>0)
           { // commands left
            stGNB.nGNBState=3;
           } // commands left
           else
           {
            stGNB.nGNBState=0; // no commands left
           }
         } // wake them up - they are stuck
       } // wait full heartbeat
       else if ((stGNB.nGNBCState==2||stGNB.nGNBCState==0)&&GetCurrentAction(OBJECT_SELF)!=ACTION_INVALID)
       { // wait until no actions
         if (stGNB.nGNBHBCount>=stGNB.nGNBMaxHB||!fnOperational(stGNB.sGNBHours))
         { // wake them up - they are stuck
           AssignCommand(OBJECT_SELF,ClearAllActions());
           if(GetStringLength(stGNB.sGNBActions)>0)
           { // commands left
            stGNB.nGNBState=3;
           } // commands left
           else
           {
            stGNB.nGNBState=0; // no commands left
           }
         } // wake them up - they are stuck
       } // wait until no actions
       else
       { // doing nothing
        if(GetStringLength(stGNB.sGNBActions)>0)
           { // commands left
            stGNB.nGNBState=3;
           } // commands left
           else
           {
            stGNB.nGNBState=0; // no commands left
           }
       } // doing nothing
       if (stGNB.nGNBCState==3||(GetCurrentAction()==ACTION_INVALID&&stGNB.nGNBCState==2))
       { // process another command - use this mode carefully
        stGNB.nGNBState=3;
        //if (GetLocalInt(OBJECT_SELF,"nGNBDisabled")!=TRUE)
        //{
         GNBSetLocals(stGNB);
         ExecuteScript("npcact_states",OBJECT_SELF); // recursion - be careful!
         stGNB=GNBGetLocals();
        //}
       } // process another command - use this mode carefully
       GNBSetLocals(stGNB);
       } // 4
    break;
    } /////////////////////////// ACTING STATE ///////////////////
    case 5: { /////////////////// WAIT STATE /////////////////////
    /* This state is used for delays that are needed that anti-stuck
       should not interfere with. */
       GNBErrorReport("");
       stGNB=GNBGetLocals();
       if (stGNB.nGNBHBCount>=stGNB.nGNBMaxHB||!fnOperational(stGNB.sGNBHours))
       { // time to wake up
         AssignCommand(OBJECT_SELF,ClearAllActions());
         if(GetStringLength(stGNB.sGNBActions)>0)
           { // commands left
            stGNB.nGNBState=3;
           } // commands left
           else
            stGNB.nGNBState=0; // no commands left
         GNBSetLocals(stGNB);
       } // time to wake up
    break;
    } /////////////////////////// WAIT STATE /////////////////////
    default: break;
  } // switch for states
  GNBSetLocals(stGNB); // pass parameters back
}
////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////
// SUPPORT FUNCTIONS
////////////////////////////////////////////////////////////////////

//[---------------------------------------[GetStringPart]---------------------
string GetStringPart(string sIn,int nS,int nE)
{ // return portion of string starting at nS and ending at nE
  int nC=1;
  string sWork=sIn;
  string sRet="";
  while(GetStringLength(sWork)>1&&nC<(nE+1))
  { // build return string
    if(nC>=nS&&nC<=nE)
      sRet=sRet+GetStringLeft(sWork,1);
    sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
    nC++;
  } // build return string
  return sRet;
} // GetStringPart()


//----------------------------------------------------[GetGNBWPNum]-----------
string GetGNBWPNum(int nN)
{
  string sRet="01";
  if (nN<10)
   sRet="0"+IntToString(nN);
  else
   sRet=IntToString(nN);
  return sRet;
} // GetGNBWPNum()

//---------------------------------------------------[StringCleanup]----------
string StringCleanup(string sStart,string sPart)
{ // remove sPart from sStart
  string sRet=GetStringRight(sStart,GetStringLength(sStart)-GetStringLength(sPart));
  return sRet;
} // StringCleanup()


//----------------------------------------------------[ParseGNBDest]----------
string ParseGNBDest(string sIn,int nMode=0)
{
  string sReturn=sIn;
  int nRv;
  int nSv;
  int nEv;
  GNBErrorReport("[ParseGNBDest("+sIn+","+IntToString(nMode)+")]");
  if (GetStringLeft(sIn,2)=="00")
  {
   if (nMode==0){ SetLocalString(OBJECT_SELF,"sGNBDTag","00"); // POST_
   sReturn=GetStringRight(sIn,GetStringLength(sIn)-3); }
   else
    sReturn="00";
  }
  else if (StringToInt(GetStringLeft(sIn,2))>0)
  {
   if (nMode==0) {
    SetLocalString(OBJECT_SELF,"sGNBDTag",GetStringLeft(sIn,2)); // WP_
    sReturn=GetStringRight(sIn,GetStringLength(sIn)-3);
   }
   else
    sReturn=GetStringLeft(sIn,2);
  }
  else if (GetStringLeft(sIn,1)=="R")
  { // Random
   if (nMode==0)
   {
     sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
     nRv=StringToInt(GetStringLeft(sReturn,2));
     nRv=Random(nRv)+1;
     SetLocalString(OBJECT_SELF,"sGNBDTag","0"+IntToString(nRv));
     sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
    }
     else sReturn=GetStringLeft(sReturn,3);
  } // Random
  else if (GetStringLeft(sIn,1)=="B")
  { // Bounded Random
  if (nMode==0)
  {
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
   int nSv=StringToInt(GetStringLeft(sReturn,2));
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-2);
   int nEv=StringToInt(GetStringLeft(sReturn,2));
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
   if (nEv>nSv)
   { // bounds okay
    int nRv=nEv-nSv;
    nRv=Random(nRv)+1+nSv;
    SetLocalString(OBJECT_SELF,"sGNBDTag","0"+IntToString(nRv));
   } // bounds okay
   else
    SetLocalString(OBJECT_SELF,"sGNBDTag","00"); // POST_
   } // mode 0
   else
     sReturn=GetStringLeft(sReturn,5);
  } // Bounded Random
  else if (GetStringLeft(sIn,1)=="S")
  { // SHARED WAYPOINT
   sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1); // Trim S
   string sTag="";
   // parse tag
   while((GetStringLeft(sReturn,1)!="_")&&GetStringLeft(sReturn,1)!="."&&GetStringLength(sReturn)>0)
   { // get the tag
     sTag=sTag+GetStringLeft(sReturn,1);
     sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
   } // get the tag
   if (GetStringLeft(sReturn,1)=="_")
   { // valid
     sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
      if (GetStringLeft(sReturn,2)=="00")
      { // Post
       if(nMode==0)
       {
        SetLocalString(OBJECT_SELF,"sGNBDTag",sTag);
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
       }
       else sReturn="S"+sTag+"_00";
      } // Post
      else if (StringToInt(GetStringLeft(sReturn,2))>0)
      { // Specific Waypoint
       if (nMode==0)
       {
        SetLocalString(OBJECT_SELF,"sGNBDTag",sTag+"_"+GetStringLeft(sReturn,2));
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
       }
       else
         sReturn="S"+sTag+"_"+GetStringLeft(sReturn,2);
      } // Specific Waypoint
      else if (GetStringLeft(sReturn,1)=="R")
      { // Random
       if (nMode==0)
       {
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
        nRv=StringToInt(GetStringLeft(sReturn,2));
        nRv=Random(nRv)+1;
        SetLocalString(OBJECT_SELF,"sGNBDTag",sTag+"_"+GetGNBWPNum(nRv));
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
       }
       else sReturn="S"+sTag+"_"+GetStringRight(sReturn,3);
      } // Random
      else if (GetStringLeft(sReturn,1)=="B")
      { // Bounded Random
       if (nMode==0)
       {
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
        nSv=StringToInt(GetStringLeft(sReturn,2));
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-2);
        nEv=StringToInt(GetStringLeft(sReturn,2));
        sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-3);
        if(nEv<nSv)
        { // Post
         SetLocalString(OBJECT_SELF,"sGNBDTag","00");
        } // Post
        else
        { // bound it
         nRv=nEv-nSv;
         nRv=Random(nRv)+1+nSv;
         SetLocalString(OBJECT_SELF,"sGNBDTag",sTag+"_"+GetGNBWPNum(nRv));
        } // bound it
       } // mode 0
       else
        sReturn="S"+sTag+"_"+GetStringRight(sReturn,5);
      } // Bounded Random
      else
      {
       if(nMode==0)
       {
        SetLocalString(OBJECT_SELF,"sGNBDTag",sTag);
       }
       else
         sReturn=sTag;
      }
   } // valid
   else
   {
    if (nMode==0)
    {
     SetLocalString(OBJECT_SELF,"sGNBDTag",sTag);
    }
    else sReturn="S"+sTag;
   }
  } // SHARED WAYPOINT
  else
  { // unknown
   if (nMode==0)
   {
    SetLocalString(OBJECT_SELF,"sGNBDTag","00"); // POST_
    while(GetStringLeft(sReturn,1)!="_"&&GetStringLength(sReturn)>0)
      sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
    if (GetStringLeft(sReturn,1)=="_")
      sReturn=GetStringRight(sReturn,GetStringLength(sReturn)-1);
    } // nMode 0
    else sReturn="";
  } // unknown
  GNBErrorReport("[ParseGNBDest("+sIn+","+IntToString(nMode)+")="+sReturn+"]");
  return sReturn;
} // ParseGNBDest()


//[---------------------------------------[GetIsNPCACT4]----------------------
int GetIsNPCACT4(string sHdr)
{ // determine if this is an NPC ACTIVITIES 4.0 header return TRUE if is
  int nRet=FALSE;
  if (GetStringLeft(StringCleanup(sHdr,ParseGNBDest(sHdr,1)),1)=="_") nRet=TRUE;
  return nRet;
} // GetIsNPCACT4()


//[---------------------------------------[PreprocessHeader]------------------
string PreprocessHeader(string sHdr)
{ // this converts NPC ACTIVITIES 4.0 header into a NPC ACTIVITIES 5.0
  /* notice ALL _s converted to .s with the exception of the initial
     destination way points All .s converted to /s*/
  string sNew="";
  string sWork=sHdr;
  string sC;
  int nC=0;
  sNew=ParseGNBDest(sWork,1)+".";
  sWork=StringCleanup(sHdr,sNew);
  while(GetStringLength(sWork)>0)
  {
   sC=GetStringLeft(sWork,1);
   if (sC!="_"&&sC!=".") sNew=sNew+GetStringLeft(sWork,1);
   else if (sC=="_") sNew=sNew+".";
   else sNew=sNew+"/";
   sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  }
  if (DEBUG_NPCACT_ON) SendMessageToPC(GetFirstPC(),"PREPROCESS: ["+sHdr+"]"+sNew);
  return sNew;
} // PreprocessHeader()


//[---------------------------------------[GetUnstuck]------------------------
void GetUnstuck(object oD)
{ // try to get unstuck - Revised by Lupus Yonderboy
  object oMoveTo;
  int nDist;
  float fRange;
  int nNum=d8();
  oMoveTo=GetNearestObject(OBJECT_TYPE_PLACEABLE,OBJECT_SELF,nNum);
  if (oMoveTo==OBJECT_INVALID) oMoveTo=GetNearestObject(OBJECT_TYPE_PLACEABLE,OBJECT_SELF,nNum);
  if (oMoveTo==OBJECT_INVALID) oMoveTo=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nNum);
  if (oMoveTo==OBJECT_INVALID) oMoveTo=GetNearestObject(OBJECT_TYPE_WAYPOINT,OBJECT_SELF,1);
  ClearAllActions();
  fRange=GetDistanceToObject(oMoveTo);
  if (fRange<10.0)
  {// pick a random distance towards object
   nDist=FloatToInt(fRange);
   nDist=Random(nDist)+1;
   fRange=IntToFloat(nDist)+0.5;
  }// pick a random distance towards object
  else
  {
    fRange=fRange-8.0; // don't move any further than 8 meters
  }
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" Getting Unstuck: " + GetTag(oMoveTo));
  ActionForceMoveToObject(oMoveTo,FALSE,fRange,20.0);
  float fDelay = IntToFloat(Random(8)+1);
  DelayCommand(fDelay, ClearAllActions());
  DelayCommand(fDelay + 0.5,ActionForceMoveToObject(oD,FALSE,1.0,200.0));
} // GetUnstuck()


//[---------------------------------------[HandleAntiStuckMove]---------------
void HandleAntiStuckMove(int nAS,object oD,int nHB,int nMaxHB)
{ // handle the anti-stuck reactions for the Moving state
  int nRunKick=FALSE;
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" Anti-Stuck AS:"+IntToString(nAS)+" oD:"+GetName(oD)+" nHB:"+IntToString(nHB)+" nMaxHB:"+IntToString(nMaxHB));
  if (nAS==0||nAS==1||nAS==3||nAS==4) nRunKick==TRUE;
  if (nHB==nMaxHB)
  { // kickstart
    if (nRunKick)
    { // run
      ClearAllActions();
      MoveNPCToDestination(NPCACT_MOVE_RUN,oD);
    } // run
    else
    { // walk
      ClearAllActions();
      MoveNPCToDestination(0,oD);
    } // walk
  } // kickstart
  else if (nHB>(nMaxHB+4))
  { // teleport
    ClearAllActions();
    MoveNPCToDestination(NPCACT_MOVE_TELEP,oD);
  } // teleport
} // HandleAntiStuckMove()


//[----------------------------------------[MoveNPCToDestination]-------------
void MoveNPCToDestination(int nMethod, object oD)
{ // move the NPC to oD using nMethod
  int nRun=FALSE;
  effect eVFX;
  //if (DEEP_DEBUG_ON) GNBErrorReport("["+GetTag(OBJECT_SELF)+"]MoveNPCToDestination("+IntToString(nMethod)+","+GetTag(oD)+")");
  if (nMethod==NPCACT_MOVE_RUN) nRun=TRUE;
  if ((nMethod&NPCACT_MOVE_HIDE)>0)
    ActionUseSkill(SKILL_HIDE,OBJECT_SELF); // enable hide
  if ((nMethod&NPCACT_MOVE_SEARCH)>0)
    ActionUseSkill(SKILL_SEARCH,OBJECT_SELF); // enable search
  if ((nMethod&NPCACT_MOVE_VFX)>0)
  { // teleport visual effects
    eVFX=EffectVisualEffect(VFX_FNF_IMPLOSION);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVFX,OBJECT_SELF,3.0);
  } // teleport visual effects
  if (oD!=OBJECT_INVALID)
  { // !OI
    if (nMethod==NPCACT_MOVE_TELEP||(nMethod&NPCACT_MOVE_TELEP)>0)
    { // teleport
       JumpToObject(oD); // teleport
    } // teleport
    else
    { // move normal
      ActionForceMoveToObject(oD,nRun,1.0,200.0);
    } // move normal
  } // !OI
} // MoveNPCToDestination()


//---------------------------------------------------------[GetNPCWaypoint]---
object GetNPCWaypoint(int nTime,string sIn)
{
  object oReturn=OBJECT_INVALID;
  string sPost1="POST_";
  string sPost2="NIGHT_";
  string sPre="WP_";
  string sPre2="WN_";
  string sTry;
  // check for day night change so, no whether to post
  //GNBErrorReport("[GetNPCWaypoint("+GetTag(OBJECT_SELF)+" "+sIn+")]");
  if (nTime==NPCACT_TIME_DUSK||nTime==NPCACT_TIME_NIGHT)
  { // switch posts and pre
    sPost1="NIGHT_";
    sPost2="POST_";
    sPre="WN_";
    sPre2="WP_";
  } // switch posts and pre
  if (GetStringLength(sIn)<2)
  { // no specified destination
    //if (DEEP_DEBUG_ON) GNBErrorReport(" GNPCWP-No specified destination");
    sTry=sPost1+GetTag(OBJECT_SELF);
    oReturn=GetNearestObjectByTag(sTry);
    if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPost2+GetTag(OBJECT_SELF);
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPre+GetTag(OBJECT_SELF)+"_01";
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPre2+GetTag(OBJECT_SELF)+"_01";
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry="WP_"+GetTag(OBJECT_SELF)+"_01";
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry="WN_"+GetTag(OBJECT_SELF)+"_01";
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI
  } // no specified destination
  else if (StringToInt(sIn)==0)
  { // specific non-numeric destination
    //if (DEEP_DEBUG_ON) GNBErrorReport("  non-numeric waypoint");
    sTry=sIn;
    oReturn=GetNearestObjectByTag(sTry);
    if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPre+sIn;
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPost1+sIn;
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPre2+sIn;
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI
      sTry=sPost2+sIn;
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI
    if (oReturn==OBJECT_INVALID)
    { // OI - post
      sTry=sPost1+GetTag(OBJECT_SELF);
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI - post
    if (oReturn==OBJECT_INVALID)
    { // OI - post 2
      sTry=sPost2+GetTag(OBJECT_SELF);
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI - post 2
  } // specific non-numeric destination
  else
  { // numeric destination
    //if (DEEP_DEBUG_ON) GNBErrorReport("  numeric destination");
    sTry=GetTag(OBJECT_SELF)+"_";
    if (StringToInt(sIn)<10)
    {
      sTry=sTry+"0"+IntToString(StringToInt(sIn));
    }
    else
    {
      sTry=sTry+IntToString(StringToInt(sIn));
    }
    oReturn=GetNearestObjectByTag(sPre+sTry);
    if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sPre+sTry);
    if (oReturn==OBJECT_INVALID)
    { // OI - Night/Day
      oReturn=GetNearestObjectByTag(sPre2+sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sPre2+sTry);
    } // OI - Night/day
    if (oReturn==OBJECT_INVALID)
    { // OI - POST
      sTry=sPost1+GetTag(OBJECT_SELF);
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI - POST
    if (oReturn==OBJECT_INVALID)
    { // OI - POST 2
      sTry=sPost2+GetTag(OBJECT_SELF);
      oReturn=GetNearestObjectByTag(sTry);
      if (oReturn==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oReturn=GetObjectByTag(sTry);
    } // OI - POST 2
  } // numeric destination
  GNBErrorReport("[GetNPCWaypoint("+GetTag(OBJECT_SELF)+" "+sIn+")="+GetTag(oReturn)+"]");
  return oReturn;
} // GetNPCWaypoint()


//[--------------------------------------------------------[GetGNBTime]-------
int GetGNBTime()
{
  int nReturn=NPCACT_TIME_DUSK;
  if (GetIsDawn())nReturn=NPCACT_TIME_DAWN;
  else if (GetIsDay()) nReturn=NPCACT_TIME_DAY;
  else if (GetIsNight()) nReturn=NPCACT_TIME_NIGHT;
  //SendMessageToPC(GetFirstPC(),"GetGNBTime()="+IntToString(nReturn));
  return nReturn;
} // GetGNBTime()

//[--------------------------------------------------[fnSetMovementType-------
int fnSetMovementType(string sIn)
{ // set the movement flags for this
  if (sIn=="R") return NPCACT_MOVE_RUN;
  if (sIn=="H") return NPCACT_MOVE_HIDE;
  if (sIn=="S") return NPCACT_MOVE_SEARCH;
  if (sIn=="C") return NPCACT_MOVE_HIDE|NPCACT_MOVE_SEARCH;
  if (sIn=="T") return NPCACT_MOVE_TELEP;
  if (sIn=="V") return NPCACT_MOVE_TELEP|NPCACT_MOVE_VFX;
  return 0;
} //fnSetMovementType()

int fnOperational(string sIn)
{ // check to see if current hours of operation are in effect
 int nRet=TRUE;
 int nTime=GetGNBTime();
 int nStart;
 int nEnd;
 int nNow=GetTimeHour();
 if (sIn=="N"&&nTime!=NPCACT_TIME_NIGHT) nRet=FALSE;
 else if (sIn=="D"&&nTime!=NPCACT_TIME_DAY) nRet=FALSE;
 else if (sIn=="U"&&nTime!=NPCACT_TIME_DUSK) nRet=FALSE;
 else if (sIn=="W"&&nTime!=NPCACT_TIME_DAWN) nRet=FALSE;
 else if (GetStringLeft(sIn,1)=="0"||StringToInt(GetStringLeft(sIn,1))>0)
 { // check hours
   nStart=StringToInt(GetStringLeft(sIn,2));
   nEnd=StringToInt(GetStringRight(sIn,2));
   if (nStart<=nEnd&&(nNow<nStart||nNow>nEnd)) nRet=FALSE;
 } // check hours
 return nRet;
} // fnOperational()

//[----------------------------------------[fnParseDestinaton]----------------
string fnParseDestination(string sHead)
{ // get the destination from sHead  store it in sGNBDtag
  // return the portion of the header that was used to determine this
  string sData=sHead;
  string sWork=fnParsePeriod(sHead);
  string sRet=sWork;
  string sL1=GetStringLeft(sWork,1);
  string sDest;
  int nNum;
  int nStr;
  int nFin;
  int nRnd;
  int nTime=GetGNBTime();
  int nLastTime=GetLocalInt(OBJECT_SELF,"nGNBLDest"); // sometimes DUSK, NIGHT would come and they would go to the # for night that corresponded to the next DAY #
  sData=fnStripStringSize(sData,sWork);
  if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" PARSEDEST  nTime:"+IntToString(nTime)+" nLastTime:"+IntToString(nLastTime));
  if ((nTime==NPCACT_TIME_DUSK||nTime==NPCACT_TIME_NIGHT)&&nLastTime!=2) { sWork="00";sL1="0"; SetLocalInt(OBJECT_SELF,"nGNBLDest",2); } // POST
  else if ((nTime==NPCACT_TIME_DAWN||nTime==NPCACT_TIME_DAY)&&nLastTime!=1) { sWork="00";sL1="0"; SetLocalInt(OBJECT_SELF,"nGNBLDest",1); }
  if (sL1=="S")
  { // shared waypoint - the tricky part :)
    sData=sWork;
    if (DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" SHARED WAYPOINT MODE");
     sData=GetStringRight(sData,GetStringLength(sData)-1);
     sL1="";
     nNum=0;
     sDest="";
     while(GetStringLength(sData)>0)
     { // build parts
       if (GetStringLeft(sData,1)=="_")
       {
         nNum++;
         if (nNum>1)
         {
          sL1=sL1+"_"+sDest;
          sDest="";
         }
       }
       else if (nNum==0) sL1=sL1+GetStringLeft(sData,1);
       else sDest=sDest+GetStringLeft(sData,1);
       sData=GetStringRight(sData,GetStringLength(sData)-1);
     } // build parts
     if (DEEP_DEBUG_ON) GNBErrorReport("  SWP->PART1:"+sL1+" PART2:"+sDest);
     if ((sDest=="00"||StringToInt(sDest)>0)||(GetStringLeft(sDest,1)!="R"&&
         GetStringLeft(sDest,1)!="B"&&GetStringLength(sDest)>0))
      { // second part of waypoint should actually go with the first
         sL1=sL1+"_"+sDest;
         sDest="";
      } // second part of waypoint should actually go with the first
      if (DEEP_DEBUG_ON) GNBErrorReport(" SWP->CONSOLIDATION PART1:"+sL1+" PART2:"+sDest);
      if (GetStringLength(sDest)<1)
      { // direct waypoint
        SetLocalString(OBJECT_SELF,"sGNBDTag",sL1);
      } // direct waypoint
      else
      { // multipart waypoint
        if (GetStringLeft(sDest,1)=="R")
        { // Random Shared
          nNum=StringToInt(GetStringRight(sDest,2));
          nRnd=Random(nNum);
          nRnd=nRnd+1;
          if (nRnd<10)
            SetLocalString(OBJECT_SELF,"sGNBDTag",sL1+"_0"+IntToString(nRnd));
          else
            SetLocalString(OBJECT_SELF,"sGNBDTag",sL1+"_"+IntToString(nRnd));
        } // Random Shared
        else if (GetStringLeft(sDest,1)=="B")
        { // Bounded Shared
          nFin=StringToInt(GetStringRight(sDest,2));
          sDest=GetStringRight(sWork,GetStringLength(sDest)-1); // strip B
          nStr=StringToInt(GetStringLeft(sDest,2));
          nNum=(nFin-nStr)+1;
          nRnd=Random(nNum);
          nRnd=nStr+nRnd;
          if (nRnd<10)
            SetLocalString(OBJECT_SELF,"sGNBDTag",sL1+"_0"+IntToString(nRnd));
          else
            SetLocalString(OBJECT_SELF,"sGNBDTag",sL1+"_"+IntToString(nRnd));
        } // Bounded Shared
        else if (DEBUG_NPCACT_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" in area "+GetName(GetArea(OBJECT_SELF))+" shared waypoint problem.");
      } // multipart waypoint
  } // shared waypoint - the tricky part :)
  else if (sL1=="R")
  { // Random waypoint
    nNum=StringToInt(GetStringRight(sWork,2));
    nRnd=Random(nNum);
    nRnd=nRnd+1;
    if (nRnd<10)
      SetLocalString(OBJECT_SELF,"sGNBDTag","0"+IntToString(nRnd));
    else
      SetLocalString(OBJECT_SELF,"sGNBDTag",IntToString(nRnd));
  } // Random waypoint
  else if (sL1=="B")
  { // Bounded waypoint
    nFin=StringToInt(GetStringRight(sWork,2));
    sWork=GetStringRight(sWork,GetStringLength(sWork)-1); // strip B
    nStr=StringToInt(GetStringLeft(sWork,2));
    nNum=(nFin-nStr)+1;
    nRnd=Random(nNum);
    nRnd=nStr+nRnd;
    if (nRnd<10)
      SetLocalString(OBJECT_SELF,"sGNBDTag","0"+IntToString(nRnd));
    else
      SetLocalString(OBJECT_SELF,"sGNBDTag",IntToString(nRnd));
  } // Bounded waypoint
  else // standard waypoint - nothing fancy
  {
   SetLocalString(OBJECT_SELF,"sGNBDTag",sWork);
  }
 //if(DEEP_DEBUG_ON) GNBErrorReport(GetTag(OBJECT_SELF)+" ParseDestination("+GetLocalString(OBJECT_SELF,"sGNBDTag")+")");
 return sRet;
} // fnParseDestination()
