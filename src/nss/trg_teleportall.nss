//#include "pqj_inc"
#include "inc_party"
void main()
{
object oArea = GetArea(OBJECT_SELF), oPC = GetFirstPC();
object oDst = GetWaypointByTag("WP_HOMEBASE");

while (oPC != OBJECT_INVALID)
    {
    if (GetArea(oPC) == oArea)
        {
        SetPartyInt(oPC, "diabloquest", 5);
        SetPartyInt(oPC, "diablokill", 5);
        //AddPersistentJournalQuestEntry("QST_DIABLO", 2, oPC, FALSE, FALSE);
        AddJournalQuestEntry("QST_DIABLO", 2, oPC, TRUE, FALSE);
        //ExecuteScript("sav_lastspeaker", OBJECT_SELF);
        AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, JumpToObject(oDst));
        }
    oPC = GetNextPC();
    }
}

