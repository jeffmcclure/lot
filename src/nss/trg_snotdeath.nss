object oTarget;
void main()
{

object oPC = GetFirstPC();
//while (GetIsObjectValid(GetMaster(oPC)))
//   {
//   oPC=GetMaster(oPC);
//   }
//
//if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "NW_JOURNAL_ENTRYQST_MAGICBANNER");
if (nInt == 2)
   {
   CreateItemOnObject("tavernsignx", OBJECT_SELF);
   oTarget = GetObjectByTag("DOOR_SNOTPILL");
   SetLocked(oTarget, FALSE);
   AssignCommand(oTarget, ActionOpenDoor(oTarget));

   }
else
   {
   oTarget = GetObjectByTag("DOOR_SNOTSPILL");
   SetLocked(oTarget, FALSE);
   AssignCommand(oTarget, ActionOpenDoor(oTarget));
   }
}
