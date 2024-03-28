void main() {
    ExecuteScript("ac_"+GetTag (GetModuleItemAcquired()), OBJECT_SELF);

    object oItem = GetModuleItemAcquired();
    //object oPC = GetModuleItemAcquiredBy();
    // Note: you can use GetItemPossessor(oItem); to get oPC
    object oPC =  GetItemPossessor(oItem);

    string limitAcquire = GetLocalString(oItem, "LIMIT_ACQUIRE");
    //SendMessageToPC(GetFirstPC(), "LIMIT_ACQUIRE=" + limitAcquire);
    if (limitAcquire != "") {
        string charName = GetName(oPC);
        if (limitAcquire != charName) {
            SendMessageToPC(GetFirstPC(), "That item belongs to '" + limitAcquire + "'");
            object oLostBy = GetModuleItemAcquiredFrom();
            //ActionGiveItem(oItem, oLostBy);
            AssignCommand(oPC, DelayCommand(0.1, ActionGiveItem(oItem, oLostBy)));
            //AssignCommand(oPC, ActionSpeakString("May the spirit of Arkaine protect me!"));
        }
    }

    //string sLog = GetName(oPC) + " acquired " + GetName(oItem) + " from " + GetName(oLostBy);
    //PrintString(sLog);

    // Using AssignCommand so sequence is preserved
    //AssignCommand(oMystery, ActionTakeItem(oClothes, oPC));
    //AssignCommand(oMystery, ActionDoCommand(SendMessageToPC(oPC, "HasItem on oMystery says: " + IntToString(HasItem(oMystery, GetTag(oClothes))))));
    //AssignCommand(oMystery, DelayCommand(1.0, ActionSpeakString("Hey, great abs! You been working out?")));
    //AssignCommand(oMystery, DelayCommand(3.0, ActionGiveItem(oClothes, oPC)));
    //AssignCommand(oMystery, DelayCommand(3.1, AssignCommand(oPC, ActionEquipItem(oClothes, INVENTORY_SLOT_CHEST))));
}
