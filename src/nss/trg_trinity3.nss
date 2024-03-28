void main()
{
    object oItem = GetInventoryDisturbItem();
    int nItemBase =  GetBaseItemType(oItem);
    if(GetLocalInt(OBJECT_SELF,"") == FALSE &&
       GetTag(oItem) == "TRINITY_TOTEM2" )
    {
        DestroyObject(oItem);
        object oTarget;
        oTarget = GetObjectByTag("WP_TRINITY_02");
        //Visual effects can't be applied to waypoints, so if it is a WP
        //apply to the WP's location instead
        int nInt;
        nInt = GetObjectType(oTarget);
        if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL), oTarget);
        else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL), GetLocation(oTarget));
        oTarget = GetObjectByTag("TRINITY_ROCK_02");
        CreateItemOnObject("pestilenttotem", oTarget);
    }
}

