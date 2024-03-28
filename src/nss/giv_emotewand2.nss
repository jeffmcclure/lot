void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

if (GetItemPossessedBy(oPC, "dmfi_pc_emote")!= OBJECT_INVALID)
   return;

CreateItemOnObject("dmfi_pc_emote", oPC);

}

