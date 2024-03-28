void main()
{
object oPC = GetFirstPC();

ExecuteScript("giv_soulstone", OBJECT_SELF);
//ExportAllCharacters();
FadeToBlack(oPC, FADE_SPEED_SLOW);
DelayCommand(1.0, EndGame("lotending"));
//EndGame("lotending");
}
