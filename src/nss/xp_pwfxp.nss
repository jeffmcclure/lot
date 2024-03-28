/*

  This is a more sophisticated XP distribution script geared towards PWs.
  It comes with more then a dozen XP modifiers to fine tune XP output and
  is losely based on the old but solid TTV XP script.

  here is a small example of features, all modifiers are scalable:

  - PCs suffer XP reduction if their level is not close enough to the average
    party level. level 1 grouping with level 10 is probably not a good idea...

  - PCs suffer XP reduction if their level is not close enough to the CR of the killed MOB
    (both directions, if a PC kills a mob much stronger then himself = xp reduction, and vice versa)

  - Adjustable ECL modifiers, easy to sync with any subrace scripts

  - Group bonus. groups receive a small XP bonus (or big, if you wish) to encourage teamplay

  - Groupmembers need to be within minimum distance to the killed MOB if they want to receive XP

  - many more, see the constants...

  - easy to add new modifiers..

  all in all, this is pushing the nwn XP system more close to what you get in a MMORPG. You can
  make it very hard to level or easy as hell, with good control of group impact and flexible
  boundaries.

  system went through extensive beta tests at www.thefold.org - thanks to all the great
  players and staff there...

  --- USAGE --- --- USAGE --- --- USAGE --- --- USAGE --- --- USAGE ---

  just add the following line to the onDeath script of your creatures (default: nw_c2_default7):

    ExecuteScript("pwfxp",OBJECT_SELF);

  Don't forget to set the XP-Scale slider to 0 (module properties)

  ---------------------------------------------------------------------

  changelog:

  v1.1 initial full release (10/2003)

  - fine tuned and slightly optimized code
  - added debug toggle

  v1.0 beta (8/2003):

  - distance check should now work correctly

  - minimum XP award (see new PWFXP_MINIMUM_XP constant)

  - henchman, familiars, animal companions, summoned creatures and other NPCs in a player
    group now take away XP. see PWFXP_XP_DIVISOR_PC and PWFXP_XP_DIVISOR_NPC constants

  - made it easier to manage ECL modifiers. see PWFXP_ECL_MODIFIERS string constant

*/
//:://////////////////////////////////////////////
//:: Created By: LasCivious & Knat
//:: Created On: 7/2003
//:://////////////////////////////////////////////


// this will modify global xp output
const float PWFXP_GLOBAL_MODIFIER = 40.0;

// displays one-line XP status info after each kill
// useful while you fine tune the system.
const int PWFXP_DEBUG = TRUE;

// this is where you apply your subrace ECL modifiers
// add them to the constant in this form "(Modifier)-(Subrace)|...next|...etc"
const string PWFXP_ECL_MODIFIERS = "1-AASIMAR|1-TIEFLING|1-AIR GENASI|1-FIRE GENASI|1-WATER GENASI|1-EARTH GENASI|2-DROW|2-GRAY|2-DUERGAR|3-DEEP|3-SVIRFNEBLIN";

// small bonus for killing blow dealer
const float PWFXP_KILLINGBLOW_MODIFIER = 0.2; // 10%

// PC level gets compared to the average party level.
// APL = Average Party Level
//
// XP gets reduced if PC-level > APL + APL_REDUCTION
//   XP reduction is based on SCALAR, be careful if you change this
//   right now its 0 - 50% (scalar 0.5) for delta 2 (APL_REDUCTION) .. delta 4 (APL_NOXP)
//    delta = abs(APL - PC Level)
//   this means it will switch from 50% reduction to 100% reduction in one leap in case the PC level
//   is greater then APL + APL_NOXP.
//   i did this for a better granularity for the given default values but
//   you can freely change APL_REDUCTION and/or APL_NOXP. XP reduction gets auto-adjusted to the maximum
//   of SCALAR (50% default). if you want a more linear reduction, change scalar to 1
//
// XP gets reduced to zero if PC-level > APL + APL_NOXP
//
//
// Example (using default values):
// PC A = level 7
// PC B = level 3
// PC C = level 1
//
// average party level (APL) = 3.66
//
// Distance PC A = abs(PClevel - AveragePartyLevel) = abs(7 - 3.66) = 3.34
// PC-A has a final distance of 1.34 (3.34 - APL_REDUCTION)
// XP reduction = (SCALAR / (APL_NOXP - APL_REDUCTION)) * 1.34 = (0.5 / 2) * 1.34 = 33.5% XP reduction
//
// Distance PC B = abs(PClevel - AveragePartyLevel) = abs(3 - 3.66) = 0.66
// PC-A has a final distance of -1.34 (0.66 - APL_REDUCTION)
// no XP reduction
//
// Distance PC C = abs(PClevel - AveragePartyLevel) = abs(1 - 3.66) = 2.66
// PC-A has a final distanceof 0.66 (2.66 - APL_REDUCTION)
// XP reduction = (SCALAR / (APL_NOXP - APL_REDUCTION)) * 0.66 = (0.5 / 2) * 0.66 = 16.5% XP reduction
//
// those PCs with the biggest impact to the average party level receive the biggest XP reduction
// (in the above case PC A)
//
// set both to 20 if you don't want any apl_reduction
//
// example uses below values
// const float PWFXP_APL_REDUCTION = 2.5;
// const float PWFXP_APL_NOXP = 5.0;
//
// changed default to a bit less harsh values
const float PWFXP_APL_REDUCTION = 20.0; // levels
const float PWFXP_APL_NOXP = 20.0;


// this works like the APL constants above but it compares
// PC level vs challenge rating of the dead creature
// PCs get XP reduction if their level distance is greater then dead creature CR + PWFXP_CR_REDUCTION
// math is the same as the example above, just exchange
// AveragePartyLevel with CR of dead creature and use
// CR_REDUCTION and CR_NOXP as the constants
//
// set both to PWFXP_CR_MAX if you dont want any cr_reduction
const float PWFXP_CR_REDUCTION = 3.0; // levels
const float PWFXP_CR_NOXP = 6.0;

// described above
const float PWFXP_SCALAR = 0.5;

// maximum CR cap
// this stops creatures with sky-high CRs from giving godly XP
const float PWFXP_CR_MAX = 85.0;

// groups get a small xp bonus
// formular is groupsize-1 * modifier
// with a default value of 0.1 (10%) a party of 4 receives 30% XP bonus
// this should encourage grouping
// set it to 0.0 if you dont like that...
const float PWFXP_GROUPBONUS_MODIFIER = 0.2;

// groub members need to be within this distance to the dead creature
// if they want to get any XP during fights
const float PWFXP_MAXIMUM_DISTANCE_TO_GROUP = 35.0; // meters

// minimum XP for a kill
const int PWFXP_MINIMUM_XP = 25;

// these two constants determine how XP division works
// a group with two PCs and one NPC gets a total XP divisor of 2.5 (using default values)
// if they kill a 1000XP mob, both PCs only reveive 400 XP
const float PWFXP_XP_DIVISOR_PC  = 1.0;
const float PWFXP_XP_DIVISOR_NPC = 0.5;

