int StartingConditional()
{
    int iResult;

    iResult = (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_PALADIN || GetClassByPosition(2, OBJECT_SELF) == CLASS_TYPE_PALADIN || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_PALADIN || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_INVALID) && (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD && GetAlignmentLawChaos(OBJECT_SELF) == ALIGNMENT_LAWFUL);
    return iResult;
}
