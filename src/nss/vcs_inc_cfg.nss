//:://////////////////////////////////////////////////////////////////////////
//::  Visible Cloaks Script 1.62 - vcs_inc_cfg
//::  Created by: DaRKWuRM wurmie666@hotmail.com
//::  Created Date: 1/3/2004
//::
//::  Thanks go to Rhedd for his wounderful cloaks as well as the
//::  inspiration for this script.
//:://////////////////////////////////////////////////////////////////////////

/*

  !@!@! THIS IS A INCLUDE FILE DO NOT PLACE ANYWAYRE !@!@!

*/

/* USAGE README:

     **********************************************************
     YOU MUST HAVE either/atleast Rhedds Cloak hak or CEP
     TO USE THIS
     **********************************************************


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
     add VCS006. VCS must be all caps, and any single digit must
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

     *** NOTE: Added toggle for NPC cloaks to be turned off
     at script level, so if you install them you may turn
     easly if for some reason you need to. This was a requested
     feature that seemed to make sence.

     *CEP SUPPORT* - CEP changed a couple things in this code.
     Most noteably is the number scheme for cloak items. If
     your not using CEP don't worry, its fully optional. This
     script has a habbit of mantaining backwards compatibility
     meaning if you update your old code in a live module,
     everything should work fine. If you have CEP the you have
     some additional options, like choosing the default model
     at script level in this config file. I have listed all the
     models for the CEP cloaks in the section where you can
     configure the default.

*/

//:://////////////////////////////////////////////////////////////////////////
// Set this to TRUE to enable NPC Cloaks otherwise set to False.
// Default setting is TRUE
//:://////////////////////////////////////////////////////////////////////////
int VCS_NPC_CLOAK_ON = TRUE;

//:://////////////////////////////////////////////////////////////////////////
// Set this to TRUE to enable CEP Expansion otherwise set to False.
// Default setting is TRUE
//:://////////////////////////////////////////////////////////////////////////
int VCS_CEPEXP_ON = TRUE;

//:://////////////////////////////////////////////////////////////////////////
// If CEP is ON set this to the default cloak model you want displayed.
//
// 112 = Cloth 1 Rhedds
// 113 = Cloth 2 Rhedds
// 155 = Lisa's Fancy
// 156 = Lisa's Fancy
// 157 = Lisa's Fancy
//
// Default setting is 112 for Rhedds Default Model
//:://////////////////////////////////////////////////////////////////////////
int VCS_CEP_DEFAULT_CMODEL = 112;
