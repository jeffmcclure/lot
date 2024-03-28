#include "inc_party"
location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "shrine4");

if (!(nInt == 0))
   return;

SetPartyInt(oPC, "shrine4", 1);

if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_abandon004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_creepy004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_cryptic004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_divine004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_mendicant004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_eerie004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_gloomy004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_glowing004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_hidden004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_magical004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_oily004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_secluded004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_sparking004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_spiritual004", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_weird004", lTarget);

   }
else
   {
   oTarget = GetWaypointByTag("WP_SHRINE1D");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_divine004", lTarget);

   }
}
