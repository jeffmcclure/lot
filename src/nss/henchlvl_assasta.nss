int StartingConditional()
{
    int iResult;

    iResult = (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_ASSASSIN || GetClassByPosition(2, OBJECT_SELF) == CLASS_TYPE_ASSASSIN || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_ASSASSIN || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_INVALID) && (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL) && (GetSkillRank(SKILL_HIDE, OBJECT_SELF) >= 8) && (GetSkillRank(SKILL_MOVE_SILENTLY, OBJECT_SELF) >= 8) && (GetLevelByClass(CLASS_TYPE_ASSASSIN, OBJECT_SELF) != 10);
    return iResult;
}
