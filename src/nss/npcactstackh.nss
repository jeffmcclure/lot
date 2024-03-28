/////////////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - Special Functions Header File
//===================================================================
// By Deva Bryson Winblood.  01/2003
//===================================================================
/* This file handles STACKS and such used by GOSSIP routines and
   possibly in other areas.                                          */
// FILE: npcactstackh
/////////////////////////////////////////////////////////////////////

struct StackHeader {
      int nNum;
      int nTop;
      string sPre; // stack prefix
      string sRet; // returned from top (if POP)
      };

struct StackHeader fnPopStack(struct StackHeader stack)
{ // Pop item off top of stack
  struct StackHeader sRet;
  if (stack.nTop>0)
  { // there are items on the stack
    sRet.sPre=stack.sPre;
    sRet.nNum=stack.nNum-1;
    sRet.nTop=stack.nTop-1;
    sRet.sRet=GetLocalString(OBJECT_SELF,stack.sPre+IntToString(stack.nTop));
    if (GetStringLength(sRet.sRet)>0)DeleteLocalString(OBJECT_SELF,stack.sPre+IntToString(stack.nTop));
  } // there are items on the stack
  return sRet;
} // fnPopStack()

struct StackHeader fnPushStack(struct StackHeader stack, string sItem)
{ // Push an item onto the stack
   struct StackHeader sRet;
   sRet.sPre=stack.sPre;
   sRet.nNum=stack.nNum+1;
   sRet.nTop=stack.nTop+1;
   SetLocalString(OBJECT_SELF,sRet.sPre+IntToString(sRet.nTop),sItem);
   return sRet;
} // fnPushStack()

string fnGetStackItem(struct StackHeader stack,int nNum)
{ // return the value of a specific item in the stack
  string sRet="";
  if (nNum<=stack.nNum)
  { // valid
    sRet=GetLocalString(OBJECT_SELF,stack.sPre+IntToString(nNum));
  } // valid
  return sRet;
} // fnGetStackItem()

int fnAlreadyOnStack(struct StackHeader stack,string sItem)
{ // returns true if it is already on the stack somewhere
  int nRet=FALSE;
  int nNum=0;
  while(nNum<stack.nTop&&nRet!=TRUE)
  {
    nNum++;
    if(GetLocalString(OBJECT_SELF,stack.sPre+IntToString(nNum))==sItem) nRet=TRUE;
  }
  return nRet;
} // fnAlreadyOnStack()

struct StackHeader fnGetLocalStack(string sPre)
{ // retrieve stack information
  struct StackHeader sRet;
  sRet.nNum=GetLocalInt(OBJECT_SELF,"nDBWSStack"+sPre+"Num");
  sRet.nTop=GetLocalInt(OBJECT_SELF,"nDBWSStack"+sPre+"Top");
  sRet.sPre=sPre;
  return sRet;
} // fnGetLocalStack()

void fnSetLocalStack(struct StackHeader sRet)
{ // store stack information
  SetLocalInt(OBJECT_SELF,"nDBWSStack"+sRet.sPre+"Num",sRet.nNum);
  SetLocalInt(OBJECT_SELF,"nDBWSStack"+sRet.sPre+"Top",sRet.nTop);
} // fnSetLocalStack()

