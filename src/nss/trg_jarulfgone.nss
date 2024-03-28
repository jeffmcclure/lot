void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("HENCH_JARULF");
DestroyObject(oTarget, 0.0);

}

