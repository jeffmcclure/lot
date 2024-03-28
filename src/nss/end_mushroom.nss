//#include "pqj_inc"
//#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_SPECTRALELIXIRFAKE");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

}
