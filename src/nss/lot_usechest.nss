void main() {
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) return;
    string monsterIdTag = GetLocalString(OBJECT_SELF, "monsterIdTag");
    //SendMessageToPC(oPC, "2 monsterIdTag = '" + monsterIdTag + "'");
    if (GetLocalInt(oPC, monsterIdTag) != 0)
        return;
    SetLocalInt(oPC, monsterIdTag, 1);

    object obj = CreateItemOnObject("nw_it_mneck013", oPC);
    SetIdentified(obj,TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oPC);
}