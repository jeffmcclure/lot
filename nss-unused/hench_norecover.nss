#include "hench_i0_conv"

int StartingConditional()
{
    if (GetLocalInt(OBJECT_SELF, sHenchAutoRecoverTraps))
    {
        return FALSE;
    }
    return GetHasSkill(SKILL_DISABLE_TRAP);
}

