// henchman death script
void main() {
    ExecuteScript("snd_monk", OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "DEATH_TOKEN", 30003);
    ExecuteScript("war_hen_death", OBJECT_SELF);
}
