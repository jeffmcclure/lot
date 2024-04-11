// henchman death script
void main() {
    ExecuteScript("snd_warrior", OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "DEATH_TOKEN", 30001);
    ExecuteScript("war_hen_death", OBJECT_SELF);
}
