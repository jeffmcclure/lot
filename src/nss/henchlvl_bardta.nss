int StartingConditional()
{
    int iResult;

    iResult = (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_BARD || GetClassByPosition(2, OBJECT_SELF) == CLASS_TYPE_BARD || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_BARD || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_INVALID) && (GetAlignmentLawChaos(OBJECT_SELF) != ALIGNMENT_LAWFUL);
    return iResult;
}
