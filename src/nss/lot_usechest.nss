void main() {
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) return;
    string monsterIdTag = GetLocalString(OBJECT_SELF, "monsterIdTag");
    //SendMessageToPC(oPC, "2 monsterIdTag = '" + monsterIdTag + "'");
    if (GetLocalInt(oPC, monsterIdTag) != 0)
        return;

    SetLocalInt(oPC, monsterIdTag, 1);

    int any = FALSE;
    int i;
    for (i = 0; i < 5; i++) {
        string loot1 = GetLocalString(OBJECT_SELF, "loot" + IntToString(i));
        if (loot1 != "") {
            any = TRUE;
            object obj = CreateItemOnObject(loot1, oPC);
            SetIdentified(obj, TRUE);
        }
    }

    if (any)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oPC);
}
