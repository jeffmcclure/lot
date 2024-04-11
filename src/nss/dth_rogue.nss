// henchman death script
void main() {
    ExecuteScript("snd_rogue", OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "DEATH_TOKEN", 30002);
    ExecuteScript("rog_hen_death", OBJECT_SELF);
}
