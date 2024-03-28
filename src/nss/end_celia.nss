void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("CELIA");
DelayCommand(12.0, DestroyObject(oTarget, 0.0));

}
