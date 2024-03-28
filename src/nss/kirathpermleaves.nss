void main()
{
     object oreleased_hench_controlblock = GetObjectByTag("released_hench_controlblock");
     SetLocalInt(oreleased_hench_controlblock, "Kirath was permanently released by the PC", 1);
     SetIsDestroyable(TRUE, FALSE, FALSE);
     ActionDoCommand(DestroyObject(OBJECT_SELF, 1.0));
     SetCommandable(FALSE);
}
