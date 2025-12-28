#include "inc_jeff"
void main() {
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("QST_BUTCHER", 1, oPC, TRUE, FALSE);
    JeffCreateObjectOnAllPartyMembers("key_butcher", 1, "", TRUE, TRUE);
}
