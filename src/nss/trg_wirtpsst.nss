void main()
{
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    if (GetIsObjectValid(oPC) && (GetDistanceToObject(oPC) < 5.0))
    {
        SpeakString("Psst! Over here!");
    }
}
