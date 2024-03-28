#include "inc_party"
#include "nw_i0_generic"
location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetPartyInt(oPC, "nadine");
if (!(nInt == 2))
   return;

if ((GetGender(oPC)!=GENDER_FEMALE))
   {
   oTarget = GetWaypointByTag("WP_TEMPTING");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "nadinetemptress", lTarget);
   oTarget = oSpawn;
   AssignCommand(oTarget, ActionStartConversation(oPC, ""));

   oTarget = oSpawn;
//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead
   nInt = GetObjectType(oTarget);
   if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), oTarget));
   else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_POLYMORPH), GetLocation(oTarget)));
   //AssignCommand(GetObjectByTag("NADINE_TEMPTRESS"), ActionSpeakString("Foolish man!  So easily fooled by the desires of the flesh!"));

   oTarget = GetObjectByTag("NADINE");
   DestroyObject(oTarget, 0.0);
   SetPartyInt(oPC, "nadine", 3);

   }
else
   {
   SetPartyInt(oPC, "nadine", 3);
   ExecuteScript("trg_nadinefirex", OBJECT_SELF);

   }

}
