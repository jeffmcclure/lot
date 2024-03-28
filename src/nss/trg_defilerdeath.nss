void main()
{

object oPC = GetFirstPC();

AddJournalQuestEntry("QST_DEFILER", 3, oPC, TRUE, FALSE);

object oTarget;
oTarget = GetObjectByTag("SMOKE_HIVE");
DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("SND_HIVENOISE");
SoundObjectStop(oTarget);

}
