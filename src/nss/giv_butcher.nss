#include "inc_jeff"
void main() {
    object oPC = GetPCSpeaker();
    AddJournalQuestEntry("QST_BUTCHER", 1, oPC, TRUE, FALSE);
    //object oTarget = GetObjectByTag("DOOR_BUTCHER");
    //SetLocked(oTarget, FALSE);
    JeffCreateObjectOnAllPartyMembers("key_butcher", 1, "", TRUE, TRUE);
}
