int StartingConditional()
{
object oPC = GetPCSpeaker();
if (!(GetLocalInt(oPC, "bush") == 1)) return FALSE;
return TRUE;

if (GetItemPossessedBy(oPC, "D1_IRAQOIL") == OBJECT_INVALID) return FALSE;
return TRUE;

}

