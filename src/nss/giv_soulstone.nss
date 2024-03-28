const string sRefItem ="soulstone";
void main()
{
    object oPC = GetPCSpeaker();
    object oAreaSpeaker = GetArea(oPC);
    // Get the first PC party member
    object oPartyMember = GetFirstFactionMember(oPC, TRUE);
    // We stop when there are no more valid PC's in the party.
    while(GetIsObjectValid(oPartyMember) == TRUE)
    {
        // check they are in the same area as the speaker
        if (GetArea(oPartyMember) == oAreaSpeaker)
        {
            // Give Item to oPartyMember
            CreateItemOnObject(sRefItem, oPartyMember);
        }
        // Get the next PC member of oPC's faction.
        // If we put anything but oPC into this, it may be a totally
        // unreliable loop!
        oPartyMember = GetNextFactionMember(oPC, TRUE);
    }
ExportAllCharacters();
}

