/////////////////////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - On Area Enter  (required for LAG and other functions)
//===========================================================================
// By Deva Bryson Winblood.  02/2003
//===========================================================================
// This OnEnter script must be used on any AREA where you wish to use Anti-Lag
// commands
//////////////////////////////////////////////////////////////////////////////
// Create a WAYPOINT somewhere in the module named LAG4_RESPAWN_TEMP
// This is the temporary place that NPCs are respawned so, their tag can be
// read to determine where to jump them to.
//////////////////////////////////////////////////////////////////////////////


#include "npcactstackh"

void main()
{
   object oPC=GetEnteringObject();
   struct StackHeader stInact;   // inactive LAG4 NPCs
   stInact=fnGetLocalStack("stLAG4");
   object oNPC;
   string sResRef;
   object oWP;
   object oTempWP=GetWaypointByTag("LAG4_RESPAWN_TEMP");
   int nGNBPCs=GetLocalInt(OBJECT_SELF,"nGNBPCs");
   if (GetIsPC(oPC)==TRUE)
   { // entering object is a PC
     nGNBPCs++;
     SetLocalInt(OBJECT_SELF,"nGNBPCs",nGNBPCs);
     if (nGNBPCs==1)
     { // this is the first PC... deal with any LAG4 NPCs
       while(stInact.nNum>0)
       { // pop resrefs off the stack and spawn them
         stInact=fnPopStack(stInact);
         sResRef=stInact.sRet;
         if (oTempWP!=OBJECT_INVALID)
         { // respawn
           oNPC=CreateObject(OBJECT_TYPE_CREATURE,sResRef,GetLocation(oTempWP));
           if (oNPC!=OBJECT_INVALID)
           { // it is respawned - find it's POST and move it
             oWP=GetWaypointByTag("POST_"+GetTag(oNPC));
             if (oWP!=OBJECT_INVALID)
             { // move them
               AssignCommand(oNPC,JumpToObject(oWP));
             } // move them
             else
             { // error
               SendMessageToPC(oPC,"ERROR: NPC ACTIVITIES 5.0 - Could not find waypoint POST_"+GetTag(oNPC)+" therefor the NPC in Area:"+GetName(OBJECT_SELF)+" was not respawned.");
               DestroyObject(oNPC);
             } // error
           } // it is respawned - find it's POST and move it
           else
           { // error
             SendMessageToPC(oPC,"ERROR: NPC ACTIVITIES 5.0 - Could not respawn NPC with ResRef '"+sResRef+"' in Area:"+GetName(OBJECT_SELF));
           } // error
         } // respawn
         else
         { // error
           SendMessageToPC(oPC,"ERROR: NPC ACTIVITIES 5.0 - Please notify the module creator that they need to have a waypoint labeled LAG4_RESPAWN_TEMP somewhere.  NPCs cannot respawn!");
         } // error
       } // pop resrefs off the stack and spawn them
     } // this is the first PC... deal with any LAG4 NPCs
   } // entering object is a PC
   fnSetLocalStack(stInact);
}
