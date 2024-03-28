void main()
{
    object oItem = GetInventoryDisturbItem();
    int nItemBase =  GetBaseItemType(oItem);
    if(GetLocalInt(OBJECT_SELF,"") == FALSE &&
       GetTag(oItem) == "D1_BLOODSTONE1" )
    {
        DestroyObject(oItem);
        object oDoor = GetObjectByTag("DOOR_BLOOD1");
        AssignCommand(oDoor,ActionOpenDoor(oDoor));
        SetLocked(oDoor,FALSE);

        object oPC = GetLastDisturbed();
        object oTarget;
        object oSpawn;
        location lTarget;
        oTarget = GetWaypointByTag("PORTAL_BLOODSTONE1");
        lTarget = GetLocation(oTarget);
        oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "bloodstoneportal", lTarget);

        oTarget = oSpawn;

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

        int nInt;
        nInt = GetObjectType(oTarget);

        if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oTarget));
        else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), GetLocation(oTarget)));

        FloatingTextStringOnCreature("The door to the East has unlocked!", oPC);
    }
}

