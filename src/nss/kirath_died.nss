//::///////////////////////////////////////////////
//:: FileName kirath_died
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/03/2004 10:40:47
//:://////////////////////////////////////////////
int StartingConditional()
{
    object ocontroldeathblock = GetObjectByTag("controldeathblock");
    // Inspect local variables
    if(!(GetLocalInt(ocontroldeathblock, "kirath died") == 1))
        return FALSE;

    return TRUE;
}
