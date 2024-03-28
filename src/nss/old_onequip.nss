//:://////////////////////////////////////////////////////////////////////////
//::  Visible Cloaks Script 1.60b - vcs_onequip
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

       ExecuteScript("vcs_onequip", OBJECT_SELF);

     Near the top of your void main() on your OnPlayerEquip
     script if you have one, otherwise make it our default
     OnPlayerEquip script.

*/

/* CHANGELOG:

     1/11/2004 - Brought include file into the picture.
                 Removed old checking code. Removed core
                 functions.


     1/10/2004 - Squished bug where in certian cases cloak
                 would not appear(dubbed LoCash bug).
                 Squished bug where cloak on cloak obtained
                 eronius result (dubbed StewPid bug).

*/

#include "vcs_include"

void main()
{

  object oItem = GetPCItemLastEquipped();
  object oPC   = GetPCItemLastEquippedBy();
  int iBaseItem = GetBaseItemType(oItem);


  if(GetIsPC(oPC) != TRUE) {

    return;

  }

  if((iBaseItem == BASE_ITEM_CLOAK) || (iBaseItem == BASE_ITEM_ARMOR)) {

    if (GetLocalInt(oPC, "VCS_CLOAK_EQUIP_SWITCH")!=1) {

      SetLocalInt(oPC, "VCS_CLOAK_EQUIP_SWITCH", 1);


      object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oPC);
      object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK,oPC);
      object oNewArmor;


      if ((iBaseItem == BASE_ITEM_CLOAK) && (oArmor != OBJECT_INVALID)) {

        if(GetLocalString(oArmor, "VCS_NECK_PART") != "") {

            VCSDoApplyCloak(oPC, oArmor, oItem);

        }

        if(GetLocalString(oArmor, "VCS_NECK_PART") == "") {

            SetLocalString(oArmor, "VCS_NECK_PART", IntToString(VCSGetPartNumber(oPC, oArmor, "NECK")));
            VCSDoApplyCloak(oPC, oArmor, oItem);


        }

      }

      if ((iBaseItem == BASE_ITEM_ARMOR) && (oCloak != OBJECT_INVALID)) {

        if(GetLocalString(oItem, "VCS_NECK_PART") != "") {

           VCSDoApplyCloak(oPC, oItem, oCloak);

        }

        if(GetLocalString(oItem, "VCS_NECK_PART") == "") {

           SetLocalString(oItem, "VCS_NECK_PART", IntToString(VCSGetPartNumber(oPC, oItem, "NECK")));
           VCSDoApplyCloak(oPC, oItem, oCloak);

        }

      }

      if ((iBaseItem == BASE_ITEM_ARMOR) && (oCloak == OBJECT_INVALID)) {

        if(GetLocalString(oItem, "VCS_NECK_PART") != "") {

           VCSDoRestoreArmor(oPC, oItem);
           SendMessageToPC(oPC, "NoCloak - Applied old neck");

        }

        if(GetLocalString(oItem, "VCS_NECK_PART") == "") {

           SetLocalString(oItem, "VCS_NECK_PART", IntToString(VCSGetPartNumber(oPC, oItem, "NECK")));

        }

      }

     DelayCommand(0.1, SetLocalInt(oPC, "VCS_CLOAK_EQUIP_SWITCH", 0));

    }

  }
ExecuteScript("eq_"+GetTag
(GetPCItemLastEquipped()), OBJECT_SELF);
}
