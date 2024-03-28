#include "inc_jeff"

void main() {
    object oPC = GetEnteringObject();

    // for debug testing
//    JeffGiveStuff(oPC);

    string msg = "Welcome to Tolitz Rosel's \"The Lord of Terror\" version 1.0.7 with enhancements by Jeff McClure";
    SendMessageToPC(oPC,msg);
}
