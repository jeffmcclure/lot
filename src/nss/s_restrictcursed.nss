void main()
{
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget( OBJECT_SELF );
location lLoc = GetLocation( oTarget );

int nInt;
nInt=GetLocalInt(oClicker, "NW_JOURNAL_ENTRYQST_LOSTBOYS");

if (nInt >= 1)
   {
    AssignCommand( oClicker, JumpToLocation( lLoc ) );
    } else {
    object oPC = GetClickingObject();
    if (!GetIsPC(oPC)) return;
    SendMessageToPC(oPC, "This cave reeks of suffering and death.  You need to have a good reason before you enter this place.");
    }
}
