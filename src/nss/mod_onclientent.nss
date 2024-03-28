#include "inc_jeff"

void forDebug(object oPC) {
    JeffGiveStuff(oPC);
    CreateItemOnObject("key_butcher", oPC);
    CreateItemOnObject("tavernsign", oPC);
    AddJournalQuestEntry("QST_BUTCHER", 1, oPC, TRUE, FALSE);
    SetLocked(GetObjectByTag("CHURCH3_2LEORIC"), FALSE);
}

void main() {
    object oPC = GetEnteringObject();

    // for debug testing
    //forDebug(oPC);

    string msg = "Welcome to Tolitz Rosel's \"The Lord of Terror\" version 2.0.2 with enhancements by Jeff McClure\n";
    // Send welcome message to joining player
    SendMessageToPC(oPC,msg);

    // Introduce joining player to existing players
    string pcName = GetPCPlayerName(oPC);
    string charName = GetName(oPC);
    MessageAll("'" + pcName + "' joined as '" + charName + "'");
}
