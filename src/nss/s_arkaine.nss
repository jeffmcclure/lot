object oTarget;
effect eEffect;
void main()
{

object oPC = GetLastUsedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "arkaine");

if (nInt == 5)
   {
   ExecuteScript("s_onusedconverse", OBJECT_SELF);
   }
}
