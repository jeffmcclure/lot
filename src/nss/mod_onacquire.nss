void main() {
    string script = "ac_"+GetTag (GetModuleItemAcquired());
    ExecuteScript(script, OBJECT_SELF); // original script

    object oItem = GetModuleItemAcquired();
    object oPC =  GetItemPossessor(oItem);
    // only restrict players from picking up certain tagged objects
    if (!GetIsPC(oPC)) {
        return;
    }

    string limitAcquire = GetLocalString(oItem, "LIMIT_ACQUIRE");
    if (limitAcquire != "") {
        string charName = GetName(oPC);
        if (limitAcquire != charName) {
            SendMessageToPC(oPC, "That loot belongs to '" + limitAcquire + "'");
            AssignCommand(oPC, ActionSpeakString("I'll leave that for " + limitAcquire));
            object oLostBy = GetModuleItemAcquiredFrom();
            AssignCommand(oPC, DelayCommand(0.1, ActionGiveItem(oItem, oLostBy)));
        } else {
            // clear it so we can trade to other players
            SetLocalString(oItem, "LIMIT_ACQUIRE", "");
        }
    }
}
