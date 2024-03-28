// OnPlayerLevelUp script:  tm_levelup
//
// When a player levels, this checks to see if the henchman is ready to
// level up as well, and takes necessary action.
//
#include "tm_henchlib"
//
void main()
{
// Find the leveling pc and its henchman
object oPC=GetPCLevellingUp();
object oHench=GetHenchman(oPC);
//
if (GetIsObjectValid(oHench))  // Don’t go on if no henchman
  {
  if (GetReadyToLevel(oHench)) // Don’t go on if not time to level
    {
    LevelHench(oHench);
    }
  }
}

