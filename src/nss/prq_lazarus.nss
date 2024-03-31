#include "inc_party"
int StartingConditional() {
    object oPC = GetPCSpeaker();

    //if (GetItemPossessedBy(oPC, "KEY_LAZARUS_STAFF") == OBJECT_INVALID) return FALSE;
    return GetItemPossessedBy(oPC, "KEY_LAZARUS_STAFF") != OBJECT_INVALID;
}
