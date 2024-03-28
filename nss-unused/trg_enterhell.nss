object oTarget;
object oItem;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "diablokill");

if (nInt == 1)
   {
   SetLocalInt(oPC, "diablokill", 2);

   oTarget = GetObjectByTag("PORTAL_SANCTUARY");

//Visual effects can't be applied to waypoints, so if it is a WP
//apply to the WP's location instead

   nInt = GetObjectType(oTarget);

   if (nInt != OBJECT_TYPE_WAYPOINT) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), oTarget);
   else ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_GATE), GetLocation(oTarget));

   SendMessageToPC(oPC, "You have a BAD feeling about this...");

   }
else
   {
   SendMessageToPC(oPC, "You must destroy the dark lord now!");

   }

}
