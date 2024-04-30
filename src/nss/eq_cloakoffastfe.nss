void main() {
    object oItem = GetPCItemLastEquipped();
    object oTarget =  GetItemPossessor(oItem);
    effect eGoFast = EffectMovementSpeedIncrease(50);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGoFast, oTarget);
}
