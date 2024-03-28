void main()
{
//ExecuteScript("vcs_onequip", OBJECT_SELF);
ExecuteScript("eq_"+GetTag
(GetPCItemLastEquipped()), OBJECT_SELF);
}
