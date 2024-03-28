void main() {
    ExecuteScript("xp_partyextra", OBJECT_SELF);
    //ExecuteScript("loot_normal_hi", OBJECT_SELF);

    //location loc = GetLocation(OBJECT_SELF);

    // Locate the area we are in
    object oArea = GetArea(OBJECT_SELF);

    // Locate where in the are we are
    vector vPosition = GetPosition(OBJECT_SELF);

    // Identify the direction we are facing
    float fOrientation = GetFacing(OBJECT_SELF) - 180.0;
    if (fOrientation < 0.0) fOrientation = fOrientation + 360.0;

    // Create a new location with this information
    location loc = Location(oArea, vPosition, fOrientation);

    object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, "x0_treasure_high", loc);
    SetLocked(oChest, FALSE);
    SetName(oChest, "Loot");
    string monsterIdTag = GetTag(OBJECT_SELF);

    object oPC = GetLastKiller();
    string loot1 = GetLocalString(OBJECT_SELF, "loot1");
    SendMessageToPC(oPC, "1 loot1 = '" + loot1 + "'");

    SetLocalString(oChest, "monsterIdTag", monsterIdTag);
    SetLocalString(oChest, "loot1", "nw_it_mneck013");
    SetEventScript(oChest, EVENT_SCRIPT_PLACEABLE_ON_USED, "lot_usechest");
}
