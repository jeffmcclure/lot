//SCRIPT TO PUT ON TEXT APPEARS WHEN OF
//THE FIRST LINE
//- THE ONE THAT SHOULD ONLY BE SPOKEN
//ONCE
//NOTE, THAT LINE MUST HAVE A REPLY, IF ONLY
//AN END DIALOG!
#include "inc_party"

int StartingConditional() {
    object oPC=GetPCSpeaker();

    string sTag=GetTag(OBJECT_SELF); // OBJECT_SELF is the NPC we are talking to; GetTag() returns "NPC_THEEMON" for example

    // Local to player (vs party)
    return (GetLocalInt(oPC, sTag)==0);
}