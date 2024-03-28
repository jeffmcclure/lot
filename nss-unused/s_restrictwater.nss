void main()
{
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget( OBJECT_SELF );
location lLoc = GetLocation( oTarget );

int nInt;
nInt=GetLocalInt(oClicker, "NW_JOURNAL_ENTRYQST_WATERSUPPLY");

if (nInt == 1)
   {
    AssignCommand( oClicker, JumpToLocation( lLoc ) );
    } else {
    object oPC = GetClickingObject();
    if (!GetIsPC(oPC)) return;
    SendMessageToPC(oPC, "The air beyond this door carries a sense of foreboding.  You find no reason to enter this place.");
    }
}
