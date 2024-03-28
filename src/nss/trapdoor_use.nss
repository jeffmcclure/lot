//trapdoor_use script by Kerico 7/5/02 for doorclosed by default
//place in trapdoor on-use scipt
//opens the trapdoor and starts convo between using pc and trapdoor

void main()
{
    //Get PC
    object oPC = GetLastUsedBy();

    //Get Trapdoor
    object oDoor = GetObjectByTag("TRISTRAM_2HIVE");

    //open trapdoor commands

    //have the PC kneel down and act as if opening the trapdoor
    AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 0.7f));
    //swing the door to open after a slight delay to allow for the PC's animation
    DelayCommand(1.0f, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));

    //OPTIONAL- have the using PC call the state
    //AssignCommand (oPC,SpeakString("Trapdoor Open"));

    //start trapdoor conversation
    AssignCommand (oPC,ActionStartConversation(oDoor));

}
