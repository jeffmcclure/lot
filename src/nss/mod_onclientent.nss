#include "inc_jeff"
#include "loot_inc_gen_mod"

void forDebug(object oPC) {
    JeffGiveStuff(oPC);

    CreateItemOnObject("key_butcher", oPC);
    //CreateItemOnObject("rectorykey", oPC);
    CreateItemOnObject("key_rectory_outs", oPC); // rectory outdoor key

    //CreateItemOnObject("tavernsign", oPC);
    CreateItemOnObject("lootgenie", oPC);   // loot genie
    object obj = CreateItemOnObject("it_mneck026", oPC); // natural armor +1
    SetIdentified(obj,TRUE);
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_NECK)));

    obj = CreateItemOnObject("nw_it_mneck023", oPC); // glittering necklace
    //DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_NECK)));

    CreateItemOnObject("nw_wswls001", oPC); // long sword
    //obj = CreateItemOnObject("nw_waxbt001", oPC); // battle axe
    obj = CreateItemOnObject("butcherscleaver", oPC); // butcher's cleaver
    SetIdentified(obj,TRUE);
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_RIGHTHAND)));

    obj = CreateItemOnObject("nw_ashlw001", oPC); // large shield
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_LEFTHAND)));

    CreateItemOnObject("nw_it_sparscr216", oPC); // knock scroll

    //CreateItemOnObject("nw_it_mring009", oPC); // Ring of cyan
    obj = CreateItemOnObject("nw_it_mring013", oPC); // Ring of scholors - lore white light
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_LEFTRING)));

    CreateLoot("tomeoftownportal", oPC, oPC); // Tome of town portal
    CreateLoot("bookoftownportal", oPC, oPC); // Tome of town portal
    CreateLoot("scrolloftownport", oPC, oPC); // Scroll of town portal
    CreateLoot("wandoftownportal", oPC, oPC); // Tome of town portal

    CreateItemOnObject("nw_it_book011", oPC); // Tome of identify
    CreateItemOnObject("nw_it_book021", oPC); // Tome of healing
    CreateItemOnObject("nw_it_book031", oPC); // apocalypse

    obj = CreateItemOnObject("cloakoffastfe", oPC, 1, "cloakoffastfe"); // Cloak of Fast Feet
    SetIdentified(obj,TRUE);
    SetPlotFlag(obj, TRUE);  // set resale value to zero
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_CLOAK)));

    GiveGoldToCreature(oPC, 76543);

    AddJournalQuestEntry("QST_BUTCHER", 1, oPC, TRUE, FALSE);
    AddJournalQuestEntry("QST_FIND_REMY", 1, oPC, TRUE, FALSE);
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
    forDebug(oPC);

    string msg = "Welcome to Tolitz Rosel's \"The Lord of Terror\" version 2.0.6 with enhancements by Jeff McClure\n";
    // Send welcome message to joining player
    SendMessageToPC(oPC,msg);

    // Introduce joining player to existing players
    string pcName = GetPCPlayerName(oPC);
    string charName = GetName(oPC);
    MessageAll("'" + pcName + "' joined as '" + charName + "'");
    //AssignCommand(oPC, ActionStartConversation(OBJECT_SELF, "dmfi_universal", TRUE));
    //object oBoy = GetObjectByTag("BEGINNING");
    //AssignCommand(oBoy, ActionStartConversation(oPC, "con_beginning", TRUE));

    //ActionStartConversation(GetEnteringObject(), "con_beginning");
}
