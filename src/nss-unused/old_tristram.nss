object oTarget;
void main()
{

object oPC = GetEnteringObject();

   ExploreAreaForPlayer(GetArea(oPC), oPC);
   SetLocalInt(oPC, "wirthome", 0);

}
