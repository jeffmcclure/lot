//:://////////////////////////////////////////////////////////////////////////
//::  Visible Cloaks Script 1.60b - vcs_include
//::  Created by: DaRKWuRM wurmie666@hotmail.com
//::  Created Date: 1/3/2004
//::
//::  Thanks go to Rhedd for his wounderful cloaks as well as the
//::  inspiration for this script.
//:://////////////////////////////////////////////////////////////////////////

/*

  !@!@! THIS IS A INCLUDE FILE DO NOT EDIT OR PLACE ANYWAYRE !@!@!

*/

/* USAGE README:


     BG_CLOAK_VARIANT - Still supported, and always will be. It
     only functions for setting to Cloth 2 however. Adding any
     int value will now trigger Cloth 2 style. It would be
     a good idea to change over to tagline format VCS soon.

     EXAMPLE ITEM VARIABLE:
         Nameline: BG_CLOAK_VARIANT
         Typebox: int
         Value: 1

     VCS_CLOAK_TYPE - Replaces BG_CLOAK_VARIANT and supports both
     setting 1 in addition to other hakpacks with use of their
     neck part numbers as the setting. This function is now also
     depreciated. Tagline VCS has less problems.

     EXAMPLE ITEM VARIABLE:
         Nameline: VCS_CLOAK_TYPE
         Typebox: int
         Value: 31

     *TAGLINE VCS* -  At this point and time local item vars are
     cleared on merchant inventory saves. Tagline VCS looks at
     a cloaks tagline and checks for the VCS tag followed by
     3 digits. To show additional cloak colors/styles you must
     edit your items tagline and add VCS followed by a 3 digit
     extension. If you want cloth 2 for example you would
     add VCS031. VCS must be all caps, and any single digit must
     have 00 in front of the digit. Double digits like 22 would
     require adding a 0 to make it 022. This setting works on
     cloak items only, armor support has been dropped. Most
     should use the method unless you are trying to set a cloak
     style while in game.

     Examples:

               itemtagVCS009

               itemtagVCS022

               itemtagVCS161


     *** NOTE: VCS001 no longer supported. ***


     *NPC Cloaks* - Shows cloaks in a similar manner on NPC's.
     It wont work on monsters however, and never will I'm
     sorry to say. Any npc you build that changes their
     appearance when you equip armors and the like will
     function correctly. You may use custom VCS Tagline
     cloaks as well. I do not support use of the var methods
     but they may work as well. Just add:

     ExecuteScript("vcs_onspawn", OBJECT_SELF);

     to your NPC's OnSpawn script. And of course add a cloak
     too =)

*/

/* CHANGELOG:

   1/14/2004 - Removed Debug codes.

   1/13/2004 - Streamlined some code. Made new function for
               getting armor by ResRef then get neck part.

   1/11/2004 - Optimized core functions. Added NPC support
               thru OnSpawn.

   1/10/2004 - Set up core functions.

*/

// VCS1.6x Function
// Returns VCS appearance code.
int VCSSetItemType(object oVCSItem, object oPlayer);
int VCSSetItemType(object oVCSItem, object oPlayer) {

      int iBaseItem = GetBaseItemType(oVCSItem);
      string sVCSItemType;
      string sVCStagline = GetStringRight(GetTag(oVCSItem), 6);

      if((iBaseItem == BASE_ITEM_CLOAK) || (iBaseItem == BASE_ITEM_ARMOR)) {

         if(GetLocalInt(oVCSItem, "BG_CLOAK_VARIANT") != 0) {

            sVCSItemType = "31";

         }

         if(GetLocalInt(oVCSItem, "VCS_CLOAK_TYPE") != 0) {

            int iVCScloaktype = GetLocalInt(oVCSItem, "VCS_CLOAK_TYPE");

            if (iVCScloaktype == 1) { sVCSItemType = "31"; }
            if (iVCScloaktype > 1) { sVCSItemType = IntToString(iVCScloaktype); }

         }

      }


      if(TestStringAgainstPattern("VCS*n", sVCStagline) == TRUE) {

         if(TestStringAgainstPattern("*n", GetStringRight(sVCStagline, 3)) == TRUE) {

            sVCSItemType = GetStringRight(sVCStagline, 3);

         }


      }

      if(sVCSItemType == "") {

         if((iBaseItem == BASE_ITEM_CLOAK) || (iBaseItem == BASE_ITEM_ARMOR)) {

            sVCSItemType = "30";

         }

      }

   int iVCSItemType = StringToInt(sVCSItemType);

   return iVCSItemType;

}

// VCS1.6x Function
// Applys cloak to armor.
void VCSDoApplyCloak(object oCreature, object oVCSarmor, object oCloak);
void VCSDoApplyCloak(object oCreature, object oVCSarmor, object oCloak) {

     object oNewArmor = CopyItemAndModify(oVCSarmor, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_NECK, VCSSetItemType(oCloak, oCreature), TRUE);
     AssignCommand(oCreature,ActionEquipItem(oNewArmor,INVENTORY_SLOT_CHEST));
     DestroyObject(oVCSarmor);

}

// VCS1.6x Function
// Restores VCS improved armor appearance to normal.
void VCSDoRestoreArmor(object oPlayer, object oVCSarmor);
void VCSDoRestoreArmor(object oPlayer, object oVCSarmor) {

     object oNewArmor = CopyItemAndModify(oVCSarmor, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_NECK, StringToInt(GetLocalString(oVCSarmor, "VCS_NECK_PART")), TRUE);
     AssignCommand(oPlayer,ActionEquipItem(oNewArmor,INVENTORY_SLOT_CHEST));
     DestroyObject(oVCSarmor);

}


// VCS1.6x Function
// Get Item By BP.
object VCSGetItemByBP(object oPlayer, string sVCSItemBP);
object VCSGetItemByBP(object oPlayer, string sVCSItemBP) {

   object oVCSItem = GetFirstItemInInventory(oPlayer);
   object oFoundItem;

   while(GetIsObjectValid(oVCSItem)) {

      if((GetResRef(oVCSItem) == sVCSItemBP)) {

         oFoundItem = oVCSItem;

      }

      oVCSItem = GetNextItemInInventory(oPlayer);

   }

   return oFoundItem;

}

// VCS1.6x Function
// Get Stock Item Part Number.
int VCSGetPartNumber(object oPlayer, object oVCSItem, string sPart);
int VCSGetPartNumber(object oPlayer, object oVCSItem, string sPart) {
  int iRefValue;
  string sVCSResRef = GetResRef(oVCSItem);
  if((sVCSResRef != "") && (sPart == "NECK")) {

    CreateItemOnObject(sVCSResRef, oPlayer);

    object oRefItem = VCSGetItemByBP(oPlayer, sVCSResRef);

    int iRefValue = GetItemAppearance(oRefItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_NECK);
    DestroyObject(oRefItem);
  }

  return iRefValue;

}
