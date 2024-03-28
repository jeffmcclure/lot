#include "inc_party"
location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "shrine3");

if (!(nInt == 0))
   return;

SetPartyInt(oPC, "shrine3", 1);

if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_abandon003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_creepy003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_cryptic003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_divine003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_mendicant003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_eerie003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_gloomy003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_glowing003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_hidden003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_magical003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_oily003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_secluded003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_sparking003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_spiritual003", lTarget);

   }
else if (d100()<=10)
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_weird003", lTarget);

   }
else
   {
   oTarget = GetWaypointByTag("WP_SHRINE1C");
   lTarget = GetLocation(oTarget);
   oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "shr_cryptic003", lTarget);

   }
}
