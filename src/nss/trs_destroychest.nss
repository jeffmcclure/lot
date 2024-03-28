void main()
{

object oTarget;
oTarget = OBJECT_SELF;

DelayCommand(60.0, ExecuteScript("trs_spawnchest", OBJECT_SELF));

DelayCommand(90.0, DestroyObject(oTarget, 0.0));

}
