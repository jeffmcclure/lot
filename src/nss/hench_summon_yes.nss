// Auldar: Check if we haven't asked the associate to stop summoning
int StartingConditional()
{
if (!GetLocalInt(OBJECT_SELF, "DontSummon"))
    {
    return TRUE;
    }
else return FALSE;
}
