void main()
{
    object oreleased_hench_controlblock = GetObjectByTag("released_hench_controlblock");
    SetLocalInt(oreleased_hench_controlblock, "Kirath was permanently released by the PC", 1);
    ClearAllActions();
    SetIsDestroyable(TRUE, FALSE, FALSE);
    object oExit = GetNearestObjectByTag("rezzed_henchman_exit");
    ActionForceMoveToObject(oExit, TRUE);
    ActionDoCommand(DestroyObject(OBJECT_SELF, 1.0));
    SetCommandable(FALSE);
}

