void main()
{
    if(GetLocalInt(OBJECT_SELF, "arkaine_open") == FALSE)
        ActionStartConversation(GetLastUsedBy());
}
