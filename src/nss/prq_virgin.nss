//SCRIPT TO PUT ON TEXT APPEARS WHEN OF
//THE FIRST LINE
//- THE ONE THAT SHOULD ONLY BE SPOKEN
//ONCE
//NOTE, THAT LINE MUST HAVE A REPLY, IF ONLY
//AN END DIALOG!
#include "inc_party"

int StartingConditional()
{
object oPC=GetPCSpeaker();

string sTag=GetTag(OBJECT_SELF);

return (GetPartyInt(oPC, sTag)==0);
//only returns true when variable is 0
}
