//::///////////////////////////////////////////////
//:: 69_hen_castspell
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Returns true only if Henchman has at least
   one level in spell casting class.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

int StartingConditional()
{
    if (GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF) > 0 || GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF) > 0 || GetLevelByClass(CLASS_TYPE_BARD, OBJECT_SELF) > 0  || GetLevelByClass(CLASS_TYPE_SORCERER, OBJECT_SELF) > 0 || GetLevelByClass(CLASS_TYPE_WIZARD, OBJECT_SELF) > 0)
    {
        return TRUE;
    }
    return FALSE;
}
