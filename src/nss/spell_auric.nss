void RemoveXPFromParty(int nXP, object oPC, int bAllParty=TRUE)
{

if (!bAllParty)
   {
   nXP=(GetXP(oPC)-nXP)>=0 ? GetXP(oPC)-nXP : 0;
   SetXP(oPC, nXP);
   }
else
   {
   object oMember=GetFirstFactionMember(oPC, TRUE);

   while (GetIsObjectValid(oMember))
      {
      nXP=(GetXP(oMember)-nXP)>=0 ? GetXP(oMember)-nXP : 0;
      SetXP(oMember, nXP);
      oMember=GetNextFactionMember(oPC, TRUE);
      }
   }
}
#include "nw_i0_tool"
void main()
{
object oPC;
if (!GetIsPC(GetItemActivatedTarget())
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();
RewardPartyGP(25000, oPC, TRUE);
oPC = GetItemActivatedTarget();
RemoveXPFromParty(1000, oPC, FALSE);

effect eEffect;
eEffect = EffectDamage(125, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);

ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, GetItemActivator());

object oTarget;
oTarget = GetItemActivator();

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), oTarget);
else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), GetLocation(oTarget));

}
