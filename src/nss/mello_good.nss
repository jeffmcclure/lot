void main()
{

object oPC = GetPCSpeaker();
AdjustAlignment(oPC, ALIGNMENT_GOOD, 10);

object oTarget;
oTarget = OBJECT_SELF;
DelayCommand(10.0, DestroyObject(oTarget, 0.0));

}

