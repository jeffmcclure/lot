void main()
{

object oPC = GetFirstPC();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;
//
AddJournalQuestEntry("QST_WORMS", 2, oPC, TRUE, FALSE);

object oTarget;
oTarget = GetObjectByTag("SND_WORMS1");
SoundObjectStop(oTarget);
AmbientSoundStop(GetArea(oPC));

}

