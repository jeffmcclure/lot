object oTarget;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "arkaine");

if (nInt <= 4)
   {
   oTarget = OBJECT_SELF;

   AssignCommand(oTarget, ActionStartConversation(oPC, "con_arkaine2"));

   }
else
   {
   oTarget = OBJECT_SELF;

   AssignCommand(oTarget, ActionStartConversation(oPC, "con_arkaine1"));

   }

}
