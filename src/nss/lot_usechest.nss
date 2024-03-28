// 2024-03-01 - Jeff McClure
// use with lot_generic_boss.nss
// allow each player to receive the loot once
// automatically puts loot in players inventory; loot does not appear in chest
void main() {
    SendMessageToPC(GetFirstPC(), "lot_usechest");

    //object oPC = GetLastUsedBy();
    //if (!GetIsPC(oPC)) return;
    //string monsterIdTag = GetLocalString(OBJECT_SELF, "monsterIdTag");
    //SendMessageToPC(oPC, "2 monsterIdTag = '" + monsterIdTag + "'");
    //if (GetLocalInt(oPC, monsterIdTag) != 0)
        //return;

    //SetLocalInt(oPC, monsterIdTag, 1);

    int any = FALSE;
    int i;
    for (i = 0; i < 5; i++) {
        string loot1 = GetLocalString(OBJECT_SELF, "loot" + IntToString(i));
        SendMessageToPC(GetFirstPC(), "loot1='" + loot1 + "'");
        if (loot1 != "") {
            any = TRUE;
            object obj = CreateItemOnObject(loot1, OBJECT_SELF);
            SetIdentified(obj, TRUE);
            SetLocalString(obj, "LIMIT_ACQUIRE", "not you");
        }
    }

    //if (any) ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oPC);
}
