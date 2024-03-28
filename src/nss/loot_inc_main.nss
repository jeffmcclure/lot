// Throw this switch for debugging

int LOOT_INC_MAIN_DEBUGGING = TRUE;


int GetPartyMemberCount (object oPC, int iMinimumLevel)
{
int iPartyMemberCount = 0;
int iPartyMemberLevel;
object oPartyMember = GetFirstFactionMember (oPC);
while (GetIsObjectValid (oPartyMember))
    {
    if (GetIsPC (oPartyMember))
        {
        iPartyMemberCount ++;
        iPartyMemberLevel = GetLevelByPosition (1, oPartyMember) + GetLevelByPosition (2, oPartyMember) + GetLevelByPosition (3, oPartyMember);
        if (iPartyMemberLevel < iMinimumLevel) iPartyMemberCount --;
        }
    oPartyMember = GetNextFactionMember (oPC);
    }
if (iPartyMemberCount < 1) iPartyMemberCount = 1;

WriteTimestampedLogEntry ("iPartyMemberCount " + IntToString (iPartyMemberCount));

return iPartyMemberCount;
}

object GetRandomPartyMember (object oPC)
{
int iPartyMemberCount = GetPartyMemberCount (oPC, 0);
int iRandNum = (Random (iPartyMemberCount)+1);
if (iRandNum == 1) return oPC;
object oPartyMember = GetFirstFactionMember (oPC);
int iCounter;
for (iCounter = 1; iCounter < iRandNum; iCounter ++)
    {
    if (!GetIsPC(oPartyMember)) iCounter --;
    oPartyMember = GetNextFactionMember (oPC);
    }
return oPartyMember;
}

int GetIsOverMaxAllowedLevel (object oPC , object oCaller)
{
    int iHighestPartyMemberLevel = 0;
    object oPartyMember = GetFirstFactionMember(oPC);
    while (GetIsObjectValid(oPartyMember))
        {
        int iPartyMemberLevel = GetLevelByPosition (1, oPartyMember) + GetLevelByPosition (2, oPartyMember) + GetLevelByPosition (3, oPartyMember);
        if (iPartyMemberLevel > iHighestPartyMemberLevel) iHighestPartyMemberLevel = iPartyMemberLevel;
        oPartyMember = GetNextFactionMember(oPC);
        }
    int iMaxAllowedLevel = GetMaxAllowedLevel (oCaller);
    if (iHighestPartyMemberLevel > iMaxAllowedLevel) return TRUE;
    return FALSE;
}

void GenerateUniqueTreasure (object oCaller,object oPC)
{
    int iMinimumLevel = GetMinimumLevel (oCaller);
    int iNumberOfItemsToGenerate = GetPartyMemberCount (oPC, iMinimumLevel);
    int iMinimum = GetMinimumNumberOfItemsToGenerate (oCaller);
    int iMaximum = GetMaximumNumberOfItemsToGenerate (oCaller);
    if (iNumberOfItemsToGenerate < iMinimum) iNumberOfItemsToGenerate = iMinimum;
    if (iNumberOfItemsToGenerate > iMaximum) iNumberOfItemsToGenerate = iMaximum;

    int iNumItemsInList = GetTotalAvailableItems (oCaller);

    int iRandomNumber;
    string sItemTemplate;
    int iCounter;

    for (iCounter = 0; iCounter < iNumberOfItemsToGenerate; iCounter ++)
        {
        iRandomNumber = Random (iNumItemsInList)+1;
        sItemTemplate = GetUniqueItemFromList (oCaller, iRandomNumber);
        CreateItemOnObject (sItemTemplate,oCaller,1);
        if (LOOT_INC_MAIN_DEBUGGING == TRUE) WriteTimestampedLogEntry (GetTag (oCaller) + " generated " + sItemTemplate);
        }
}
