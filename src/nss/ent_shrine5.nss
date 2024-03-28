#include "inc_party"
location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "shrine5");

if (!(nInt == 0))
   return;

SetPartyInt(oPC, "shrine5", 1);

if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_abandon005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_creepy005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_cryptic005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_divine005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_mendicant005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_eerie005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_gloomy005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_glowing005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_hidden005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_magical005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_oily005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_secluded005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_sparking005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_spiritual005", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_weird005", lTarget);

   }
else
   {
   oTarget = GetWaypointByTag("WP_SHRINE1E");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_magical005", lTarget);

   }
}
