void main() {
    //SendMessageToPC(GetFirstPC(), "destroy_if_empty ENTER");

    if (!GetIsObjectValid(GetFirstItemInInventory(OBJECT_SELF)) && GetGold(OBJECT_SELF) < 1) {
        //SendMessageToPC(GetFirstPC(), "destroy_if_empty DESTROY");
        DestroyObject(OBJECT_SELF);
    }
}
