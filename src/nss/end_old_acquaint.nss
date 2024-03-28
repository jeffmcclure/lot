#include "inc_oldacquainta"
void main() {
    object oPC=GetPCSpeaker();
    string sTag=GetTag(OBJECT_SELF); // OBJECT_SELF is the NPC we are talking to
    OldAcquaintance(OBJECT_SELF);
}
