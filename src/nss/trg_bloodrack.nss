void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WARLORD");
if (nInt == 3)
   {
   object oTarget;
   oTarget = OBJECT_SELF;

   SetLocked(oTarget, FALSE);

   ExecuteScript("loot_unique", OBJECT_SELF);

   }
//nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_WARLORD");
else if (nInt == 4)
   {
   object oTarget;
   oTarget = OBJECT_SELF;

   SetLocked(oTarget, TRUE);

   SendMessageToPC(oPC, "You have already accessed the contents of this rack.");

   }
else
   {
   object oTarget;
   oTarget = OBJECT_SELF;

   SetLocked(oTarget, TRUE);

   SendMessageToPC(oPC, "You cannot access this rack until you have killed the Warlord of Blood");

   }

}
