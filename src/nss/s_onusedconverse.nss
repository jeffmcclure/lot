void main() {
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) return;

    AssignCommand(OBJECT_SELF, ActionStartConversation(oPC, "", TRUE));
}
