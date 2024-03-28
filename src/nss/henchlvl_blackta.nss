int StartingConditional()
{
    int iResult;

    iResult = (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_BLACKGUARD || GetClassByPosition(2, OBJECT_SELF) == CLASS_TYPE_BLACKGUARD || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_BLACKGUARD || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_INVALID) && (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL) && (GetSkillRank(SKILL_HIDE, OBJECT_SELF) >= 5) && (GetHasFeat(FEAT_CLEAVE, OBJECT_SELF)) && (GetBaseAttackBonus(OBJECT_SELF) >= 6) && (GetLevelByClass(CLASS_TYPE_BLACKGUARD, OBJECT_SELF) != 10);
    return iResult;
}
