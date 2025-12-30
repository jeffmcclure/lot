#include "inc_jeff"
#include "inc_party"
#include "loot_inc_gen_mod"

void levelUp(object oPC) {
    //int grant = 16000 - GetXP(oPC);
    int grant = 28000 - GetXP(oPC);
    if (grant > 0)
        GiveXPToCreature(oPC, grant);
}

void equipment(object oPC) {
    //CreateItemOnObject("lootgenie", oPC);   // loot genie
    object obj;
    obj = CreateItemOnObject("it_mneck026", oPC); // natural armor +1
    SetIdentified(obj,TRUE);
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_NECK)));

    //obj = CreateItemOnObject("nw_it_mneck023", oPC); // glittering necklace
    //DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_NECK)));

    CreateItemOnObject("nw_wswls001", oPC); // long sword
    //obj = CreateItemOnObject("nw_waxbt001", oPC); // battle axe
    obj = CreateItemOnObject("butcherscleaver", oPC); // butcher's cleaver
    SetIdentified(obj,TRUE);
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_RIGHTHAND)));

    obj = CreateItemOnObject("nw_ashlw001", oPC); // large shield
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_LEFTHAND)));

    //obj = CreateItemOnObject("nw_it_mring011", oPC); // jade ring
    //DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_LEFTRING)));
    //CreateItemOnObject("nw_it_mring009", oPC); // Ring of cyan

    obj = CreateItemOnObject("nw_it_mring013", oPC); // Ring of scholors - lore white light
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_LEFTRING)));
}

void forDebug(object oPC) {

    int nNumber = GetLocalInt(oPC, "FOR_DEBUG");
    if(nNumber > 0) {
        return;
    }
    SetLocalInt(oPC, "FOR_DEBUG", 1);

    levelUp(oPC);

    JeffGiveStuff(oPC);

    CreateItemOnObject("key_butcher", oPC);
    AddJournalQuestEntry("QST_BUTCHER", 1, oPC, TRUE, FALSE);

    CreateItemOnObject("key_rectory_ins", oPC);
    CreateItemOnObject("key_rectory_outs", oPC); // rectory outdoor key
    AddJournalQuestEntry("QST_FIND_REMY", 1, oPC, TRUE, FALSE);

    //CreateItemOnObject("tavernsign", oPC);

    equipment(oPC);

    CreateItemOnObject("nw_it_sparscr216", oPC); // knock scroll

    object obj;

    CreateLoot("tomeoftownportal", oPC, oPC); // Tome of town portal
    CreateLoot("bookoftownportal", oPC, oPC); // Tome of town portal
    CreateLoot("scrolloftownport", oPC, oPC); // Scroll of town portal
    CreateLoot("wandoftownportal", oPC, oPC); // Tome of town portal

    CreateItemOnObject("nw_it_book011", oPC); // Tome of identify
    CreateItemOnObject("nw_it_book021", oPC); // Tome of healing
    CreateItemOnObject("nw_it_book021", oPC); // Tome of healing
    CreateItemOnObject("nw_it_book021", oPC); // Tome of healing
    CreateItemOnObject("nw_it_mpotion012", oPC); // Potion of heal
    CreateItemOnObject("nw_it_mpotion003", oPC); // Potion of Cure Critical Wounds
    CreateItemOnObject("nw_it_mpotion015", oPC); // Potion of Bull's Strength
    CreateItemOnObject("nw_it_mpotion016", oPC); // Potion of Aid
    CreateItemOnObject("nw_it_mpotion005", oPC); // Potion of Barkskin
    CreateItemOnObject("nw_it_mpotion009", oPC); // Potion of Bless
    CreateItemOnObject("nw_it_book031", oPC); // apocalypse

    obj = CreateItemOnObject("cloakoffastfe", oPC, 1, "cloakoffastfe"); // Cloak of Fast Feet
    SetIdentified(obj,TRUE);
    SetPlotFlag(obj, TRUE);  // set resale value to zero
    DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(obj, INVENTORY_SLOT_CLOAK)));

    GiveGoldToCreature(oPC, 76543);

    SetLocked(GetObjectByTag("CHURCH3_2LEORIC"), FALSE);
}

void shareOneQuest(object oPC, string questName) {
    // read greatest state from all party members
    int nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRY" + questName);
    if (nInt > 0)
        AddJournalQuestEntry(questName, nInt, oPC, FALSE, FALSE);
}

void shareQuests(object oPC) {
    shareOneQuest(oPC, "QST_BUTCHER");
    shareOneQuest(oPC, "QST_IRAQ");
    shareOneQuest(oPC, "QST_ANDARIEL");
    shareOneQuest(oPC, "QST_FIND_REMY");
    shareOneQuest(oPC, "QST_FLESHDOOM");
    shareOneQuest(oPC, "QST_GHARBAD");
    shareOneQuest(oPC, "QST_GRAVEMATTERS");
    shareOneQuest(oPC, "QST_IZUA");
    shareOneQuest(oPC, "QST_JANNA");
    shareOneQuest(oPC, "QST_LACHDANAN");
    shareOneQuest(oPC, "QST_SHADOWFANG");
    shareOneQuest(oPC, "QST_ANVIL");
    shareOneQuest(oPC, "QST_ARKAINE");
    shareOneQuest(oPC, "QST_BANDIT");
    shareOneQuest(oPC, "QST_MUSHROOM");
    shareOneQuest(oPC, "QST_CHAMBER");
    shareOneQuest(oPC, "QST_MAINMODULE");
    shareOneQuest(oPC, "QST_CORNERSTONE");
    shareOneQuest(oPC, "QST_LEORIC");
    shareOneQuest(oPC, "QST_DEFILER");
    shareOneQuest(oPC, "QST_NAKRUL");
    shareOneQuest(oPC, "QST_ORCHARD");
    shareOneQuest(oPC, "QST_BLIND");
    shareOneQuest(oPC, "QST_MAGICROCK");
    shareOneQuest(oPC, "QST_ISLAND");
    shareOneQuest(oPC, "QST_COW");
    shareOneQuest(oPC, "QST_DIABLO");
    shareOneQuest(oPC, "QST_LOSTBOYS");
    shareOneQuest(oPC, "QST_MAGICBANNER");
    shareOneQuest(oPC, "QST_OGDENSIGN");
    shareOneQuest(oPC, "QST_WATERSUPPLY");
    shareOneQuest(oPC, "QST_THEODORE");
    shareOneQuest(oPC, "QST_LIGHTS");
    shareOneQuest(oPC, "QST_LAZARUS");
    shareOneQuest(oPC, "QST_WARLORD");
    shareOneQuest(oPC, "QST_WORMS");
    shareOneQuest(oPC, "QST_ZHAR");
    shareOneQuest(oPC, "QST_HENCH_JARULF_DEAD");
    shareOneQuest(oPC, "QST_HENCH_JANNA_DEAD");
    shareOneQuest(oPC, "QST_HENCH_MELLO_DEAD");
    shareOneQuest(oPC, "QST_HENCH_TKRON_DEAD");

    // butcher key
    int nInt;

    nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_BUTCHER"); // read from party
    if (nInt > 0 && nInt < 2)
        JeffCreateObjectOnAllPartyMembers("key_butcher", 1, "", TRUE, TRUE);

    // rectory key
    nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_FIND_REMY"); // read from party
    if (nInt == 1)
        JeffCreateObjectOnAllPartyMembers("key_rectory_outs", 1, "", TRUE, TRUE);

    if (nInt == 3)
        JeffCreateObjectOnAllPartyMembers("key_rectory_ins", 1, "", TRUE, TRUE);
}

void main() {
    object oPC = GetEnteringObject();

    // for debug testing
    //forDebug(oPC);

    //levelUp(oPC);
    //equipment(oPC);
    //CreateItemOnObject("key_rectory_ins", oPC);
    //CreateItemOnObject("key_rectory_ins", oPC);
    //CreateItemOnObject("key_rectory_ins", oPC);
    //CreateItemOnObject("key_rectory_outs", oPC); // rectory outdoor key
    //CreateItemOnObject("key_rectory_outs", oPC); // rectory outdoor key
    //CreateItemOnObject("key_rectory_outs", oPC); // rectory outdoor key

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

    shareQuests(oPC);
}
