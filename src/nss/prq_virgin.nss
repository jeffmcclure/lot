//SCRIPT TO PUT ON TEXT APPEARS WHEN OF
//THE FIRST LINE
//- THE ONE THAT SHOULD ONLY BE SPOKEN
//ONCE
//NOTE, THAT LINE MUST HAVE A REPLY, IF ONLY
//AN END DIALOG!
#include "inc_party"

int StartingConditional() {
    object oPC=GetPCSpeaker();

    // OBJECT_SELF is the NPC we are talking to
    string sTag=GetTag(OBJECT_SELF);

    // Global to party
    return (GetPartyInt(oPC, sTag)==0);
}
