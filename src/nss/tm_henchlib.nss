// My henchman routines: tm_henchlib
//
// Written by: Celowin
// Last updated: 7/25/02
//
#include "nw_i0_henchman"
//
// Defines how many levels behind the pc the henchman lags
// Minimum of 0
int HENCH_LAG=1;
// Defines the lowest level the henchman can be
// Minimum of 1, Maximum of 20
int HENCH_MIN=5;
// Defines the highest level the henchman can be
// Minimum of HENCHMIN, Maximum of 20
int HENCH_MAX=20;
//
// This function figures out what level the henchman
// "should" be, based on the min, max, and lag
// numbers above, as well as the pc level.
int GetTargetLevel(object oHench=OBJECT_SELF)
{
// Find the pc's level.
int nMasterLevel=GetHitDice(GetMaster(oHench));
// Apply the lag.
int nTargetLevel=nMasterLevel-HENCH_LAG;
// If that is less than the minimum level, the
// henchman should be that minimum level.
if (nTargetLevel < HENCH_MIN)
  nTargetLevel = HENCH_MIN;
// If the level is over the max, cap the level
// to that max.
if (nTargetLevel > HENCH_MAX)
  nTargetLevel = HENCH_MAX;
return nTargetLevel;
}
//
// This function checks to see if the henchman
// is ready to level up.
int GetReadyToLevel(object oHench=OBJECT_SELF)
{
// Find both the current henchman level, and
// what level the henchman should be.
int nTargetLevel=GetTargetLevel(oHench);
int nCurrentLevel=GetHitDice(oHench);
// If the current level is too low, it is ready
// to level up.
if (nCurrentLevel<nTargetLevel)
  return TRUE;
else
  return FALSE;
}
//
// This is the biggie.  This is the function to
// actually level up the henchman.
void LevelHench(object oHench=OBJECT_SELF)
{
// Find the desired level.
int nTargetLevel=GetTargetLevel(oHench);
// Whee!  Fun with string manipulation!
// All this is working to find the appropriate blueprint
// to create the "new and improved" henchman.
string sNewBlueprint=GetTag(oHench);
sNewBlueprint=GetStringLowerCase(sNewBlueprint);
if (nTargetLevel<=9)
  sNewBlueprint=sNewBlueprint+"0";
sNewBlueprint=sNewBlueprint+IntToString(nTargetLevel);
// Create the new henchman.
// There will be a "fade in" of the new one and a "fade out"
// of the old.
object oNewHench=CreateObject(OBJECT_TYPE_CREATURE, sNewBlueprint, GetLocation(oHench));
// Get rid of the old henchman.  You're fired!
object oMaster=GetMaster(oHench);
RemoveHenchman(oMaster, oHench);
// Copy our desired behavior patterns to the new henchman.
CopyLocals(oHench, oNewHench);
AssignCommand(oNewHench,SetAssociateListenPatterns());
// Add in our new henchman.
AddHenchman(oMaster,oNewHench);
// Take out the trash.
DestroyObject(oHench);
}

