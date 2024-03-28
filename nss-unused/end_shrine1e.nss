#include "x0_i0_treasure"


/*                         Created By Ben Hawkins 1.26.04
                              thelandofmyrr@hotmail.com
                             -----*****************-----
                      Online Server: Myrr Dunn 24.118.27.11:5121

  --->    Place this script in the OnDeath and OnOpen script events of the placeable  <---                */



    void MagicalChest(int nObjectType, string sObj, location lLoc)
{
    CreateObject(OBJECT_TYPE_PLACEABLE, sObj, lLoc);
}

    void main ()
{
    object oArea = GetArea(OBJECT_SELF);
    string sObj;

    // You can change the number (example) switch (Random(2)) ---->  switch (Random(5)) to reflect the number of chests you desire in your array.
        switch (Random(16))
{
        case 0: sObj = "shr_abandon005";
        break;

        case 1: sObj = "shr_creepy005";
        break;

        case 2: sObj = "shr_cryptic005";
        break;

        case 3: sObj = "shr_divine005";
        break;

        case 4: sObj = "shr_eerie005";
        break;

        case 5: sObj = "shr_gloomy005";
        break;

        case 6: sObj = "shr_glowing005";
        break;

        case 7: sObj = "shr_hidden005";
        break;

        case 8: sObj = "shr_magical005";
        break;

        case 9: sObj = "shr_mendicant005";
        break;

        case 10: sObj = "shr_oily005";
        break;

        case 11: sObj = "shr_secluded005";
        break;

        case 12: sObj = "shr_sparking005";
        break;

        case 13: sObj = "shr_spiritual005";
        break;

        case 14: sObj = "shr_weird005";
        break;
}

    //This line designates the TAG of the Waypoint where you want the chest to spawn.
    location lLoc = GetLocation(GetWaypointByTag ("WP_SHRINE1E"));

    //This line determines the length of time before the chest actually respawns. The purple number is how many seconds. (60.0 = 1 minute / 300.0 = 5 minutes / 600.0 = 10 minutes etc)
    //I have it set for speedy respawn to play test the treasure.
    AssignCommand(oArea, DelayCommand(3.0, MagicalChest(OBJECT_TYPE_PLACEABLE, sObj, lLoc)));


        object oPC = GetLastOpenedBy();

        if (!GetIsPC(oPC)) return;

        object oTarget;
        oTarget = OBJECT_SELF;

        //This next block generates treasure with the Custom Treasure Generator system. Very nice and simple although if you are data base savvy, im sure that would be more desirable.
{       //Please note that the treasure type is   LOW    <----  you can easily change this.
        CTG_CreateTreasure(TREASURE_TYPE_LOW, GetLastOpener(), OBJECT_SELF);
        SetLocalInt(OBJECT_SELF,"Looted",1);
        CTG_SetIsTreasureGenerated(OBJECT_SELF, FALSE);
        DelayCommand (2.0,SetLocalInt(OBJECT_SELF,"Looted",0));
}

        int nInt;
        nInt = GetObjectType(oTarget);

        // Apply a visual effect to the chest. You can also delay the effect to occur in time with the destruction.The number ->>> DelayCommand (5.0, <---- must correspond with
        // the number in line 79    DestroyObject (oTarget,6.0 <----
        // Note that the effect should be fired before the object is gone. Hence DelayCommand(5.0) versus DestroyObject(oTarget,6.0)
        if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand (5.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget));
        else DelayCommand (5.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget)));

            oTarget = OBJECT_SELF;

            DestroyObject(oTarget,6.0);


}

