void main()
{
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget( OBJECT_SELF );
location lLoc = GetLocation( oTarget );

int nInt;
nInt=GetLocalInt(oClicker, "NW_JOURNAL_ENTRYQST_ANDARIEL");

if (nInt >= 1)
   {
    AssignCommand( oClicker, JumpToLocation( lLoc ) );
    } else {
    object oPC = GetClickingObject();
    if (!GetIsPC(oPC)) return;
    SendMessageToPC(oPC, "Going deeper leads to more unknown dangers.  You must have a good reason for going further.");
    }
}
