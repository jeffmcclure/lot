#include "inc_party"
#include "inc_jeff"
#include "nw_i0_generic"
#include "x0_i0_partywide"

void main()
{
  object leoric = GetObjectByTag("NPC_KING_LEORIC");
  SetObjectVisualTransform(leoric, OBJECT_VISUAL_TRANSFORM_SCALE, 2.1);
  object oPC = GetFirstPC();
  int points = 249 * GetNumberPartyMembers(oPC);
  SetCurrentHitPoints(leoric, points);
  MessageAll("Leoric hit points set to " + IntToString(points));
}
