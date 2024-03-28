void main()
{
object oClicker = GetClickingObject();
object oTarget = GetTransitionTarget( OBJECT_SELF );
location lLoc = GetLocation( oTarget );
if ((GetHitDice(oClicker) >= 10) && (GetHitDice(oClicker) <= 40)) {
AssignCommand( oClicker, JumpToLocation( lLoc ) );
} else {
object oPC = GetClickingObject();
if (!GetIsPC(oPC)) return;
SendMessageToPC(oPC, "Your character level must be at least 11 to access this area...");
}
}
