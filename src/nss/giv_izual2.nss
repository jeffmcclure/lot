void main()
{

object oPC = GetPCSpeaker();
AddJournalQuestEntry("QST_IZUAL", 2, oPC, TRUE, FALSE);

object oTarget;
oTarget = GetObjectByTag("HELL3_2HELLFORGE");
SetLocked(oTarget, FALSE);

}

