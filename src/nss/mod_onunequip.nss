void main() {
    //SendMessageToPC(GetFirstPC(), "mod_onunequip.nss");
    //ExecuteScript("vcs_onunequip", OBJECT_SELF);
    //SendMessageToPC(GetFirstPC(), "uq_"+GetTag(GetPCItemLastUnequipped()));
    ExecuteScript("uq_"+GetTag(GetPCItemLastUnequipped()), OBJECT_SELF);
}
