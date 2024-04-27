#include "inc_destroy"

// recommended use OnClosed event
void main() {
    //SendMessageToPC(GetFirstPC(), "disable_if_empty ENTER");
    DisableIfEmptyV1(OBJECT_SELF);
}
