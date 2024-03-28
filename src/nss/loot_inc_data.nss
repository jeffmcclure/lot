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
    if (sTag == "ALTAR_HELLFORGE") fRespawnTime = 9000.00;

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
    if (sTag == "CHEST_BLIND") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "CHEST_EPIC") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "RACK_ARMOR1") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "RACK_WEAPON1") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "GRISWOLD_FORGE") iMinimumNumberOfItemsToGenerate = 2;
    if (sTag == "ALTAR_HELLFORGE") iMinimumNumberOfItemsToGenerate = 1;
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

    if (sTag == "CHEST_BONE1") iMaximumNumberOfItemsToGenerate = 4;
    if (sTag == "CHEST_BONE2") iMaximumNumberOfItemsToGenerate = 4;
    if (sTag == "CHEST_BLIND") iMaximumNumberOfItemsToGenerate = 3;
    if (sTag == "CHEST_EPIC") iMaximumNumberOfItemsToGenerate = 3;
    if (sTag == "RACK_WEAPON1") iMaximumNumberOfItemsToGenerate = 3;
    if (sTag == "RACK_ARMOR1") iMaximumNumberOfItemsToGenerate = 3;
    if (sTag == "GRISWOLD_FORGE") iMaximumNumberOfItemsToGenerate = 5;
    if (sTag == "ALTAR_HELLFORGE") iMaximumNumberOfItemsToGenerate = 3;
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

    if (sTag == "CHEST_BONE1") iNumItems = 334;
    if (sTag == "CHEST_BONE2") iNumItems = 220;
    if (sTag == "CHEST_BLIND") iNumItems = 118;
    if (sTag == "CHEST_EPIC") iNumItems = 331;
    if (sTag == "RACK_ARMOR1") iNumItems = 202;
    if (sTag == "RACK_WEAPON1") iNumItems = 385;
    if (sTag == "GRISWOLD_FORGE") iNumItems = 445;
    if (sTag == "ALTAR_HELLFORGE") iNumItems = 385;
    if (sTag == "UNIQUE_LOW") iNumItems = 316;
    if (sTag == "UNIQUE_MID") iNumItems = 484;
    if (sTag == "UNIQUE_HI") iNumItems = 469;
    if (sTag == "UNIQUE_EPIC") iNumItems = 358;
    if (sTag == "UNIQUE_ELITE") iNumItems = 277;
    if (sTag == "NPC_FLESHDOOM") iNumItems = 425;
    if (sTag == "NPC_LAZARUS") iNumItems = 331;
    if (sTag == "NPC_DIABLO") iNumItems = 250;

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
        case 4: case 5: case 6: return "thedefender"; break;
        case 7: case 8: case 9: return "spectralshard"; break;
        case 10: case 11: case 12: return "nwnholyavenger"; break;
        case 13: case 14: case 15: return "baneash"; break;
        case 16: case 17: case 18: return "theblackoakbow"; break;
        case 19: case 20: case 21: return "waxmgr022"; break;
        case 22: case 23: case 24: return "bladebone"; break;
        case 25: case 26: case 27: return "diggler"; break;
        case 28: case 29: case 30: return "soulflay"; break;
        case 31: case 32: case 33: return "bloodcrescent"; break;
        case 34: case 35: case 36: return "rixotskeen"; break;
        case 37: case 38: case 39: return "zep_xblma_002"; break;
        case 40: case 41: case 42: return "staffofapocalyps"; break;
        case 43: case 44: case 45: return "wplmhb017"; break;
        case 46: case 47: case 48: return "woestave"; break;
        case 49: case 50: case 51: return "axeoffelchmar"; break;
        case 52: case 53: case 54: return "deathspade"; break;
        case 55: case 56: case 57: return "wswmss017"; break;
        case 58: case 59: case 60: return "zep_xdbsc_004"; break;
        case 61: case 62: case 63: return "desertsfury"; break;
        case 64: case 65: case 66: return "mindcry"; break;
        case 67: case 68: case 69: return "serpentlord"; break;
        case 70: case 71: case 72: return "ravenclaw"; break;
        case 73: case 74: case 75: return "theriftbow"; break;
        case 76: case 77: case 78: return "kinemilsawl"; break;
        case 79: case 80: case 81: return "gleamscythe"; break;
        case 82: case 83: case 84: return "felloak"; break;
        case 85: case 86: case 87: return "wplmhb016"; break;
        case 88: case 89: case 90: return "leadcrow"; break;
        case 91: case 92: case 93: return "blitzen"; break;
        case 94: case 95: case 96: return "celestialbow"; break;
        case 97: case 98: case 99: return "flambeau"; break;
        case 100: case 101: case 102: return "witchwildstring"; break;
        case 103: case 104: case 105: return "bloodslayer"; break;
        case 106: case 107: case 108: return "goreshovel"; break;
        case 109: case 110: case 111: return "stonecleaver"; break;
        case 112: case 113: case 114: return "blacktongue"; break;
        case 115: case 116: case 117: return "skewerofkrinitz"; break;
        case 118: case 119: case 120: return "gryphonsclaw"; break;
        case 121: case 122: case 123: return "wswmss019"; break;
        case 124: case 125: case 126: return "zep_xblma_004"; break;
        case 127: case 128: case 129: return "immolator"; break;
        case 130: case 131: case 132: return "najspuzzler"; break;
        case 133: case 134: case 135: return "salamander"; break;
        case 136: case 137: case 138: return "dimoakshew"; break;
        case 139: case 140: case 141: return "soulharvest"; break;
        case 142: case 143: case 144: return "steelgoad"; break;
        case 145: case 146: case 147: return "ichorsting"; break;
        case 148: case 149: case 150: return "blastbark"; break;
        case 151: case 152: case 153: return "fleshstinger"; break;
        case 154: case 155: case 156: return "roguesbow"; break;
        case 157: case 158: case 159: return "bowofthedead"; break;
        case 160: case 161: case 162: return "rakescar"; break;
        case 163: case 164: case 165: return "thechieftain"; break;
        case 166: case 167: case 168: return "ripsaw"; break;
        case 169: case 170: case 171: return "gibbousmoon"; break;
        case 172: case 173: case 174: return "stoutnail"; break;
        case 175: case 176: case 177: return "tandoliga"; break;
        case 178: case 179: case 180: return "crushflange"; break;
        case 181: case 182: case 183: return "zep_xblmh_003"; break;
        case 184: case 185: case 186: return "zep_xdbsc_003"; break;
        case 187: case 188: case 189: return "meatscraper"; break;
        case 190: case 191: case 192: return "thecelestialaxe"; break;
        case 193: case 194: case 195: return "sharpbeak"; break;
        case 196: case 197: case 198: return "blackrazor"; break;
        case 199: case 200: case 201: return "heartcarver"; break;
        case 202: case 203: case 204: return "wblmfh016"; break;
        case 205: case 206: case 207: return "crackrust"; break;
        case 208: case 209: case 210: return "razorswitch"; break;
        case 211: case 212: case 213: return "skullsplitterx"; break;
        case 214: case 215: case 216: return "athenaswrath"; break;
        case 217: case 218: case 219: return "blackleachblade"; break;
        case 220: case 221: case 222: return "battlebranch"; break;
        case 223: case 224: case 225: return "flamedart"; break;
        case 226: case 227: case 228: return "hellclap"; break;
        case 229: case 230: case 231: return "brainhew"; break;
        case 232: case 233: case 234: return "gonnagalsdirk"; break;
        case 235: case 236: case 237: return "shadowhawk"; break;
        case 238: case 239: case 240: return "zep_unholysw"; break;
        case 241: case 242: case 243: return "thebonesaw"; break;
        case 244: case 245: case 246: return "gnarledroot"; break;
        case 247: case 248: case 249: return "bonesnapx"; break;
        case 250: case 251: case 252: return "ironstone"; break;
        case 253: case 254: case 255: return "nwnstormwalker"; break;
        case 256: case 257: case 258: return "rodofonan"; break;
        case 259: case 260: case 261: return "ironjangbong"; break;
        case 262: case 263: case 264: return "doomslinger"; break;
        case 265: case 266: case 267: return "gnatsting"; break;
        case 268: case 269: case 270: return "islestrike"; break;
        case 271: case 272: case 273: return "diamondedge"; break;
        case 274: case 275: case 276: return "stormspike"; break;
        case 277: case 278: case 279: return "thepatriarch"; break;
        case 280: case 281: case 282: return "culwenspoint"; break;
        case 283: case 284: case 285: return "hellplague"; break;
        case 286: case 287: case 288: return "coldsteeleye"; break;
        case 289: case 290: case 291: return "thefalconstalon"; break;
        case 292: case 293: case 294: return "thecelestialstar"; break;
        case 295: case 296: case 297: return "steeldriverx"; break;
        case 298: case 299: case 300: return "bloodrise"; break;
        case 301: case 302: case 303: return "hellishwhip"; break;
        case 304: case 305: case 306: return "thundercall"; break;
        case 307: case 308: case 309: return "nwnwithering"; break;
        case 310: case 311: case 312: return "thehandofbroc"; break;
        case 313: case 314: case 315: return "ghoulhide"; break;
        case 316: case 317: case 318: return "gravepalm"; break;
        case 319: case 320: case 321: return "magefist"; break;
        case 322: case 323: case 324: return "venomgrip"; break;
        case 325: case 326: case 327: return "frostburn"; break;
        case 328: case 329: case 330: return "bloodfist"; break;
        case 331: case 332: case 333: return "lavagout"; break;
        case 334: return "swordofinferno"; break;
            }
         }
    if (sTag == "CHEST_BONE2")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "venomward"; break;
        case 4: case 5: case 6: return "coifofglory"; break;
        case 7: case 8: case 9: return "howltusk"; break;
        case 10: case 11: case 12: return "greyform"; break;
        case 13: case 14: case 15: return "iceblink"; break;
        case 16: case 17: case 18: return "armorofgloom"; break;
        case 19: case 20: case 21: return "bonechainarmor"; break;
        case 22: case 23: case 24: return "stormguild"; break;
        case 25: case 26: case 27: return "gladiatorsbane"; break;
        case 28: case 29: case 30: return "duskdeep"; break;
        case 31: case 32: case 33: return "helmofspirits"; break;
        case 34: case 35: case 36: return "wormskull"; break;
        case 37: case 38: case 39: return "darkglow"; break;
        case 40: case 41: case 42: return "swordbackhold"; break;
        case 43: case 44: case 45: return "leatherofaut"; break;
        case 46: case 47: case 48: return "hawkmail"; break;
        case 49: case 50: case 51: return "steelclash"; break;
        case 52: case 53: case 54: return "umbraldisk"; break;
        case 55: case 56: case 57: return "zep_dirganswall"; break;
        case 58: case 59: case 60: return "blinkbatform"; break;
        case 61: case 62: case 63: return "arhe002"; break;
        case 64: case 65: case 66: return "twitchthroe"; break;
        case 67: case 68: case 69: return "scavcarapace"; break;
        case 70: case 71: case 72: return "sparkingmail"; break;
        case 73: case 74: case 75: return "ancientspledge"; break;
        case 76: case 77: case 78: return "bverritkeep"; break;
        case 79: case 80: case 81: return "boneflesh"; break;
        case 82: case 83: case 84: return "armhe020"; break;
        case 85: case 86: case 87: return "armhe021"; break;
        case 88: case 89: case 90: return "nightwingsveil"; break;
        case 91: case 92: case 93: return "stealskull"; break;
        case 94: case 95: case 96: return "faceofhorror"; break;
        case 97: case 98: case 99: return "maarcl137"; break;
        case 100: case 101: case 102: return "lidlesswall"; break;
        case 103: case 104: case 105: return "nadir"; break;
        case 106: case 107: case 108: return "blackthornsface"; break;
        case 109: case 110: case 111: return "centurion"; break;
        case 112: case 113: case 114: return "visceratuant"; break;
        case 115: case 116: case 117: return "rockfleece"; break;
        case 118: case 119: case 120: return "toothrow"; break;
        case 121: case 122: case 123: return "wealth"; break;
        case 124: case 125: case 126: return "armhe023"; break;
        case 127: case 128: case 129: return "rockstopper"; break;
        case 130: case 131: case 132: return "armhe028"; break;
        case 133: case 134: case 135: return "skinofvipermagi"; break;
        case 136: case 137: case 138: return "spiritshroud"; break;
        case 139: case 140: case 141: return "silksofthevictor"; break;
        case 142: case 143: case 144: return "foolscrest"; break;
        case 145: case 146: case 147: return "griffonseye"; break;
        case 148: case 149: case 150: return "crowcaw"; break;
        case 151: case 152: case 153: return "heavenlygarb"; break;
        case 154: case 155: case 156: return "mosersblessed"; break;
        case 157: case 158: case 159: return "theward"; break;
        case 160: case 161: case 162: return "rattlecage"; break;
        case 163: case 164: case 165: return "valkyriewing"; break;
        case 166: case 167: case 168: return "vampiregaze"; break;
        case 169: case 170: case 171: return "ironpelt"; break;
        case 172: case 173: case 174: return "lanceguard"; break;
        case 175: case 176: case 177: return "rhyme"; break;
        case 178: case 179: case 180: return "holydefender"; break;
        case 181: case 182: case 183: return "gloomstrap"; break;
        case 184: case 185: case 186: return "nightsmoke"; break;
        case 187: case 188: case 189: return "razortail"; break;
        case 190: case 191: case 192: return "snowclash"; break;
        case 193: case 194: case 195: return "bladebuckle"; break;
        case 196: case 197: case 198: return "stringofears"; break;
        case 199: case 200: case 201: return "gorefoot"; break;
        case 202: case 203: case 204: return "tearhaunch"; break;
        case 205: case 206: case 207: return "treadsofcthon"; break;
        case 208: case 209: case 210: return "infernostride"; break;
        case 211: case 212: case 213: return "sandstormtrek"; break;
        case 214: case 215: case 216: return "cloakofaccelerat"; break;
        case 217: case 218: case 219: return "cloakarcanexpert"; break;
        case 220: return "demonspikecoat"; break;
            }
         }
    if (sTag == "CHEST_BLIND")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "it_mring035"; break;
        case 4: case 5: case 6: return "it_mring037"; break;
        case 7: case 8: case 9: return "it_mring038"; break;
        case 10: case 11: case 12: return "commandersring"; break;
        case 13: case 14: case 15: return "giantsknuckle"; break;
        case 16: case 17: case 18: return "zep_necro_ring"; break;
        case 19: case 20: case 21: return "kariksring"; break;
        case 22: case 23: case 24: return "korlicsring"; break;
        case 25: case 26: case 27: return "mercurialring"; break;
        case 28: case 29: case 30: return "ringofmystics"; break;
        case 31: case 32: case 33: return "it_mring036"; break;
        case 34: case 35: case 36: return "xorinesring"; break;
        case 37: case 38: case 39: return "aegisring"; break;
        case 40: case 41: case 42: return "carrionwind"; break;
        case 43: case 44: case 45: return "dwarfstar"; break;
        case 46: case 47: case 48: return "bramble"; break;
        case 49: case 50: case 51: return "constrictingring"; break;
        case 52: case 53: case 54: return "ringoftheorient"; break;
        case 55: case 56: case 57: return "ringofregha"; break;
        case 58: case 59: case 60: return "gladiatorsring"; break;
        case 61: case 62: case 63: return "ironskinring"; break;
        case 64: case 65: case 66: return "ravenfrost"; break;
        case 67: case 68: case 69: return "ringofengagement"; break;
        case 70: case 71: case 72: return "it_mring034"; break;
        case 73: case 74: case 75: return "wispprojector"; break;
        case 76: case 77: case 78: return "naturespeace"; break;
        case 79: case 80: case 81: return "bulkathoswedding"; break;
        case 82: case 83: case 84: return "thebleeder"; break;
        case 85: case 86: case 87: return "acolytesamulet"; break;
        case 88: case 89: case 90: return "amuletofwarding"; break;
        case 91: case 92: case 93: return "atmasscarab"; break;
        case 94: case 95: case 96: return "crescentmoon"; break;
        case 97: case 98: case 99: return "nokozanrelic"; break;
        case 100: case 101: case 102: return "divineradiance"; break;
        case 103: case 104: case 105: return "saracenschance"; break;
        case 106: case 107: case 108: return "seraphshymn"; break;
        case 109: case 110: case 111: return "catseye"; break;
        case 112: case 113: case 114: return "highlordswrath"; break;
        case 115: case 116: case 117: return "mahimoakcurio"; break;
        case 118: return "manaldheal"; break;
            }
         }
    if (sTag == "RACK_ARMOR1")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "nightscape"; break;
        case 4: case 5: case 6: return "atmaswail"; break;
        case 7: case 8: case 9: return "demonspikecoat"; break;
        case 10: case 11: case 12: return "emeraldplateabs"; break;
        case 13: case 14: case 15: return "maarcl156"; break;
        case 16: case 17: case 18: return "maarcl157"; break;
        case 19: case 20: case 21: return "kirasguardian"; break;
        case 22: case 23: case 24: return "overlordshelm"; break;
        case 25: case 26: case 27: return "peasantcrown"; break;
        case 28: case 29: case 30: return "radiance"; break;
        case 31: case 32: case 33: return "steelshade"; break;
        case 34: case 35: case 36: return "nwnbindingsblood"; break;
        case 37: case 38: case 39: return "maarcl123"; break;
        case 40: case 41: case 42: return "maarcl122"; break;
        case 43: case 44: case 45: return "skinofflayedone"; break;
        case 46: case 47: case 48: return "queheganswisdom"; break;
        case 49: case 50: case 51: return "maarcl136"; break;
        case 52: case 53: case 54: return "maarcl138"; break;
        case 55: case 56: case 57: return "almanegra"; break;
        case 58: case 59: case 60: return "ashmlw014"; break;
        case 61: case 62: case 63: return "ashmlw017"; break;
        case 64: case 65: case 66: return "spikethorn"; break;
        case 67: case 68: case 69: return "stormchaser"; break;
        case 70: case 71: case 72: return "goldskin"; break;
        case 73: case 74: case 75: return "cloth027"; break;
        case 76: case 77: case 78: return "smoke"; break;
        case 79: case 80: case 81: return "tornfleshofsouls"; break;
        case 82: case 83: case 84: return "wisdomswrap"; break;
        case 85: case 86: case 87: return "blackhades"; break;
        case 88: case 89: case 90: return "maarcl153"; break;
        case 91: case 92: case 93: return "corpsemourn"; break;
        case 94: case 95: case 96: return "guardianangel"; break;
        case 97: case 98: case 99: return "maarcl158"; break;
        case 100: case 101: case 102: return "andarielsvisage"; break;
        case 103: case 104: case 105: return "crownofthieves"; break;
        case 106: case 107: case 108: return "darksighthelm"; break;
        case 109: case 110: case 111: return "demonhornsedge"; break;
        case 112: case 113: case 114: return "gotterdamerung"; break;
        case 115: case 116: case 117: return "wolfhowl"; break;
        case 118: case 119: case 120: return "stealth"; break;
        case 121: case 122: case 123: return "spiritforge"; break;
        case 124: case 125: case 126: return "headhuntersglory"; break;
        case 127: case 128: case 129: return "radamantssphere"; break;
        case 130: case 131: case 132: return "freedom"; break;
        case 133: case 134: case 135: return "ormusrobes"; break;
        case 136: case 137: case 138: return "demonplatearmor"; break;
        case 139: case 140: case 141: return "leviathan"; break;
        case 142: case 143: case 144: return "crownofages"; break;
        case 145: case 146: case 147: return "delirium"; break;
        case 148: case 149: case 150: return "royalcirclet"; break;
        case 151: case 152: case 153: return "thinkingcap"; break;
        case 154: case 155: case 156: return "prudence"; break;
        case 157: case 158: case 159: return "blackoakshield"; break;
        case 160: case 161: case 162: return "dragonscale"; break;
        case 163: case 164: case 165: return "exile"; break;
        case 166: case 167: case 168: return "medusasgaze"; break;
        case 169: case 170: case 171: return "spiritward"; break;
        case 172: case 173: case 174: return "arachnidmesh"; break;
        case 175: case 176: case 177: return "nosferatuscoil"; break;
        case 178: case 179: case 180: return "thundergodsvigor"; break;
        case 181: case 182: case 183: return "verdungoscord"; break;
        case 184: case 185: case 186: return "gorerider"; break;
        case 187: case 188: case 189: return "wartraveler"; break;
        case 190: case 191: case 192: return "waterwalk"; break;
        case 193: case 194: case 195: return "marrowwalk"; break;
        case 196: case 197: case 198: return "shadowdancer"; break;
        case 199: case 200: case 201: return "silkweave"; break;
        case 202: return "shaftstop"; break;
            }
         }
    if (sTag == "RACK_WEAPON1")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "waxmgr017"; break;
        case 4: case 5: case 6: return "humongous"; break;
        case 7: case 8: case 9: return "waxmgr021"; break;
        case 10: case 11: case 12: return "butcherspupil"; break;
        case 13: case 14: case 15: return "coldkill"; break;
        case 16: case 17: case 18: return "guardiannaga"; break;
        case 19: case 20: case 21: return "themangler"; break;
        case 22: case 23: case 24: return "wickedaxe"; break;
        case 25: case 26: case 27: return "wswmbs006"; break;
        case 28: case 29: case 30: return "blackbogssharp"; break;
        case 31: case 32: case 33: return "spineripper"; break;
        case 34: case 35: case 36: return "ginthersrift"; break;
        case 37: case 38: case 39: return "iceshank"; break;
        case 40: case 41: case 42: return "swordofinferno"; break;
        case 43: case 44: case 45: return "katanamummylord"; break;
        case 46: case 47: case 48: return "nwnradiantdeath"; break;
        case 49: case 50: case 51: return "darkclancrusher"; break;
        case 52: case 53: case 54: return "craniumbasherx"; break;
        case 55: case 56: case 57: return "staffofshadows"; break;
        case 58: case 59: case 60: return "deathcoil"; break;
        case 61: case 62: case 63: return "shockwhip"; break;
        case 64: case 65: case 66: return "chromaticire"; break;
        case 67: case 68: case 69: return "zep_gnarledstaff"; break;
        case 70: case 71: case 72: return "ribcracker"; break;
        case 73: case 74: case 75: return "theprotectorx"; break;
        case 76: case 77: case 78: return "pierretombale"; break;
        case 79: case 80: case 81: return "hellcast"; break;
        case 82: case 83: case 84: return "langerbriser"; break;
        case 85: case 86: case 87: return "pusspitter"; break;
        case 88: case 89: case 90: return "endlesshail"; break;
        case 91: case 92: case 93: return "kukoshakaku"; break;
        case 94: case 95: case 96: return "wizendraw"; break;
        case 97: case 98: case 99: return "wbwmsh015"; break;
        case 100: case 101: case 102: return "stormstrike"; break;
        case 103: case 104: case 105: return "boneslayerblade"; break;
        case 106: case 107: case 108: return "theminotaur"; break;
        case 109: case 110: case 111: return "aginarashatchet"; break;
        case 112: case 113: case 114: return "dwarvenwaraxe008"; break;
        case 115: case 116: case 117: return "runemaster"; break;
        case 118: case 119: case 120: return "spellsteel"; break;
        case 121: case 122: case 123: return "stormrider"; break;
        case 124: case 125: case 126: return "cloudcrack"; break;
        case 127: case 128: case 129: return "doombringer"; break;
        case 130: case 131: case 132: return "eaterofsouls"; break;
        case 133: case 134: case 135: return "wswmdg014"; break;
        case 136: case 137: case 138: return "fleshripper"; break;
        case 139: case 140: case 141: return "bingszwang"; break;
        case 142: case 143: case 144: return "craintevomir"; break;
        case 145: case 146: case 147: return "executionerblade"; break;
        case 148: case 149: case 150: return "thegrizzly"; break;
        case 151: case 152: case 153: return "todesfaelleflamm"; break;
        case 154: case 155: case 156: return "headstriker"; break;
        case 157: case 158: case 159: return "plaguebearer"; break;
        case 160: case 161: case 162: return "hexfire"; break;
        case 163: case 164: case 165: return "wswmka010"; break;
        case 166: case 167: case 168: return "bloodletter"; break;
        case 169: case 170: case 171: return "wswmss018"; break;
        case 172: case 173: case 174: return "fleshrender"; break;
        case 175: case 176: case 177: return "baezilsvortex"; break;
        case 178: case 179: case 180: return "bloodtreestumpx"; break;
        case 181: case 182: case 183: return "earthshaker"; break;
        case 184: case 185: case 186: return "gavelofpain"; break;
        case 187: case 188: case 189: return "hammerofjholm"; break;
        case 190: case 191: case 192: return "thunderclap"; break;
        case 193: case 194: case 195: return "windhammerx"; break;
        case 196: case 197: case 198: return "sureshillfrost"; break;
        case 199: case 200: case 201: return "moonfall"; break;
        case 202: case 203: case 204: return "wdbmqs014"; break;
        case 205: case 206: case 207: return "nwnthornshield"; break;
        case 208: case 209: case 210: return "epicshockwhip"; break;
        case 211: case 212: case 213: return "shadowkiller"; break;
        case 214: case 215: case 216: return "leaf"; break;
        case 217: case 218: case 219: return "eschutastemperx"; break;
        case 220: case 221: case 222: return "theoculusx"; break;
        case 223: case 224: case 225: return "pompeiiswrathx"; break;
        case 226: case 227: case 228: return "grimsburningdead"; break;
        case 229: case 230: case 231: return "stoneraven"; break;
        case 232: case 233: case 234: return "reaperstoll"; break;
        case 235: case 236: case 237: return "magewrath"; break;
        case 238: case 239: case 240: return "riphook"; break;
        case 241: case 242: case 243: return "skystrike"; break;
        case 244: case 245: case 246: return "wbwmsl015"; break;
        case 247: case 248: case 249: return "waxmgr011"; break;
        case 250: case 251: case 252: return "waxmhn010"; break;
        case 253: case 254: case 255: return "razorsedge"; break;
        case 256: case 257: case 258: return "axeofthedwarflor"; break;
        case 259: case 260: case 261: return "etherealedge"; break;
        case 262: case 263: case 264: return "waxmbt010"; break;
        case 265: case 266: case 267: return "warlordstrust"; break;
        case 268: case 269: case 270: return "wswmbs005"; break;
        case 271: case 272: case 273: return "wswmbs007"; break;
        case 274: case 275: case 276: return "wswmdg006"; break;
        case 277: case 278: case 279: return "wswmgs011"; break;
        case 280: case 281: case 282: return "wswmls012"; break;
        case 283: case 284: case 285: return "frostwind"; break;
        case 286: case 287: case 288: return "wswmsc010"; break;
        case 289: case 290: case 291: return "wswmrp010"; break;
        case 292: case 293: case 294: return "wswmss011"; break;
        case 295: case 296: case 297: return "demonlimb"; break;
        case 298: case 299: case 300: return "wblmcl010"; break;
        case 301: case 302: case 303: return "wblmfl010"; break;
        case 304: case 305: case 306: return "wblmfh010"; break;
        case 307: case 308: case 309: return "nwnfiendfoe"; break;
        case 310: case 311: case 312: return "wblmhw011"; break;
        case 313: case 314: case 315: return "wblmhl010"; break;
        case 316: case 317: case 318: return "civerbcudgelx"; break;
        case 319: case 320: case 321: return "wblmml011"; break;
        case 322: case 323: case 324: return "wblmms010"; break;
        case 325: case 326: case 327: return "wdbmqs004"; break;
        case 328: case 329: case 330: return "wdbmax010"; break;
        case 331: case 332: case 333: return "wdbmma010"; break;
        case 334: case 335: case 336: return "wdbmsw010"; break;
        case 337: case 338: case 339: return "wspmku006"; break;
        case 340: case 341: case 342: return "wspmsc010"; break;
        case 343: case 344: case 345: return "wspmka008"; break;
        case 346: case 347: case 348: return "warspear"; break;
        case 349: case 350: case 351: return "deathsfathomx"; break;
        case 352: case 353: case 354: return "wplmss018"; break;
        case 355: case 356: case 357: return "lycandersflank"; break;
        case 358: case 359: case 360: return "wplmhb010"; break;
        case 361: case 362: case 363: return "wplmsc010"; break;
        case 364: case 365: case 366: return "gutsiphon"; break;
        case 367: case 368: case 369: return "cliffkiller"; break;
        case 370: case 371: case 372: return "wbwmln008"; break;
        case 373: case 374: case 375: return "wbwmsh012"; break;
        case 376: case 377: case 378: return "draculsgrasp"; break;
        case 379: case 380: case 381: return "souldrainer"; break;
        case 382: case 383: case 384: return "steelrend"; break;
        case 385: return "theatlantean"; break;
            }
         }
    if (sTag == "UNIQUE_LOW")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "it_mglove002"; break;
        case 4: case 5: case 6: return "lenymo"; break;
        case 7: case 8: case 9: return "ventrueluckcharm"; break;
        case 10: case 11: case 12: return "theneedler"; break;
        case 13: case 14: case 15: return "bonering"; break;
        case 16: case 17: case 18: return "bigginsbonnet"; break;
        case 19: case 20: case 21: return "ringforceshield"; break;
        case 22: case 23: case 24: return "hotspur"; break;
        case 25: case 26: case 27: return "it_mring028"; break;
        case 28: case 29: case 30: return "gull"; break;
        case 31: case 32: case 33: return "grimreaper"; break;
        case 34: case 35: case 36: return "pluckeye"; break;
        case 37: case 38: case 39: return "witherstring"; break;
        case 40: case 41: case 42: return "snakecord"; break;
        case 43: case 44: case 45: return "purpledragonring"; break;
        case 46: case 47: case 48: return "dragonsbreach"; break;
        case 49: case 50: case 51: return "peltalunata"; break;
        case 52: case 53: case 54: return "gleamsong"; break;
        case 55: case 56: case 57: return "it_mglove011"; break;
        case 58: case 59: case 60: return "ringofglaciers"; break;
        case 61: case 62: case 63: return "ringimproveevade"; break;
        case 64: case 65: case 66: return "ringofthunder"; break;
        case 67: case 68: case 69: return "skulldersire"; break;
        case 70: case 71: case 72: return "ashmlw016"; break;
        case 73: case 74: case 75: return "splitskullshield"; break;
        case 76: case 77: case 78: return "thedeflector"; break;
        case 79: case 80: case 81: return "gorefoot"; break;
        case 82: case 83: case 84: return "cloakofaccelerat"; break;
        case 85: case 86: case 87: return "luckstone"; break;
        case 88: case 89: case 90: return "ringofmagma"; break;
        case 91: case 92: case 93: return "venomward"; break;
        case 94: case 95: case 96: return "coifofglory"; break;
        case 97: case 98: case 99: return "howltusk"; break;
        case 100: case 101: case 102: return "thegnasher"; break;
        case 103: case 104: case 105: return "thedefender"; break;
        case 106: case 107: case 108: return "gloomstrap"; break;
        case 109: case 110: case 111: return "nightsmoke"; break;
        case 112: case 113: case 114: return "razortail"; break;
        case 115: case 116: case 117: return "thehandofbroc"; break;
        case 118: case 119: case 120: return "it_mring035"; break;
        case 121: case 122: case 123: return "it_mring037"; break;
        case 124: case 125: case 126: return "it_mring038"; break;
        case 127: case 128: case 129: return "greyform"; break;
        case 130: case 131: case 132: return "iceblink"; break;
        case 133: case 134: case 135: return "armorofgloom"; break;
        case 136: case 137: case 138: return "bonechainarmor"; break;
        case 139: case 140: case 141: return "stormguild"; break;
        case 142: case 143: case 144: return "spectralshard"; break;
        case 145: case 146: case 147: return "nwnholyavenger"; break;
        case 148: case 149: case 150: return "commandersring"; break;
        case 151: case 152: case 153: return "giantsknuckle"; break;
        case 154: case 155: case 156: return "zep_necro_ring"; break;
        case 157: case 158: case 159: return "gladiatorsbane"; break;
        case 160: case 161: case 162: return "baneash"; break;
        case 163: case 164: case 165: return "theblackoakbow"; break;
        case 166: case 167: case 168: return "acolytesamulet"; break;
        case 169: case 170: case 171: return "kariksring"; break;
        case 172: case 173: case 174: return "korlicsring"; break;
        case 175: case 176: case 177: return "mercurialring"; break;
        case 178: case 179: case 180: return "ringofmystics"; break;
        case 181: case 182: case 183: return "it_mring036"; break;
        case 184: case 185: case 186: return "xorinesring"; break;
        case 187: case 188: case 189: return "duskdeep"; break;
        case 190: case 191: case 192: return "helmofspirits"; break;
        case 193: case 194: case 195: return "wormskull"; break;
        case 196: case 197: case 198: return "darkglow"; break;
        case 199: case 200: case 201: return "swordbackhold"; break;
        case 202: case 203: case 204: return "waxmgr022"; break;
        case 205: case 206: case 207: return "bladebone"; break;
        case 208: case 209: case 210: return "diggler"; break;
        case 211: case 212: case 213: return "soulflay"; break;
        case 214: case 215: case 216: return "bloodcrescent"; break;
        case 217: case 218: case 219: return "rixotskeen"; break;
        case 220: case 221: case 222: return "zep_xblma_002"; break;
        case 223: case 224: case 225: return "staffofapocalyps"; break;
        case 226: case 227: case 228: return "wplmhb017"; break;
        case 229: case 230: case 231: return "woestave"; break;
        case 232: case 233: case 234: return "snowclash"; break;
        case 235: case 236: case 237: return "ghoulhide"; break;
        case 238: case 239: case 240: return "amuletofwarding"; break;
        case 241: case 242: case 243: return "aegisring"; break;
        case 244: case 245: case 246: return "carrionwind"; break;
        case 247: case 248: case 249: return "dwarfstar"; break;
        case 250: case 251: case 252: return "leatherofaut"; break;
        case 253: case 254: case 255: return "hawkmail"; break;
        case 256: case 257: case 258: return "steelclash"; break;
        case 259: case 260: case 261: return "umbraldisk"; break;
        case 262: case 263: case 264: return "zep_dirganswall"; break;
        case 265: case 266: case 267: return "axeoffelchmar"; break;
        case 268: case 269: case 270: return "deathspade"; break;
        case 271: case 272: case 273: return "wswmss017"; break;
        case 274: case 275: case 276: return "zep_xdbsc_004"; break;
        case 277: case 278: case 279: return "desertsfury"; break;
        case 280: case 281: case 282: return "mindcry"; break;
        case 283: case 284: case 285: return "serpentlord"; break;
        case 286: case 287: case 288: return "ravenclaw"; break;
        case 289: case 290: case 291: return "theriftbow"; break;
        case 292: case 293: case 294: return "tearhaunch"; break;
        case 295: case 296: case 297: return "gravepalm"; break;
        case 298: case 299: case 300: return "bramble"; break;
        case 301: case 302: case 303: return "constrictingring"; break;
        case 304: case 305: case 306: return "dragonchang"; break;
        case 307: case 308: case 309: return "goblinetoe"; break;
        case 310: case 311: case 312: return "torchofiro"; break;
        case 313: case 314: case 315: return "razortine"; break;
        case 316: return "ringoftheorient"; break;
            }
         }
    if (sTag == "UNIQUE_MID")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "blinkbatform"; break;
        case 4: case 5: case 6: return "arhe002"; break;
        case 7: case 8: case 9: return "twitchthroe"; break;
        case 10: case 11: case 12: return "scavcarapace"; break;
        case 13: case 14: case 15: return "sparkingmail"; break;
        case 16: case 17: case 18: return "ancientspledge"; break;
        case 19: case 20: case 21: return "bverritkeep"; break;
        case 22: case 23: case 24: return "kinemilsawl"; break;
        case 25: case 26: case 27: return "gleamscythe"; break;
        case 28: case 29: case 30: return "felloak"; break;
        case 31: case 32: case 33: return "wplmhb016"; break;
        case 34: case 35: case 36: return "leadcrow"; break;
        case 37: case 38: case 39: return "blitzen"; break;
        case 40: case 41: case 42: return "celestialbow"; break;
        case 43: case 44: case 45: return "flambeau"; break;
        case 46: case 47: case 48: return "witchwildstring"; break;
        case 49: case 50: case 51: return "treadsofcthon"; break;
        case 52: case 53: case 54: return "ringofregha"; break;
        case 55: case 56: case 57: return "boneflesh"; break;
        case 58: case 59: case 60: return "armhe020"; break;
        case 61: case 62: case 63: return "armhe021"; break;
        case 64: case 65: case 66: return "nightwingsveil"; break;
        case 67: case 68: case 69: return "stealskull"; break;
        case 70: case 71: case 72: return "faceofhorror"; break;
        case 73: case 74: case 75: return "maarcl137"; break;
        case 76: case 77: case 78: return "lidlesswall"; break;
        case 79: case 80: case 81: return "bloodslayer"; break;
        case 82: case 83: case 84: return "goreshovel"; break;
        case 85: case 86: case 87: return "stonecleaver"; break;
        case 88: case 89: case 90: return "blacktongue"; break;
        case 91: case 92: case 93: return "skewerofkrinitz"; break;
        case 94: case 95: case 96: return "gryphonsclaw"; break;
        case 97: case 98: case 99: return "wswmss019"; break;
        case 100: case 101: case 102: return "zep_xblma_004"; break;
        case 103: case 104: case 105: return "immolator"; break;
        case 106: case 107: case 108: return "najspuzzler"; break;
        case 109: case 110: case 111: return "salamander"; break;
        case 112: case 113: case 114: return "dimoakshew"; break;
        case 115: case 116: case 117: return "soulharvest"; break;
        case 118: case 119: case 120: return "steelgoad"; break;
        case 121: case 122: case 123: return "ichorsting"; break;
        case 124: case 125: case 126: return "blastbark"; break;
        case 127: case 128: case 129: return "fleshstinger"; break;
        case 130: case 131: case 132: return "roguesbow"; break;
        case 133: case 134: case 135: return "bowofthedead"; break;
        case 136: case 137: case 138: return "cloakarcanexpert"; break;
        case 139: case 140: case 141: return "magefist"; break;
        case 142: case 143: case 144: return "venomgrip"; break;
        case 145: case 146: case 147: return "atmasscarab"; break;
        case 148: case 149: case 150: return "crescentmoon"; break;
        case 151: case 152: case 153: return "gladiatorsring"; break;
        case 154: case 155: case 156: return "ironskinring"; break;
        case 157: case 158: case 159: return "ravenfrost"; break;
        case 160: case 161: case 162: return "ringofengagement"; break;
        case 163: case 164: case 165: return "it_mring034"; break;
        case 166: case 167: case 168: return "wispprojector"; break;
        case 169: case 170: case 171: return "nadir"; break;
        case 172: case 173: case 174: return "blackthornsface"; break;
        case 175: case 176: case 177: return "centurion"; break;
        case 178: case 179: case 180: return "visceratuant"; break;
        case 181: case 182: case 183: return "rakescar"; break;
        case 184: case 185: case 186: return "thechieftain"; break;
        case 187: case 188: case 189: return "ripsaw"; break;
        case 190: case 191: case 192: return "gibbousmoon"; break;
        case 193: case 194: case 195: return "stoutnail"; break;
        case 196: case 197: case 198: return "tandoliga"; break;
        case 199: case 200: case 201: return "crushflange"; break;
        case 202: case 203: case 204: return "zep_xblmh_003"; break;
        case 205: case 206: case 207: return "zep_xdbsc_003"; break;
        case 208: case 209: case 210: return "meatscraper"; break;
        case 211: case 212: case 213: return "frostburn"; break;
        case 214: case 215: case 216: return "nokozanrelic"; break;
        case 217: case 218: case 219: return "rockfleece"; break;
        case 220: case 221: case 222: return "toothrow"; break;
        case 223: case 224: case 225: return "wealth"; break;
        case 226: case 227: case 228: return "armhe023"; break;
        case 229: case 230: case 231: return "rockstopper"; break;
        case 232: case 233: case 234: return "armhe028"; break;
        case 235: case 236: case 237: return "thecelestialaxe"; break;
        case 238: case 239: case 240: return "sharpbeak"; break;
        case 241: case 242: case 243: return "blackrazor"; break;
        case 244: case 245: case 246: return "heartcarver"; break;
        case 247: case 248: case 249: return "wblmfh016"; break;
        case 250: case 251: case 252: return "crackrust"; break;
        case 253: case 254: case 255: return "razorswitch"; break;
        case 256: case 257: case 258: return "skullsplitterx"; break;
        case 259: case 260: case 261: return "athenaswrath"; break;
        case 262: case 263: case 264: return "blackleachblade"; break;
        case 265: case 266: case 267: return "battlebranch"; break;
        case 268: case 269: case 270: return "flamedart"; break;
        case 271: case 272: case 273: return "hellclap"; break;
        case 274: case 275: case 276: return "bladebuckle"; break;
        case 277: case 278: case 279: return "divineradiance"; break;
        case 280: case 281: case 282: return "saracenschance"; break;
        case 283: case 284: case 285: return "seraphshymn"; break;
        case 286: case 287: case 288: return "naturespeace"; break;
        case 289: case 290: case 291: return "skinofvipermagi"; break;
        case 292: case 293: case 294: return "spiritshroud"; break;
        case 295: case 296: case 297: return "silksofthevictor"; break;
        case 298: case 299: case 300: return "foolscrest"; break;
        case 301: case 302: case 303: return "griffonseye"; break;
        case 304: case 305: case 306: return "crowcaw"; break;
        case 307: case 308: case 309: return "heavenlygarb"; break;
        case 310: case 311: case 312: return "mosersblessed"; break;
        case 313: case 314: case 315: return "theward"; break;
        case 316: case 317: case 318: return "brainhew"; break;
        case 319: case 320: case 321: return "gonnagalsdirk"; break;
        case 322: case 323: case 324: return "shadowhawk"; break;
        case 325: case 326: case 327: return "zep_unholysw"; break;
        case 328: case 329: case 330: return "thebonesaw"; break;
        case 331: case 332: case 333: return "gnarledroot"; break;
        case 334: case 335: case 336: return "bonesnapx"; break;
        case 337: case 338: case 339: return "ironstone"; break;
        case 340: case 341: case 342: return "nwnstormwalker"; break;
        case 343: case 344: case 345: return "rodofonan"; break;
        case 346: case 347: case 348: return "ironjangbong"; break;
        case 349: case 350: case 351: return "doomslinger"; break;
        case 352: case 353: case 354: return "gnatsting"; break;
        case 355: case 356: case 357: return "stringofears"; break;
        case 358: case 359: case 360: return "bloodfist"; break;
        case 361: case 362: case 363: return "lavagout"; break;
        case 364: case 365: case 366: return "catseye"; break;
        case 367: case 368: case 369: return "highlordswrath"; break;
        case 370: case 371: case 372: return "bulkathoswedding"; break;
        case 373: case 374: case 375: return "thebleeder"; break;
        case 376: case 377: case 378: return "rattlecage"; break;
        case 379: case 380: case 381: return "valkyriewing"; break;
        case 382: case 383: case 384: return "vampiregaze"; break;
        case 385: case 386: case 387: return "ironpelt"; break;
        case 388: case 389: case 390: return "lanceguard"; break;
        case 391: case 392: case 393: return "rhyme"; break;
        case 394: case 395: case 396: return "holydefender"; break;
        case 397: case 398: case 399: return "islestrike"; break;
        case 400: case 401: case 402: return "diamondedge"; break;
        case 403: case 404: case 405: return "stormspike"; break;
        case 406: case 407: case 408: return "thepatriarch"; break;
        case 409: case 410: case 411: return "culwenspoint"; break;
        case 412: case 413: case 414: return "hellplague"; break;
        case 415: case 416: case 417: return "coldsteeleye"; break;
        case 418: case 419: case 420: return "thefalconstalon"; break;
        case 421: case 422: case 423: return "thecelestialstar"; break;
        case 424: case 425: case 426: return "steeldriverx"; break;
        case 427: case 428: case 429: return "bloodrise"; break;
        case 430: case 431: case 432: return "hellishwhip"; break;
        case 433: case 434: case 435: return "thundercall"; break;
        case 436: case 437: case 438: return "nwnwithering"; break;
        case 439: case 440: case 441: return "infernostride"; break;
        case 442: case 443: case 444: return "sandstormtrek"; break;
        case 445: case 446: case 447: return "goldwrap"; break;
        case 448: case 449: case 450: return "theimpaler"; break;
        case 451: case 452: case 453: return "cerebusbite"; break;
        case 454: case 455: case 456: return "deathbit"; break;
        case 457: case 458: case 459: return "rusthandle"; break;
        case 460: case 461: case 462: return "maelstrom"; break;
        case 463: case 464: case 465: return "umeslament"; break;
        case 466: case 467: case 468: return "knellstriker"; break;
        case 469: case 470: case 471: return "gravenspine"; break;
        case 472: case 473: case 474: return "walloftheeyeless"; break;
        case 475: case 476: case 477: return "ravenlore"; break;
        case 478: case 479: case 480: return "soulfeasttine"; break;
        case 481: case 482: case 483: return "thescalper"; break;
        case 484: return "mahimoakcurio"; break;
            }
         }
    if (sTag == "UNIQUE_HI")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "nightscape"; break;
        case 4: case 5: case 6: return "atmaswail"; break;
        case 7: case 8: case 9: return "demonspikecoat"; break;
        case 10: case 11: case 12: return "emeraldplateabs"; break;
        case 13: case 14: case 15: return "maarcl156"; break;
        case 16: case 17: case 18: return "maarcl157"; break;
        case 19: case 20: case 21: return "kirasguardian"; break;
        case 22: case 23: case 24: return "overlordshelm"; break;
        case 25: case 26: case 27: return "peasantcrown"; break;
        case 28: case 29: case 30: return "radiance"; break;
        case 31: case 32: case 33: return "steelshade"; break;
        case 34: case 35: case 36: return "nwnbindingsblood"; break;
        case 37: case 38: case 39: return "maarcl123"; break;
        case 40: case 41: case 42: return "maarcl122"; break;
        case 43: case 44: case 45: return "skinofflayedone"; break;
        case 46: case 47: case 48: return "queheganswisdom"; break;
        case 49: case 50: case 51: return "maarcl136"; break;
        case 52: case 53: case 54: return "maarcl138"; break;
        case 55: case 56: case 57: return "almanegra"; break;
        case 58: case 59: case 60: return "ashmlw014"; break;
        case 61: case 62: case 63: return "ashmlw017"; break;
        case 64: case 65: case 66: return "spikethorn"; break;
        case 67: case 68: case 69: return "stormchaser"; break;
        case 70: case 71: case 72: return "waxmgr017"; break;
        case 73: case 74: case 75: return "humongous"; break;
        case 76: case 77: case 78: return "waxmgr021"; break;
        case 79: case 80: case 81: return "butcherspupil"; break;
        case 82: case 83: case 84: return "coldkill"; break;
        case 85: case 86: case 87: return "guardiannaga"; break;
        case 88: case 89: case 90: return "themangler"; break;
        case 91: case 92: case 93: return "wickedaxe"; break;
        case 94: case 95: case 96: return "wswmbs006"; break;
        case 97: case 98: case 99: return "blackbogssharp"; break;
        case 100: case 101: case 102: return "spineripper"; break;
        case 103: case 104: case 105: return "ginthersrift"; break;
        case 106: case 107: case 108: return "iceshank"; break;
        case 109: case 110: case 111: return "swordofinferno"; break;
        case 112: case 113: case 114: return "katanamummylord"; break;
        case 115: case 116: case 117: return "nwnradiantdeath"; break;
        case 118: case 119: case 120: return "darkclancrusher"; break;
        case 121: case 122: case 123: return "craniumbasherx"; break;
        case 124: case 125: case 126: return "staffofshadows"; break;
        case 127: case 128: case 129: return "deathcoil"; break;
        case 130: case 131: case 132: return "shockwhip"; break;
        case 133: case 134: case 135: return "chromaticire"; break;
        case 136: case 137: case 138: return "zep_gnarledstaff"; break;
        case 139: case 140: case 141: return "ribcracker"; break;
        case 142: case 143: case 144: return "theprotectorx"; break;
        case 145: case 146: case 147: return "pierretombale"; break;
        case 148: case 149: case 150: return "hellcast"; break;
        case 151: case 152: case 153: return "langerbriser"; break;
        case 154: case 155: case 156: return "pusspitter"; break;
        case 157: case 158: case 159: return "endlesshail"; break;
        case 160: case 161: case 162: return "kukoshakaku"; break;
        case 163: case 164: case 165: return "wizendraw"; break;
        case 166: case 167: case 168: return "wbwmsh015"; break;
        case 169: case 170: case 171: return "stormstrike"; break;
        case 172: case 173: case 174: return "arachnidmesh"; break;
        case 175: case 176: case 177: return "nosferatuscoil"; break;
        case 178: case 179: case 180: return "gorerider"; break;
        case 181: case 182: case 183: return "wartraveler"; break;
        case 184: case 185: case 186: return "waterwalk"; break;
        case 187: case 188: case 189: return "metalgrid"; break;
        case 190: case 191: case 192: return "risingsun"; break;
        case 193: case 194: case 195: return "eyeofelitch"; break;
        case 196: case 197: case 198: return "manaldheal"; break;
        case 199: case 200: case 201: return "goldskin"; break;
        case 202: case 203: case 204: return "cloth027"; break;
        case 205: case 206: case 207: return "smoke"; break;
        case 208: case 209: case 210: return "tornfleshofsouls"; break;
        case 211: case 212: case 213: return "wisdomswrap"; break;
        case 214: case 215: case 216: return "blackhades"; break;
        case 217: case 218: case 219: return "maarcl153"; break;
        case 220: case 221: case 222: return "corpsemourn"; break;
        case 223: case 224: case 225: return "guardianangel"; break;
        case 226: case 227: case 228: return "maarcl158"; break;
        case 229: case 230: case 231: return "andarielsvisage"; break;
        case 232: case 233: case 234: return "crownofthieves"; break;
        case 235: case 236: case 237: return "darksighthelm"; break;
        case 238: case 239: case 240: return "demonhornsedge"; break;
        case 241: case 242: case 243: return "gotterdamerung"; break;
        case 244: case 245: case 246: return "wolfhowl"; break;
        case 247: case 248: case 249: return "stealth"; break;
        case 250: case 251: case 252: return "spiritforge"; break;
        case 253: case 254: case 255: return "headhuntersglory"; break;
        case 256: case 257: case 258: return "radamantssphere"; break;
        case 259: case 260: case 261: return "boneslayerblade"; break;
        case 262: case 263: case 264: return "theminotaur"; break;
        case 265: case 266: case 267: return "aginarashatchet"; break;
        case 268: case 269: case 270: return "dwarvenwaraxe008"; break;
        case 271: case 272: case 273: return "runemaster"; break;
        case 274: case 275: case 276: return "spellsteel"; break;
        case 277: case 278: case 279: return "stormrider"; break;
        case 280: case 281: case 282: return "cloudcrack"; break;
        case 283: case 284: case 285: return "doombringer"; break;
        case 286: case 287: case 288: return "eaterofsouls"; break;
        case 289: case 290: case 291: return "wswmdg014"; break;
        case 292: case 293: case 294: return "fleshripper"; break;
        case 295: case 296: case 297: return "bingszwang"; break;
        case 298: case 299: case 300: return "craintevomir"; break;
        case 301: case 302: case 303: return "executionerblade"; break;
        case 304: case 305: case 306: return "thegrizzly"; break;
        case 307: case 308: case 309: return "todesfaelleflamm"; break;
        case 310: case 311: case 312: return "headstriker"; break;
        case 313: case 314: case 315: return "plaguebearer"; break;
        case 316: case 317: case 318: return "hexfire"; break;
        case 319: case 320: case 321: return "wswmka010"; break;
        case 322: case 323: case 324: return "bloodletter"; break;
        case 325: case 326: case 327: return "wswmss018"; break;
        case 328: case 329: case 330: return "fleshrender"; break;
        case 331: case 332: case 333: return "baezilsvortex"; break;
        case 334: case 335: case 336: return "bloodtreestumpx"; break;
        case 337: case 338: case 339: return "earthshaker"; break;
        case 340: case 341: case 342: return "gavelofpain"; break;
        case 343: case 344: case 345: return "hammerofjholm"; break;
        case 346: case 347: case 348: return "thunderclap"; break;
        case 349: case 350: case 351: return "windhammerx"; break;
        case 352: case 353: case 354: return "sureshillfrost"; break;
        case 355: case 356: case 357: return "moonfall"; break;
        case 358: case 359: case 360: return "wdbmqs014"; break;
        case 361: case 362: case 363: return "nwnthornshield"; break;
        case 364: case 365: case 366: return "epicshockwhip"; break;
        case 367: case 368: case 369: return "shadowkiller"; break;
        case 370: case 371: case 372: return "leaf"; break;
        case 373: case 374: case 375: return "eschutastemperx"; break;
        case 376: case 377: case 378: return "theoculusx"; break;
        case 379: case 380: case 381: return "pompeiiswrathx"; break;
        case 382: case 383: case 384: return "grimsburningdead"; break;
        case 385: case 386: case 387: return "stoneraven"; break;
        case 388: case 389: case 390: return "reaperstoll"; break;
        case 391: case 392: case 393: return "magewrath"; break;
        case 394: case 395: case 396: return "riphook"; break;
        case 397: case 398: case 399: return "skystrike"; break;
        case 400: case 401: case 402: return "wbwmsl015"; break;
        case 403: case 404: case 405: return "thundergodsvigor"; break;
        case 406: case 407: case 408: return "marrowwalk"; break;
        case 409: case 410: case 411: return "shadowdancer"; break;
        case 412: case 413: case 414: return "silkweave"; break;
        case 415: case 416: case 417: return "maarcl101"; break;
        case 418: case 419: case 420: return "draculsgrasp"; break;
        case 421: case 422: case 423: return "souldrainer"; break;
        case 424: case 425: case 426: return "maraskaleidoscop"; break;
        case 427: case 428: case 429: return "zakarumshand"; break;
        case 430: case 431: case 432: return "kelpiesnare"; break;
        case 433: case 434: case 435: return "chanceguards"; break;
        case 436: case 437: case 438: return "blackhandkey"; break;
        case 439: case 440: case 441: return "homunculus"; break;
        case 442: case 443: case 444: return "jalalsmane"; break;
        case 445: case 446: case 447: return "spiritkeeper"; break;
        case 448: case 449: case 450: return "bloodthief"; break;
        case 451: case 452: case 453: return "lanceofyaggai"; break;
        case 454: case 455: case 456: return "tannrgorerod"; break;
        case 457: case 458: case 459: return "honesundan"; break;
        case 460: case 461: case 462: return "suicidebranch"; break;
        case 463: case 464: case 465: return "boneshade"; break;
        case 466: case 467: case 468: return "deathsweb"; break;
        case 469: return "stoneofjordan"; break;
            }
         }
    if (sTag == "UNIQUE_EPIC")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "freedom"; break;
        case 4: case 5: case 6: return "ormusrobes"; break;
        case 7: case 8: case 9: return "demonplatearmor"; break;
        case 10: case 11: case 12: return "leviathan"; break;
        case 13: case 14: case 15: return "crownofages"; break;
        case 16: case 17: case 18: return "delirium"; break;
        case 19: case 20: case 21: return "royalcirclet"; break;
        case 22: case 23: case 24: return "thinkingcap"; break;
        case 25: case 26: case 27: return "prudence"; break;
        case 28: case 29: case 30: return "blackoakshield"; break;
        case 31: case 32: case 33: return "dragonscale"; break;
        case 34: case 35: case 36: return "exile"; break;
        case 37: case 38: case 39: return "medusasgaze"; break;
        case 40: case 41: case 42: return "spiritward"; break;
        case 43: case 44: case 45: return "waxmgr011"; break;
        case 46: case 47: case 48: return "waxmhn010"; break;
        case 49: case 50: case 51: return "razorsedge"; break;
        case 52: case 53: case 54: return "axeofthedwarflor"; break;
        case 55: case 56: case 57: return "etherealedge"; break;
        case 58: case 59: case 60: return "waxmbt010"; break;
        case 61: case 62: case 63: return "warlordstrust"; break;
        case 64: case 65: case 66: return "wswmbs005"; break;
        case 67: case 68: case 69: return "wswmbs007"; break;
        case 70: case 71: case 72: return "wswmdg006"; break;
        case 73: case 74: case 75: return "wswmgs011"; break;
        case 76: case 77: case 78: return "wswmls012"; break;
        case 79: case 80: case 81: return "frostwind"; break;
        case 82: case 83: case 84: return "wswmsc010"; break;
        case 85: case 86: case 87: return "wswmrp010"; break;
        case 88: case 89: case 90: return "wswmss011"; break;
        case 91: case 92: case 93: return "demonlimb"; break;
        case 94: case 95: case 96: return "wblmcl010"; break;
        case 97: case 98: case 99: return "wblmfl010"; break;
        case 100: case 101: case 102: return "wblmfh010"; break;
        case 103: case 104: case 105: return "nwnfiendfoe"; break;
        case 106: case 107: case 108: return "wblmhw011"; break;
        case 109: case 110: case 111: return "wblmhl010"; break;
        case 112: case 113: case 114: return "civerbcudgelx"; break;
        case 115: case 116: case 117: return "holythunderx"; break;
        case 118: case 119: case 120: return "wblmml011"; break;
        case 121: case 122: case 123: return "wblmms010"; break;
        case 124: case 125: case 126: return "wdbmqs004"; break;
        case 127: case 128: case 129: return "wdbmax010"; break;
        case 130: case 131: case 132: return "wdbmma010"; break;
        case 133: case 134: case 135: return "wdbmsw010"; break;
        case 136: case 137: case 138: return "wspmku006"; break;
        case 139: case 140: case 141: return "wspmsc010"; break;
        case 142: case 143: case 144: return "wspmka008"; break;
        case 145: case 146: case 147: return "warspear"; break;
        case 148: case 149: case 150: return "deathsfathomx"; break;
        case 151: case 152: case 153: return "wplmss018"; break;
        case 154: case 155: case 156: return "lycandersflank"; break;
        case 157: case 158: case 159: return "wplmhb010"; break;
        case 160: case 161: case 162: return "wplmsc010"; break;
        case 163: case 164: case 165: return "gutsiphon"; break;
        case 166: case 167: case 168: return "cliffkiller"; break;
        case 169: case 170: case 171: return "wbwmln008"; break;
        case 172: case 173: case 174: return "wbwmsh012"; break;
        case 175: case 176: case 177: return "verdungoscord"; break;
        case 178: case 179: case 180: return "steelrend"; break;
        case 181: case 182: case 183: return "bandoffirefrost"; break;
        case 184: case 185: case 186: return "ringofelemental2"; break;
        case 187: case 188: case 189: return "rainbowcloak"; break;
        case 190: case 191: case 192: return "steelcarapace"; break;
        case 193: case 194: case 195: return "shaftstop"; break;
        case 196: case 197: case 198: return "tiamatsrebuke"; break;
        case 199: case 200: case 201: return "executionersjust"; break;
        case 202: case 203: case 204: return "kingswordblood"; break;
        case 205: case 206: case 207: return "theatlantean"; break;
        case 208: case 209: case 210: return "wswmdg007"; break;
        case 211: case 212: case 213: return "swordguard"; break;
        case 214: case 215: case 216: return "vilehusk"; break;
        case 217: case 218: case 219: return "wswmrp016"; break;
        case 220: case 221: case 222: return "bartucscutthroat"; break;
        case 223: case 224: case 225: return "jadetalon"; break;
        case 226: case 227: case 228: return "bonehew"; break;
        case 229: case 230: case 231: return "husoldalevo"; break;
        case 232: case 233: case 234: return "goldstrikearch"; break;
        case 235: case 236: case 237: return "widowmaker"; break;
        case 238: case 239: case 240: return "duress"; break;
        case 241: case 242: case 243: return "gerkessanctuary"; break;
        case 244: case 245: case 246: return "heraldofzakarum"; break;
        case 247: case 248: case 249: return "cranebreak"; break;
        case 250: case 251: case 252: return "kingswordhaste"; break;
        case 253: case 254: case 255: return "bloodmoon"; break;
        case 256: case 257: case 258: return "nordstenderizer"; break;
        case 259: case 260: case 261: return "handblessedlite"; break;
        case 262: case 263: case 264: return "ondalswisdom"; break;
        case 265: case 266: case 267: return "hellmouth"; break;
        case 268: case 269: case 270: return "halaberdsreign"; break;
        case 271: case 272: case 273: return "najslightplate"; break;
        case 274: case 275: case 276: return "shirotachi"; break;
        case 277: case 278: case 279: return "horizonstornado"; break;
        case 280: case 281: case 282: return "earthshifter"; break;
        case 283: case 284: case 285: return "firelizardtalons"; break;
        case 286: case 287: case 288: return "archangelapoc"; break;
        case 289: case 290: case 291: return "burizadokyanon"; break;
        case 292: case 293: case 294: return "templarsmight"; break;
        case 295: case 296: case 297: return "deathcleaver"; break;
        case 298: case 299: case 300: return "ghostflame"; break;
        case 301: case 302: case 303: return "flamebellow"; break;
        case 304: case 305: case 306: return "stormlash"; break;
        case 307: case 308: case 309: return "stonecrusher"; break;
        case 310: case 311: case 312: return "astreonironwardx"; break;
        case 313: case 314: case 315: return "hellrack"; break;
        case 316: case 317: case 318: return "dreamflange"; break;
        case 319: case 320: case 321: return "hellslayer"; break;
        case 322: case 323: case 324: return "wizardspike"; break;
        case 325: case 326: case 327: return "lightsaber001"; break;
        case 328: case 329: case 330: return "djinnslayer"; break;
        case 331: case 332: case 333: return "stormeye"; break;
        case 334: case 335: case 336: return "heavenslight"; break;
        case 337: case 338: case 339: return "theredeemer"; break;
        case 340: case 341: case 342: return "wraithflight"; break;
        case 343: case 344: case 345: return "arreatsface"; break;
        case 346: case 347: case 348: return "fetidsprinkler"; break;
        case 349: case 350: case 351: return "lacerator"; break;
        case 352: case 353: case 354: return "titansrevenge"; break;
        case 355: case 356: case 357: return "lycandersaim"; break;
        case 358: return "obsidianringzod"; break;
            }
         }
    if (sTag == "UNIQUE_ELITE")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "duress"; break;
        case 4: case 5: case 6: return "gerkessanctuary"; break;
        case 7: case 8: case 9: return "heraldofzakarum"; break;
        case 10: case 11: case 12: return "cranebreak"; break;
        case 13: case 14: case 15: return "kingswordhaste"; break;
        case 16: case 17: case 18: return "bloodmoon"; break;
        case 19: case 20: case 21: return "nordstenderizer"; break;
        case 22: case 23: case 24: return "handblessedlite"; break;
        case 25: case 26: case 27: return "ondalswisdom"; break;
        case 28: case 29: case 30: return "hellmouth"; break;
        case 31: case 32: case 33: return "halaberdsreign"; break;
        case 34: case 35: case 36: return "najslightplate"; break;
        case 37: case 38: case 39: return "shirotachi"; break;
        case 40: case 41: case 42: return "horizonstornado"; break;
        case 43: case 44: case 45: return "earthshifter"; break;
        case 46: case 47: case 48: return "firelizardtalons"; break;
        case 49: case 50: case 51: return "archangelapoc"; break;
        case 52: case 53: case 54: return "burizadokyanon"; break;
        case 55: case 56: case 57: return "templarsmight"; break;
        case 58: case 59: case 60: return "deathcleaver"; break;
        case 61: case 62: case 63: return "ghostflame"; break;
        case 64: case 65: case 66: return "flamebellow"; break;
        case 67: case 68: case 69: return "stormlash"; break;
        case 70: case 71: case 72: return "stonecrusher"; break;
        case 73: case 74: case 75: return "astreonironwardx"; break;
        case 76: case 77: case 78: return "hellrack"; break;
        case 79: case 80: case 81: return "dreamflange"; break;
        case 82: case 83: case 84: return "hellslayer"; break;
        case 85: case 86: case 87: return "wizardspike"; break;
        case 88: case 89: case 90: return "lightsaber001"; break;
        case 91: case 92: case 93: return "djinnslayer"; break;
        case 94: case 95: case 96: return "obsidianringzod"; break;
        case 97: case 98: case 99: return "wswmss020"; break;
        case 100: case 101: case 102: return "stormspire"; break;
        case 103: case 104: case 105: return "demonmachine"; break;
        case 106: case 107: case 108: return "eaglehorn"; break;
        case 109: case 110: case 111: return "schaefershammerx"; break;
        case 112: case 113: case 114: return "baranarstar"; break;
        case 115: case 116: case 117: return "tyraelsmight"; break;
        case 118: case 119: case 120: return "messereaver"; break;
        case 121: case 122: case 123: return "godlypltwhale"; break;
        case 124: case 125: case 126: return "godlyrobewhale"; break;
        case 127: case 128: case 129: return "godlyarmorwhale"; break;
        case 130: case 131: case 132: return "stormshield"; break;
        case 133: case 134: case 135: return "windforce"; break;
        case 136: case 137: case 138: return "mangsongslesson"; break;
        case 139: case 140: case 141: return "tombreaver"; break;
        case 142: case 143: case 144: return "splendor"; break;
        case 145: case 146: case 147: return "sanctuary"; break;
        case 148: case 149: case 150: return "ancientspledgex"; break;
        case 151: case 152: case 153: return "wind"; break;
        case 154: case 155: case 156: return "handofjustice"; break;
        case 157: case 158: case 159: return "heartofoak"; break;
        case 160: case 161: case 162: return "crescentmoon002"; break;
        case 163: case 164: case 165: return "enigma"; break;
        case 166: case 167: case 168: return "stone"; break;
        case 169: case 170: case 171: return "lore"; break;
        case 172: case 173: case 174: return "lionheart"; break;
        case 175: case 176: case 177: return "chainsofhonor"; break;
        case 178: case 179: case 180: return "beast"; break;
        case 181: case 182: case 183: return "steel"; break;
        case 184: case 185: case 186: return "fury"; break;
        case 187: case 188: case 189: return "malice"; break;
        case 190: case 191: case 192: return "breathofthedying"; break;
        case 193: case 194: case 195: return "kingsgrace"; break;
        case 196: case 197: case 198: return "honor"; break;
        case 199: case 200: case 201: return "silence"; break;
        case 202: case 203: case 204: return "kingslayer"; break;
        case 205: case 206: case 207: return "lightsaber001"; break;
        case 208: case 209: case 210: return "passion"; break;
        case 211: case 212: case 213: return "famine"; break;
        case 214: case 215: case 216: return "holythunderx"; break;
        case 217: case 218: case 219: return "strength"; break;
        case 220: case 221: case 222: return "calltoarms"; break;
        case 223: case 224: case 225: return "eternity"; break;
        case 226: case 227: case 228: return "chaos"; break;
        case 229: case 230: case 231: return "wspmku014"; break;
        case 232: case 233: case 234: return "memory"; break;
        case 235: case 236: case 237: return "doom"; break;
        case 238: case 239: case 240: return "venom"; break;
        case 241: case 242: case 243: return "zephyr"; break;
        case 244: case 245: case 246: return "zephyr001"; break;
        case 247: case 248: case 249: return "zephyr002"; break;
        case 250: case 251: case 252: return "darkforcespawn"; break;
        case 253: case 254: case 255: return "demonsarch"; break;
        case 256: case 257: case 258: return "boneflame"; break;
        case 259: case 260: case 261: return "steelpillar"; break;
        case 262: case 263: case 264: return "thunderstroke"; break;
        case 265: case 266: case 267: return "ariocsneedle"; break;
        case 268: case 269: case 270: return "viperfork"; break;
        case 271: case 272: case 273: return "gargoylebite"; break;
        case 274: case 275: case 276: return "spikeofhonor"; break;
        case 277: return "thegrandfather"; break;
            }
         }
    if (sTag == "NPC_FLESHDOOM")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "nightscape"; break;
        case 4: case 5: case 6: return "atmaswail"; break;
        case 7: case 8: case 9: return "demonspikecoat"; break;
        case 10: case 11: case 12: return "emeraldplateabs"; break;
        case 13: case 14: case 15: return "maarcl156"; break;
        case 16: case 17: case 18: return "maarcl157"; break;
        case 19: case 20: case 21: return "kirasguardian"; break;
        case 22: case 23: case 24: return "overlordshelm"; break;
        case 25: case 26: case 27: return "peasantcrown"; break;
        case 28: case 29: case 30: return "radiance"; break;
        case 31: case 32: case 33: return "steelshade"; break;
        case 34: case 35: case 36: return "nwnbindingsblood"; break;
        case 37: case 38: case 39: return "maarcl123"; break;
        case 40: case 41: case 42: return "maarcl122"; break;
        case 43: case 44: case 45: return "skinofflayedone"; break;
        case 46: case 47: case 48: return "queheganswisdom"; break;
        case 49: case 50: case 51: return "maarcl136"; break;
        case 52: case 53: case 54: return "maarcl138"; break;
        case 55: case 56: case 57: return "almanegra"; break;
        case 58: case 59: case 60: return "ashmlw014"; break;
        case 61: case 62: case 63: return "ashmlw017"; break;
        case 64: case 65: case 66: return "spikethorn"; break;
        case 67: case 68: case 69: return "stormchaser"; break;
        case 70: case 71: case 72: return "waxmgr017"; break;
        case 73: case 74: case 75: return "humongous"; break;
        case 76: case 77: case 78: return "waxmgr021"; break;
        case 79: case 80: case 81: return "butcherspupil"; break;
        case 82: case 83: case 84: return "coldkill"; break;
        case 85: case 86: case 87: return "guardiannaga"; break;
        case 88: case 89: case 90: return "themangler"; break;
        case 91: case 92: case 93: return "wickedaxe"; break;
        case 94: case 95: case 96: return "wswmbs006"; break;
        case 97: case 98: case 99: return "blackbogssharp"; break;
        case 100: case 101: case 102: return "spineripper"; break;
        case 103: case 104: case 105: return "ginthersrift"; break;
        case 106: case 107: case 108: return "iceshank"; break;
        case 109: case 110: case 111: return "swordofinferno"; break;
        case 112: case 113: case 114: return "katanamummylord"; break;
        case 115: case 116: case 117: return "nwnradiantdeath"; break;
        case 118: case 119: case 120: return "darkclancrusher"; break;
        case 121: case 122: case 123: return "craniumbasherx"; break;
        case 124: case 125: case 126: return "staffofshadows"; break;
        case 127: case 128: case 129: return "deathcoil"; break;
        case 130: case 131: case 132: return "shockwhip"; break;
        case 133: case 134: case 135: return "chromaticire"; break;
        case 136: case 137: case 138: return "zep_gnarledstaff"; break;
        case 139: case 140: case 141: return "ribcracker"; break;
        case 142: case 143: case 144: return "theprotectorx"; break;
        case 145: case 146: case 147: return "pierretombale"; break;
        case 148: case 149: case 150: return "hellcast"; break;
        case 151: case 152: case 153: return "langerbriser"; break;
        case 154: case 155: case 156: return "pusspitter"; break;
        case 157: case 158: case 159: return "endlesshail"; break;
        case 160: case 161: case 162: return "kukoshakaku"; break;
        case 163: case 164: case 165: return "wizendraw"; break;
        case 166: case 167: case 168: return "wbwmsh015"; break;
        case 169: case 170: case 171: return "stormstrike"; break;
        case 172: case 173: case 174: return "arachnidmesh"; break;
        case 175: case 176: case 177: return "nosferatuscoil"; break;
        case 178: case 179: case 180: return "gorerider"; break;
        case 181: case 182: case 183: return "wartraveler"; break;
        case 184: case 185: case 186: return "waterwalk"; break;
        case 187: case 188: case 189: return "metalgrid"; break;
        case 190: case 191: case 192: return "risingsun"; break;
        case 193: case 194: case 195: return "eyeofelitch"; break;
        case 196: case 197: case 198: return "manaldheal"; break;
        case 199: case 200: case 201: return "goldskin"; break;
        case 202: case 203: case 204: return "cloth027"; break;
        case 205: case 206: case 207: return "smoke"; break;
        case 208: case 209: case 210: return "tornfleshofsouls"; break;
        case 211: case 212: case 213: return "wisdomswrap"; break;
        case 214: case 215: case 216: return "blackhades"; break;
        case 217: case 218: case 219: return "maarcl153"; break;
        case 220: case 221: case 222: return "corpsemourn"; break;
        case 223: case 224: case 225: return "guardianangel"; break;
        case 226: case 227: case 228: return "maarcl158"; break;
        case 229: case 230: case 231: return "andarielsvisage"; break;
        case 232: case 233: case 234: return "crownofthieves"; break;
        case 235: case 236: case 237: return "darksighthelm"; break;
        case 238: case 239: case 240: return "demonhornsedge"; break;
        case 241: case 242: case 243: return "gotterdamerung"; break;
        case 244: case 245: case 246: return "wolfhowl"; break;
        case 247: case 248: case 249: return "stealth"; break;
        case 250: case 251: case 252: return "spiritforge"; break;
        case 253: case 254: case 255: return "headhuntersglory"; break;
        case 256: case 257: case 258: return "radamantssphere"; break;
        case 259: case 260: case 261: return "boneslayerblade"; break;
        case 262: case 263: case 264: return "theminotaur"; break;
        case 265: case 266: case 267: return "aginarashatchet"; break;
        case 268: case 269: case 270: return "dwarvenwaraxe008"; break;
        case 271: case 272: case 273: return "runemaster"; break;
        case 274: case 275: case 276: return "spellsteel"; break;
        case 277: case 278: case 279: return "stormrider"; break;
        case 280: case 281: case 282: return "cloudcrack"; break;
        case 283: case 284: case 285: return "doombringer"; break;
        case 286: case 287: case 288: return "eaterofsouls"; break;
        case 289: case 290: case 291: return "wswmdg014"; break;
        case 292: case 293: case 294: return "fleshripper"; break;
        case 295: case 296: case 297: return "bingszwang"; break;
        case 298: case 299: case 300: return "craintevomir"; break;
        case 301: case 302: case 303: return "executionerblade"; break;
        case 304: case 305: case 306: return "thegrizzly"; break;
        case 307: case 308: case 309: return "todesfaelleflamm"; break;
        case 310: case 311: case 312: return "headstriker"; break;
        case 313: case 314: case 315: return "plaguebearer"; break;
        case 316: case 317: case 318: return "hexfire"; break;
        case 319: case 320: case 321: return "wswmka010"; break;
        case 322: case 323: case 324: return "bloodletter"; break;
        case 325: case 326: case 327: return "wswmss018"; break;
        case 328: case 329: case 330: return "fleshrender"; break;
        case 331: case 332: case 333: return "baezilsvortex"; break;
        case 334: case 335: case 336: return "bloodtreestumpx"; break;
        case 337: case 338: case 339: return "earthshaker"; break;
        case 340: case 341: case 342: return "gavelofpain"; break;
        case 343: case 344: case 345: return "hammerofjholm"; break;
        case 346: case 347: case 348: return "thunderclap"; break;
        case 349: case 350: case 351: return "windhammerx"; break;
        case 352: case 353: case 354: return "sureshillfrost"; break;
        case 355: case 356: case 357: return "moonfall"; break;
        case 358: case 359: case 360: return "wdbmqs014"; break;
        case 361: case 362: case 363: return "nwnthornshield"; break;
        case 364: case 365: case 366: return "epicshockwhip"; break;
        case 367: case 368: case 369: return "shadowkiller"; break;
        case 370: case 371: case 372: return "leaf"; break;
        case 373: case 374: case 375: return "eschutastemperx"; break;
        case 376: case 377: case 378: return "theoculusx"; break;
        case 379: case 380: case 381: return "pompeiiswrathx"; break;
        case 382: case 383: case 384: return "grimsburningdead"; break;
        case 385: case 386: case 387: return "stoneraven"; break;
        case 388: case 389: case 390: return "reaperstoll"; break;
        case 391: case 392: case 393: return "magewrath"; break;
        case 394: case 395: case 396: return "riphook"; break;
        case 397: case 398: case 399: return "skystrike"; break;
        case 400: case 401: case 402: return "wbwmsl015"; break;
        case 403: case 404: case 405: return "thundergodsvigor"; break;
        case 406: case 407: case 408: return "marrowwalk"; break;
        case 409: case 410: case 411: return "shadowdancer"; break;
        case 412: case 413: case 414: return "silkweave"; break;
        case 415: case 416: case 417: return "maarcl101"; break;
        case 418: case 419: case 420: return "draculsgrasp"; break;
        case 421: case 422: case 423: return "souldrainer"; break;
        case 424: case 425: case 426: return "maraskaleidoscop"; break;
        case 427: return "stoneofjordan"; break;
            }
         }
    if (sTag == "NPC_LAZARUS")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "freedom"; break;
        case 4: case 5: case 6: return "ormusrobes"; break;
        case 7: case 8: case 9: return "demonplatearmor"; break;
        case 10: case 11: case 12: return "leviathan"; break;
        case 13: case 14: case 15: return "crownofages"; break;
        case 16: case 17: case 18: return "delirium"; break;
        case 19: case 20: case 21: return "royalcirclet"; break;
        case 22: case 23: case 24: return "thinkingcap"; break;
        case 25: case 26: case 27: return "prudence"; break;
        case 28: case 29: case 30: return "blackoakshield"; break;
        case 31: case 32: case 33: return "dragonscale"; break;
        case 34: case 35: case 36: return "exile"; break;
        case 37: case 38: case 39: return "medusasgaze"; break;
        case 40: case 41: case 42: return "spiritward"; break;
        case 43: case 44: case 45: return "waxmgr011"; break;
        case 46: case 47: case 48: return "waxmhn010"; break;
        case 49: case 50: case 51: return "razorsedge"; break;
        case 52: case 53: case 54: return "axeofthedwarflor"; break;
        case 55: case 56: case 57: return "etherealedge"; break;
        case 58: case 59: case 60: return "waxmbt010"; break;
        case 61: case 62: case 63: return "warlordstrust"; break;
        case 64: case 65: case 66: return "wswmbs005"; break;
        case 67: case 68: case 69: return "wswmbs007"; break;
        case 70: case 71: case 72: return "wswmdg006"; break;
        case 73: case 74: case 75: return "wswmgs011"; break;
        case 76: case 77: case 78: return "wswmls012"; break;
        case 79: case 80: case 81: return "frostwind"; break;
        case 82: case 83: case 84: return "wswmsc010"; break;
        case 85: case 86: case 87: return "wswmrp010"; break;
        case 88: case 89: case 90: return "wswmss011"; break;
        case 91: case 92: case 93: return "demonlimb"; break;
        case 94: case 95: case 96: return "wblmcl010"; break;
        case 97: case 98: case 99: return "wblmfl010"; break;
        case 100: case 101: case 102: return "wblmfh010"; break;
        case 103: case 104: case 105: return "nwnfiendfoe"; break;
        case 106: case 107: case 108: return "wblmhw011"; break;
        case 109: case 110: case 111: return "wblmhl010"; break;
        case 112: case 113: case 114: return "civerbcudgelx"; break;
        case 115: case 116: case 117: return "holythunderx"; break;
        case 118: case 119: case 120: return "wblmml011"; break;
        case 121: case 122: case 123: return "wblmms010"; break;
        case 124: case 125: case 126: return "wdbmqs004"; break;
        case 127: case 128: case 129: return "wdbmax010"; break;
        case 130: case 131: case 132: return "wdbmma010"; break;
        case 133: case 134: case 135: return "wdbmsw010"; break;
        case 136: case 137: case 138: return "wspmku006"; break;
        case 139: case 140: case 141: return "wspmsc010"; break;
        case 142: case 143: case 144: return "wspmka008"; break;
        case 145: case 146: case 147: return "warspear"; break;
        case 148: case 149: case 150: return "deathsfathomx"; break;
        case 151: case 152: case 153: return "wplmss018"; break;
        case 154: case 155: case 156: return "lycandersflank"; break;
        case 157: case 158: case 159: return "wplmhb010"; break;
        case 160: case 161: case 162: return "wplmsc010"; break;
        case 163: case 164: case 165: return "gutsiphon"; break;
        case 166: case 167: case 168: return "cliffkiller"; break;
        case 169: case 170: case 171: return "wbwmln008"; break;
        case 172: case 173: case 174: return "wbwmsh012"; break;
        case 175: case 176: case 177: return "verdungoscord"; break;
        case 178: case 179: case 180: return "steelrend"; break;
        case 181: case 182: case 183: return "bandoffirefrost"; break;
        case 184: case 185: case 186: return "ringofelemental2"; break;
        case 187: case 188: case 189: return "rainbowcloak"; break;
        case 190: case 191: case 192: return "steelcarapace"; break;
        case 193: case 194: case 195: return "shaftstop"; break;
        case 196: case 197: case 198: return "tiamatsrebuke"; break;
        case 199: case 200: case 201: return "executionersjust"; break;
        case 202: case 203: case 204: return "kingswordblood"; break;
        case 205: case 206: case 207: return "theatlantean"; break;
        case 208: case 209: case 210: return "wswmdg007"; break;
        case 211: case 212: case 213: return "swordguard"; break;
        case 214: case 215: case 216: return "vilehusk"; break;
        case 217: case 218: case 219: return "wswmrp016"; break;
        case 220: case 221: case 222: return "bartucscutthroat"; break;
        case 223: case 224: case 225: return "jadetalon"; break;
        case 226: case 227: case 228: return "bonehew"; break;
        case 229: case 230: case 231: return "husoldalevo"; break;
        case 232: case 233: case 234: return "goldstrikearch"; break;
        case 235: case 236: case 237: return "widowmaker"; break;
        case 238: case 239: case 240: return "duress"; break;
        case 241: case 242: case 243: return "gerkessanctuary"; break;
        case 244: case 245: case 246: return "heraldofzakarum"; break;
        case 247: case 248: case 249: return "cranebreak"; break;
        case 250: case 251: case 252: return "kingswordhaste"; break;
        case 253: case 254: case 255: return "bloodmoon"; break;
        case 256: case 257: case 258: return "nordstenderizer"; break;
        case 259: case 260: case 261: return "handblessedlite"; break;
        case 262: case 263: case 264: return "ondalswisdom"; break;
        case 265: case 266: case 267: return "hellmouth"; break;
        case 268: case 269: case 270: return "halaberdsreign"; break;
        case 271: case 272: case 273: return "najslightplate"; break;
        case 274: case 275: case 276: return "shirotachi"; break;
        case 277: case 278: case 279: return "horizonstornado"; break;
        case 280: case 281: case 282: return "earthshifter"; break;
        case 283: case 284: case 285: return "firelizardtalons"; break;
        case 286: case 287: case 288: return "archangelapoc"; break;
        case 289: case 290: case 291: return "burizadokyanon"; break;
        case 292: case 293: case 294: return "templarsmight"; break;
        case 295: case 296: case 297: return "deathcleaver"; break;
        case 298: case 299: case 300: return "ghostflame"; break;
        case 301: case 302: case 303: return "flamebellow"; break;
        case 304: case 305: case 306: return "stormlash"; break;
        case 307: case 308: case 309: return "stonecrusher"; break;
        case 310: case 311: case 312: return "astreonironwardx"; break;
        case 313: case 314: case 315: return "hellrack"; break;
        case 316: case 317: case 318: return "dreamflange"; break;
        case 319: case 320: case 321: return "hellslayer"; break;
        case 322: case 323: case 324: return "wizardspike"; break;
        case 325: case 326: case 327: return "lightsaber001"; break;
        case 328: case 329: case 330: return "djinnslayer"; break;
        case 331: return "obsidianringzod"; break;
            }
         }
    if (sTag == "CHEST_EPIC")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "freedom"; break;
        case 4: case 5: case 6: return "ormusrobes"; break;
        case 7: case 8: case 9: return "demonplatearmor"; break;
        case 10: case 11: case 12: return "leviathan"; break;
        case 13: case 14: case 15: return "crownofages"; break;
        case 16: case 17: case 18: return "delirium"; break;
        case 19: case 20: case 21: return "royalcirclet"; break;
        case 22: case 23: case 24: return "thinkingcap"; break;
        case 25: case 26: case 27: return "prudence"; break;
        case 28: case 29: case 30: return "blackoakshield"; break;
        case 31: case 32: case 33: return "dragonscale"; break;
        case 34: case 35: case 36: return "exile"; break;
        case 37: case 38: case 39: return "medusasgaze"; break;
        case 40: case 41: case 42: return "spiritward"; break;
        case 43: case 44: case 45: return "waxmgr011"; break;
        case 46: case 47: case 48: return "waxmhn010"; break;
        case 49: case 50: case 51: return "razorsedge"; break;
        case 52: case 53: case 54: return "axeofthedwarflor"; break;
        case 55: case 56: case 57: return "etherealedge"; break;
        case 58: case 59: case 60: return "waxmbt010"; break;
        case 61: case 62: case 63: return "warlordstrust"; break;
        case 64: case 65: case 66: return "wswmbs005"; break;
        case 67: case 68: case 69: return "wswmbs007"; break;
        case 70: case 71: case 72: return "wswmdg006"; break;
        case 73: case 74: case 75: return "wswmgs011"; break;
        case 76: case 77: case 78: return "wswmls012"; break;
        case 79: case 80: case 81: return "frostwind"; break;
        case 82: case 83: case 84: return "wswmsc010"; break;
        case 85: case 86: case 87: return "wswmrp010"; break;
        case 88: case 89: case 90: return "wswmss011"; break;
        case 91: case 92: case 93: return "demonlimb"; break;
        case 94: case 95: case 96: return "wblmcl010"; break;
        case 97: case 98: case 99: return "wblmfl010"; break;
        case 100: case 101: case 102: return "wblmfh010"; break;
        case 103: case 104: case 105: return "nwnfiendfoe"; break;
        case 106: case 107: case 108: return "wblmhw011"; break;
        case 109: case 110: case 111: return "wblmhl010"; break;
        case 112: case 113: case 114: return "civerbcudgelx"; break;
        case 115: case 116: case 117: return "holythunderx"; break;
        case 118: case 119: case 120: return "wblmml011"; break;
        case 121: case 122: case 123: return "wblmms010"; break;
        case 124: case 125: case 126: return "wdbmqs004"; break;
        case 127: case 128: case 129: return "wdbmax010"; break;
        case 130: case 131: case 132: return "wdbmma010"; break;
        case 133: case 134: case 135: return "wdbmsw010"; break;
        case 136: case 137: case 138: return "wspmku006"; break;
        case 139: case 140: case 141: return "wspmsc010"; break;
        case 142: case 143: case 144: return "wspmka008"; break;
        case 145: case 146: case 147: return "warspear"; break;
        case 148: case 149: case 150: return "deathsfathomx"; break;
        case 151: case 152: case 153: return "wplmss018"; break;
        case 154: case 155: case 156: return "lycandersflank"; break;
        case 157: case 158: case 159: return "wplmhb010"; break;
        case 160: case 161: case 162: return "wplmsc010"; break;
        case 163: case 164: case 165: return "gutsiphon"; break;
        case 166: case 167: case 168: return "cliffkiller"; break;
        case 169: case 170: case 171: return "wbwmln008"; break;
        case 172: case 173: case 174: return "wbwmsh012"; break;
        case 175: case 176: case 177: return "verdungoscord"; break;
        case 178: case 179: case 180: return "steelrend"; break;
        case 181: case 182: case 183: return "bandoffirefrost"; break;
        case 184: case 185: case 186: return "ringofelemental2"; break;
        case 187: case 188: case 189: return "rainbowcloak"; break;
        case 190: case 191: case 192: return "steelcarapace"; break;
        case 193: case 194: case 195: return "shaftstop"; break;
        case 196: case 197: case 198: return "tiamatsrebuke"; break;
        case 199: case 200: case 201: return "executionersjust"; break;
        case 202: case 203: case 204: return "kingswordblood"; break;
        case 205: case 206: case 207: return "theatlantean"; break;
        case 208: case 209: case 210: return "wswmdg007"; break;
        case 211: case 212: case 213: return "swordguard"; break;
        case 214: case 215: case 216: return "vilehusk"; break;
        case 217: case 218: case 219: return "wswmrp016"; break;
        case 220: case 221: case 222: return "bartucscutthroat"; break;
        case 223: case 224: case 225: return "jadetalon"; break;
        case 226: case 227: case 228: return "bonehew"; break;
        case 229: case 230: case 231: return "husoldalevo"; break;
        case 232: case 233: case 234: return "goldstrikearch"; break;
        case 235: case 236: case 237: return "widowmaker"; break;
        case 238: case 239: case 240: return "duress"; break;
        case 241: case 242: case 243: return "gerkessanctuary"; break;
        case 244: case 245: case 246: return "heraldofzakarum"; break;
        case 247: case 248: case 249: return "cranebreak"; break;
        case 250: case 251: case 252: return "kingswordhaste"; break;
        case 253: case 254: case 255: return "bloodmoon"; break;
        case 256: case 257: case 258: return "nordstenderizer"; break;
        case 259: case 260: case 261: return "handblessedlite"; break;
        case 262: case 263: case 264: return "ondalswisdom"; break;
        case 265: case 266: case 267: return "hellmouth"; break;
        case 268: case 269: case 270: return "halaberdsreign"; break;
        case 271: case 272: case 273: return "najslightplate"; break;
        case 274: case 275: case 276: return "shirotachi"; break;
        case 277: case 278: case 279: return "horizonstornado"; break;
        case 280: case 281: case 282: return "earthshifter"; break;
        case 283: case 284: case 285: return "firelizardtalons"; break;
        case 286: case 287: case 288: return "archangelapoc"; break;
        case 289: case 290: case 291: return "burizadokyanon"; break;
        case 292: case 293: case 294: return "templarsmight"; break;
        case 295: case 296: case 297: return "deathcleaver"; break;
        case 298: case 299: case 300: return "ghostflame"; break;
        case 301: case 302: case 303: return "flamebellow"; break;
        case 304: case 305: case 306: return "stormlash"; break;
        case 307: case 308: case 309: return "stonecrusher"; break;
        case 310: case 311: case 312: return "astreonironwardx"; break;
        case 313: case 314: case 315: return "hellrack"; break;
        case 316: case 317: case 318: return "dreamflange"; break;
        case 319: case 320: case 321: return "hellslayer"; break;
        case 322: case 323: case 324: return "wizardspike"; break;
        case 325: case 326: case 327: return "lightsaber001"; break;
        case 328: case 329: case 330: return "djinnslayer"; break;
        case 331: return "obsidianringzod"; break;
            }
         }
    if (sTag == "GRISWOLD_FORGE")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "blinkbatform"; break;
        case 4: case 5: case 6: return "arhe002"; break;
        case 7: case 8: case 9: return "twitchthroe"; break;
        case 10: case 11: case 12: return "scavcarapace"; break;
        case 13: case 14: case 15: return "sparkingmail"; break;
        case 16: case 17: case 18: return "ancientspledge"; break;
        case 19: case 20: case 21: return "bverritkeep"; break;
        case 22: case 23: case 24: return "kinemilsawl"; break;
        case 25: case 26: case 27: return "gleamscythe"; break;
        case 28: case 29: case 30: return "felloak"; break;
        case 31: case 32: case 33: return "wplmhb016"; break;
        case 34: case 35: case 36: return "leadcrow"; break;
        case 37: case 38: case 39: return "blitzen"; break;
        case 40: case 41: case 42: return "celestialbow"; break;
        case 43: case 44: case 45: return "flambeau"; break;
        case 46: case 47: case 48: return "witchwildstring"; break;
        case 49: case 50: case 51: return "treadsofcthon"; break;
        case 52: case 53: case 54: return "ringofregha"; break;
        case 55: case 56: case 57: return "boneflesh"; break;
        case 58: case 59: case 60: return "armhe020"; break;
        case 61: case 62: case 63: return "armhe021"; break;
        case 64: case 65: case 66: return "nightwingsveil"; break;
        case 67: case 68: case 69: return "stealskull"; break;
        case 70: case 71: case 72: return "faceofhorror"; break;
        case 73: case 74: case 75: return "maarcl137"; break;
        case 76: case 77: case 78: return "lidlesswall"; break;
        case 79: case 80: case 81: return "bloodslayer"; break;
        case 82: case 83: case 84: return "goreshovel"; break;
        case 85: case 86: case 87: return "stonecleaver"; break;
        case 88: case 89: case 90: return "blacktongue"; break;
        case 91: case 92: case 93: return "skewerofkrinitz"; break;
        case 94: case 95: case 96: return "gryphonsclaw"; break;
        case 97: case 98: case 99: return "wswmss019"; break;
        case 100: case 101: case 102: return "zep_xblma_004"; break;
        case 103: case 104: case 105: return "immolator"; break;
        case 106: case 107: case 108: return "najspuzzler"; break;
        case 109: case 110: case 111: return "salamander"; break;
        case 112: case 113: case 114: return "dimoakshew"; break;
        case 115: case 116: case 117: return "soulharvest"; break;
        case 118: case 119: case 120: return "steelgoad"; break;
        case 121: case 122: case 123: return "ichorsting"; break;
        case 124: case 125: case 126: return "blastbark"; break;
        case 127: case 128: case 129: return "fleshstinger"; break;
        case 130: case 131: case 132: return "roguesbow"; break;
        case 133: case 134: case 135: return "bowofthedead"; break;
        case 136: case 137: case 138: return "cloakarcanexpert"; break;
        case 139: case 140: case 141: return "magefist"; break;
        case 142: case 143: case 144: return "venomgrip"; break;
        case 145: case 146: case 147: return "atmasscarab"; break;
        case 148: case 149: case 150: return "crescentmoon"; break;
        case 151: case 152: case 153: return "gladiatorsring"; break;
        case 154: case 155: case 156: return "ironskinring"; break;
        case 157: case 158: case 159: return "ravenfrost"; break;
        case 160: case 161: case 162: return "ringofengagement"; break;
        case 163: case 164: case 165: return "it_mring034"; break;
        case 166: case 167: case 168: return "wispprojector"; break;
        case 169: case 170: case 171: return "nadir"; break;
        case 172: case 173: case 174: return "blackthornsface"; break;
        case 175: case 176: case 177: return "centurion"; break;
        case 178: case 179: case 180: return "visceratuant"; break;
        case 181: case 182: case 183: return "rakescar"; break;
        case 184: case 185: case 186: return "thechieftain"; break;
        case 187: case 188: case 189: return "ripsaw"; break;
        case 190: case 191: case 192: return "gibbousmoon"; break;
        case 193: case 194: case 195: return "stoutnail"; break;
        case 196: case 197: case 198: return "tandoliga"; break;
        case 199: case 200: case 201: return "crushflange"; break;
        case 202: case 203: case 204: return "zep_xblmh_003"; break;
        case 205: case 206: case 207: return "zep_xdbsc_003"; break;
        case 208: case 209: case 210: return "meatscraper"; break;
        case 211: case 212: case 213: return "frostburn"; break;
        case 214: case 215: case 216: return "nokozanrelic"; break;
        case 217: case 218: case 219: return "rockfleece"; break;
        case 220: case 221: case 222: return "toothrow"; break;
        case 223: case 224: case 225: return "wealth"; break;
        case 226: case 227: case 228: return "armhe023"; break;
        case 229: case 230: case 231: return "rockstopper"; break;
        case 232: case 233: case 234: return "armhe028"; break;
        case 235: case 236: case 237: return "thecelestialaxe"; break;
        case 238: case 239: case 240: return "sharpbeak"; break;
        case 241: case 242: case 243: return "blackrazor"; break;
        case 244: case 245: case 246: return "heartcarver"; break;
        case 247: case 248: case 249: return "wblmfh016"; break;
        case 250: case 251: case 252: return "crackrust"; break;
        case 253: case 254: case 255: return "razorswitch"; break;
        case 256: case 257: case 258: return "skullsplitterx"; break;
        case 259: case 260: case 261: return "athenaswrath"; break;
        case 262: case 263: case 264: return "blackleachblade"; break;
        case 265: case 266: case 267: return "battlebranch"; break;
        case 268: case 269: case 270: return "flamedart"; break;
        case 271: case 272: case 273: return "hellclap"; break;
        case 274: case 275: case 276: return "bladebuckle"; break;
        case 277: case 278: case 279: return "divineradiance"; break;
        case 280: case 281: case 282: return "saracenschance"; break;
        case 283: case 284: case 285: return "seraphshymn"; break;
        case 286: case 287: case 288: return "naturespeace"; break;
        case 289: case 290: case 291: return "skinofvipermagi"; break;
        case 292: case 293: case 294: return "spiritshroud"; break;
        case 295: case 296: case 297: return "silksofthevictor"; break;
        case 298: case 299: case 300: return "foolscrest"; break;
        case 301: case 302: case 303: return "griffonseye"; break;
        case 304: case 305: case 306: return "crowcaw"; break;
        case 307: case 308: case 309: return "heavenlygarb"; break;
        case 310: case 311: case 312: return "mosersblessed"; break;
        case 313: case 314: case 315: return "theward"; break;
        case 316: case 317: case 318: return "brainhew"; break;
        case 319: case 320: case 321: return "gonnagalsdirk"; break;
        case 322: case 323: case 324: return "shadowhawk"; break;
        case 325: case 326: case 327: return "zep_unholysw"; break;
        case 328: case 329: case 330: return "thebonesaw"; break;
        case 331: case 332: case 333: return "gnarledroot"; break;
        case 334: case 335: case 336: return "bonesnapx"; break;
        case 337: case 338: case 339: return "ironstone"; break;
        case 340: case 341: case 342: return "nwnstormwalker"; break;
        case 343: case 344: case 345: return "rodofonan"; break;
        case 346: case 347: case 348: return "ironjangbong"; break;
        case 349: case 350: case 351: return "doomslinger"; break;
        case 352: case 353: case 354: return "gnatsting"; break;
        case 355: case 356: case 357: return "stringofears"; break;
        case 358: case 359: case 360: return "bloodfist"; break;
        case 361: case 362: case 363: return "lavagout"; break;
        case 364: case 365: case 366: return "catseye"; break;
        case 367: case 368: case 369: return "highlordswrath"; break;
        case 370: case 371: case 372: return "bulkathoswedding"; break;
        case 373: case 374: case 375: return "thebleeder"; break;
        case 376: case 377: case 378: return "rattlecage"; break;
        case 379: case 380: case 381: return "valkyriewing"; break;
        case 382: case 383: case 384: return "vampiregaze"; break;
        case 385: case 386: case 387: return "ironpelt"; break;
        case 388: case 389: case 390: return "lanceguard"; break;
        case 391: case 392: case 393: return "rhyme"; break;
        case 394: case 395: case 396: return "holydefender"; break;
        case 397: case 398: case 399: return "islestrike"; break;
        case 400: case 401: case 402: return "diamondedge"; break;
        case 403: case 404: case 405: return "stormspike"; break;
        case 406: case 407: case 408: return "thepatriarch"; break;
        case 409: case 410: case 411: return "culwenspoint"; break;
        case 412: case 413: case 414: return "hellplague"; break;
        case 415: case 416: case 417: return "coldsteeleye"; break;
        case 418: case 419: case 420: return "thefalconstalon"; break;
        case 421: case 422: case 423: return "thecelestialstar"; break;
        case 424: case 425: case 426: return "steeldriverx"; break;
        case 427: case 428: case 429: return "bloodrise"; break;
        case 430: case 431: case 432: return "hellishwhip"; break;
        case 433: case 434: case 435: return "thundercall"; break;
        case 436: case 437: case 438: return "nwnwithering"; break;
        case 439: case 440: case 441: return "infernostride"; break;
        case 442: case 443: case 444: return "sandstormtrek"; break;
        case 445: return "mahimoakcurio"; break;
            }
         }
    if (sTag == "ALTAR_HELLFORGE")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "waxmgr017"; break;
        case 4: case 5: case 6: return "humongous"; break;
        case 7: case 8: case 9: return "waxmgr021"; break;
        case 10: case 11: case 12: return "butcherspupil"; break;
        case 13: case 14: case 15: return "coldkill"; break;
        case 16: case 17: case 18: return "guardiannaga"; break;
        case 19: case 20: case 21: return "themangler"; break;
        case 22: case 23: case 24: return "wickedaxe"; break;
        case 25: case 26: case 27: return "wswmbs006"; break;
        case 28: case 29: case 30: return "blackbogssharp"; break;
        case 31: case 32: case 33: return "spineripper"; break;
        case 34: case 35: case 36: return "ginthersrift"; break;
        case 37: case 38: case 39: return "iceshank"; break;
        case 40: case 41: case 42: return "swordofinferno"; break;
        case 43: case 44: case 45: return "katanamummylord"; break;
        case 46: case 47: case 48: return "nwnradiantdeath"; break;
        case 49: case 50: case 51: return "darkclancrusher"; break;
        case 52: case 53: case 54: return "craniumbasherx"; break;
        case 55: case 56: case 57: return "staffofshadows"; break;
        case 58: case 59: case 60: return "deathcoil"; break;
        case 61: case 62: case 63: return "shockwhip"; break;
        case 64: case 65: case 66: return "chromaticire"; break;
        case 67: case 68: case 69: return "zep_gnarledstaff"; break;
        case 70: case 71: case 72: return "ribcracker"; break;
        case 73: case 74: case 75: return "theprotectorx"; break;
        case 76: case 77: case 78: return "pierretombale"; break;
        case 79: case 80: case 81: return "hellcast"; break;
        case 82: case 83: case 84: return "langerbriser"; break;
        case 85: case 86: case 87: return "pusspitter"; break;
        case 88: case 89: case 90: return "endlesshail"; break;
        case 91: case 92: case 93: return "kukoshakaku"; break;
        case 94: case 95: case 96: return "wizendraw"; break;
        case 97: case 98: case 99: return "wbwmsh015"; break;
        case 100: case 101: case 102: return "stormstrike"; break;
        case 103: case 104: case 105: return "boneslayerblade"; break;
        case 106: case 107: case 108: return "theminotaur"; break;
        case 109: case 110: case 111: return "aginarashatchet"; break;
        case 112: case 113: case 114: return "dwarvenwaraxe008"; break;
        case 115: case 116: case 117: return "runemaster"; break;
        case 118: case 119: case 120: return "spellsteel"; break;
        case 121: case 122: case 123: return "stormrider"; break;
        case 124: case 125: case 126: return "cloudcrack"; break;
        case 127: case 128: case 129: return "doombringer"; break;
        case 130: case 131: case 132: return "eaterofsouls"; break;
        case 133: case 134: case 135: return "wswmdg014"; break;
        case 136: case 137: case 138: return "fleshripper"; break;
        case 139: case 140: case 141: return "bingszwang"; break;
        case 142: case 143: case 144: return "craintevomir"; break;
        case 145: case 146: case 147: return "executionerblade"; break;
        case 148: case 149: case 150: return "thegrizzly"; break;
        case 151: case 152: case 153: return "todesfaelleflamm"; break;
        case 154: case 155: case 156: return "headstriker"; break;
        case 157: case 158: case 159: return "plaguebearer"; break;
        case 160: case 161: case 162: return "hexfire"; break;
        case 163: case 164: case 165: return "wswmka010"; break;
        case 166: case 167: case 168: return "bloodletter"; break;
        case 169: case 170: case 171: return "wswmss018"; break;
        case 172: case 173: case 174: return "fleshrender"; break;
        case 175: case 176: case 177: return "baezilsvortex"; break;
        case 178: case 179: case 180: return "bloodtreestumpx"; break;
        case 181: case 182: case 183: return "earthshaker"; break;
        case 184: case 185: case 186: return "gavelofpain"; break;
        case 187: case 188: case 189: return "hammerofjholm"; break;
        case 190: case 191: case 192: return "thunderclap"; break;
        case 193: case 194: case 195: return "windhammerx"; break;
        case 196: case 197: case 198: return "sureshillfrost"; break;
        case 199: case 200: case 201: return "moonfall"; break;
        case 202: case 203: case 204: return "wdbmqs014"; break;
        case 205: case 206: case 207: return "nwnthornshield"; break;
        case 208: case 209: case 210: return "epicshockwhip"; break;
        case 211: case 212: case 213: return "shadowkiller"; break;
        case 214: case 215: case 216: return "leaf"; break;
        case 217: case 218: case 219: return "eschutastemperx"; break;
        case 220: case 221: case 222: return "theoculusx"; break;
        case 223: case 224: case 225: return "pompeiiswrathx"; break;
        case 226: case 227: case 228: return "grimsburningdead"; break;
        case 229: case 230: case 231: return "stoneraven"; break;
        case 232: case 233: case 234: return "reaperstoll"; break;
        case 235: case 236: case 237: return "magewrath"; break;
        case 238: case 239: case 240: return "riphook"; break;
        case 241: case 242: case 243: return "skystrike"; break;
        case 244: case 245: case 246: return "wbwmsl015"; break;
        case 247: case 248: case 249: return "waxmgr011"; break;
        case 250: case 251: case 252: return "waxmhn010"; break;
        case 253: case 254: case 255: return "razorsedge"; break;
        case 256: case 257: case 258: return "axeofthedwarflor"; break;
        case 259: case 260: case 261: return "etherealedge"; break;
        case 262: case 263: case 264: return "waxmbt010"; break;
        case 265: case 266: case 267: return "warlordstrust"; break;
        case 268: case 269: case 270: return "wswmbs005"; break;
        case 271: case 272: case 273: return "wswmbs007"; break;
        case 274: case 275: case 276: return "wswmdg006"; break;
        case 277: case 278: case 279: return "wswmgs011"; break;
        case 280: case 281: case 282: return "wswmls012"; break;
        case 283: case 284: case 285: return "frostwind"; break;
        case 286: case 287: case 288: return "wswmsc010"; break;
        case 289: case 290: case 291: return "wswmrp010"; break;
        case 292: case 293: case 294: return "wswmss011"; break;
        case 295: case 296: case 297: return "demonlimb"; break;
        case 298: case 299: case 300: return "wblmcl010"; break;
        case 301: case 302: case 303: return "wblmfl010"; break;
        case 304: case 305: case 306: return "wblmfh010"; break;
        case 307: case 308: case 309: return "nwnfiendfoe"; break;
        case 310: case 311: case 312: return "wblmhw011"; break;
        case 313: case 314: case 315: return "wblmhl010"; break;
        case 316: case 317: case 318: return "civerbcudgelx"; break;
        case 319: case 320: case 321: return "wblmml011"; break;
        case 322: case 323: case 324: return "wblmms010"; break;
        case 325: case 326: case 327: return "wdbmqs004"; break;
        case 328: case 329: case 330: return "wdbmax010"; break;
        case 331: case 332: case 333: return "wdbmma010"; break;
        case 334: case 335: case 336: return "wdbmsw010"; break;
        case 337: case 338: case 339: return "wspmku006"; break;
        case 340: case 341: case 342: return "wspmsc010"; break;
        case 343: case 344: case 345: return "wspmka008"; break;
        case 346: case 347: case 348: return "warspear"; break;
        case 349: case 350: case 351: return "deathsfathomx"; break;
        case 352: case 353: case 354: return "wplmss018"; break;
        case 355: case 356: case 357: return "lycandersflank"; break;
        case 358: case 359: case 360: return "wplmhb010"; break;
        case 361: case 362: case 363: return "wplmsc010"; break;
        case 364: case 365: case 366: return "gutsiphon"; break;
        case 367: case 368: case 369: return "cliffkiller"; break;
        case 370: case 371: case 372: return "wbwmln008"; break;
        case 373: case 374: case 375: return "wbwmsh012"; break;
        case 376: case 377: case 378: return "draculsgrasp"; break;
        case 379: case 380: case 381: return "souldrainer"; break;
        case 382: case 383: case 384: return "steelrend"; break;
        case 385: return "theatlantean"; break;
            }
         }
    if (sTag == "NPC_DIABLO")
        {
        switch (iNumber)
            {
        case 1: case 2: case 3: return "duress"; break;
        case 4: case 5: case 6: return "gerkessanctuary"; break;
        case 7: case 8: case 9: return "heraldofzakarum"; break;
        case 10: case 11: case 12: return "cranebreak"; break;
        case 13: case 14: case 15: return "kingswordhaste"; break;
        case 16: case 17: case 18: return "bloodmoon"; break;
        case 19: case 20: case 21: return "nordstenderizer"; break;
        case 22: case 23: case 24: return "handblessedlite"; break;
        case 25: case 26: case 27: return "ondalswisdom"; break;
        case 28: case 29: case 30: return "hellmouth"; break;
        case 31: case 32: case 33: return "halaberdsreign"; break;
        case 34: case 35: case 36: return "najslightplate"; break;
        case 37: case 38: case 39: return "shirotachi"; break;
        case 40: case 41: case 42: return "horizonstornado"; break;
        case 43: case 44: case 45: return "earthshifter"; break;
        case 46: case 47: case 48: return "firelizardtalons"; break;
        case 49: case 50: case 51: return "archangelapoc"; break;
        case 52: case 53: case 54: return "burizadokyanon"; break;
        case 55: case 56: case 57: return "templarsmight"; break;
        case 58: case 59: case 60: return "deathcleaver"; break;
        case 61: case 62: case 63: return "ghostflame"; break;
        case 64: case 65: case 66: return "flamebellow"; break;
        case 67: case 68: case 69: return "stormlash"; break;
        case 70: case 71: case 72: return "stonecrusher"; break;
        case 73: case 74: case 75: return "astreonironwardx"; break;
        case 76: case 77: case 78: return "hellrack"; break;
        case 79: case 80: case 81: return "dreamflange"; break;
        case 82: case 83: case 84: return "hellslayer"; break;
        case 85: case 86: case 87: return "wizardspike"; break;
        case 88: case 89: case 90: return "lightsaber001"; break;
        case 91: case 92: case 93: return "djinnslayer"; break;
        case 94: case 95: case 96: return "obsidianringzod"; break;
        case 97: case 98: case 99: return "wswmss020"; break;
        case 100: case 101: case 102: return "stormspire"; break;
        case 103: case 104: case 105: return "demonmachine"; break;
        case 106: case 107: case 108: return "eaglehorn"; break;
        case 109: case 110: case 111: return "schaefershammerx"; break;
        case 112: case 113: case 114: return "baranarstar"; break;
        case 115: case 116: case 117: return "tyraelsmight"; break;
        case 118: case 119: case 120: return "messereaver"; break;
        case 121: case 122: case 123: return "godlypltwhale"; break;
        case 124: case 125: case 126: return "godlyrobewhale"; break;
        case 127: case 128: case 129: return "godlyarmorwhale"; break;
        case 130: case 131: case 132: return "stormshield"; break;
        case 133: case 134: case 135: return "windforce"; break;
        case 136: case 137: case 138: return "mangsongslesson"; break;
        case 139: case 140: case 141: return "tombreaver"; break;
        case 142: case 143: case 144: return "splendor"; break;
        case 145: case 146: case 147: return "sanctuary"; break;
        case 148: case 149: case 150: return "ancientspledgex"; break;
        case 151: case 152: case 153: return "wind"; break;
        case 154: case 155: case 156: return "handofjustice"; break;
        case 157: case 158: case 159: return "heartofoak"; break;
        case 160: case 161: case 162: return "crescentmoon002"; break;
        case 163: case 164: case 165: return "enigma"; break;
        case 166: case 167: case 168: return "stone"; break;
        case 169: case 170: case 171: return "lore"; break;
        case 172: case 173: case 174: return "lionheart"; break;
        case 175: case 176: case 177: return "chainsofhonor"; break;
        case 178: case 179: case 180: return "beast"; break;
        case 181: case 182: case 183: return "steel"; break;
        case 184: case 185: case 186: return "fury"; break;
        case 187: case 188: case 189: return "malice"; break;
        case 190: case 191: case 192: return "breathofthedying"; break;
        case 193: case 194: case 195: return "kingsgrace"; break;
        case 196: case 197: case 198: return "honor"; break;
        case 199: case 200: case 201: return "silence"; break;
        case 202: case 203: case 204: return "kingslayer"; break;
        case 205: case 206: case 207: return "lightsaber001"; break;
        case 208: case 209: case 210: return "passion"; break;
        case 211: case 212: case 213: return "famine"; break;
        case 214: case 215: case 216: return "holythunderx"; break;
        case 217: case 218: case 219: return "strength"; break;
        case 220: case 221: case 222: return "calltoarms"; break;
        case 223: case 224: case 225: return "eternity"; break;
        case 226: case 227: case 228: return "chaos"; break;
        case 229: case 230: case 231: return "wspmku014"; break;
        case 232: case 233: case 234: return "memory"; break;
        case 235: case 236: case 237: return "doom"; break;
        case 238: case 239: case 240: return "venom"; break;
        case 241: case 242: case 243: return "zephyr"; break;
        case 244: case 245: case 246: return "zephyr001"; break;
        case 247: case 248: case 249: return "zephyr002"; break;
        case 250: return "thegrandfather"; break;
            }
         }
    return "ERROR - NO TAG MATCH";
}
