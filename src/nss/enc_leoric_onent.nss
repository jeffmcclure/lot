#include "inc_party"
#include "inc_jeff"
#include "nw_i0_generic"
#include "x0_i0_partywide"

void main() {
    MessageAll("enc_leoric_onent 1");
    object waypoint = GetWaypointByTag("WP_LEORIC_C");
    if (GetLocalInt(waypoint, "LEORIC_ONCE") > 0) return;
    object oPC = GetEnteringObject();
    MessageAll("enc_leoric_onent 2");
    SetLocalInt(waypoint, "LEORIC_ONCE", 1);

    location lTarget = GetLocation(waypoint);
    object leoric = CreateObject(OBJECT_TYPE_CREATURE, "kingleoric", lTarget);
    if(GetIsPC(oPC)) {
        MessageAll("enc_leoric_onent yes IsPC");
        SetIsTemporaryEnemy(oPC, leoric);
        AssignCommand(leoric, ActionAttack(oPC));
        AssignCommand(leoric, DetermineCombatRound(oPC));
    }

    SetObjectVisualTransform(leoric, OBJECT_VISUAL_TRANSFORM_SCALE, 2.1);
    int partyMembers = GetNumberPartyMembers(GetFirstPC());
    int points = 249 * partyMembers;
    SetCurrentHitPoints(leoric, points);
    MessageAll("Leoric hit points set to " + IntToString(points));
}
