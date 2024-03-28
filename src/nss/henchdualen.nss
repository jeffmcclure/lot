//::///////////////////////////////////////////////
//:: FileName henchdualen
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/13/2003 3:44:51 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    int wieldState = GetLocalInt(OBJECT_SELF, "DualWieldState");
    if(wieldState == 1)
    {
        return TRUE;
    }
    if(wieldState == 2)
    {
        return FALSE;
    }
    if (GetHasFeat(FEAT_TWO_WEAPON_FIGHTING, OBJECT_SELF))
    {
        return TRUE;
    }
    return FALSE;
}
