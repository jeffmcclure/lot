void main() {
    //SendMessageToPC(GetFirstPC(), "mod_onequip.nss");
    //ExecuteScript("vcs_onequip", OBJECT_SELF);
    //SendMessageToPC(GetFirstPC(), "eq_" + GetTag(GetPCItemLastEquipped()));
    ExecuteScript("eq_" + GetTag(GetPCItemLastEquipped()), OBJECT_SELF);
}
