int StartingConditional()
{
    int iResult;

    iResult = (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_SORCERER || GetClassByPosition(2, OBJECT_SELF) == CLASS_TYPE_SORCERER || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_SORCERER || GetClassByPosition(3, OBJECT_SELF) == CLASS_TYPE_INVALID);
    return iResult;
}
