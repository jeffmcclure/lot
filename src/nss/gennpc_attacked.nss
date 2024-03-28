////////////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - Gennpc_attacked OnPhysicalAttacked
//==========================================================
// By Deva Bryson Winblood.  02/2003
////////////////////////////////////////////////////////////

void main()
{
   SetLocalInt(OBJECT_SELF,"nGNBDisabled",TRUE);
   DelayCommand(60.0,SetLocalInt(OBJECT_SELF,"nGNBDisabled",FALSE));
   ExecuteScript("nw_c2_default5",OBJECT_SELF);
}
