//:://////////////////////////////////////////////
//::        Function - GetMaxAllowedLevel
//:://////////////////////////////////////////////
/*
                Function Description

Use this function to set the maximum level at which
ANY member of the party can be to generate treasure.
If ANY member of the party is higher than this, all
they will get is worn out boots.

For example, if the level cap on an area is 5, and
ANY member of a party consisting of 4,3,4,6 opens a
chest in the area, they will get boots.

Each are should have an entry in this table matching its tag.
If a match is not found the function will return 100 - but
this is not a good thing because that means anyone can
generate treasure in the area - so be careful!

IMPORTANT NOTE: You can override the area wide level
restrictions by adding an item specific statement.
This can be useful if you have a tough boss in an
otherwise weaker area. If you do assign an override,
insert the item tag into the second part of the function.

*/

int GetMaxAllowedLevel (object oCaller)
{
    int iMaxAllowedLevel = 100;
    string sTag = GetTag (oCaller);
    string sAreaTag = GetTag(GetArea(oCaller));

    // Get The Area's Default Max Level
    if (sAreaTag == "TamaraCoast") iMaxAllowedLevel = 10;
    if (sAreaTag == "Bugbear1") iMaxAllowedLevel = 5;

    // Set the Max Level by the object's tag instead
    if (sTag == "SAMPLE_OVERRIDE_CHEST") iMaxAllowedLevel = 15;
    if (sTag == "SAMPLE_BOSS") iMaxAllowedLevel = 15;

    return iMaxAllowedLevel;
}


//:://////////////////////////////////////////////
//::        Function - GetMinimumLevel
//:://////////////////////////////////////////////
/*
                Function Description

Use this function to set the minimum level at which
a party member could reasonably contribute enough
to generate treasure. For example, if the party has
just tackled a CR 15 monster, chances are the level 1
guy tagging along didn't do anything to help, so he
doesn't deserve to have treasure generated for him.

Each item that generates a unique treasure should
have an entry in this table. If a match is not found
the function will return 0 - but this is not a good
thing because that means a bunch of level 1s can tag
along and generate tons of treasure.

*/

int GetMinimumLevel (object oCaller)
{
    int iMinimumLevel = 0;
    string sTag = GetTag (oCaller);

    if (sTag == "NPC_ANDARIEL") iMinimumLevel = 13;
    if (sTag == "NPC_LAZARUS") iMinimumLevel = 15;
    if (sTag == "NPC_WARLORDBLOOD") iMinimumLevel = 15;
    if (sTag == "NPC_IZUALFALLEN") iMinimumLevel = 15;
    if (sTag == "NPC_DIABLO") iMinimumLevel = 17;

    return iMinimumLevel;
}


//:://////////////////////////////////////////////
//::        Function - GetRespawnTime
//:://////////////////////////////////////////////
/*
                Function Description

This sets the respawn time for chests. It is area wide,
although you can override the respawn time on a given
chest by adding an entry based on the items tag. in the
second part of the function.

Default is an hour.

*/


float GetRespawnTime (object oCaller)
{

    float fRespawnTime = 3600.00;
    string sTag = GetTag (oCaller);
    string sAreaTag = GetTag(GetArea(oCaller));

    // Add your area wide respawn times here.

    if (sAreaTag == "TRISTRAM") fRespawnTime = 900.00;

    // Set the respawn time by the object's tag instead.

    if (sTag == "CHEST_BONE1") fRespawnTime = 7200.00;
    if (sTag == "CHEST_BONE2") fRespawnTime = 7200.00;
    if (sTag == "CHEST_BLIND") fRespawnTime = 7200.00;
    if (sTag == "CHEST_EPIC") fRespawnTime = 7200.00;
    if (sTag == "RACK_WEAPON1") fRespawnTime = 7200.00;
    if (sTag == "RACK_ARMOR1") fRespawnTime = 7200.00;
    if (sTag == "GRISWOLD_FORGE") fRespawnTime = 7200.00;

    return fRespawnTime;
}

//:://////////////////////////////////////////////
//:: Function - GetMinimumNumberOfItemsToGenerate
//:://////////////////////////////////////////////
/*
                Function Description

This sets the minimum number of items that a specific
boss loot will generate. In the if statement, include
a statement referencing the tag of the item containing
the loot.

Default is one item.

*/

int GetMinimumNumberOfItemsToGenerate (object oCaller)
{
    int iMinimumNumberOfItemsToGenerate = 1;
    string sTag = GetTag(oCaller);

    if (sTag == "CHEST_BONE1") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "CHEST_BONE2") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "CHEST_BLIND") iMinimumNumberOfItemsToGenerate = 1;
    if (sTag == "CHEST_EPIC") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "RACK_ARMOR1") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "RACK_WEAPON1") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "GRISWOLD_FORGE") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "UNIQUE_LOW") iMinimumNumberOfItemsToGenerate = 1;
    if (sTag == "UNIQUE_MID") iMinimumNumberOfItemsToGenerate = 1;
    if (sTag == "UNIQUE_HI") iMinimumNumberOfItemsToGenerate = 1;
    if (sTag == "UNIQUE_EPIC") iMinimumNumberOfItemsToGenerate = 1;
    if (sTag == "UNIQUE_ELITE") iMinimumNumberOfItemsToGenerate = 1;
    if (sTag == "NPC_FLESHDOOM") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "NPC_DIABLO") iMinimumNumberOfItemsToGenerate = 3;

    return iMinimumNumberOfItemsToGenerate;
}


//:://////////////////////////////////////////////
//:: Function - GetMaximumNumberOfItemsToGenerate
//:://////////////////////////////////////////////
/*
                Function Description

This sets the maximum number of items that a specific
boss loot will generate. In the if statement, include
a statement referencing the tag of the item containing
the loot.

Default is four items.

*/

int GetMaximumNumberOfItemsToGenerate (object oCaller)
{
    int iMaximumNumberOfItemsToGenerate = 1;
    string sTag = GetTag(oCaller);

    if (sTag == "CHEST_BONE1") iMaximumNumberOfItemsToGenerate = 3;
    if (sTag == "CHEST_BONE2") iMaximumNumberOfItemsToGenerate = 3;
    if (sTag == "CHEST_BLIND") iMaximumNumberOfItemsToGenerate = 1;
    if (sTag == "CHEST_EPIC") iMaximumNumberOfItemsToGenerate = 2;
    if (sTag == "RACK_WEAPON1") iMaximumNumberOfItemsToGenerate = 2;
    if (sTag == "RACK_ARMOR1") iMaximumNumberOfItemsToGenerate = 2;
    if (sTag == "GRISWOLD_FORGE") iMaximumNumberOfItemsToGenerate = 4;
    if (sTag == "UNIQUE_LOW") iMaximumNumberOfItemsToGenerate = 1;
    if (sTag == "UNIQUE_MID") iMaximumNumberOfItemsToGenerate = 1;
    if (sTag == "UNIQUE_HI") iMaximumNumberOfItemsToGenerate = 1;
    if (sTag == "UNIQUE_EPIC") iMaximumNumberOfItemsToGenerate = 1;
    if (sTag == "UNIQUE_ELITE") iMaximumNumberOfItemsToGenerate = 1;
    if (sTag == "NPC_FLESHDOOM") iMaximumNumberOfItemsToGenerate = 3;
    if (sTag == "NPC_DIABLO") iMaximumNumberOfItemsToGenerate = 5;

    return iMaximumNumberOfItemsToGenerate;
}




//:://////////////////////////////////////////////
//::        Function - GetTotalAvailableItems
//:://////////////////////////////////////////////
/*
                Function Description

This function returns simply returns the number of items
available on a boss's treasure table. Default is 1.

*/

int GetTotalAvailableItems (object oCaller)
{
    string sTag = GetTag (oCaller);
    int iNumItems = 1;

    if (sTag == "CHEST_BONE1") iNumItems = 121;
    if (sTag == "CHEST_BONE2") iNumItems = 91;
    if (sTag == "CHEST_BLIND") iNumItems = 55;
    if (sTag == "CHEST_EPIC") iNumItems = 334;
    if (sTag == "RACK_ARMOR1") iNumItems = 79;
    if (sTag == "RACK_WEAPON1") iNumItems = 208;
    if (sTag == "GRISWOLD_FORGE") iNumItems = 121;
    if (sTag == "UNIQUE_LOW") iNumItems = 124;
    if (sTag == "UNIQUE_MID") iNumItems = 211;
    if (sTag == "UNIQUE_HI") iNumItems = 334;
    if (sTag == "UNIQUE_EPIC") iNumItems = 133;
    if (sTag == "UNIQUE_ELITE") iNumItems = 142;
    if (sTag == "NPC_FLESHDOOM") iNumItems = 133;
    if (sTag == "NPC_LAZARUS") iNumItems = 133;
    if (sTag == "NPC_DIABLO") iNumItems = 112;

    return iNumItems;
}

//:://////////////////////////////////////////////
//::        Function - GetUniqueItemFromList
//:://////////////////////////////////////////////
/*
                Function Description

This function returns the template of an item to be
generated on the list. The number of items in the switch
statment must match the number of items you specified in
GetTotalAvailableItems or it could misfire.


*** MAKE SURE YOU USE THE BLUEPRINT RESREF NOT THE TAG ***

*/

string GetUniqueItemFromList (object oCaller,int iNumber)
{
    string sTag = GetTag (oCaller);
    if (sTag == "CHEST_BONE1")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "thegnasher"; break;
        case 4: case 5: case 6: return "deathspade"; break;
        case 7: case 8: case 9: return "grimreaper"; break;
        case 10: case 11: case 12: return "gleamsong"; break;
        case 13: case 14: case 15: return "gull"; break;
        case 16: case 17: case 18: return "spectralshard"; break;
        case 19: case 20: case 21: return "rixotskeen"; break;
        case 22: case 23: case 24: return "thedefender"; break;
        case 25: case 26: case 27: return "theneedler"; break;
        case 28: case 29: case 30: return "pluckeye"; break;
        case 31: case 32: case 33: return "witherstring"; break;
        case 34: case 35: case 36: return "spectralshard"; break;
        case 37: case 38: case 39: return "deathspade"; break;
        case 40: case 41: case 42: return "bladebone"; break;
        case 43: case 44: case 45: return "axeoffelchmar"; break;
        case 46: case 47: case 48: return "felloak"; break;
        case 49: case 50: case 51: return "stoutnail"; break;
        case 52: case 53: case 54: return "steelgoad"; break;
        case 55: case 56: case 57: return "woestave"; break;
        case 58: case 59: case 60: return "baneash"; break;
        case 61: case 62: case 63: return "serpentlord"; break;
        case 64: case 65: case 66: return "mindcry"; break;
        case 67: case 68: case 69: return "theprotector"; break;
        case 70: case 71: case 72: return "diggler"; break;
        case 73: case 74: case 75: return "jadetando"; break;
        case 76: case 77: case 78: return "kinemilsawl"; break;
        case 79: case 80: case 81: return "soulflay"; break;
        case 82: case 83: case 84: return "gryphonsclaw"; break;
        case 85: case 86: case 87: return "bloodcrescent"; break;
        case 88: case 89: case 90: return "skewerofkrinitz"; break;
        case 91: case 92: case 93: return "gleamscythe"; break;
        case 94: case 95: case 96: return "leadcrow"; break;
        case 97: case 98: case 99: return "ravenclaw"; break;
        case 100: case 101: case 102: return "blitzen"; break;
        case 103: case 104: case 105: return "celestialbow"; break;
        case 106: case 107: case 108: return "flambeau"; break;
        case 109: case 110: case 111: return "bowofthedead"; break;
        case 112: case 113: case 114: return "theblackoakbow"; break;
        case 115: case 116: case 117: return "theriftbow"; break;
        case 118: case 119: case 120: return "witchwildstring"; break;
        case 121: return "shadowhawk"; break;
            }
         }
    if (sTag == "CHEST_BONE2")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "greyform"; break;
        case 4: case 5: case 6: return "armorofgloom"; break;
        case 7: case 8: case 9: return "bonechainarmor"; break;
        case 10: case 11: case 12: return "venomward"; break;
        case 13: case 14: case 15: return "iceblink"; break;
        case 16: case 17: case 18: return "skulldersire"; break;
        case 19: case 20: case 21: return "armorofgloom"; break;
        case 22: case 23: case 24: return "blinkbatform"; break;
        case 25: case 26: case 27: return "gladiatorsbane"; break;
        case 28: case 29: case 30: return "leatherofaut"; break;
        case 31: case 32: case 33: return "twitchthroe"; break;
        case 34: case 35: case 36: return "darkglow"; break;
        case 37: case 38: case 39: return "scavcarapace"; break;
        case 40: case 41: case 42: return "hawkmail"; break;
        case 43: case 44: case 45: return "sparkingmail"; break;
        case 46: case 47: case 48: return "bonechainarmor"; break;
        case 49: case 50: case 51: return "skulldersire"; break;
        case 52: case 53: case 54: return "goldskin"; break;
        case 55: case 56: case 57: return "tornfleshofsouls"; break;
        case 58: case 59: case 60: return "skinofvipermagi"; break;
        case 61: case 62: case 63: return "spiritshroud"; break;
        case 64: case 65: case 66: return "twitchthroe"; break;
        case 67: case 68: case 69: return "centurion"; break;
        case 70: case 71: case 72: return "heavenlygarb"; break;
        case 73: case 74: case 75: return "crowcaw"; break;
        case 76: case 77: case 78: return "boneflesh"; break;
        case 79: case 80: case 81: return "emeraldplateabs"; break;
        case 82: case 83: case 84: return "rockfleece"; break;
        case 85: case 86: case 87: return "toothrow"; break;
        case 88: case 89: case 90: return "silksofthevictor"; break;
        case 91: return "demonspikecoat"; break;
            }
         }
    if (sTag == "CHEST_BLIND")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "constrictingring"; break;
        case 4: case 5: case 6: return "ringofglaciers"; break;
        case 7: case 8: case 9: return "ringofthunder"; break;
        case 10: case 11: case 12: return "ringofmagma"; break;
        case 13: case 14: case 15: return "giantsknuckle"; break;
        case 16: case 17: case 18: return "ringoftheorient"; break;
        case 19: case 20: case 21: return "acolytesamulet"; break;
        case 22: case 23: case 24: return "amuletofwarding"; break;
        case 25: case 26: case 27: return "kariksring"; break;
        case 28: case 29: case 30: return "korlicsring"; break;
        case 31: case 32: case 33: return "mercurialring"; break;
        case 34: case 35: case 36: return "ringofmystics"; break;
        case 37: case 38: case 39: return "xorinesring"; break;
        case 40: case 41: case 42: return "carrionwind"; break;
        case 43: case 44: case 45: return "dwarfstar"; break;
        case 46: case 47: case 48: return "aegisring"; break;
        case 49: case 50: case 51: return "bramble"; break;
        case 52: case 53: case 54: return "ringofregha"; break;
        case 55: return "ringoftheorient"; break;
            }
         }
    if (sTag == "RACK_ARMOR1")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "nightscape"; break;
        case 4: case 5: case 6: return "ormusrobes"; break;
        case 7: case 8: case 9: return "rainbowcloak"; break;
        case 10: case 11: case 12: return "wisdomswrap"; break;
        case 13: case 14: case 15: return "skinofflayedone"; break;
        case 16: case 17: case 18: return "najslightplate"; break;
        case 19: case 20: case 21: return "ironpelt"; break;
        case 22: case 23: case 24: return "queheganswisdom"; break;
        case 25: case 26: case 27: return "spiritforge"; break;
        case 28: case 29: case 30: return "demonplatearmor"; break;
        case 31: case 32: case 33: return "rattlecage"; break;
        case 34: case 35: case 36: return "atmaswail"; break;
        case 37: case 38: case 39: return "blackhades"; break;
        case 40: case 41: case 42: return "corpsemourn"; break;
        case 43: case 44: case 45: return "demonspikecoat"; break;
        case 46: case 47: case 48: return "guardianangel"; break;
        case 49: case 50: case 51: return "leviathan"; break;
        case 52: case 53: case 54: return "steelcarapace"; break;
        //unique helms
        case 55: case 56: case 57: return "kirasguardian"; break;
        case 58: case 59: case 60: return "peasantcrown"; break;
        case 61: case 62: case 63: return "steelshade"; break;
        case 64: case 65: case 66: return "andarielsvisage"; break;
        case 67: case 68: case 69: return "darksighthelm"; break;
        case 70: case 71: case 72: return "demonhornsedge"; break;
        case 73: case 74: case 75: return "gotterdamerung"; break;
        case 76: case 77: case 78: return "crownofages"; break;
        case 100: return "shaftstop"; break;
            }
         }
    if (sTag == "RACK_WEAPON1")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "guardiannaga"; break;
        case 4: case 5: case 6: return "islestrike"; break;
        case 7: case 8: case 9: return "wickedaxe"; break;
        case 10: case 11: case 12: return "pompeiiswrathx"; break;
        case 13: case 14: case 15: return "runemaster"; break;
        case 16: case 17: case 18: return "spellsteel"; break;
        case 19: case 20: case 21: return "warlordstrust"; break;
        case 22: case 23: case 24: return "humongous"; break;
        case 25: case 26: case 27: return "boneslayerblade"; break;
        case 28: case 29: case 30: return "theminotaur"; break;
        case 31: case 32: case 33: return "darkclancrusher"; break;
        case 34: case 35: case 36: return "fleshrender"; break;
        case 37: case 38: case 39: return "thecelestialstar"; break;
        case 40: case 41: case 42: return "baezilsvortex"; break;
        case 43: case 44: case 45: return "bonesnapx"; break;
        case 46: case 47: case 48: return "steeldriverx"; break;
        case 49: case 50: case 51: return "bloodtreestumpx"; break;
        case 52: case 53: case 54: return "craniumbasherx"; break;
        case 55: case 56: case 57: return "gavelofpain"; break;
        case 58: case 59: case 60: return "thunderclap"; break;
        case 61: case 62: case 63: return "hammerofjholm"; break;
        case 64: case 65: case 66: return "civerbcudgelx"; break;
        case 67: case 68: case 69: return "dreamflange"; break;
        case 70: case 71: case 72: return "sureshillfrost"; break;
        case 73: case 74: case 75: return "moonfall"; break;
        case 76: case 77: case 78: return "shadowkiller"; break;
        case 79: case 80: case 81: return "pierretombale"; break;
        case 82: case 83: case 84: return "staffofshadows"; break;
        case 85: case 86: case 87: return "lycandersflank"; break;
        case 88: case 89: case 90: return "stoneraven"; break;
        case 91: case 92: case 93: return "thundercall"; break;
        case 94: case 95: case 96: return "chromaticire"; break;
        case 97: case 98: case 99: return "ribcracker"; break;
        case 100: case 101: case 102: return "warspear"; break;
        case 103: case 104: case 105: return "diamondedge"; break;
        case 106: case 107: case 108: return "cloudcrack"; break;
        case 109: case 110: case 111: return "doombringer"; break;
        case 112: case 113: case 114: return "eaterofsouls"; break;
        case 115: case 116: case 117: return "doombringer"; break;
        case 118: case 119: case 120: return "stormspike"; break;
        case 121: case 122: case 123: return "blackbogssharp"; break;
        case 124: case 125: case 126: return "spineripper"; break;
        case 127: case 128: case 129: return "fleshripper"; break;
        case 130: case 131: case 132: return "bingszwang"; break;
        case 133: case 134: case 135: return "executionerblade"; break;
        case 136: case 137: case 138: return "craintevomir"; break;
        case 139: case 140: case 141: return "thegrizzly"; break;
        case 142: case 143: case 144: return "todesfaelleflamm"; break;
        case 145: case 146: case 147: return "swordguard"; break;
        case 148: case 149: case 150: return "headstriker"; break;
        case 151: case 152: case 153: return "plaguebearer"; break;
        case 154: case 155: case 156: return "bloodletter"; break;
        case 157: case 158: case 159: return "hexfire"; break;
        case 160: case 161: case 162: return "shirotachi"; break;
        case 163: case 164: case 165: return "hellcast"; break;
        case 166: case 167: case 168: return "langerbriser"; break;
        case 169: case 170: case 171: return "pusspitter"; break;
        case 172: case 173: case 174: return "gutsiphon"; break;
        case 175: case 176: case 177: return "endlesshail"; break;
        case 178: case 179: case 180: return "kukoshakaku"; break;
        case 181: case 182: case 183: return "wizendraw"; break;
        case 184: case 185: case 186: return "cliffkiller"; break;
        case 187: case 188: case 189: return "stormstrike"; break;
        case 190: case 191: case 192: return "magewrath"; break;
        case 193: case 194: case 195: return "riphook"; break;
        case 196: case 197: case 198: return "skystrike"; break;
        case 199: case 200: case 201: return "draculsgrasp"; break;
        case 202: case 203: case 204: return "souldrainer"; break;
        case 205: case 206: case 207: return "steelrend"; break;
        case 208: return "theatlantean"; break;
            }
         }
    if (sTag == "UNIQUE_LOW")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "greyform"; break;
        case 4: case 5: case 6: return "armorofgloom"; break;
        case 7: case 8: case 9: return "bonechainarmor"; break;
        case 10: case 11: case 12: return "venomward"; break;
        case 13: case 14: case 15: return "iceblink"; break;
        case 16: case 17: case 18: return "skulldersire"; break;
        //unique helms
        case 19: case 20: case 21: return "bigginsbonnet"; break;
        case 22: case 23: case 24: return "coifofglory"; break;
        case 25: case 26: case 27: return "howltusk"; break;
        case 28: case 29: case 30: return "duskdeep"; break;
        //unique shields
        case 31: case 32: case 33: return "thedeflector"; break;
        case 34: case 35: case 36: return "peltalunata"; break;
        case 37: case 38: case 39: return "dragonsbreach"; break;
        case 40: case 41: case 42: return "splitskullshield"; break;
        case 43: case 44: case 45: return "stormguild"; break;
        //unique weapons
        case 46: case 47: case 48: return "thegnasher"; break;
        case 49: case 50: case 51: return "deathspade"; break;
        case 52: case 53: case 54: return "grimreaper"; break;
        case 55: case 56: case 57: return "gleamsong"; break;
        case 58: case 59: case 60: return "gull"; break;
        case 61: case 62: case 63: return "spectralshard"; break;
        case 64: case 65: case 66: return "rixotskeen"; break;
        case 67: case 68: case 69: return "thedefender"; break;
        case 70: case 71: case 72: return "theneedler"; break;
        case 73: case 74: case 75: return "pluckeye"; break;
        case 76: case 77: case 78: return "witherstring"; break;
        //unique clothing
        case 79: case 80: case 81: return "lenymo"; break;
        case 82: case 83: case 84: return "snakecord"; break;
        case 85: case 86: case 87: return "gloomstrap"; break;
        case 88: case 89: case 90: return "nightsmoke"; break;
        case 91: case 92: case 93: return "razortail"; break;
        case 94: case 95: case 96: return "hotspur"; break;
        case 97: case 98: case 99: return "gorefoot"; break;
        case 100: case 101: case 102: return "thehandofbroc"; break;
        case 103: case 104: case 105: return "ghoulhide"; break;
        case 106: case 107: case 108: return "gravepalm"; break;
        //unique jewelry
        case 109: case 110: case 111: return "constrictingring"; break;
        case 112: case 113: case 114: return "ringofglaciers"; break;
        case 115: case 116: case 117: return "ringofthunder"; break;
        case 118: case 119: case 120: return "ringofmagma"; break;
        case 121: case 122: case 123: return "giantsknuckle"; break;
        case 124: return "ringoftheorient"; break;
            }
         }
    if (sTag == "UNIQUE_MID")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "armorofgloom"; break;
        case 4: case 5: case 6: return "blinkbatform"; break;
        case 7: case 8: case 9: return "gladiatorsbane"; break;
        case 10: case 11: case 12: return "leatherofaut"; break;
        case 13: case 14: case 15: return "twitchthroe"; break;
        case 16: case 17: case 18: return "darkglow"; break;
        case 19: case 20: case 21: return "scavcarapace"; break;
        case 22: case 23: case 24: return "hawkmail"; break;
        case 25: case 26: case 27: return "sparkingmail"; break;
        case 28: case 29: case 30: return "bonechainarmor"; break;
        case 31: case 32: case 33: return "skulldersire"; break;
        //unique helms
        case 34: case 35: case 36: return "faceofhorror"; break;
        case 37: case 38: case 39: return "helmofspirits"; break;
        case 40: case 41: case 42: return "wormskull"; break;
        case 43: case 44: case 45: return "duskdeep"; break;
        //unique shields
        case 46: case 47: case 48: return "umbraldisk"; break;
        case 49: case 50: case 51: return "steelclash"; break;
        case 52: case 53: case 54: return "swordbackhold"; break;
        case 55: case 56: case 57: return "bverritkeep"; break;
        //unique weapons
        case 58: case 59: case 60: return "spectralshard"; break;
        case 61: case 62: case 63: return "deathspade"; break;
        case 64: case 65: case 66: return "bladebone"; break;
        case 67: case 68: case 69: return "axeoffelchmar"; break;
        case 70: case 71: case 72: return "felloak"; break;
        case 73: case 74: case 75: return "stoutnail"; break;
        case 76: case 77: case 78: return "steelgoad"; break;
        case 79: case 80: case 81: return "woestave"; break;
        case 82: case 83: case 84: return "baneash"; break;
        case 85: case 86: case 87: return "serpentlord"; break;
        case 88: case 89: case 90: return "mindcry"; break;
        case 91: case 92: case 93: return "theprotector"; break;
        case 94: case 95: case 96: return "diggler"; break;
        case 97: case 98: case 99: return "jadetando"; break;
        case 100: case 101: case 102: return "kinemilsawl"; break;
        case 103: case 104: case 105: return "soulflay"; break;
        case 106: case 107: case 108: return "gryphonsclaw"; break;
        case 109: case 110: case 111: return "bloodcrescent"; break;
        case 112: case 113: case 114: return "skewerofkrinitz"; break;
        case 115: case 116: case 117: return "gleamscythe"; break;
        case 118: case 119: case 120: return "leadcrow"; break;
        case 121: case 122: case 123: return "ravenclaw"; break;
        case 124: case 125: case 126: return "blitzen"; break;
        case 127: case 128: case 129: return "celestialbow"; break;
        case 130: case 131: case 132: return "flambeau"; break;
        case 133: case 134: case 135: return "bowofthedead"; break;
        case 136: case 137: case 138: return "theblackoakbow"; break;
        case 139: case 140: case 141: return "theriftbow"; break;
        case 142: case 143: case 144: return "witchwildstring"; break;
        //unique clothing
        case 145: case 146: case 147: return "snowclash"; break;
        case 148: case 149: case 150: return "treadsofcthon"; break;
        case 151: case 152: case 153: return "tearhaunch"; break;
        case 154: case 155: case 156: return "ghoulhide"; break;
        case 157: case 158: case 159: return "gravepalm"; break;
        case 160: case 161: case 162: return "venomgrip"; break;
        //unique jewelry
        case 163: case 164: case 165: return "acolytesamulet"; break;
        case 166: case 167: case 168: return "amuletofwarding"; break;
        case 169: case 170: case 171: return "giantsknuckle"; break;
        case 172: case 173: case 174: return "kariksring"; break;
        case 175: case 176: case 177: return "korlicsring"; break;
        case 178: case 179: case 180: return "mercurialring"; break;
        case 181: case 182: case 183: return "ringofmystics"; break;
        case 184: case 185: case 186: return "xorinesring"; break;
        case 187: case 188: case 189: return "carrionwind"; break;
        case 190: case 191: case 192: return "dwarfstar"; break;
        case 193: case 194: case 195: return "aegisring"; break;
        case 196: case 197: case 198: return "bramble"; break;
        case 199: case 200: case 201: return "ringoftheorient"; break;
        case 202: case 203: case 204: return "ringofregha"; break;
        //miscellaneous
        case 205: case 206: case 207: return "ancientspledge"; break;
        case 208: case 209: case 210: return "dwarfstar"; break;
        case 211: return "saracenschance"; break;
            }
         }
    if (sTag == "UNIQUE_HI")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "goldskin"; break;
        case 4: case 5: case 6: return "tornfleshofsouls"; break;
        case 7: case 8: case 9: return "skinofvipermagi"; break;
        case 10: case 11: case 12: return "spiritshroud"; break;
        case 13: case 14: case 15: return "twitchthroe"; break;
        case 16: case 17: case 18: return "centurion"; break;
        case 19: case 20: case 21: return "heavenlygarb"; break;
        case 22: case 23: case 24: return "crowcaw"; break;
        case 25: case 26: case 27: return "boneflesh"; break;
        case 28: case 29: case 30: return "emeraldplateabs"; break;
        case 31: case 32: case 33: return "rockfleece"; break;
        case 34: case 35: case 36: return "toothrow"; break;
        case 37: case 38: case 39: return "silksofthevictor"; break;
        //unique helms
        case 40: case 41: case 42: return "foolscrest"; break;
        case 43: case 44: case 45: return "nightwingsveil"; break;
        case 46: case 47: case 48: return "stealskull"; break;
        case 49: case 50: case 51: return "blackthornsface"; break;
        case 52: case 53: case 54: return "rockstopper"; break;
        case 55: case 56: case 57: return "griffonseye"; break;
        case 58: case 59: case 60: return "vampiregaze"; break;
        //unique shields
        case 61: case 62: case 63: return "visceratuant"; break;
        case 64: case 65: case 66: return "mosersblessed"; break;
        case 67: case 68: case 69: return "lidlesswall"; break;
        case 70: case 71: case 72: return "bverritkeep"; break;
        case 73: case 74: case 75: return "holydefender"; break;
        case 76: case 77: case 78: return "theward"; break;
        //unique weapons
        case 79: case 80: case 81: return "bloodslayer"; break;
        case 82: case 83: case 84: return "goreshovel"; break;
        case 85: case 86: case 87: return "skullsplitterx"; break;
        case 88: case 89: case 90: return "stonecleaver"; break;
        case 91: case 92: case 93: return "rakescar"; break;
        case 94: case 95: case 96: return "thechieftain"; break;
        case 97: case 98: case 99: return "sharpbeak"; break;
        case 100: case 101: case 102: return "themangler"; break;
        case 103: case 104: case 105: return "brainhew"; break;
        case 106: case 107: case 108: return "thecelestialaxe"; break;
        case 109: case 110: case 111: return "gnarledroot"; break;
        case 112: case 113: case 114: return "tandoliga"; break;
        case 115: case 116: case 117: return "ironstone"; break;
        case 118: case 119: case 120: return "crushflange"; break;
        case 121: case 122: case 123: return "crackrust"; break;
        case 124: case 125: case 126: return "bloodrise"; break;
        case 127: case 128: case 129: return "blackleachblade"; break;
        case 130: case 131: case 132: return "dimoakshew"; break;
        case 133: case 134: case 135: return "soulharvest"; break;
        case 136: case 137: case 138: return "battlebranch"; break;
        case 139: case 140: case 141: return "meatscraper"; break;
        case 142: case 143: case 144: return "athenaswrath"; break;
        case 145: case 146: case 147: return "theprotector"; break;
        case 148: case 149: case 150: return "immolator"; break;
        case 151: case 152: case 153: return "najspuzzler"; break;
        case 154: case 155: case 156: return "salamander"; break;
        case 157: case 158: case 159: return "ironjangbong"; break;
        case 160: case 161: case 162: return "razorswitch"; break;
        case 163: case 164: case 165: return "rodofonan"; break;
        case 166: case 167: case 168: return "blacktongue"; break;
        case 169: case 170: case 171: return "blackrazor"; break;
        case 172: case 173: case 174: return "gonnagalsdirk"; break;
        case 175: case 176: case 177: return "heartcarver"; break;
        case 178: case 179: case 180: return "kinemilsawl"; break;
        case 181: case 182: case 183: return "ripsaw"; break;
        case 184: case 185: case 186: return "thepatriarch"; break;
        case 187: case 188: case 189: return "gibbousmoon"; break;
        case 190: case 191: case 192: return "hellplague"; break;
        case 193: case 194: case 195: return "culwenspoint"; break;
        case 196: case 197: case 198: return "ginthersrift"; break;
        case 199: case 200: case 201: return "iceshank"; break;
        case 202: case 203: case 204: return "swordofinferno"; break;
        case 205: case 206: case 207: return "shadowhawk"; break;
        case 208: case 209: case 210: return "thebonesaw"; break;
        case 211: case 212: case 213: return "thefalconstalon"; break;
        case 214: case 215: case 216: return "gleamscythe"; break;
        case 217: case 218: case 219: return "leadcrow"; break;
        case 220: case 221: case 222: return "ichorsting"; break;
        case 223: case 224: case 225: return "doomslinger"; break;
        case 226: case 227: case 228: return "blitzen"; break;
        case 229: case 230: case 231: return "celestialbow"; break;
        case 232: case 233: case 234: return "flambeau"; break;
        case 235: case 236: case 237: return "blastbark"; break;
        case 238: case 239: case 240: return "fleshstinger"; break;
        case 241: case 242: case 243: return "roguesbow"; break;
        case 244: case 245: case 246: return "flamedart"; break;
        case 247: case 248: case 249: return "fleshstinger"; break;
        case 250: case 251: case 252: return "witchwildstring"; break;
        case 253: case 254: case 255: return "hellclap"; break;
        //unique clothing
        case 256: case 257: case 258: return "stringofears"; break;
        case 259: case 260: case 261: return "bladebuckle"; break;
        case 262: case 263: case 264: return "venomgrip"; break;
        case 265: case 266: case 267: return "magefist"; break;
        case 268: case 269: case 270: return "bloodfist"; break;
        case 271: case 272: case 273: return "frostburn"; break;
        case 274: case 275: case 276: return "lavagout"; break;
        //unique jewelry
        case 277: case 278: case 279: return "atmasscarab"; break;
        case 280: case 281: case 282: return "crescentmoon"; break;
        case 283: case 284: case 285: return "nokozanrelic"; break;
        case 286: case 287: case 288: return "saracenschance"; break;
        case 289: case 290: case 291: return "seraphshymn"; break;
        case 292: case 293: case 294: return "catseye"; break;
        case 295: case 296: case 297: return "highlordswrath"; break;
        case 298: case 299: case 300: return "eyeofelitch"; break;
        case 301: case 302: case 303: return "ringofregha"; break;
        case 304: case 305: case 306: return "gladiatorsring"; break;
        case 307: case 308: case 309: return "ravenfrost"; break;
        case 310: case 311: case 312: return "ringofengagement"; break;
        case 313: case 314: case 315: return "wispprojector"; break;
        case 316: case 317: case 318: return "thebleeder"; break;
        case 319: case 320: case 321: return "naturespeace"; break;
        case 322: case 323: case 324: return "bulkathoswedding"; break;
        //miscellaneous
        case 325: case 326: case 327: return "doombringer"; break;
        case 328: case 329: case 330: return "eaterofsouls"; break;
        case 331: case 332: case 333: return "executionerblade"; break;
        case 334: return "crownofages"; break;
            }
         }
    if (sTag == "UNIQUE_EPIC")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "najslightplate"; break;
        case 4: case 5: case 6: return "spiritforge"; break;
        case 7: case 8: case 9: return "shaftstop"; break;
        case 10: case 11: case 12: return "leviathan"; break;
        case 13: case 14: case 15: return "steelcarapace"; break;
        case 16: case 17: case 18: return "demonplatearmor"; break;
        //unique helms
        case 19: case 20: case 21: return "crownofages"; break;
        case 22: case 23: case 24: return "royalcirclet"; break;
        case 25: case 26: case 27: return "thinkingcap"; break;
        //unique shields
        case 28: case 29: case 30: return "blackoakshield"; break;
        case 31: case 32: case 33: return "tiamatsrebuke"; break;
        case 34: case 35: case 36: return "headhuntersglory"; break;
        case 37: case 38: case 39: return "medusasgaze"; break;
        case 40: case 41: case 42: return "spiritward"; break;
        case 43: case 44: case 45: return "dragonscale"; break;
        case 46: case 47: case 48: return "heraldofzakarum"; break;
        case 49: case 50: case 51: return "gerkessanctuary"; break;
        //unique weapons
        case 52: case 53: case 54: return "warlordstrust"; break;
        case 55: case 56: case 57: return "stormrider"; break;
        case 58: case 59: case 60: return "deathcleaver"; break;
        case 61: case 62: case 63: return "etherealedge"; break;
        case 64: case 65: case 66: return "handblessedlite"; break;
        case 67: case 68: case 69: return "horizonstornado"; break;
        case 70: case 71: case 72: return "hammerofjholm"; break;
        case 73: case 74: case 75: return "bartucscutthroat"; break;
        case 76: case 77: case 78: return "jadetalon"; break;
        case 79: case 80: case 81: return "bonehew"; break;
        case 82: case 83: case 84: return "husoldalevo"; break;
        case 85: case 86: case 87: return "warspear"; break;
        case 88: case 89: case 90: return "ondalswisdom"; break;
        case 91: case 92: case 93: return "kingswordblood"; break;
        case 94: case 95: case 96: return "theatlantean"; break;
        case 97: case 98: case 99: return "tiamatsrebuke"; break;
        case 100: case 101: case 102: return "swordguard"; break;
        case 103: case 104: case 105: return "vilehusk"; break;
        case 106: case 107: case 108: return "bloodmoon"; break;
        case 109: case 110: case 111: return "gutsiphon"; break;
        case 112: case 113: case 114: return "burizadokyanon"; break;
        case 115: case 116: case 117: return "cliffkiller"; break;
        case 118: case 119: case 120: return "goldstrikearch"; break;
        case 121: case 122: case 123: return "widowmaker"; break;
        //unique clothing
        case 124: case 125: case 126: return "verdungoscord"; break;
        case 127: case 128: case 129: return "steelrend"; break;
        case 130: case 131: case 132: return "hellmouth"; break;
        //miscellaneous
        case 133: return "ringofelemental"; break;
            }
         }
    if (sTag == "UNIQUE_ELITE")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "godlypltwhale"; break;
        case 4: case 5: case 6: return "templarsmight"; break;
        case 7: case 8: case 9: return "tyraelsmight"; break;
        case 10: case 11: case 12: return "godlypltwhale"; break;
        //unique helms
        case 13: case 14: case 15: return "halaberdsreign"; break;
        //unique shields
        case 16: case 17: case 18: return "gerkessanctuary"; break;
        case 19: case 20: case 21: return "stormshield"; break;
        //unique weapons
        case 22: case 23: case 24: return "cranebreakx"; break;
        case 25: case 26: case 27: return "hellslayer"; break;
        case 28: case 29: case 30: return "executionersjust"; break;
        case 31: case 32: case 33: return "messereaver"; break;
        case 34: case 35: case 36: return "darkclancrusher"; break;
        case 37: case 38: case 39: return "astreonironwardx"; break;
        case 40: case 41: case 42: return "nordstenderizer"; break;
        case 43: case 44: case 45: return "horizonstornado"; break;
        case 46: case 47: case 48: return "stormlash"; break;
        case 49: case 50: case 51: return "windhammerx"; break;
        case 52: case 53: case 54: return "stonecrusher"; break;
        case 55: case 56: case 57: return "earthshifter"; break;
        case 58: case 59: case 60: return "schaefershammerx"; break;
        case 61: case 62: case 63: return "craniumbasherx"; break;
        case 64: case 65: case 66: return "baranarstar"; break;
        case 67: case 68: case 69: return "firelizardtalons"; break;
        case 70: case 71: case 72: return "husoldalevo"; break;
        case 73: case 74: case 75: return "grimsburningdead"; break;
        case 76: case 77: case 78: return "reaperstoll"; break;
        case 79: case 80: case 81: return "stormspire"; break;
        case 82: case 83: case 84: return "tombreaver"; break;
        case 85: case 86: case 87: return "archangelapoc"; break;
        case 88: case 89: case 90: return "mangsongslesson"; break;
        case 91: case 92: case 93: return "kingswordhaste"; break;
        case 94: case 95: case 96: return "ghostflame"; break;
        case 97: case 98: case 99: return "wizardspike"; break;
        case 100: case 101: case 102: return "ringofelemental"; break;
        case 103: case 104: case 105: return "flamebellow"; break;
        case 106: case 107: case 108: return "thegrandfather"; break;
        case 109: case 110: case 111: return "azurewrath"; break;
        case 112: case 113: case 114: return "frostwind"; break;
        case 115: case 116: case 117: return "djinnslayer"; break;
        case 118: case 119: case 120: return "lightsabre"; break;
        case 121: case 122: case 123: return "burizadokyanon"; break;
        case 124: case 125: case 126: return "demonmachine"; break;
        case 127: case 128: case 129: return "hellrack"; break;
        case 130: case 131: case 132: return "eaglehorn"; break;
        case 133: case 134: case 135: return "windforce"; break;
        //unique clothing
        case 136: case 137: case 138: return "hellmouth"; break;
        //unique jewelry
        case 139: case 140: case 141: return "ringofelemental"; break;
        case 142: return "obsidianringzod"; break;
            }
         }
    if (sTag == "NPC_FLESHDOOM")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "najslightplate"; break;
        case 4: case 5: case 6: return "spiritforge"; break;
        case 7: case 8: case 9: return "shaftstop"; break;
        case 10: case 11: case 12: return "leviathan"; break;
        case 13: case 14: case 15: return "steelcarapace"; break;
        case 16: case 17: case 18: return "demonplatearmor"; break;
        //unique helms
        case 19: case 20: case 21: return "crownofages"; break;
        case 22: case 23: case 24: return "royalcirclet"; break;
        case 25: case 26: case 27: return "thinkingcap"; break;
        //unique shields
        case 28: case 29: case 30: return "blackoakshield"; break;
        case 31: case 32: case 33: return "tiamatsrebuke"; break;
        case 34: case 35: case 36: return "headhuntersglory"; break;
        case 37: case 38: case 39: return "medusasgaze"; break;
        case 40: case 41: case 42: return "spiritward"; break;
        case 43: case 44: case 45: return "dragonscale"; break;
        case 46: case 47: case 48: return "heraldofzakarum"; break;
        case 49: case 50: case 51: return "gerkessanctuary"; break;
        //unique weapons
        case 52: case 53: case 54: return "warlordstrust"; break;
        case 55: case 56: case 57: return "stormrider"; break;
        case 58: case 59: case 60: return "deathcleaver"; break;
        case 61: case 62: case 63: return "etherealedge"; break;
        case 64: case 65: case 66: return "handblessedlite"; break;
        case 67: case 68: case 69: return "horizonstornado"; break;
        case 70: case 71: case 72: return "hammerofjholm"; break;
        case 73: case 74: case 75: return "bartucscutthroat"; break;
        case 76: case 77: case 78: return "jadetalon"; break;
        case 79: case 80: case 81: return "bonehew"; break;
        case 82: case 83: case 84: return "husoldalevo"; break;
        case 85: case 86: case 87: return "warspear"; break;
        case 88: case 89: case 90: return "ondalswisdom"; break;
        case 91: case 92: case 93: return "kingswordblood"; break;
        case 94: case 95: case 96: return "theatlantean"; break;
        case 97: case 98: case 99: return "tiamatsrebuke"; break;
        case 100: case 101: case 102: return "swordguard"; break;
        case 103: case 104: case 105: return "vilehusk"; break;
        case 106: case 107: case 108: return "bloodmoon"; break;
        case 109: case 110: case 111: return "gutsiphon"; break;
        case 112: case 113: case 114: return "burizadokyanon"; break;
        case 115: case 116: case 117: return "cliffkiller"; break;
        case 118: case 119: case 120: return "goldstrikearch"; break;
        case 121: case 122: case 123: return "widowmaker"; break;
        //unique clothing
        case 124: case 125: case 126: return "verdungoscord"; break;
        case 127: case 128: case 129: return "steelrend"; break;
        case 130: case 131: case 132: return "hellmouth"; break;
        //miscellaneous
        case 133: return "ringofelemental"; break;
            }
         }
    if (sTag == "NPC_LAZARUS")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "najslightplate"; break;
        case 4: case 5: case 6: return "spiritforge"; break;
        case 7: case 8: case 9: return "shaftstop"; break;
        case 10: case 11: case 12: return "leviathan"; break;
        case 13: case 14: case 15: return "steelcarapace"; break;
        case 16: case 17: case 18: return "demonplatearmor"; break;
        //unique helms
        case 19: case 20: case 21: return "crownofages"; break;
        case 22: case 23: case 24: return "royalcirclet"; break;
        case 25: case 26: case 27: return "thinkingcap"; break;
        //unique shields
        case 28: case 29: case 30: return "blackoakshield"; break;
        case 31: case 32: case 33: return "tiamatsrebuke"; break;
        case 34: case 35: case 36: return "headhuntersglory"; break;
        case 37: case 38: case 39: return "medusasgaze"; break;
        case 40: case 41: case 42: return "spiritward"; break;
        case 43: case 44: case 45: return "dragonscale"; break;
        case 46: case 47: case 48: return "heraldofzakarum"; break;
        case 49: case 50: case 51: return "gerkessanctuary"; break;
        //unique weapons
        case 52: case 53: case 54: return "warlordstrust"; break;
        case 55: case 56: case 57: return "stormrider"; break;
        case 58: case 59: case 60: return "deathcleaver"; break;
        case 61: case 62: case 63: return "etherealedge"; break;
        case 64: case 65: case 66: return "handblessedlite"; break;
        case 67: case 68: case 69: return "horizonstornado"; break;
        case 70: case 71: case 72: return "hammerofjholm"; break;
        case 73: case 74: case 75: return "bartucscutthroat"; break;
        case 76: case 77: case 78: return "jadetalon"; break;
        case 79: case 80: case 81: return "bonehew"; break;
        case 82: case 83: case 84: return "husoldalevo"; break;
        case 85: case 86: case 87: return "warspear"; break;
        case 88: case 89: case 90: return "ondalswisdom"; break;
        case 91: case 92: case 93: return "kingswordblood"; break;
        case 94: case 95: case 96: return "theatlantean"; break;
        case 97: case 98: case 99: return "spiritward"; break;
        case 100: case 101: case 102: return "swordguard"; break;
        case 103: case 104: case 105: return "vilehusk"; break;
        case 106: case 107: case 108: return "bloodmoon"; break;
        case 109: case 110: case 111: return "gutsiphon"; break;
        case 112: case 113: case 114: return "burizadokyanon"; break;
        case 115: case 116: case 117: return "cliffkiller"; break;
        case 118: case 119: case 120: return "goldstrikearch"; break;
        case 121: case 122: case 123: return "widowmaker"; break;
        //unique clothing
        case 124: case 125: case 126: return "verdungoscord"; break;
        case 127: case 128: case 129: return "steelrend"; break;
        case 130: case 131: case 132: return "hellmouth"; break;
        //miscellaneous
        case 133: return "ringofelemental"; break;
            }
         }
    if (sTag == "CHEST_EPIC")
        {
        switch (iNumber)
            {
        //unique armor
        case 1: case 2: case 3: return "goldskin"; break;
        case 4: case 5: case 6: return "tornfleshofsouls"; break;
        case 7: case 8: case 9: return "skinofvipermagi"; break;
        case 10: case 11: case 12: return "spiritshroud"; break;
        case 13: case 14: case 15: return "twitchthroe"; break;
        case 16: case 17: case 18: return "centurion"; break;
        case 19: case 20: case 21: return "heavenlygarb"; break;
        case 22: case 23: case 24: return "crowcaw"; break;
        case 25: case 26: case 27: return "boneflesh"; break;
        case 28: case 29: case 30: return "emeraldplateabs"; break;
        case 31: case 32: case 33: return "rockfleece"; break;
        case 34: case 35: case 36: return "toothrow"; break;
        case 37: case 38: case 39: return "silksofthevictor"; break;
        //unique helms
        case 40: case 41: case 42: return "foolscrest"; break;
        case 43: case 44: case 45: return "nightwingsveil"; break;
        case 46: case 47: case 48: return "stealskull"; break;
        case 49: case 50: case 51: return "blackthornsface"; break;
        case 52: case 53: case 54: return "rockstopper"; break;
        case 55: case 56: case 57: return "griffonseye"; break;
        case 58: case 59: case 60: return "vampiregaze"; break;
        //unique shields
        case 61: case 62: case 63: return "visceratuant"; break;
        case 64: case 65: case 66: return "mosersblessed"; break;
        case 67: case 68: case 69: return "lidlesswall"; break;
        case 70: case 71: case 72: return "bverritkeep"; break;
        case 73: case 74: case 75: return "holydefender"; break;
        case 76: case 77: case 78: return "theward"; break;
        //unique weapons
        case 79: case 80: case 81: return "bloodslayer"; break;
        case 82: case 83: case 84: return "goreshovel"; break;
        case 85: case 86: case 87: return "skullsplitterx"; break;
        case 88: case 89: case 90: return "stonecleaver"; break;
        case 91: case 92: case 93: return "rakescar"; break;
        case 94: case 95: case 96: return "thechieftain"; break;
        case 97: case 98: case 99: return "sharpbeak"; break;
        case 100: case 101: case 102: return "themangler"; break;
        case 103: case 104: case 105: return "brainhew"; break;
        case 106: case 107: case 108: return "thecelestialaxe"; break;
        case 109: case 110: case 111: return "gnarledroot"; break;
        case 112: case 113: case 114: return "tandoliga"; break;
        case 115: case 116: case 117: return "ironstone"; break;
        case 118: case 119: case 120: return "crushflange"; break;
        case 121: case 122: case 123: return "crackrust"; break;
        case 124: case 125: case 126: return "bloodrise"; break;
        case 127: case 128: case 129: return "blackleachblade"; break;
        case 130: case 131: case 132: return "dimoakshew"; break;
        case 133: case 134: case 135: return "soulharvest"; break;
        case 136: case 137: case 138: return "battlebranch"; break;
        case 139: case 140: case 141: return "meatscraper"; break;
        case 142: case 143: case 144: return "athenaswrath"; break;
        case 145: case 146: case 147: return "theprotector"; break;
        case 148: case 149: case 150: return "immolator"; break;
        case 151: case 152: case 153: return "najspuzzler"; break;
        case 154: case 155: case 156: return "salamander"; break;
        case 157: case 158: case 159: return "ironjangbong"; break;
        case 160: case 161: case 162: return "razorswitch"; break;
        case 163: case 164: case 165: return "rodofonan"; break;
        case 166: case 167: case 168: return "blacktongue"; break;
        case 169: case 170: case 171: return "blackrazor"; break;
        case 172: case 173: case 174: return "gonnagalsdirk"; break;
        case 175: case 176: case 177: return "heartcarver"; break;
        case 178: case 179: case 180: return "kinemilsawl"; break;
        case 181: case 182: case 183: return "ripsaw"; break;
        case 184: case 185: case 186: return "thepatriarch"; break;
        case 187: case 188: case 189: return "gibbousmoon"; break;
        case 190: case 191: case 192: return "hellplague"; break;
        case 193: case 194: case 195: return "culwenspoint"; break;
        case 196: case 197: case 198: return "ginthersrift"; break;
        case 199: case 200: case 201: return "iceshank"; break;
        case 202: case 203: case 204: return "swordofinferno"; break;
        case 205: case 206: case 207: return "shadowhawk"; break;
        case 208: case 209: case 210: return "thebonesaw"; break;
        case 211: case 212: case 213: return "thefalconstalon"; break;
        case 214: case 215: case 216: return "gleamscythe"; break;
        case 217: case 218: case 219: return "leadcrow"; break;
        case 220: case 221: case 222: return "ichorsting"; break;
        case 223: case 224: case 225: return "doomslinger"; break;
        case 226: case 227: case 228: return "blitzen"; break;
        case 229: case 230: case 231: return "celestialbow"; break;
        case 232: case 233: case 234: return "flambeau"; break;
        case 235: case 236: case 237: return "blastbark"; break;
        case 238: case 239: case 240: return "fleshstinger"; break;
        case 241: case 242: case 243: return "roguesbow"; break;
        case 244: case 245: case 246: return "flamedart"; break;
        case 247: case 248: case 249: return "fleshstinger"; break;
        case 250: case 251: case 252: return "witchwildstring"; break;
        case 253: case 254: case 255: return "hellclap"; break;
        //unique clothing
        case 256: case 257: case 258: return "stringofears"; break;
        case 259: case 260: case 261: return "bladebuckle"; break;
        case 262: case 263: case 264: return "venomgrip"; break;
        case 265: case 266: case 267: return "magefist"; break;
        case 268: case 269: case 270: return "bloodfist"; break;
        case 271: case 272: case 273: return "frostburn"; break;
        case 274: case 275: case 276: return "lavagout"; break;
        //unique jewelry
        case 277: case 278: case 279: return "atmasscarab"; break;
        case 280: case 281: case 282: return "crescentmoon"; break;
        case 283: case 284: case 285: return "nokozanrelic"; break;
        case 286: case 287: case 288: return "saracenschance"; break;
        case 289: case 290: case 291: return "seraphshymn"; break;
        case 292: case 293: case 294: return "catseye"; break;
        case 295: case 296: case 297: return "highlordswrath"; break;
        case 298: case 299: case 300: return "eyeofelitch"; break;
        case 301: case 302: case 303: return "ringofregha"; break;
        case 304: case 305: case 306: return "gladiatorsring"; break;
        case 307: case 308: case 309: return "ravenfrost"; break;
        case 310: case 311: case 312: return "ringofengagement"; break;
        case 313: case 314: case 315: return "wispprojector"; break;
        case 316: case 317: case 318: return "thebleeder"; break;
        case 319: case 320: case 321: return "naturespeace"; break;
        case 322: case 323: case 324: return "bulkathoswedding"; break;
        //miscellaneous
        case 325: case 326: case 327: return "doombringer"; break;
        case 328: case 329: case 330: return "eaterofsouls"; break;
        case 331: case 332: case 333: return "executionerblade"; break;
        case 334: return "crownofages"; break;
            }
         }
    if (sTag == "GRISWOLD_FORGE")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "thegnasher"; break;
        case 4: case 5: case 6: return "deathspade"; break;
        case 7: case 8: case 9: return "grimreaper"; break;
        case 10: case 11: case 12: return "bloodslayer"; break;
        case 13: case 14: case 15: return "gull"; break;
        case 16: case 17: case 18: return "spectralshard"; break;
        case 19: case 20: case 21: return "rixotskeen"; break;
        case 22: case 23: case 24: return "brainhew"; break;
        case 25: case 26: case 27: return "theneedler"; break;
        case 28: case 29: case 30: return "pluckeye"; break;
        case 31: case 32: case 33: return "witherstring"; break;
        case 34: case 35: case 36: return "spectralshard"; break;
        case 37: case 38: case 39: return "deathspade"; break;
        case 40: case 41: case 42: return "bladebone"; break;
        case 43: case 44: case 45: return "axeoffelchmar"; break;
        case 46: case 47: case 48: return "felloak"; break;
        case 49: case 50: case 51: return "stoutnail"; break;
        case 52: case 53: case 54: return "steelgoad"; break;
        case 55: case 56: case 57: return "crushflange"; break;
        case 58: case 59: case 60: return "shadowhawk"; break;
        case 61: case 62: case 63: return "thedefender"; break;
        case 64: case 65: case 66: return "gibbousmoon"; break;
        case 67: case 68: case 69: return "ripsaw"; break;
        case 70: case 71: case 72: return "diggler"; break;
        case 73: case 74: case 75: return "jadetando"; break;
        case 76: case 77: case 78: return "kinemilsawl"; break;
        case 79: case 80: case 81: return "soulflay"; break;
        case 82: case 83: case 84: return "gryphonsclaw"; break;
        case 85: case 86: case 87: return "bloodcrescent"; break;
        case 88: case 89: case 90: return "skewerofkrinitz"; break;
        case 91: case 92: case 93: return "gleamscythe"; break;
        case 94: case 95: case 96: return "leadcrow"; break;
        case 97: case 98: case 99: return "ravenclaw"; break;
        case 100: case 101: case 102: return "blitzen"; break;
        case 103: case 104: case 105: return "celestialbow"; break;
        case 106: case 107: case 108: return "flambeau"; break;
        case 109: case 110: case 111: return "bowofthedead"; break;
        case 112: case 113: case 114: return "theblackoakbow"; break;
        case 115: case 116: case 117: return "theriftbow"; break;
        case 118: case 119: case 120: return "witchwildstring"; break;
        case 121: return "blackleachblade"; break;
            }
         }
    if (sTag == "NPC_DIABLO")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "shaftstop"; break;
        case 4: case 5: case 6: return "demonplatearmor"; break;
        case 7: case 8: case 9: return "templarsmight"; break;
        case 10: case 11: case 12: return "halaberdsreign"; break;
        case 13: case 14: case 15: return "dragonscale"; break;
        case 16: case 17: case 18: return "heraldofzakarum"; break;
        case 19: case 20: case 21: return "gerkessanctuary"; break;
        case 22: case 23: case 24: return "stormshield"; break;
        case 25: case 26: case 27: return "stormrider"; break;
        case 28: case 29: case 30: return "deathcleaver"; break;
        case 31: case 32: case 33: return "etherealedge"; break;
        case 34: case 35: case 36: return "cranebreakx"; break;
        case 37: case 38: case 39: return "executionersjust"; break;
        case 40: case 41: case 42: return "handblessedlite"; break;
        case 43: case 44: case 45: return "darkclancrusher"; break;
        case 46: case 47: case 48: return "horizonstornado"; break;
        case 49: case 50: case 51: return "windhammerx"; break;
        case 52: case 53: case 54: return "stonecrusher"; break;
        case 55: case 56: case 57: return "godlypltwhale"; break;
        case 58: case 59: case 60: return "bartucscutthroat"; break;
        case 61: case 62: case 63: return "jadetalon"; break;
        case 64: case 65: case 66: return "bloodmoon"; break;
        case 67: case 68: case 69: return "bonehew"; break;
        case 70: case 71: case 72: return "husoldalevo"; break;
        case 73: case 74: case 75: return "grimsburningdead"; break;
        case 76: case 77: case 78: return "reaperstoll"; break;
        case 79: case 80: case 81: return "theatlantean"; break;
        case 82: case 83: case 84: return "ondalswisdom"; break;
        case 85: case 86: case 87: return "archangelapoc"; break;
        case 88: case 89: case 90: return "ghostflame"; break;
        case 91: case 92: case 93: return "vilehusk"; break;
        case 94: case 95: case 96: return "frostwind"; break;
        case 97: case 98: case 99: return "burizadokyanon"; break;
        case 100: case 101: case 102: return "goldstrikearch"; break;
        case 103: case 104: case 105: return "widowmaker"; break;
        case 106: case 107: case 108: return "hellmouth"; break;
        case 109: case 110: case 111: return "kingswordblood"; break;
        case 112: return "kingswordhaste"; break;
            }
         }
    return "ERROR - NO TAG MATCH";
}
