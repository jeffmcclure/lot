#include "inc_jeff"
//#include "NW_I0_GENERIC"

void forDebug(object oPC) {
    JeffGiveStuff(oPC);

    CreateItemOnObject("key_butcher", oPC);
    //CreateItemOnObject("rectorykey", oPC);
    CreateItemOnObject("key_rectory_outs", oPC);

    CreateItemOnObject("tavernsign", oPC);
    CreateItemOnObject("lootgenie", oPC);
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
    //CreateItemOnObject("lootgenie", oPC);

    string msg = "Welcome to Tolitz Rosel's \"The Lord of Terror\" version 2.0.4 with enhancements by Jeff McClure\n";
    // Send welcome message to joining player
    SendMessageToPC(oPC,msg);

    // Introduce joining player to existing players
    string pcName = GetPCPlayerName(oPC);
    string charName = GetName(oPC);
    MessageAll("'" + pcName + "' joined as '" + charName + "'");
}
