void main() {
    string script = "ac_"+GetTag (GetModuleItemAcquired());
    //SendMessageToPC(GetFirstPC(), "script = " + script);
    ExecuteScript(script, OBJECT_SELF); // original script

    object oItem = GetModuleItemAcquired();
    object oPC =  GetItemPossessor(oItem);
    // only restrict players from picking up certain tagged objects
    if (!GetIsPC(oPC)) {
        return;
    }

    string limitAcquire = GetLocalString(oItem, "LIMIT_ACQUIRE");
    if (limitAcquire != "") {
        //SendMessageToPC(GetFirstPC(), "GetIsPC()      '" + IntToString(GetIsPC(oPC)) + "'");
        string charName = GetName(oPC);
        if (limitAcquire != charName) {
            //SendMessageToPC(GetFirstPC(), "That loot belongs to '" + limitAcquire + "'");
            //SendMessageToPC(GetFirstPC(), "acquire1 from charName '" + charName + "'");
            //SendMessageToPC(GetFirstPC(), "acquire2 from tag      '" + GetTag(oPC) + "'");
            //SendMessageToPC(GetFirstPC(), "GetIsPC()      '" + IntToString(GetIsPC(oPC)) + "'");
            //SendMessageToPC(GetFirstPC(), "GetDescription '" + GetDescription(oItem) + "'");
            //SendMessageToPC(GetFirstPC(), "GetName '" + GetName(oItem) + "'");
            //SendMessageToPC(GetFirstPC(), "GetResRef '" + GetResRef(oItem) + "'");

            //if (charName == "Remains" || GetTag(oPC) == "BodyBag") {
        //if (GetTag(oPC) != "BodyBag") {
            AssignCommand(oPC, ActionSpeakString("I'll leave that for " + limitAcquire));
            object oLostBy = GetModuleItemAcquiredFrom();
            AssignCommand(oPC, DelayCommand(0.1, ActionGiveItem(oItem, oLostBy)));
        //}
        } else {
            // clear it so we can trade to other players
            SetLocalString(oItem, "LIMIT_ACQUIRE", "");
        }
    }
}
