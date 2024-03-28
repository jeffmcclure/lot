void main()
{

object oPC = GetPCSpeaker();

    int nHD = GetHitDice(oPC) + 1;
    int nNewXP = ((( nHD * ( nHD - 1) ) / 2 ) * 1000) + 1;
    SetXP(oPC, nNewXP);

}
