// henchman death script
void main() {
    ExecuteScript("snd_sorcerer", OBJECT_SELF);
    SetLocalInt(OBJECT_SELF, "DEATH_TOKEN", 30004);
    ExecuteScript("sor_hen_death", OBJECT_SELF);
}
