//#include "pqj_inc"
//#include "inc_party"
void main()
{

object oPC = GetFirstPC();

//SetPartyInt(oPC, "andariel", 5);
ActionSpeakString("You haven't seen the last of me, mortal!  We will deal with you soon...");

//AddPersistentJournalQuestEntry("QST_ANDARIEL", 3, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_ANDARIEL", 3, oPC, TRUE, FALSE);
DelayCommand(3.0, AssignCommand(oPC, ActionSpeakString("You will no longer lure men to their deaths!")));
//ExecuteScript("sav_lastkilled", OBJECT_SELF);

object oNPC = GetLastKiller();
object oTarget;
oTarget = GetObjectByTag("");
MusicBackgroundStop(GetArea(oNPC));
}
