int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "NW_WSPMKA002") == OBJECT_INVALID) return FALSE;
//if (!(GetAlignmentLawChaos(oPC) == ALIGNMENT_LAWFUL)) return FALSE;
if (!(GetLocalInt(oPC, "mello") == 1)) return FALSE;
if (!(GetLocalInt(oPC, "needkama") == 1)) return FALSE;

return TRUE;
}

