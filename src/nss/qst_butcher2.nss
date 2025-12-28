#include "inc_party"
void main() {
    object oPC = GetPCSpeaker();
    AdjustAlignment(oPC, ALIGNMENT_EVIL, 2);
}
