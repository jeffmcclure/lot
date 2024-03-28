void main() {

    object oPC = GetEnteringObject();
    if (!GetIsPC(oPC)) return;

    int DoOnce = GetLocalInt(oPC, GetTag(OBJECT_SELF)); // show intro per user
    if (DoOnce==TRUE) return;

    SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE); // show intro per user

    object oTarget = GetObjectByTag("BEGINNING");
    AssignCommand(oTarget, ActionStartConversation(oPC, ""));
}
