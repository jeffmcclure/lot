void main()
{
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget( OBJECT_SELF );
location lLoc = GetLocation( oTarget );

int nInt;
nInt=GetLocalInt(oClicker, "bonechamber");

if (nInt <= 4)
   {
    AssignCommand( oClicker, JumpToLocation( lLoc ) );
    } else {
    object oPC = GetClickingObject();
    if (!GetIsPC(oPC)) return;
    SendMessageToPC(oPC, "You have already finished this quest. Time to move on...");
    }
}
