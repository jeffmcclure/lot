#include "inc_party"
void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "nakrulspell");

if (nInt == 1)
   {
   SetPartyInt(oPC, "nakrulspell", 2);
   FloatingTextStringOnCreature("Praedictum Otium", oPC);
   PlaySound("war_chant3");
   }
else if (GetPartyInt(oPC, "nakrulspell") == 3)
   {
   FloatingTextStringOnCreature("Praedictum Otium", oPC);
   PlaySound("war_chant3");
   }
else
   {
   SetPartyInt(oPC, "nakrulspell", 0);
   FloatingTextStringOnCreature("Praedictum Otium", oPC);
   PlaySound("war_chant3");
   }

}
