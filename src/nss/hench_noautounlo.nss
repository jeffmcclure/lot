#include "hench_i0_conv"

int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, sHenchAutoOpenLocks))
    {
        return FALSE;
    }
    return GetHasSkill(SKILL_OPEN_LOCK);
}
