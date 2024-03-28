void main()
{
    object oDoor = GetObjectByTag("HideoutPortcullis");
    //ActionCloseDoor(oDoor);
    SetLocked(oDoor, FALSE);
    if (GetLocalInt(OBJECT_SELF, "bPulled") == FALSE) {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        SetLocalInt(OBJECT_SELF, "bPulled", TRUE);
    }
    else {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        SetLocalInt(OBJECT_SELF, "bPulled", FALSE);
    }
    ActionOpenDoor(oDoor);
}
