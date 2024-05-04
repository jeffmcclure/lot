// Other special actions can be added here, not just this cloak logic
void CloakOfFastFeet(object oPC) {
    //SendMessageToPC(GetFirstPC(), "CloakOfFastFeet() ENTER");
    object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    if (GetIsObjectValid(oItem)) {
        if ("cloakoffastfe" == GetTag(oItem)) {
            effect eGoFast = EffectMovementSpeedIncrease(50);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGoFast, oPC);
        }
    }
}
