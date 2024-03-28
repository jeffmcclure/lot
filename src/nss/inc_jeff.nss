void MessageAll(string sMessage) {
    object oPlayer = GetFirstPC();
    while(GetIsObjectValid(oPlayer)) {
        SendMessageToPC(oPlayer,sMessage);
        oPlayer = GetNextPC();
    }
}
