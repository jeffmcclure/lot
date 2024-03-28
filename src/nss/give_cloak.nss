#include "inc_jeff"
void main() {
    object oPC = GetPCSpeaker();
    JeffGiveStuff(oPC);
    AddJournalQuestEntry("QST_FIND_REMY", 2, oPC);
}
