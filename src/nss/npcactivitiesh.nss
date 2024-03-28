////////////////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - Include Header file
//---------------------------------------------------------------------
// By Deva Bryson Winblood.   01/2003
////////////////////////////////////////////////////////////////////////

int DEBUG_NPCACT_ON = FALSE; // set this to false when not debugging
int DEEP_DEBUG_ON = FALSE; // set this if you need even more verbose debugging
int NPCACT_MAX_SCAN = 20;  // Number of objects to test before stopping
                           // This helps prevent TOO MANY INSTRUCTION errors
string DEBUG_TAG = ""; // Set this to a specific NPC if you want only
                                  // messages reguarding a single NPC

//-----------customizations
int NPCACT_ONLY_NEAREST=FALSE;  /* If this is set to true it will ONLY
                                   use GetNearest when looking for objects
                                   it will NOT look in areas outside of where
                                   the NPC currently is.  This is a requested feature */

//------------------- data structure
struct stNPCLocals {
  int nGNBState;  // State
  int nGNBHBCount; // heartbeats passed so far
  int nGNBMaxHB; // maximum heartbeats allowed for this action
  string sGNBActions; // Actions remaining to be done storage
  string sGNBDTag; // Current destination tag
  int nGNBRun; // Run/walk/hide/search/teleport method
  float fGNBPause; // Pause at end of actions before next waypoint
  string sGNBHours; // Hours of operation
  int nGNBLagMeth; // Lag Method used for this NPC
  int nGNBLagCount; // Counter for delays to off heartbeat processing
  int nWaitFullHB; // TRUE/FALSE
  int nASMethod; // Anti-stuck method
  float fDist; // Used to tell if any motion occurred
  string sAct; // Current command working on
  int nGNBCState; // Command State
  int nNN; // No NPC Interaction (activated when TRUE)
  int nGNBLDest; // Last destination reached time
}; // struct stNPCLocals

//--------------------------------------------------------[CONSTANTS]--------
int NPCACT_TIME_DUSK        = 0;
int NPCACT_TIME_DAWN        = 1;
int NPCACT_TIME_DAY         = 2;
int NPCACT_TIME_NIGHT       = 3;
int NPCACT_MOVE_RUN         = 0x0000000000000001;
int NPCACT_MOVE_HIDE        = 0x0000000000000002;
int NPCACT_MOVE_SEARCH      = 0x0000000000000004;
int NPCACT_MOVE_TELEP       = 0x0000000000000008;
int NPCACT_MOVE_VFX         = 0x0000000000000010;
int NPCACT_CUSTOMTRAPS      = 0;

////////////////////////////////////////////////////////////////////
//  GLOBAL SUPPORT FUNCTIONS
////////////////////////////////////////////////////////////////////
struct stNPCLocals GNBGetLocals()
{ // populate structure
   struct stNPCLocals stRet;
   stRet.nGNBState=GetLocalInt(OBJECT_SELF,"nGNBState");
   stRet.nGNBHBCount=GetLocalInt(OBJECT_SELF,"nGNBHBCount");
   stRet.nGNBMaxHB=GetLocalInt(OBJECT_SELF,"nGNBMaxHB");
   stRet.nGNBLagMeth=GetLocalInt(OBJECT_SELF,"nGNBLagMeth");
   stRet.sGNBActions=GetLocalString(OBJECT_SELF,"sGNBActions");
   stRet.sGNBHours=GetLocalString(OBJECT_SELF,"sGNBHours");
   stRet.sGNBDTag=GetLocalString(OBJECT_SELF,"sGNBDTag");
   stRet.fGNBPause=GetLocalFloat(OBJECT_SELF,"fGNBPause");
   stRet.nGNBLagCount=GetLocalInt(OBJECT_SELF,"nGNBLagCount");
   stRet.nWaitFullHB=GetLocalInt(OBJECT_SELF,"nWaitFullHB");
   stRet.nGNBRun=GetLocalInt(OBJECT_SELF,"nGNBRun");
   stRet.nASMethod=GetLocalInt(OBJECT_SELF,"nASMethod");
   stRet.fDist=GetLocalFloat(OBJECT_SELF,"fDist");
   stRet.sAct=GetLocalString(OBJECT_SELF,"sGNBAct");
   stRet.nGNBCState=GetLocalInt(OBJECT_SELF,"nGNBCState");
   stRet.nNN=GetLocalInt(OBJECT_SELF,"nNN");
   stRet.nGNBLDest=GetLocalInt(OBJECT_SELF,"nGNBLDest");
   return stRet;
} // GNBGetLocals()


void GNBSetLocals(struct stNPCLocals stIn)
{ // store the local variables
  SetLocalInt(OBJECT_SELF,"nGNBState",stIn.nGNBState);
  SetLocalInt(OBJECT_SELF,"nGNBHBCount",stIn.nGNBHBCount);
  SetLocalInt(OBJECT_SELF,"nGNBMaxHB",stIn.nGNBMaxHB);
  SetLocalInt(OBJECT_SELF,"nGNBLagMeth",stIn.nGNBLagMeth);
  SetLocalString(OBJECT_SELF,"sGNBActions",stIn.sGNBActions);
  SetLocalString(OBJECT_SELF,"sGNBHours",stIn.sGNBHours);
  SetLocalString(OBJECT_SELF,"sGNBDTag",stIn.sGNBDTag);
  SetLocalFloat(OBJECT_SELF,"fGNBPause",stIn.fGNBPause);
  SetLocalInt(OBJECT_SELF,"nGNBLagCount",stIn.nGNBLagCount);
  SetLocalInt(OBJECT_SELF,"nWaitFullHB",stIn.nWaitFullHB);
  SetLocalInt(OBJECT_SELF,"nGNBRun",stIn.nGNBRun);
  SetLocalInt(OBJECT_SELF,"nASMethod",stIn.nASMethod);
  SetLocalFloat(OBJECT_SELF,"fDist",stIn.fDist);
  SetLocalString(OBJECT_SELF,"sGNBAct",stIn.sAct);
  SetLocalInt(OBJECT_SELF,"nGNBCState",stIn.nGNBCState);
  SetLocalInt(OBJECT_SELF,"nNN",stIn.nNN);
  SetLocalInt(OBJECT_SELF,"nGNBLDest",stIn.nGNBLDest);
} // GNBSetLocals()

string ItoS(int n)
{// shorter function name for Int to String
  return IntToString(n);
} // ItoS()

void GNBErrorReport(string sIn)
{
  if (DEBUG_NPCACT_ON)
  { // do error report
    object oPC=GetFirstPC();
    if (GetStringLength(DEBUG_TAG)<1||DEBUG_TAG==GetTag(OBJECT_SELF))
    { // specific
    if (GetArea(OBJECT_SELF)==GetArea(oPC))
     if (GetStringLength(sIn)>2)
       SendMessageToPC(oPC,sIn);
     else
     {
       string sMsg;
       struct stNPCLocals st=GNBGetLocals();
       sMsg="["+ItoS(st.nGNBState)+"]"+GetTag(OBJECT_SELF)+"(MH:"+ItoS(st.nGNBMaxHB)+",HB:";
       sMsg=sMsg+ItoS(st.nGNBHBCount)+",Actns:"+st.sGNBActions+",Act:"+GetLocalString(OBJECT_SELF,"sAct")+",CAction:"+ItoS(GetCurrentAction());
       sMsg=sMsg+",DTag:"+st.sGNBDTag+" nNN:"+IntToString(st.nNN)+" fDist:"+FloatToString(st.fDist)+")";
       SendMessageToPC(oPC,sMsg);
     }
    } // specific
  } // do error report
} // GNBErrorReport()  */

string fnParsePeriod(string sIn)
{ // return . delimited string
  string sRet="";
  string sWork=sIn;
  while (GetStringLength(sWork)>0&&GetStringLeft(sWork,1)!=".")
  { // build return string
    sRet=sRet+GetStringLeft(sWork,1);
    sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  } // build return string
  return sRet;
} // fnParsePeriod()

string fnParseSlash(string sIn)
{ // return / delimited string
  string sRet="";
  string sWork=sIn;
  //if (DEEP_DEBUG_ON) GNBErrorReport("[SLASHER]"+GetTag(OBJECT_SELF)+" sIn:"+sIn+" sWork:"+sWork);
  while (GetStringLength(sWork)>0&&GetStringLeft(sWork,1)!="/")
  { // build return string
    sRet=sRet+GetStringLeft(sWork,1);
    sWork=GetStringRight(sWork,GetStringLength(sWork)-1);
  } // build return string
  //if (DEEP_DEBUG_ON) GNBErrorReport("[SLASHER]sRet:"+sRet);
  return sRet;
} // fnParseSlash()

string fnStripStringSize(string sSource,string sStrip)
{ // strip size of sStrip from sSource
  string sRet=GetStringRight(sSource,GetStringLength(sSource)-GetStringLength(sStrip));
  if (GetStringLeft(sRet,1)==".") sRet=GetStringRight(sRet,GetStringLength(sRet)-1);
  return sRet;
} // fnStripStringSize()
