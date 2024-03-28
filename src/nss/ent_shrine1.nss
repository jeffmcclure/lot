#include "inc_party"
location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "shrine1");

if (!(nInt == 0))
   return;

SetPartyInt(oPC, "shrine1", 1);

if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_abandon", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_creepy", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_cryptic", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_divine", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_mendicant", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_eerie", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_gloomy", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_glowing", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_hidden", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_magical", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_oily", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_secluded", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_sparking", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_spiritual", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_weird", lTarget);

   }
else
   {
   oTarget = GetWaypointByTag("WP_SHRINE1A");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_abandon", lTarget);

   }
}
