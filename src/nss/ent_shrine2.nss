#include "inc_party"
location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "shrine2");

if (!(nInt == 0))
   return;

SetPartyInt(oPC, "shrine2", 1);

if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_abandon002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_creepy002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_cryptic002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_divine002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_mendicant002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_eerie002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_gloomy002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_glowing002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_hidden002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_magical002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_oily002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_secluded002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_sparking002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_spiritual002", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_weird002", lTarget);

   }
else
   {
   oTarget = GetWaypointByTag("WP_SHRINE1B");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_creepy002", lTarget);

   }
}
