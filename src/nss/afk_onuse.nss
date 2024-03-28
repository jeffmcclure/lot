/* onuse for afk_butterflies.
Lame Copywrite(C) 6-6-03
Thaum@msn.com
*/

void main()
{
object oPC= GetLastUsedBy(); //Get PC user
    AssignCommand(oPC, ClearAllActions()); //Clears all actions set by the player in prep. for afk
    AssignCommand(oPC, SpeakString("I am Going AFK",TALKVOLUME_TALK)); //tells everyone around PC that they are afk.
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0f, 6.0f)); //playes the sitting animation for a single heartbeats time (so the HB can take over)

}

