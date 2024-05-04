#include "inc_jeff"
//#include "NW_I0_GENERIC"

void forDebug(object oPC) {
    JeffGiveStuff(oPC);

    CreateItemOnObject("key_butcher", oPC);
    //CreateItemOnObject("rectorykey", oPC);
    CreateItemOnObject("key_rectory_outs", oPC); // rectory outdoor key

    //CreateItemOnObject("tavernsign", oPC);
    CreateItemOnObject("lootgenie", oPC);   // loot genie
    CreateItemOnObject("it_mneck026", oPC); // natural armor +1

    CreateItemOnObject("nw_wswls001", oPC); // long sword
    CreateItemOnObject("nw_waxbt001", oPC); // battle axe
    CreateItemOnObject("nw_ashlw001", oPC); // large shield

    CreateItemOnObject("nw_it_sparscr216", oPC); // knock scroll

    //CreateItemOnObject("nw_it_mring009", oPC); // Ring of cyan
    CreateItemOnObject("nw_it_mring013", oPC); // Ring of scholors - lore white light

    CreateItemOnObject("nw_it_book001", oPC); // Tome of town portal
    CreateItemOnObject("nw_it_book011", oPC); // Tome of identify
    CreateItemOnObject("nw_it_book021", oPC); // Tome of healing

    GiveGoldToCreature(oPC, 76543);

    AddJournalQuestEntry("QST_BUTCHER", 1, oPC, TRUE, FALSE);
    SetLocked(GetObjectByTag("CHURCH3_2LEORIC"), FALSE);
    int grant = 16000 - GetXP(oPC);
    if (grant > 0)
        GiveXPToCreature(oPC, grant);
    //SetXP(oPC, 16000);

    //while (TRUE) {
        //int level = GetCharacterLevel(oPC);
        //if (level >= 4) break;
        //GiveXPToCreature(oPC, 1000);
    //}
}

void main() {
    object oPC = GetEnteringObject();

    // for debug testing
    //forDebug(oPC);

    string msg = "Welcome to Tolitz Rosel's \"The Lord of Terror\" version 2.0.5 with enhancements by Jeff McClure\n";
    // Send welcome message to joining player
    SendMessageToPC(oPC,msg);

    // Introduce joining player to existing players
    string pcName = GetPCPlayerName(oPC);
    string charName = GetName(oPC);
    MessageAll("'" + pcName + "' joined as '" + charName + "'");
}
