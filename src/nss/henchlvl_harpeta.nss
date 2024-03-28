int StartingConditional()
{
    int iResult;

    iResult = (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_HARPER || GetClassByPosition(2, OBJECT_SELF) == CLASS_TYPE_HARPER || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_HARPER || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_INVALID) && (!GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL) && (GetSkillRank(SKILL_SEARCH, OBJECT_SELF) >= 4) && (GetSkillRank(SKILL_PERSUADE, OBJECT_SELF) >= 8) && (GetSkillRank(SKILL_LORE, OBJECT_SELF) >= 6) && (GetSkillRank(SKILL_DISCIPLINE, OBJECT_SELF) >= 4) && (GetHasFeat(FEAT_ALERTNESS, OBJECT_SELF)) && (GetHasFeat(FEAT_IRON_WILL, OBJECT_SELF)) && (GetLevelByClass(CLASS_TYPE_HARPER, OBJECT_SELF) != 10);
    return iResult;
}
