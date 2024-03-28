//Modified: NOV2002 69MEH69
#include "69_i0_henchman"

int StartingConditional() {
    object formerMaster = GetFormerMaster();

    if (GetFormerMaster() == GetPCSpeaker()) {
        SendMessageToPC(GetPCSpeaker(),"GetFormerMaster() == GetPCSpeaker()");
        return TRUE;
    }

    // Failsafe - trying to resolve bug where henchmen will not rejoin after separation
    if (formerMaster == OBJECT_INVALID) {
        //SendMessageToPC(GetPCSpeaker(),"formerMaster == OBJECT_INVALID");
        return FALSE;
    }

    // Failsafe - trying to resolve bug where henchmen will not rejoin after separation
    if (GetIsObjectValid(formerMaster) == FALSE) {
        SendMessageToPC(GetPCSpeaker(),"GetIsObjectValid(formerMaster) == FALSE");
        return TRUE;
    }

    return FALSE;
}
