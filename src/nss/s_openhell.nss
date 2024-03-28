#include "inc_party"
void main()
{
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget( OBJECT_SELF );
location lLoc = GetLocation( oTarget );

int nInt;
nInt=GetPartyInt(oClicker, "hell");

if (nInt == 1)
   {
    AssignCommand( oClicker, JumpToLocation( lLoc ) );
    } else {
    object oPC = GetClickingObject();
    if (!GetIsPC(oPC)) return;
    SendMessageToPC(oPC, "This stump seems to lead somewhere, but for some reason you have a hard time getting in.  Maybe you should come back to it later.");
    }
}
