#include "hench_i0_conv"

int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, sHenchAutoOpenChest))
    {
        return FALSE;
    }
    return GetSkillRank(SKILL_SEARCH) * 3 / 4 >= GetHitDice(OBJECT_SELF);
}




