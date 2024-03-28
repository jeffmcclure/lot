void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("SND_COWPORTAL");
SoundObjectStop(oTarget);

}

