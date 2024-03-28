void main()
{
    object oTagChild = GetNearestObjectByTag("TAG_CHILD");
    if (GetTag(OBJECT_SELF) == "TAG_START")
    {
     if (GetIsObjectValid(oTagChild) && GetLocalInt(OBJECT_SELF, "TagStart") == 0)
     {
     SetLocalInt(oTagChild, "IAMIT", 1);
     SetLocalInt(OBJECT_SELF, "TagStart", 1);
     return;
     }
     else if ((GetIsObjectValid(oTagChild) == FALSE) && GetLocalInt(OBJECT_SELF, "TagStart") > 0)
     {
     DeleteLocalInt(OBJECT_SELF, "TagStart");
     return;
     }
    }
    object oTagHome = GetNearestObjectByTag("TAG_HOME");

// Uncomment this next line if you want your children to disappear at night... only use this if you have a respawner script
    if (GetIsNight()) DestroyObject(OBJECT_SELF);

    if (GetLocalInt(OBJECT_SELF, "IAMIT") == 1)
    {
        if (GetDistanceToObject(oTagChild) < 1.5f)
        {
            ClearAllActions();
            ActionSpeakString("Tag! You're it!");
            PlayVoiceChat(VOICE_CHAT_LAUGH);
            ActionMoveAwayFromObject(oTagChild, TRUE);
            DelayCommand(2.0f, SetLocalInt(oTagChild, "IAMIT", 1));
            DeleteLocalInt(OBJECT_SELF, "IAMIT");
        }
        else
        {
            ClearAllActions();
            ActionMoveToObject(oTagChild, TRUE, 0.0f);
        }
    }
    else
    {
        if (GetDistanceToObject(oTagHome) > 10.0f)
        {
            ClearAllActions();
            PlayVoiceChat(VOICE_CHAT_LAUGH);
            ActionMoveToObject(oTagHome, TRUE);
        }
        else if (GetLocalInt(oTagChild, "IAMIT") == 1)
        {
            PlayVoiceChat(VOICE_CHAT_LAUGH);
            ActionMoveAwayFromObject(oTagChild, TRUE);
        }
        else
        {
            ActionRandomWalk();
        }
    }
}
