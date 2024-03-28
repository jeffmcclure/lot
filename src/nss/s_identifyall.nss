void IdentifyAll(object oSelf, object oMsg)
{ // identify all unidentified items in inventory
object oItem = GetFirstItemInInventory(oSelf);

while (oItem != OBJECT_INVALID)
    {
    if (!GetIdentified(oItem))
        {
        SetIdentified(oItem, TRUE);
        SendMessageToPC(oMsg, GetName(oItem));
        }
    oItem = GetNextItemInInventory(oSelf);
    }
}


void main()
{
object oPC = GetPCSpeaker(), oProbe = GetFirstFactionMember(oPC, FALSE);

IdentifyAll(oPC, oPC);
while (oProbe != OBJECT_INVALID)
    {
    if (GetMaster(oProbe) == oPC) IdentifyAll(oProbe, oPC);
    oProbe = GetNextFactionMember(oPC, FALSE);
    }
  AssignCommand(oPC, TakeGoldFromCreature(100, oPC, TRUE));
}
