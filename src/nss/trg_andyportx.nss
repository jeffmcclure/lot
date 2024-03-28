#include "inc_party"
#include "nw_i0_2q4luskan"
string sDeny;
void main()
{

object oPC = GetPCSpeaker();

object oItem;
oItem = GetItemPossessedBy(oPC, "andystone1");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "andystone2");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

oItem = GetItemPossessedBy(oPC, "andystone3");
if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

SendMessageToPC(oPC, "You put all three runestones into the altar...");
SendMessageToPC(oPC, "...and hear a rumbling behind you!");
FloatingTextStringOnCreature("The rune stones are opening a portal behind you - to Andariel's lair!", oPC);

object oTarget;
location lTarget;
oTarget = GetWaypointByTag("PORTAL_ANDARIEL");
lTarget = GetLocation(oTarget);
DelayCommand(2.0, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "andarielport", lTarget));
effect eEffect;
eEffect = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
DelayCommand(2.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eEffect, lTarget));

SetPartyInt(oPC, "andariel", 1);

}
