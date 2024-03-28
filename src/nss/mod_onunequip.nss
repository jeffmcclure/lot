void main()
{
//ExecuteScript("vcs_onunequip", OBJECT_SELF);
ExecuteScript("uq_"+GetTag
(GetPCItemLastUnequipped()), OBJECT_SELF);
}
