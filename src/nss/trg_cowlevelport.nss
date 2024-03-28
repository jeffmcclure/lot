location lTarget;
object oSpawn;
object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;
int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));
if (DoOnce==TRUE) return;
SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

if (GetItemPossessedBy(oPC, "spell_soulstone")!= OBJECT_INVALID)
   {
    if (GetItemPossessedBy(oPC, "spell_cornerstone")!= OBJECT_INVALID)
        {
           oTarget = GetWaypointByTag("WP_COWLEVELPORTAL");
           lTarget = GetLocation(oTarget);
           oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "cowlevelportal", lTarget);
        }
   }
else
   {
   FloatingTextStringOnCreature("You are back in Tristram.", oPC);

   }

}
