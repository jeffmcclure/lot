void main()
{
    object oItem = GetInventoryDisturbItem();
    int nItemBase =  GetBaseItemType(oItem);
    if(GetLocalInt(OBJECT_SELF,"") == FALSE &&
       GetTag(oItem) == "D1_CATHEDRALMAP" )
    {
        DestroyObject(oItem);
        object oPC = GetLastDisturbed();
        object oDoor = GetObjectByTag("TRISTRAM_2CRYPTS");
        AssignCommand(oDoor,ActionOpenDoor(oDoor));
        SetLocked(oDoor,FALSE);
        AddJournalQuestEntry("QST_GRAVEMATTERS", 2, oPC, TRUE, FALSE);
        AssignCommand(oPC, ActionSpeakString("The door to the crypts have unlocked!"));

        object oTarget;
        oTarget = GetObjectByTag("TRISTRAM_2CRYPTS");
        //Visual effects can't be applied to waypoints, so if it is a WP
        //apply to the WP's location instead
        int nInt;
        nInt = GetObjectType(oTarget);
        if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), oTarget);
        else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1), GetLocation(oTarget));
    }
}

