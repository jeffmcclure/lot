#include "nw_i0_2q4luskan"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_BROWNSUIT");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(1000, oPC, TRUE);
AddJournalQuestEntry("QST_COW", 2, oPC, TRUE, FALSE);

object oTarget;
oTarget = OBJECT_SELF;

DelayCommand(1.0, DestroyObject(oTarget, 0.0));

location lTarget;
oTarget = GetWaypointByTag("POST_COWMAN");

lTarget = GetLocation(oTarget);

DelayCommand(1.0, CreateObjectVoid(OBJECT_TYPE_CREATURE, "completenut2", lTarget));

}
