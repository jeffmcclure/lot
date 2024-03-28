//:://////////////////////////////////////////////////////////////////////////
//::  Visible Cloaks Script 1.60b - vcs_onspawn
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

       ExecuteScript("vcs_onspawn", OBJECT_SELF);

     Near // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** // on your
     NPC's OnSpawn script if you have one, otherwise make it your default
     OnSpawn script. NW_C2_DEFAULT9 is default OnSpawn script.

     ***NOTE: This only works on npc types where you can change
              their appearance by changing the armor. Monsters
              will not be effected by the script what so ever.

*/

/* CHANGELOG:

     1/11/2004 - So new no changes yet =)

*/

#include "vcs_include"

void main()
{

  object oNPC = OBJECT_SELF;
  object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST,oNPC);
  object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK,oNPC);

  if ((oCloak != OBJECT_INVALID) && (oArmor != OBJECT_INVALID)) {

     SetLocalString(oArmor, "VCS_NECK_PART", IntToString(GetItemAppearance(oArmor, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_NECK)));
     VCSDoApplyCloak(oNPC, oArmor, oCloak);

  }

}
