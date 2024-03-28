#include "inc_party"
#include "inc_jeff"
#include "nw_i0_generic"
#include "x0_i0_partywide"

void main() {
    object waypoint = GetWaypointByTag("WP_LEORIC_C");
    if (GetLocalInt(waypoint, "LEORIC_ONCE") > 0) return;
    object oPC = GetEnteringObject();
    SetLocalInt(waypoint, "LEORIC_ONCE", 1);

    location lTarget = GetLocation(waypoint);
    int partyMembers = GetNumberPartyMembers(GetFirstPC());

    string resref = "kingleoric1";
    if (partyMembers > 1 && partyMembers <= 4) {
        resref = "kingleoric" + IntToString(partyMembers);
    }

    object leoric = CreateObject(OBJECT_TYPE_CREATURE, resref, lTarget);
    DelayCommand(0.1, PlaySound("leoric1a"));
    if(GetIsPC(oPC)) {
        // Sounds cannot be played direction from triggers - here is the workaround
        object oTarget = GetObjectByTag("RDM_CHEST2_JEFF");
        AssignCommand(oTarget, ActionStartConversation(oPC, "con_leoric"));

        SetIsTemporaryEnemy(oPC, leoric);
        AssignCommand(leoric, ActionAttack(oPC));
        AssignCommand(leoric, DetermineCombatRound(oPC));
    }

    SetObjectVisualTransform(leoric, OBJECT_VISUAL_TRANSFORM_SCALE, 2.1);
    //int points = 249 * partyMembers;
    //SetCurrentHitPoints(leoric, points);
}
