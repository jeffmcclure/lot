#include "inc_party"
#include "inc_jeff"
void main() {
    object oPC = GetPCSpeaker();
    SetPartyInt(oPC, "butcherquest", 1);
    AddJournalQuestEntry("QST_BUTCHER", 1, oPC, TRUE, FALSE);
    JeffCreateObjectOnAllPartyMembers("keyButcher", 1, "", TRUE, TRUE);
}
