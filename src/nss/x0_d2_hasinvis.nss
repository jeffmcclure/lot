// check to see if the henchman has a spell memorized

int StartingConditional()
{
    int iResult;

    iResult = GetHasSpell(SPELL_INVISIBILITY, OBJECT_SELF);
    return iResult;
}

