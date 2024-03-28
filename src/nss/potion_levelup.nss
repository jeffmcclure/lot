void main()
{
    object oPC = GetItemActivator();
    int nHD = GetHitDice(oPC) + 1;
    int nNewXP = ((( nHD * ( nHD - 1) ) / 2 ) * 1000) + 1;
    SetXP(oPC, nNewXP);

    object oItem;
    oItem = GetItemPossessedBy(oPC, "potion_levelup");

    if (GetIsObjectValid(oItem))
    DestroyObject(oItem);
}
