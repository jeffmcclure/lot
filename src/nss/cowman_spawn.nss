/////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - Dynamic Script Wrapper
// For the NPC Event:OnPerception
//-----------------------------------------------------------
// By Deva Bryson Winblood  - 01/2003
/////////////////////////////////////////////////////////////
// If you use this wrapper you should NEVER need to change it
// again.  If you read the documentation that came with NPC
// ACTIVITIES 5.0 it explains how to change this script at any
// moment and as many times as you like from within the game
// while it is running.  This makes this system dynamic rather
// than static.
//////////////////////////////////////////////////////////////

void main()
{
    string  sScriptToUse=GetLocalString(OBJECT_SELF,"sCRSPPerception");
    if (GetStringLength(sScriptToUse)>1)
    { // has a specified script
      ExecuteScript(sScriptToUse,OBJECT_SELF);
    } // has a specified script
    else
    { // run the Bioware default - non henchman
      ExecuteScript("gennpc_onper",OBJECT_SELF);
    } // run the Bioware default - non henchman
ExecuteScript("set_cowmantalk", OBJECT_SELF);
}
