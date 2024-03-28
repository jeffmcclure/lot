void main()
{
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget( OBJECT_SELF );
location lLoc = GetLocation( oTarget );

int nInt;
nInt=GetLocalInt(oClicker, "NW_JOURNAL_ENTRYQST_BLIND");

if (nInt >= 2)
   {
    AssignCommand( oClicker, JumpToLocation( lLoc ) );
    } else {
    object oPC = GetClickingObject();
    if (!GetIsPC(oPC)) return;
    SendMessageToPC(oPC, "This seems like a very dark place, with unknown horrors.  Perhaps you need to ask Cain about it first.");
    }
}
