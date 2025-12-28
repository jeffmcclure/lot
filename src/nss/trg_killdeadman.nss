void main() {
    object oPC = GetPCSpeaker();

    object oTarget = OBJECT_SELF;

    //Visual effects can't be applied to waypoints, so if it is a WP
    //apply to the WP's location instead

    int nInt = GetObjectType(oTarget);

    if (nInt != OBJECT_TYPE_WAYPOINT)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget);
    else
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget));

    // do not destroy so other players in party can get the quest in an odd case when the quest sharing in mod_onclientent.nss does not work
    //oTarget = OBJECT_SELF;
    //DestroyObject(oTarget, 3.0);
}
