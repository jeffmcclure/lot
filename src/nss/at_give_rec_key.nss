#include "inc_party"
#include "inc_jeff"
//::///////////////////////////////////////////////
//:: FileName at_give_rec_key
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Jeff McClure
//:: Created On: 2023-02-26
//:://////////////////////////////////////////////
void main() {
    // Give the speaker the items
    JeffCreateObjectOnAllPartyMembers("key_rectory_outs", 1, "", TRUE, TRUE);
    AddJournalQuestEntry("QST_FIND_REMY", 1, GetPCSpeaker());
}
