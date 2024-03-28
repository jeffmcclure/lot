void main()
{

object oPC = GetExitingObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_BANDIT");

if (!(nInt >= 3))
   return;

nInt=GetLocalInt(oPC, "jacholast");

if (!(nInt == 1))
   return;

object oTarget;
oTarget = GetObjectByTag("JACHO2");

DestroyObject(oTarget, 0.0);

}
