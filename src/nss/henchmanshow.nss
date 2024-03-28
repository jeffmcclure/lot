//::///////////////////////////////////////////////
//:: FileName henchmanshow
//:://////////////////////////////////////////////
//:: This script will cause the henchman to tell the PC
//:: the full contents of his inventory.
//:://////////////////////////////////////////////
//:: Created By: 69MEH69
//:: Created On: 21JUN2003
//:://////////////////////////////////////////////
#include "69_inc_henai"
void main()
{
 object oPC = GetPCSpeaker();
 object oHenchMaster = GetHenchman(oPC);
 object oHench, oMyHench, oLastHench;
 if(oHenchMaster == OBJECT_SELF)
 {
  OpenInventory(OBJECT_SELF, oPC);
 }
 else
 {
  oHench = oHenchMaster;
  while(oHench != OBJECT_INVALID)
   {
    oLastHench = oHench;
    oHench = GetHenchman(oHench);
   }
  while(oHenchMaster != OBJECT_SELF)
  {
   oMyHench = GetHenchman(oHenchMaster);
   RemoveHenchman(oHenchMaster, oMyHench);
   RemoveHenchman(oPC, oHenchMaster);
   AddHenchman(oPC, oMyHench);
   AddHenchman(oLastHench, oHenchMaster);
   //RemoveHenchman(oHenchMaster, oMyHench);
   oLastHench = oHenchMaster;
   oHenchMaster = oMyHench;
  }
  if(oHenchMaster == OBJECT_SELF)
  {
   OpenInventory(OBJECT_SELF, oPC);
  }
 }
}
