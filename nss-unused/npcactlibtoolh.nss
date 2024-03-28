///////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - Library Tool Header file
//============================================================
// By Deva Bryson Winblood.    02/2003
///////////////////////////////////////////////////////////////
/*

    These functions are to be used to help you make your
    own library scripts as per the documentation section
    Creating your own commands.
                                                            */
string fnParseSlash(string sIn)
{ // Parse based on Slash and return the resulting string
  string sString=sIn;
  string sRet="";
  while(GetStringLength(sString)>0&&GetStringLeft(sString,1)!="/")
  { // build return string
    sRet=sRet+GetStringLeft(sString,1);
    sString=GetStringRight(sString,GetStringLength(sString)-1);
  } // build return string
  return sRet;
} // fnParseSlash()

string fnStringRemainder(string sOrig,string sRemove)
{ // removes the size of sRemove from the front of sOrig
  string sRet="";
  if (GetStringLength(sOrig)>=GetStringLength(sRemove))
  { // robustness
   sRet=GetStringRight(sOrig,GetStringLength(sOrig)-GetStringLength(sRemove));
   if (GetStringLeft(sRet,1)=="/") sRet=GetStringRight(sRet,GetStringLength(sRet)-1);
  } // robustness
  return sRet;
} // fnStringRemainder()

void fnTokenizeParameters(string sIn)
{ // build nArgc and sArgv#
  int nCount=0;
  string sParms=sIn;
  string sP;
  while(GetStringLength(sParms)>0)
  {
    nCount++;
    sP=fnParseSlash(sParms);
    sParms=fnStringRemainder(sParms,sP);
    SetLocalString(OBJECT_SELF,"sArgv"+IntToString(nCount),sP);
  }
  SetLocalInt(OBJECT_SELF,"nArgc",nCount);
} // fnTokenizeParameters()

void fnFreeParms()
{ // this deallocates memory for the parameters
     DeleteLocalString(OBJECT_SELF,"sLIBParm");
} // fnFreeParms()

