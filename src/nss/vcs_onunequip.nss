//:://////////////////////////////////////////////////////////////////////////
//::  Visible Cloaks Script 1.60b - vcs_onunequip
//::  Created by: DaRKWuRM wurmie666@hotmail.com
//::  Created Date: 1/3/2004
//::
//::  Thanks go to Rhedd for his wounderful cloaks as well as the
//::  inspiration for this script.
//:://////////////////////////////////////////////////////////////////////////

/* INSTALL README:

     Download and install Rhedds Cloak Hakpack on the vault.
     Send Rhedd a e-mail letting him know you love his work.

     Add:

       ExecuteScript("vcs_onunequip", OBJECT_SELF);

     Near the top of your void main() on your OnPlayerUnEquip
     script if you have one, otherwise make it our default
     OnPlayerUnEquip script.

*/

/* CHANGELOG:

     1/12/2004 - Reduced DelayCommand to improve speed.

     1/10/2004 - Removed loop control from UnEquip code,
                 not needed, no armor here.

      1/9/2004 - Added performace streamline. Code now only fires
                 if item is a cloak or armor.

      1/7/2004 - Fixed ghosting bug.


*/

void main()
{

   object oItem  = GetPCItemLastUnequipped();
   object oPC    = GetPCItemLastUnequippedBy();
   int iBaseItem = GetBaseItemType(oItem);


   if(GetIsPC(oPC) != TRUE) {

     return;

   }

   if(iBaseItem == BASE_ITEM_CLOAK) {

      object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
      object oNewArmor;

      if ((oArmor != OBJECT_INVALID) && (GetLocalString(oArmor, "VCS_NECK_PART") != "")) {

         oNewArmor = CopyItemAndModify(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_NECK, StringToInt(GetLocalString(oArmor, "VCS_NECK_PART")), TRUE);
         DelayCommand(0.2, AssignCommand(oPC,ActionEquipItem(oNewArmor,INVENTORY_SLOT_CHEST)));
         DestroyObject(oArmor);

      }

   }

}
