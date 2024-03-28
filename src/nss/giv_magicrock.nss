//#include "pqj_inc"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
object oSpawn;
location lTarget;

oTarget = GetWaypointByTag("WP_STOLENWAGON");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "stolenwagon001", lTarget);

oTarget = GetWaypointByTag("WP_ROBBERCORPSE");
lTarget = GetLocation(oTarget);
oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "robbercorpse", lTarget);

//AddPersistentJournalQuestEntry("QST_MAGICROCK", 1, oPC, FALSE, FALSE);
AddJournalQuestEntry("QST_MAGICROCK", 1, oPC, TRUE, FALSE);
//ExecuteScript("sav_lastspeaker", OBJECT_SELF);

}

