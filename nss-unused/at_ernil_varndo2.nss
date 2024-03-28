// Include the cu_functions script that makes AllParty() work
#include "cu_functions"

void main()
{
    // Set the variables on every party member including the speaker - gets around script generator problem of only setting it on character performing the action (speaking, opening chest, etc)
    // This is used to keep track of whether the party has picked up a particular quest.
    AllParty("nVarnQuest",GetPCSpeaker(),2);
}
