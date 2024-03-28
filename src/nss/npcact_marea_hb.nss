//////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0:  Multi-Area Monitor
//===========================================================
// By Deva Bryson Winblood.  02/2003
//===========================================================
//////////////////////////////////////////////////////////////

void main()
{
   object oOwner=GetLocalObject(OBJECT_SELF,"oOwner");
   int nLMin=GetLocalInt(oOwner,"nGNBLMin");  // Make sure accurate
   int nLSec=GetLocalInt(oOwner,"nGNBLSec");  // measurement of
   int nCMin=GetTimeMinute(); // number of 6 second heartbeats have passed
   int nCSec=GetTimeSecond(); // since this function was last called
   int nLTotal=nLMin*60+nLSec;// This will offset situations where the
   int nCTotal=nCMin*60+nCSec;// heartbeat is not called as often.
   if ((nCTotal-nLTotal)>7)
   { // there has been no fire of heartbeat - so do it
     //SendMessageToPC(GetFirstPC(),"MAREA:["+GetTag(oOwner)+"]Area:"+GetName(GetArea(oOwner)));
     ExecuteScript("npcactivities5",oOwner);
   } // there has been no fire of heartbeat - so do it
}
