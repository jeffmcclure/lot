int StartingConditional()
{

     // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "kirath released off radial menu?") == 1))
        return FALSE;

    return TRUE;
}
