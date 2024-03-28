#include "inc_jeff"

void main() {
    object oPC = GetEnteringObject();

    // for debug testing
    // JeffGiveStuff(oPC);

    string msg = "Welcome to Tolitz Rosel's \"The Lord of Terror\" version 1.0.7 with enhancements by Jeff McClure";
    // Send welcome message to joining player
    SendMessageToPC(oPC,msg);

    // Introduce joining player to existing players
    string pcName = GetPCPlayerName(oPC);
    string charName = GetName(oPC);
    MessageAll("'" + pcName + "' joined as '" + charName + "'");
}
