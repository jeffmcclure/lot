#include "inc_gen_loot_p"
void main() {
    ExecuteScript("xp_partyextra", OBJECT_SELF);
    ExecuteScript("vfx_leoricdeath", OBJECT_SELF);
    ExecuteScript("vfx_forge", OBJECT_SELF);
    ExecuteScript("trg_leoricdeath", OBJECT_SELF);
    ExecuteScript("loot_normal_hi", OBJECT_SELF);
    GenLootForEachPlayer("undeadcrown", OBJECT_SELF);
}
