// Include the cu_functions script - which makes PartyGotEntry actually work.
#include "cu_functions"

void main()
{
   if (GetLocalInt(GetPCSpeaker(),"AnkranXP2") == 0) //"AnkranXP2" is the name of a variable - this could be anything you like. This line checks to see if the xp has been given before.
    {
    PartyGotEntry("AnkranXP2",GetPCSpeaker(),65, "XP gained - furthering the plot"); //This executes the xp (Giving 65xp in this case), set "AnkranXP2" to 1 so that the xp is not given out again later, and tells the party what the XP was for (furthering the plot).
    }
}
