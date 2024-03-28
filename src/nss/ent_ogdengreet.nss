void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "ogdengreet");

if (!(nInt == 0))
   return;

object oTarget;
oTarget = GetObjectByTag("OGDEN");

AssignCommand(oTarget, ActionStartConversation(oPC, ""));
//SetLocalInt(oPC, "ogdengreet", 1);

}

