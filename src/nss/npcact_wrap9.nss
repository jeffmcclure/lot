/////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - Dynamic Script Wrapper
// For the NPC Event:OnSpawn
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

#include "npcactivitiesh"

void main()
{
    string  sScriptToUse=GetLocalString(OBJECT_SELF,"sCRSPSpawn");
    string sPost="POST_"+GetTag(OBJECT_SELF);
    object oPost=GetNearestObjectByTag(sPost);
    string sByTag=GetTag(OBJECT_SELF)+"_SPAWNC";
    string sByRes=GetResRef(OBJECT_SELF)+"_SPAWNR";
    object oSpecial=GetNearestObjectByTag(sByTag);
    if (oPost==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oPost=GetObjectByTag(sPost);
    if (oSpecial==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oSpecial=GetObjectByTag(sByTag);
    if (oSpecial==OBJECT_INVALID) oSpecial=GetNearestObjectByTag(sByRes);
    if (oSpecial==OBJECT_INVALID&&!NPCACT_ONLY_NEAREST) oSpecial=GetObjectByTag(sByRes);
    if (GetStringLength(sScriptToUse)<2&&oSpecial!=OBJECT_INVALID) sScriptToUse=GetName(oSpecial);
    if (GetStringLength(sScriptToUse)>1)
    { // has a specified script
      ExecuteScript(sScriptToUse,OBJECT_SELF);
    } // has a specified script
    else if (oPost!=OBJECT_INVALID)
    { // run the npc activities scripts
      ExecuteScript("gennpc_spawn",OBJECT_SELF);
    } // run the npc activities scripts
    else
    { // run the Bioware default - non henchman
      ExecuteScript("nw_c2_default9",OBJECT_SELF);
    } // run the Bioware default - non henchman
}
