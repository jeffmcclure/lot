#include "inc_party"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "nakrulspell");

if (nInt == 0)
   {
   SetPartyInt(oPC, "nakrulspell", 1);
   FloatingTextStringOnCreature("In Spiritu Sanctum", oPC);
   PlaySound("war_chant2");
   }
else if (GetPartyInt(oPC, "nakrulspell") == 3)
   {
   FloatingTextStringOnCreature("In Spiritu Sanctum", oPC);
   PlaySound("war_chant2");
   }
else
   {
   SetPartyInt(oPC, "nakrulspell", 0);
   FloatingTextStringOnCreature("In Spiritu Sanctum", oPC);
   PlaySound("war_chant2");
   }

}
