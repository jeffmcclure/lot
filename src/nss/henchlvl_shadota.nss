int StartingConditional()
{
    int iResult;

    iResult = (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_SHADOWDANCER || GetClassByPosition(2, OBJECT_SELF) == CLASS_TYPE_SHADOWDANCER || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_SHADOWDANCER || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_INVALID) && (GetSkillRank(SKILL_HIDE, OBJECT_SELF) >= 10) && (GetSkillRank(SKILL_TUMBLE, OBJECT_SELF) >= 5) && (GetSkillRank(SKILL_MOVE_SILENTLY, OBJECT_SELF) >= 8) && (GetHasFeat(FEAT_DODGE, OBJECT_SELF)) && (GetHasFeat(FEAT_MOBILITY, OBJECT_SELF)) && (GetLevelByClass(CLASS_TYPE_SHADOWDANCER, OBJECT_SELF) != 10);
    return iResult;
}
