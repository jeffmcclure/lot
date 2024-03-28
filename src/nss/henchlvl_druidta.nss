int StartingConditional()
{
    int iResult;

    iResult = (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_DRUID || GetClassByPosition(2, OBJECT_SELF) == CLASS_TYPE_DRUID || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_DRUID || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_INVALID) && (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_NEUTRAL || GetAlignmentLawChaos(OBJECT_SELF) == ALIGNMENT_NEUTRAL);
    return iResult;
}
