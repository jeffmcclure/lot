#include "NW_I0_GENERIC"
#include "nw_i0_tool"
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "D1_TAVERNSIGN");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

RewardPartyXP(500, oPC, TRUE);
AdjustAlignment(oPC, ALIGNMENT_EVIL, 5);

AddJournalQuestEntry("QST_MAGICBANNER", 2, oPC, TRUE, FALSE);

object oTarget;
CreateItemOnObject("tavernsign", oTarget);

oTarget = GetObjectByTag("DOOR_SNOTSPILL");
SetLocked(oTarget, FALSE);
AssignCommand(oTarget, ActionOpenDoor(oTarget));
//oTarget = GetObjectByTag("NPC_SNOTSPILL");
//AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("WP_GENERICJUMP")));

}
