void main()
{
object oArea = GetArea(OBJECT_SELF), oPC = GetFirstPC();
object oDst = GetWaypointByTag("WP_HELL4");

while (oPC != OBJECT_INVALID)
    {
    if (GetArea(oPC) == oArea)
        {
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, JumpToObject(oDst));
        }
    oPC = GetNextPC();
    }
}

