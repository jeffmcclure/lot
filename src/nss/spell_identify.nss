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
object oPC = GetItemActivator(), oProbe = GetFirstFactionMember(oPC, FALSE);

IdentifyAll(oPC, oPC);
while (oProbe != OBJECT_INVALID)
    {
    if (GetMaster(oProbe) == oPC) IdentifyAll(oProbe, oPC);
    oProbe = GetNextFactionMember(oPC, FALSE);
    }
  //AssignCommand(oPC, TakeGoldFromCreature(100, oPC, TRUE));

object oTarget;
oTarget = oPC;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BREACH), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_BREACH), GetLocation(oTarget));

}
