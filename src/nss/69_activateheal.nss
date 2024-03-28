//Place this script in the OnActivateItem event in the
//module's properties, used in conjuntion with the henchman bleeding
//option in 69_hen_death
//69MEH69 JUL2003
#include "69_i0_henchman"
void main()
{
 object oPC = GetItemActivator();
 object oTarget = GetItemActivatedTarget();
 string sTag = GetTag(oTarget);
 object oHealKit = GetItemActivated();
 string sHealKit = GetTag(oHealKit);
 object oArea = GetArea(oTarget);

 if(sHealKit == "HenchmanHealKit")
 {
  SendMessageToPC(oPC, "Healing Kit Used");
  if(GetIsHenchmanDying(oTarget))
  {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_HEALING_S, FALSE), oTarget);
   SetLocalInt(oArea, "nCHP" +sTag, 2);
  }
 }
}
