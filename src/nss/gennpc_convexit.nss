//////////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - Conversation Exit
//---------------------------------------------------------------
// By Deva Bryson Winblood - 01/2003
//////////////////////////////////////////////////////////////////

void main()
{
  SetLocalInt(OBJECT_SELF,"nGNBDisabled",FALSE); // make sure an important command
  ExecuteScript("npcactivities5",OBJECT_SELF);   // was not halted with it disabled
}
