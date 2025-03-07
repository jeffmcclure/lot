#include "loot_inc_data"
#include "inc_jeff"
#include "x0_i0_corpses"

int IsStackable(string resref);
int IsGold(string resref);
int IsDeadCreature();
int DoAllPlayersHaveLootGenie(object oPC);

int Possesses(object owner, string resref) {
    object oItem = GetFirstItemInInventory(owner);
    //SendMessageToPC(GetFirstPC(), "owner resref=" + resref);

    while (GetIsObjectValid(oItem)) {
        //SendMessageToPC(GetFirstPC(), "resref=" + GetResRef(oItem));
        if (resref == GetResRef(oItem)) return TRUE;
        oItem = GetNextItemInInventory(owner);
    }
    return FALSE;
}

string GetGoldResRef(object oContainer) {
    return "nw_it_gold007";
    object oItem = GetFirstItemInInventory(oContainer);
    while (GetIsObjectValid(oItem)) {
        string resref = GetResRef(oItem);
        if (IsGold(resref)) return resref;
        oItem = GetNextItemInInventory(oContainer);
    }
    return "nw_it_gold007";
}

object CreateLoot(string sItemTemplate, object oContainer, object oPC, int nStackSize = 1) {
    //SendMessageToPC(GetFirstPC(), "CreateLoot() '" + sItemTemplate + "' stack:" + IntToString(nStackSize));
    if (!GetIsPC(oPC)) {
        MessageAll("CreateLoot(): non-PC parameter passed resref " + sItemTemplate);
        MessageAll("CreateLoot(): non-PC parameter passed oPC name   " + GetName(oPC));
        MessageAll("CreateLoot(): non-PC parameter passed oContainer name   " + GetName(oContainer));
        return OBJECT_INVALID;
    }
    //SendMessageToPC(GetFirstPC(), "CreateLoot() 2");
    string charName = GetName(oPC);
    if (charName == "") {
        MessageAll("CreateLoot() : charName is blank");
        return OBJECT_INVALID;
    }
    //SendMessageToPC(GetFirstPC(), "CreateLoot() 3");

    object treasure = OBJECT_INVALID;

    // if Loot Genie
    if (GetItemPossessedBy(oPC, "D1_LOOT_GENIE") != OBJECT_INVALID) {
        //SendMessageToPC(GetFirstPC(), "CreateLoot() Loot Genie");
        treasure = CreateItemOnObject(sItemTemplate, oPC, nStackSize);
    } else {
        //SendMessageToPC(GetFirstPC(), "CreateLoot() party Loot " + sItemTemplate + " size:" + IntToString(nStackSize) + " in '" + GetName(oContainer) + "'");
        // normal loot
        if (IsGold(sItemTemplate)) {
            int add = nStackSize - GetGold(oContainer);
            if (add > 0) {
                SetLocalInt(oContainer, "JEFF_LOOT", 1);
                //SendMessageToPC(GetFirstPC(), "CreateLoot() gold add1 = " + IntToString(add));
                object treas = CreateItemOnObject("nw_it_gold007", oContainer, add);
                add = nStackSize - GetGold(oContainer);
                if (add > 0) {
                    //SendMessageToPC(GetFirstPC(), "CreateLoot() gold add2 = " + IntToString(add));
                    treas = CreateItemOnObject("nw_it_gold001", oContainer, add);
                    add = nStackSize - GetGold(oContainer);
                    if (add > 0) {
                        //SendMessageToPC(GetFirstPC(), "CreateLoot() gold add3 = " + IntToString(add));
                        GiveGoldToCreature(oContainer, add);
                    }
                }
                SetDroppableFlag(treas, TRUE);
                return treas;
            } else {
                return OBJECT_INVALID;
            }
        } else if (!IsStackable(sItemTemplate) || !Possesses(oContainer, sItemTemplate)) {
            SetLocalInt(oContainer, "JEFF_LOOT", 1);
            treasure = CreateItemOnObject(sItemTemplate, oContainer, nStackSize);
            // if party loot system
            SetLocalString(treasure, "LIMIT_ACQUIRE", charName);
            SetLocalInt(treasure, "JEFF_LOOT", 1);
        }
    }
    //SendMessageToPC(GetFirstPC(), "CreateLoot() '" + sItemTemplate + "' GetBaseItemType:" + IntToString(GetBaseItemType(treasure)));

    SetDroppableFlag(treasure, TRUE);
    return treasure;
}

int IsDeadCreature() {
    return GetIsObjectValid(GetLastKiller());
}


//::///////////////////////////////////////////////
//:: LOOT_INC_MAIN - Based off of the BioWare
//:: treasure scripts but with many modifications.
//:: Copyright (c) 2002 Jeremy Sager
//:: Copyright (c) 2001 Bioware Corp.,
//:://////////////////////////////////////////////
/*
  This include file handles the random treasure
  distribution for treasure from creatures and containers

 [ ] Documented
*/
//:://////////////////////////////////////////////
//:: Created By: Jeremy Sager
//:: Created On: August 2002
//:: Created By:  Brent, Andrew
//:: Created On:  November - May
//:://////////////////////////////////////////////
// :: MODS

// Modifications to CreatePotion
// Modifications to CreateKit
// Modifications to general odds


// April 23 2002: Removed animal parts. They were silly.
// May 6 2002: Added Undead to the EXCLUSION treasure list (they drop nothing now)
//  - redistributed treasure (to lessen amoun   t of armor and increase 'class specific treasure'
//  - Rangers with heavy armor prof. will be treated as Fighters else as Barbarians
//  - Gave wizards, druids and monk their own function
// MAY 29 2002: Removed the heal potion from treasure
//              Moved nymph cloak +4 to treasure bracket 6
//              Added Monk Enhancement items to random treasure

// * ---------
// * CONSTANTS
// * ---------


// * tweaking constants

    // * SIX LEVEL RANGES
    int RANGE_1_MIN = 0;
    int RANGE_1_MAX = 5;
    int RANGE_2_MIN = 6;
    int RANGE_2_MAX = 8;

    int RANGE_3_MIN = 9;
    int RANGE_3_MAX = 10;

    int RANGE_4_MIN = 11;
    int RANGE_4_MAX = 13;

    int RANGE_5_MIN = 14;
    int RANGE_5_MAX = 16;

    int RANGE_6_MIN = 17;
    int RANGE_6_MAX = 100;

    // * NUMBER OF ITEMS APPEARING
    int NUMBER_LOW_ONE   = 100; int NUMBER_MED_ONE    = 60; int NUMBER_HIGH_ONE   = 40;  int NUMBER_BOSS_ONE = 100;
    int NUMBER_LOW_TWO   = 0;   int NUMBER_MED_TWO    = 30; int NUMBER_HIGH_TWO   = 40;  int NUMBER_BOSS_TWO = 0;
    int NUMBER_LOW_THREE = 0;   int NUMBER_MED_THREE  = 10; int NUMBER_HIGH_THREE = 20;  int NUMBER_BOSS_THREE = 0;

    int NUMBER_BOOK_ONE = 75;
    int NUMBER_BOOK_TWO = 20;
    int NUMBER_BOOK_THREE = 5;

    // * AMOUNT OF GOLD BY VALUE
    float LOW_MOD_GOLD = 0.5;   float MEDIUM_MOD_GOLD = 1.0; float HIGH_MOD_GOLD = 3.0;
    // * FREQUENCY OF ITEM TYPE APPEARING BY TREASURE TYPE
    int LOW_PROB_BOOK    = 1;  int MEDIUM_PROB_BOOK =   1;  int HIGH_PROB_BOOK =1;
    int LOW_PROB_ANIMAL  = 0;  int MEDIUM_PROB_ANIMAL = 0;  int HIGH_PROB_ANIMAL = 0;
    int LOW_PROB_JUNK    = 2;  int MEDIUM_PROB_JUNK =    1;  int HIGH_PROB_JUNK = 1;
    int LOW_PROB_GOLD = 48;    int MEDIUM_PROB_GOLD =   46; int HIGH_PROB_GOLD = 15;
    int LOW_PROB_GEM  = 9;     int MEDIUM_PROB_GEM =    15; int HIGH_PROB_GEM = 15;
    int LOW_PROB_JEWEL = 4;    int MEDIUM_PROB_JEWEL =  6; int HIGH_PROB_JEWEL = 15;
    int LOW_PROB_ARCANE = 3;   int MEDIUM_PROB_ARCANE = 3; int HIGH_PROB_ARCANE = 3;
    int LOW_PROB_DIVINE = 3;   int MEDIUM_PROB_DIVINE = 3;  int HIGH_PROB_DIVINE = 3;
    int LOW_PROB_AMMO = 10;    int MEDIUM_PROB_AMMO =   5;  int HIGH_PROB_AMMO  =   3;
    int LOW_PROB_KIT = 5;      int MEDIUM_PROB_KIT =    5;  int HIGH_PROB_KIT   =   5;
    int LOW_PROB_POTION = 12;  int MEDIUM_PROB_POTION = 12; int HIGH_PROB_POTION=   9;
    int LOW_PROB_TABLE2 = 3;   int MEDIUM_PROB_TABLE2 = 3; int HIGH_PROB_TABLE2=   30;


// * readability constants

int    TREASURE_LOW = 1;
int    TREASURE_MEDIUM = 2;
int    TREASURE_HIGH = 3;
int    TREASURE_BOSS = 4;
int    TREASURE_BOOK = 5;
int    TREASURE_UNIQUE = 6;


// * JUMP_LEVEL is used in a Specific item function
// * in the case where a generic item is called for within that function
// * it will create a generic item by adding JUMP_LEVEL to the character's
// * hit die for the purposes of the treasure evaluation.
// * May 2002: Lowered JUMP_LEVEL from 3 to 2

int JUMP_LEVEL = 2;


//* Declarations
    object CreateGenericExotic(object oTarget, object oAdventurer, int nModifier = 0);
    object CreateGenericMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    object CreateSpecificMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    object CreateGenericDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    object CreateSpecificDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    object CreateGenericWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    object CreateSpecificWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0);
    int nDetermineClassToUse(object oCharacter);


// *
// * IMPLEMENTATION
// *

// * Comment the speakstring in to debug treasure generation
void dbSpeak(string s)
{
//   SpeakString(s);
}

//* made this function to help with debugging
object dbCreateItemOnObject(string sItemTemplate, object oTarget, object oPC, int nStackSize = 1) {
    if (sItemTemplate == "") {
        PrintString("blank item passed into dbCreateItemOnObject. Please report as bug to Brent.");
    }
    dbSpeak(sItemTemplate);

    //sItemTemplate = GetStringLowerCase

    if (nStackSize == 1) {
        // * checks to see if this is a throwing item and if it is
        // * it creates more

        string sRoot = GetSubString(sItemTemplate, 0, 6);
        dbSpeak("ROOT: " + sRoot);
        if (GetStringLowerCase(sRoot) == "nw_wth")
        {
            nStackSize = Random(30) + 1;
        }
    }
    object oItem = CreateLoot(sItemTemplate, oTarget, oPC, nStackSize);
    if (GetIsObjectValid(oItem) == FALSE && sItemTemplate != "NW_IT_GOLD001") {

        // * check to see if item is there in a stack, if not give warning
        if (GetIsObjectValid(GetItemPossessedBy(oTarget, GetStringUpperCase(sItemTemplate))) == FALSE &&
            GetIsObjectValid(GetItemPossessedBy(oTarget, GetStringLowerCase(sItemTemplate))) == FALSE)
        {
            PrintString("**DESIGN***");
            PrintString("******" + sItemTemplate + " is an invalid item template. Please report as bug to Brent.");
            PrintString("*******");
        }
    }
    return oItem;
}


// *
// * GET FUNCTIONS
// *

// * Returns the object that either last opened the container or destroyed it
object GetLastOpenerOrKiller() {
    //SendMessageToPC(GetFirstPC(), "GetLastOpenerOrKiller() enter");
    object oPC = GetLastOpenedBy();
    if (GetIsPC(oPC) == TRUE) {
        //SendMessageToPC(GetFirstPC(), "GetLastOpenerOrKiller() opened by pc");
        return oPC;
    }

    oPC = GetLastKiller();
    if (GetIsPC(oPC) == TRUE) {
        //SendMessageToPC(GetFirstPC(), "GetLastOpenerOrKiller() killed by pc");
        return oPC;
    }

    oPC = GetMaster(oPC);
    if (GetIsPC(oPC) == TRUE) {
        //SendMessageToPC(GetFirstPC(), "GetLastOpenerOrKiller() killed by henchman");
        return oPC;
    }

    //SendMessageToPC(GetFirstPC(), "GetLastOpenerOrKiller() failsafe");
    return GetFirstPC();
}

//::///////////////////////////////////////////////
//:: GetRange
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns true if nHD matches the correct
    level range for the indicated nCategory.
    (i.e., First to Fourth level characters
    are considered Range1)
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetRange(int nCategory, int nHD)
{
    int nMin = 0; int nMax = 0;
    switch (nCategory)
    {
        case 6: nMin = RANGE_6_MIN; nMax = RANGE_6_MAX; break;
        case 5: nMin = RANGE_5_MIN; nMax = RANGE_5_MAX; break;
        case 4: nMin = RANGE_4_MIN; nMax = RANGE_4_MAX; break;
        case 3: nMin = RANGE_3_MIN; nMax = RANGE_3_MAX; break;
        case 2: nMin = RANGE_2_MIN; nMax = RANGE_2_MAX; break;
        case 1: nMin = RANGE_1_MIN; nMax = RANGE_1_MAX; break;
    }

   dbSpeak("nMin = " + IntToString(nMin));
   dbSpeak("nMax = " + IntToString(nMax));
   dbSpeak("GetRange.nHD = " + IntToString(nHD));
   if (nHD >= nMin && nHD <= nMax)
   {
    return TRUE;
   }

  return FALSE;

}

//::///////////////////////////////////////////////
//:: GetNumberOfItems
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Returns the number of items to create.
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetNumberOfItems(int nTreasureType)
{
    int nItems = 0;
    int nRandom = 0;

    int nProbThreeItems = 0;
    int nProbTwoItems = 0;
    int nProbOneItems = 0;

    if (nTreasureType == TREASURE_LOW)
    {
     nProbThreeItems = NUMBER_LOW_THREE;
     nProbTwoItems = NUMBER_LOW_TWO;
     nProbOneItems = NUMBER_LOW_ONE;
    }
    else
    if (nTreasureType == TREASURE_MEDIUM)
    {
     nProbThreeItems = NUMBER_MED_THREE;
     nProbTwoItems = NUMBER_MED_TWO;
     nProbOneItems = NUMBER_MED_ONE;
    }
    else
    if (nTreasureType == TREASURE_HIGH)
    {
     nProbThreeItems = NUMBER_HIGH_THREE;
     nProbTwoItems = NUMBER_HIGH_TWO;
     nProbOneItems = NUMBER_HIGH_ONE;
    }
    else
    if (nTreasureType == TREASURE_BOSS)
    {
     nProbThreeItems = NUMBER_BOSS_THREE;
     nProbTwoItems = NUMBER_BOSS_TWO;
     nProbOneItems = NUMBER_BOSS_ONE;
    }
    else
    if (nTreasureType == TREASURE_BOOK)
    {
     nProbThreeItems = NUMBER_BOOK_THREE;
     nProbTwoItems = NUMBER_BOOK_TWO;
     nProbOneItems = NUMBER_BOOK_ONE;
    }


    nRandom = d100();
    if (nRandom <= nProbThreeItems)
    {
        nItems = 3;
    }
    else
    if (nRandom <= nProbTwoItems + nProbThreeItems)
    {
        nItems = 2;
    }
    else
    {
        nItems = 1;
    }

    // * May 13 2002: Cap number of items, in case of logic error
    if (nItems > 3)
    {
        nItems = 3;
    }

    return nItems;
}


// *
// * TREASURE GENERATION FUNCTIONS
// *
    // *
    // * Non-Scaling Treasure
    // *
    object CreateBook(object oTarget, object oPC) {
        int nBook1 = Random(10);
        string sRes;

        if (nBook1 < 7) {
            sRes = "bookoftownportal"; // town portal
        } else if (nBook1 < 8) {
            sRes = "NW_IT_BOOK011"; // identify
        } else if (nBook1 < 9) {
            sRes = "NW_IT_BOOK021"; // healing
        } else {
            sRes = "NW_IT_BOOK031"; // apocalypse
        }
        dbSpeak("Create book");
        object book = dbCreateItemOnObject(sRes, oTarget, oPC);
        //SetPlotFlag(book, TRUE); // set resale value to zero
        return book;
    }

    object CreateAnimalPart(object oTarget, object oPC)
    {

        string sRes = "";
        int nResult = Random(3) + 1;
        switch (nResult)
        {
            case 1: sRes = "NW_IT_MSMLMISC20"; break;
            case 2: sRes = "NW_IT_MMIDMISC05"; break;
            case 3: sRes = "NW_IT_MMIDMISC06"; break;
        }
        dbSpeak("animal");
        return dbCreateItemOnObject(sRes, oTarget, oPC);
    }

    object CreateJunk(object oTarget, object oPC)
    {
        string sRes = "NW_IT_TORCH001";
        int NUM_ITEMS = 6;
        int nResult = Random(NUM_ITEMS) + 1;
        int nKit = 0;
        switch (nResult)
        {
            case 1: sRes = "NW_IT_MPOTION021"; break; //ale
            case 2: sRes = "NW_IT_MPOTION021"; break;   // ale
            case 3: sRes = "NW_IT_MPOTION023"; break; // wine
            case 4: sRes = "NW_IT_MPOTION021"; break; // ale
            case 5: sRes = "NW_IT_MPOTION022"; break; // spirits
            case 6: sRes = "NW_IT_TORCH001"; break; //torch
        }
        dbSpeak("CreateJunk");
        return dbCreateItemOnObject(sRes, oTarget, oPC);
    }
    // *
    // * Scaling Treasure
    // *
    object CreateGold(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD = GetHitDice(oAdventurer) + nModifier;
        int nAmount = 0;

        if (GetRange(1, nHD))
        {
            nAmount = d10();
        }
        else if (GetRange(2, nHD))
        {
            nAmount = d20();
        }
        else if (GetRange(3, nHD))
        {
            nAmount = d20(2);
        }
        else if (GetRange(4, nHD))
        {
            nAmount = d20(5);
        }
        else if (GetRange(5, nHD))
        {
            nAmount = d20(8);
        }
        else if (GetRange(6, nHD))
        {
            nAmount = d20(10);
        }
        float nMod = 0.0;
        if (nTreasureType == TREASURE_LOW) nMod = LOW_MOD_GOLD;
        else if (nTreasureType == TREASURE_MEDIUM) nMod = MEDIUM_MOD_GOLD;
        else if (nTreasureType == TREASURE_HIGH) nMod = HIGH_MOD_GOLD;

        // * always at least 1gp is created
        nAmount = FloatToInt(nAmount * nMod);
        if (nAmount <= 0)
        {
            nAmount = 1;
        }
        dbSpeak("gold");
        return dbCreateItemOnObject("NW_IT_GOLD001", oTarget, oAdventurer, nAmount);
    }
    object CreateGem(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD = GetHitDice(oAdventurer) + nModifier;
        string sGem = "nw_it_gem001";
        if (GetRange(1, nHD))
        {
            int nRandom = Random(9) + 1;
            switch (nRandom)
            {
                case 1: sGem = "nw_it_gem001";  break;
                case 2: sGem = "nw_it_gem007";  break;
                case 3: sGem = "nw_it_gem002";  break;
                case 4: case 5: sGem = "nw_it_gem004"; break;
                case 6: case 7: sGem = "nw_it_gem014"; break;
                case 8: sGem = "nw_it_gem003";         break;
                case 9: sGem = "nw_it_gem015";         break;
            }
        }
        else if (GetRange(2, nHD))               // 30 GP Avg; 150 gp Max
        {
            int nRandom = d12();
            switch (nRandom)
            {
                case 1: sGem = "nw_it_gem001";         break;
                case 2: sGem = "nw_it_gem007";         break;
                case 3: sGem = "nw_it_gem002";         break;
                case 4: sGem = "nw_it_gem004";         break;
                case 5: case 6: sGem = "nw_it_gem014";  break;
                case 7: case 8: sGem = "nw_it_gem003";  break;
                case 9: case 10: sGem = "nw_it_gem015"; break;
                case 11: sGem = "nw_it_gem011";         break;
                case 12: sGem = "nw_it_gem013";         break;
            }

        }
        else if (GetRange(3, nHD))  // 75GP Avg; 500 gp max
        {
            int nRandom = d2();
            switch (nRandom)
            {
                case 1: sGem = "nw_it_gem013";         break;
                case 2: sGem = "nw_it_gem010";         break;
            }

        }
        else if (GetRange(4, nHD))  // 150 gp avg; 1000 gp max
        {
            int nRandom = d3();
            switch (nRandom)
            {
                case 1: sGem = "nw_it_gem013";  break;
                case 2: sGem = "nw_it_gem010";    break;
                case 3: sGem = "nw_it_gem008";           break;
            }
        }
        else if (GetRange(5, nHD))  // 300 gp avg; any
        {
            int nRandom = d6();
            switch (nRandom)
            {
                case 1: sGem = "nw_it_gem013";  break;
                case 2: sGem = "nw_it_gem010";    break;
                case 3: case 4: sGem = "nw_it_gem008";           break;
                case 5: sGem = "nw_it_gem009";           break;
                case 6: sGem = "nw_it_gem009";           break;
            }
        }
        else if (GetRange(6, nHD))// * Anything higher than level 15    500 gp avg; any
        {
            int nRandom = Random(8) + 1;
            switch (nRandom)
            {
                case 1: sGem = "nw_it_gem013";  break;
                case 2: sGem = "nw_it_gem010";    break;
                case 3: case 4: sGem = "nw_it_gem008";           break;
                case 5: sGem = "nw_it_gem009";           break;
                case 6: sGem = "nw_it_gem009";           break;
                case 7: sGem = "nw_it_gem006";           break;
                case 8: sGem = "nw_it_gem012";           break;
            }
        }
      dbSpeak("Create Gem");
      return dbCreateItemOnObject(sGem, oTarget, oAdventurer);
    }
    object CreateJewel(object oTarget, object oAdventurer, int nTreasureType, int nModifier = 0)
    {
        int nHD = GetHitDice(oAdventurer) + nModifier;
        string sJewel = "";

        if (GetRange(1, nHD))        // 15 gp avg; 75 gp max
        {
          int nRandom = d2();
          switch (nRandom)
          {
            case 1: sJewel = "nw_it_mring021";   break;
            case 2: sJewel = "nw_it_mneck020";   break;
          }
        }
        else if (GetRange(2, nHD))   // 30 GP Avg; 150 gp Max
        {
          int nRandom = d6();
          switch (nRandom)
          {
            case 1: sJewel = "nw_it_mring021";            break;
            case 2: case 3: sJewel = "nw_it_mneck020";    break;
            case 4: sJewel = "nw_it_mring022";            break;
            case 5: case 6: sJewel = "nw_it_mneck023";            break;          }
        }
        else if (GetRange(3, nHD))  // 75GP Avg; 500 gp max
        {
          int nRandom = d6();
          switch (nRandom)
          {
            case 1: sJewel = "nw_it_mring021";           break;
            case 2: case 3: sJewel = "nw_it_mneck020";   break;
            case 4: case 5: sJewel = "nw_it_mring022";   break;
            case 6: sJewel = "nw_it_mneck021";           break;
          }
        }
        else if (GetRange(4, nHD))  // 150 gp avg; 1000 gp max
        {
          int nRandom = d6();
          switch (nRandom)
          {
            case 1: sJewel = "nw_it_mring021";            break;
            case 2: sJewel = "nw_it_mring022";            break;
            case 3: case 4: case 5: sJewel = "nw_it_mneck021";    break;
            case 6: sJewel = "nw_it_mring023";            break;
          }
        }
        else if (GetRange(5, nHD))  // 300 gp avg; any
        {
          int nRandom = d8();
          switch (nRandom)
          {
            case 1: sJewel = "nw_it_mring022";           break;
            case 2: case 3: sJewel = "nw_it_mneck021";   break;
            case 4: case 5: case 6: sJewel = "nw_it_mring023"; break;
            case 7: case 8: sJewel = "nw_it_mneck022";               break;
          }
        }
        else if (GetRange(6, nHD))
        {
          int nRandom = d6();
          switch (nRandom)
          {
            case 1: sJewel = "nw_it_mring022";              break;
            case 2: sJewel = "nw_it_mneck021";              break;
            case 3: case 4: sJewel = "nw_it_mring023";      break;
            case 5: case 6: sJewel = "nw_it_mneck022";      break;
          }
        }
      dbSpeak("Create Jewel");

      return dbCreateItemOnObject(sJewel, oTarget, oAdventurer);
    }
    
    // * returns the valid upper limit for any arcane spell scroll
    int TrimLevel(int nScroll, int nLevel)
    {   int nMax = 5;
        switch (nLevel)
        {
            case 0: nMax = 4; break;
            case 1: nMax = 13; break;
            case 2: nMax = 21; break;
            case 3: nMax = 15; break;
            case 4: nMax = 17; break;
            case 5: nMax = 13; break;
            case 6: nMax = 14; break;
            case 7: nMax = 8; break;
            case 8: nMax = 9; break;
            case 9: nMax = 12; break;
        }
        if (nScroll > nMax) nScroll = nMax;
        return nScroll;

    }
    // * nModifier is to 'raise' the level of the oAdventurer
    object CreateArcaneScroll(object oTarget, object oAdventurer, int nModifier = 0)
    {
        int nMaxSpells = 21;
        int nHD = GetHitDice(oAdventurer) + nModifier;
        int nScroll = 1;
        int nLevel = 1;

        if (GetRange(1, nHD))           // l 1-2
        {
          nLevel = d2();
          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(2, nHD))      // l 1-4
        {
          nLevel = d4();
          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(3, nHD))    // l 2-6
        {
          nLevel = d6();
          if (nLevel < 2) nLevel = 2;

          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(4, nHD))   // l 3-8
        {
          nLevel = d8();
          if (nLevel < 3) nLevel = 3;

          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(5, nHD))   // l 4-9
        {
          nLevel = d8() + 1;
          if (nLevel < 4) nLevel = 4;

          nScroll =  Random(nMaxSpells) + 1;
        }
        else if (GetRange(6, nHD))   // 5 -9
        {
          nLevel = d8() + 1;
          if (nLevel < 5) nLevel = 5;

          nScroll =  Random(nMaxSpells) + 1;
        }

        // * Trims the level of the scroll to match the max # of scrolls in each level range
        nScroll = TrimLevel(nScroll, nLevel);

        string sRes = "nw_it_sparscr216";

        if (nScroll < 10)
        {
            sRes = "NW_IT_SPARSCR" + IntToString(nLevel) + "0" + IntToString(nScroll);
        }
        else
        {
            sRes = "NW_IT_SPARSCR" + IntToString(nLevel) + IntToString(nScroll);
        }
          return dbCreateItemOnObject(sRes, oTarget, oAdventurer);
    }

    object CreateDivineScroll(object oTarget, object oAdventurer, int nModifier=0)
    {
        int nHD = GetHitDice(oAdventurer) + nModifier;
        string sScroll = "";
        if (GetRange(1, nHD))
        {
            int nRandom = d4();
            switch (nRandom)
            {
                case 1: sScroll = "nw_it_spdvscr201"; break;
                case 2: sScroll = "nw_it_spdvscr202"; break;
                case 3: sScroll = "nw_it_spdvscr203"; break;
                case 4: sScroll = "nw_it_spdvscr204"; break;
            }
        }
        else if (GetRange(2, nHD))
        {
            int nRandom = d8();
            switch (nRandom)
            {
                case 1: sScroll = "nw_it_spdvscr201"; break;
                case 2: sScroll = "nw_it_spdvscr202";break;
                case 3: sScroll = "nw_it_spdvscr203"; break;
                case 4: sScroll = "nw_it_spdvscr204"; break;
                case 5: sScroll = "nw_it_spdvscr301"; break;
                case 6: sScroll = "nw_it_spdvscr302"; break;
                case 7: sScroll = "nw_it_spdvscr401"; break;
                case 8: sScroll = "nw_it_spdvscr402"; break;
            }

        }
        else if (GetRange(3, nHD))
        {
            int nRandom = Random(9) + 1;
            switch (nRandom)
            {
                case 1: sScroll = "nw_it_spdvscr201"; break;
                case 2: sScroll = "nw_it_spdvscr202"; break;
                case 3: sScroll = "nw_it_spdvscr203"; break;
                case 4: sScroll = "nw_it_spdvscr204"; break;
                case 5: sScroll = "nw_it_spdvscr301"; break;
                case 6: sScroll = "nw_it_spdvscr302"; break;
                case 7: sScroll = "nw_it_spdvscr401"; break;
                case 8: sScroll = "nw_it_spdvscr402"; break;
                case 9: sScroll = "nw_it_spdvscr501"; break;
            }

        }
        else
        {
            int nRandom = Random(7) + 1;
            switch (nRandom)
            {
                case 1: sScroll = "nw_it_spdvscr301"; break;
                case 2: sScroll = "nw_it_spdvscr302";  break;
                case 3: sScroll = "nw_it_spdvscr401"; break;
                case 4: sScroll = "nw_it_spdvscr402"; break;
                case 5: sScroll = "nw_it_spdvscr501"; break;
                case 6: sScroll = "nw_it_spdvscr701"; break;
                case 7: sScroll = "nw_it_spdvscr702";  break;
            }
        }
        dbSpeak("Divine Scroll");

        return dbCreateItemOnObject(sScroll, oTarget, oAdventurer);
    }
    
    object CreateAmmo(object oTarget, object oAdventurer, int nModifier=0)
    {
        int nHD = GetHitDice(oAdventurer) + nModifier;
        string sAmmo = "";

        if (GetRange(1, nHD))           // * 200 gp max
        {
            int nRandom = d3();
            switch (nRandom)
            {
                case 1: sAmmo = "nw_wamar001";  break;
                case 2: sAmmo = "nw_wambo001";  break;
                case 3: sAmmo = "nw_wambu001";  break;
            }
          }
        else if (GetRange(2, nHD))       // * 800 gp max
        {
            int nRandom = d6();
            switch (nRandom)
            {
                case 1: sAmmo = "nw_wamar001";  break;
                case 2: sAmmo = "nw_wambo001";  break;
                case 3: sAmmo = "nw_wambu001";  break;
                case 4: sAmmo = "nw_wammar001"; break;
                case 5: sAmmo = "nw_wammbo001"; break;
                case 6: sAmmo = "nw_wammbo002"; break;
            }
        }
        else if (GetRange(3, nHD))    // *  - 2500 gp
        {
            int nRandom = d20();
            switch (nRandom)
            {
                case 1: sAmmo = "nw_wamar001";   break;
                case 2: sAmmo = "nw_wambo001";   break;
                case 3: sAmmo = "nw_wambu001";   break;
                case 4: sAmmo = "nw_wammar001";  break;
                case 5: sAmmo = "nw_wammbo001";  break;
                case 6: sAmmo = "nw_wammbo002";   break;
                case 7: sAmmo = "nw_wammbo003";  break;
                case 8: sAmmo = "nw_wammbu002";  break;
                case 9: sAmmo = "nw_wammar002";  break;
                case 10: sAmmo = "nw_wammar001"; break;
                case 11: sAmmo = "nw_wammar003"; break;
                case 12: sAmmo = "nw_wammar004"; break;
                case 13: sAmmo = "nw_wammar005"; break;
                case 14: sAmmo = "nw_wammar006"; break;
                case 15: sAmmo = "nw_wammbo004";  break;
                case 16: sAmmo = "nw_wammbo005"; break;
                case 17: sAmmo = "nw_wammbu004"; break;
                case 18: sAmmo = "nw_wammbu005"; break;
                case 19: sAmmo = "nw_wammbu006"; break;
                case 20: sAmmo = "nw_wammbu007"; break;
            }
        }
        else
        {
            int nRandom = d20();
            switch (nRandom)
            {
                case 1: sAmmo = "nw_wamar001";      break;
                case 2: sAmmo = "nw_wammbu001";     break;
                case 3: sAmmo = "nw_wammbu003";     break;
                case 4: sAmmo = "nw_wammar001";     break;
                case 5: sAmmo = "nw_wammbo001";      break;
                case 6: sAmmo = "nw_wammbo002";     break;
                case 7: sAmmo = "nw_wammbo003";     break;
                case 8: sAmmo = "nw_wammbu002";     break;
                case 9: sAmmo = "nw_wammar002";     break;
                case 10: sAmmo = "nw_wammar001";    break;
                case 11: sAmmo = "nw_wammar003";    break;
                case 12: sAmmo = "nw_wammar004";     break;
                case 13: sAmmo = "nw_wammar005";    break;
                case 14: sAmmo = "nw_wammar006";    break;
                case 15: sAmmo = "nw_wammbo004";    break;
                case 16: sAmmo = "nw_wammbo005";    break;
                case 17: sAmmo = "nw_wammbu004";    break;
                case 18: sAmmo = "nw_wammbu005";    break;
                case 19: sAmmo = "nw_wammbu006";    break;
                case 20: sAmmo = "nw_wammbu007";    break;
            }
        }
        dbSpeak("ammo");
        return dbCreateItemOnObject(sAmmo, oTarget, oAdventurer, Random(30) + 1); // create up to 30 of the specified ammo type
    }

    object CreateTrapKit(object oTarget, object oAdventurer, int nModifier = 0)
    {
      int nHD = GetHitDice(oAdventurer) + nModifier;
      string sKit = "";
        if (GetRange(1, nHD))      // 200
        {
            int nRandom = d3();
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap001";    break;
                case 2: sKit = "nw_it_trap029";    break;
                case 3: sKit = "nw_it_trap033";    break;
            }
        }
        else if (GetRange(2, nHD))  // 800
        {
            int nRandom = d12();
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap001";    break;
                case 2: sKit = "nw_it_trap029";    break;
                case 3: sKit = "nw_it_trap033";    break;
                case 4: sKit = "nw_it_trap002";    break;
                case 5: sKit = "nw_it_trap030";    break;
                case 6: sKit = "nw_it_trap037";    break;
                case 7: sKit = "nw_it_trap034";   break;
                case 8: sKit = "nw_it_trap005";   break;
                case 9: sKit = "nw_it_trap038";   break;
                case 10: sKit = "nw_it_trap041";   break;
                case 11: sKit = "nw_it_trap003";    break;
                case 12: sKit = "nw_it_trap031";   break;
            }

        }
        else if (GetRange(3, nHD))   // 200 - 2500
        {
            int nRandom = Random(17) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap002";  break;
                case 2: sKit = "nw_it_trap030";  break;
                case 3: sKit = "nw_it_trap037";  break;
                case 4: sKit = "nw_it_trap034";   break;
                case 5: sKit = "nw_it_trap005";  break;
                case 6: sKit = "nw_it_trap038";   break;
                case 7: sKit = "nw_it_trap041";   break;
                case 8: sKit = "nw_it_trap003";   break;
                case 9: sKit = "nw_it_trap031";   break;
                case 10: sKit = "nw_it_trap035";   break;
                case 11: sKit = "nw_it_trap006";   break;
                case 12: sKit = "nw_it_trap042";   break;
                case 13: sKit = "nw_it_trap004";   break;
                case 14: sKit = "nw_it_trap032";   break;
                case 15: sKit = "nw_it_trap039";    break;
                case 16: sKit = "nw_it_trap009";   break;
                case 17: sKit = "nw_it_trap036";   break;
            }

       }
        else if (GetRange(4, nHD))  // 800 - 10000
        {
            int nRandom = Random(19) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap035";  break;
                case 2: sKit = "nw_it_trap006";  break;
                case 3: sKit = "nw_it_trap042";  break;
                case 4: sKit = "nw_it_trap004";   break;
                case 5: sKit = "nw_it_trap032";   break;
                case 6: sKit = "nw_it_trap039";   break;
                case 7: sKit = "nw_it_trap009";   break;
                case 8: sKit = "nw_it_trap036";   break;
                case 9: sKit = "nw_it_trap013";   break;
                case 10: sKit = "nw_it_trap040";  break;
                case 11: sKit = "nw_it_trap007";  break;
                case 12: sKit = "nw_it_trap043";  break;
                case 13: sKit = "nw_it_trap010";  break;
                case 14: sKit = "nw_it_trap017";  break;
                case 15: sKit = "nw_it_trap021"; break;
                case 16: sKit = "nw_it_trap014"; break;
                case 17: sKit = "nw_it_trap025"; break;
                case 18: sKit = "nw_it_trap008";  break;
                case 19: sKit = "nw_it_trap044";  break;
            }

        }
        else if (GetRange(5, nHD))  // 2000 -16500
        {
            int nRandom = Random(18) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap039";   break;
                case 2: sKit = "nw_it_trap009";   break;
                case 3: sKit = "nw_it_trap036";   break;
                case 4: sKit = "nw_it_trap013";   break;
                case 5: sKit = "nw_it_trap040";   break;
                case 6: sKit = "nw_it_trap007";   break;
                case 7: sKit = "nw_it_trap043";   break;
                case 8: sKit = "nw_it_trap010";  break;
                case 9: sKit = "nw_it_trap017";  break;
                case 10: sKit = "nw_it_trap021";  break;
                case 11: sKit = "nw_it_trap014";  break;
                case 12: sKit = "nw_it_trap025";  break;
                case 13: sKit = "nw_it_trap008";  break;
                case 14: sKit = "nw_it_trap044";  break;
                case 15: sKit = "nw_it_trap018";  break;
                case 16: sKit = "nw_it_trap011";  break;
                case 17: sKit = "nw_it_trap022";  break;
                case 18: sKit = "nw_it_trap026";  break;
            }

        }
        else if (GetRange(6, nHD))   // 2000 - ?
        {
            int nRandom = Random(27) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_trap039";  break;
                case 2: sKit = "nw_it_trap009";  break;
                case 3: sKit = "nw_it_trap036";  break;
                case 4: sKit = "nw_it_trap013";  break;
                case 5: sKit = "nw_it_trap040";  break;
                case 6: sKit = "nw_it_trap007";  break;
                case 7: sKit = "nw_it_trap043";  break;
                case 8: sKit = "nw_it_trap010"; break;
                case 9: sKit = "nw_it_trap017"; break;
                case 10: sKit = "nw_it_trap021"; break;
                case 11: sKit = "nw_it_trap014"; break;
                case 12: sKit = "nw_it_trap025"; break;
                case 13: sKit = "nw_it_trap008"; break;
                case 14: sKit = "nw_it_trap044"; break;
                case 15: sKit = "nw_it_trap018"; break;
                case 16: sKit = "nw_it_trap011"; break;
                case 17: sKit = "nw_it_trap022"; break;
                case 18: sKit = "nw_it_trap026"; break;
                case 19: sKit = "nw_it_trap015"; break;
                case 20: sKit = "nw_it_trap012"; break;
                case 21: sKit = "nw_it_trap019"; break;
                case 22: sKit = "nw_it_trap023"; break;
                case 23: sKit = "nw_it_trap016"; break;
                case 24: sKit = "nw_it_trap027"; break;
                case 25: sKit = "nw_it_trap020"; break;
                case 26: sKit = "nw_it_trap024"; break;
                case 27: sKit = "nw_it_trap028"; break;
             }

        }
        dbSpeak("Create Trapkit");
        return dbCreateItemOnObject(sKit, oTarget, oAdventurer);

    }
    object CreateHealingKit(object oTarget, object oAdventurer, int nModifier = 0)
    {
        int nHD = GetHitDice(oAdventurer) + nModifier;
        string sKit = "";
        if (GetRange(1, nHD))      // 200
        {
            int nRandom = Random(1) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit001";  break;
            }
        }
        else if (GetRange(2, nHD))  // 800
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit001";  break;
                case 2: sKit = "nw_it_medkit002";  break;
            }

        }
        else if (GetRange(3, nHD))   // 200 - 2500
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit002"; break;
                case 2: sKit = "nw_it_medkit003";  break;
            }

       }
        else if (GetRange(4, nHD))  // 800 - 10000
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit003";break;
                case 2: sKit = "nw_it_medkit004"; break;
            }

        }
        else if (GetRange(5, nHD))  // 2000 -16500
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit003"; break;
                case 2: sKit = "nw_it_medkit004";break;
            }

        }
        else if (GetRange(6, nHD))   // 2000 - ?
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_medkit003"; break;
                case 2: sKit = "nw_it_medkit004";break;
             }

        }
        dbSpeak("Create Healing Kit");

        return dbCreateItemOnObject(sKit, oTarget, oAdventurer);

    }
    object CreateLockPick(object oTarget, object oAdventurer, int nModifier = 0)
    {
        int nHD = GetHitDice(oAdventurer) + nModifier;
        string sKit = "";
        if (GetRange(1, nHD))      // 200
        {
            int nRandom = d8();
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks001";   break;
                case 2: sKit = "nw_it_picks002";   break;
                case 3: sKit = "nw_it_picks001";   break;
                case 4: sKit = "nw_it_picks001";   break;
                case 5: sKit = "nw_it_picks001";   break;
                case 6: sKit = "nw_it_picks001";   break;
                case 7: sKit = "nw_it_picks001";   break;
                case 8: sKit = "nw_it_picks001";   break;
            }
        }
        else if (GetRange(2, nHD))  // 800
        {
            int nRandom = d6();
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks001";   break;
                case 2: sKit = "nw_it_picks002";    break;
                case 3: sKit = "nw_it_picks003";   break;
                case 4: sKit = "nw_it_picks002";    break;
                case 5: sKit = "nw_it_picks002";    break;
                case 6: sKit = "nw_it_picks002";    break;
            }

        }
        else if (GetRange(3, nHD))   // 200 - 2500
        {
            int nRandom = Random(2) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks003";  break;
                case 2: sKit = "nw_it_picks004";  break;
            }

       }
        else if (GetRange(4, nHD))  // 800 - 10000
        {
            int nRandom = Random(1) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks004";  break;
            }

        }
        else if (GetRange(5, nHD))  // 2000 -16500
        {
            int nRandom = Random(1) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks004"; break;
            }

        }
        else if (GetRange(6, nHD))   // 2000 - ?
        {
            int nRandom = Random(1) + 1;
            switch (nRandom)
            {
                case 1: sKit = "nw_it_picks004"; break;
             }

        }
       dbSpeak("Create Lockpick");

        return dbCreateItemOnObject(sKit, oTarget, oAdventurer);
    }
    
    object CreateKit(object oTarget, object oAdventurer, int nModifier = 0)
    {
        // * April 23 2002: Major restructuring of this function
        // * to allow me to

        switch (Random(8) + 1)
        {
            case 1:
            case 2:
                return CreateTrapKit(oTarget, oAdventurer, nModifier);
                //break;
            case 3:
            case 4:
                return CreateHealingKit(oTarget, oAdventurer, nModifier);
                //break;
            case 5:
            case 6:
            case 7:
            case 8:
                return CreateLockPick(oTarget, oAdventurer, nModifier);
                //break;
            default:
                return OBJECT_INVALID;
                //break;
        }
        return OBJECT_INVALID;
    }

    object CreatePotion(object oTarget, object oAdventurer, int nModifier = 0)
    {
        string sPotion = "";
        int nHD = GetHitDice(oAdventurer) + nModifier;

        if (GetRange(1, nHD))
        {
            int nRandom = d4();
            switch (nRandom)
            {
                case 1: sPotion = "nw_it_mpotion001"; break;
                case 2: sPotion = "nw_it_mpotion002";  break;
                case 3: sPotion = "nw_it_mpotion009";  break;
                case 4: sPotion = "nw_it_mpotion005";  break;
            }

        }
        else if (GetRange(2, nHD))
        {
           int nRandom = Random(20) + 1;
            switch (nRandom)
            {
                case 1: case 2: case 3: case 4: case 5: sPotion = "nw_it_mpotion020";  break;
                case 6: sPotion = "nw_it_mpotion009";  break;
                case 7: sPotion = "nw_it_mpotion005";  break;
                case 8: sPotion = "nw_it_mpotion007";  break;
                case 9: sPotion = "nw_it_mpotion008";  break;
                case 10: sPotion = "nw_it_mpotion010";  break;
                case 11: sPotion = "nw_it_mpotion011";  break;
                case 12: sPotion = "nw_it_mpotion013";  break;
                case 13: sPotion = "nw_it_mpotion014";  break;
                case 14: sPotion = "nw_it_mpotion015";  break;
                case 15: sPotion = "nw_it_mpotion016";  break;
                case 16: sPotion = "nw_it_mpotion017";  break;
                case 17: sPotion = "nw_it_mpotion018";  break;
                case 18: sPotion = "nw_it_mpotion019";  break;
                case 19: sPotion = "nw_it_mpotion004";  break;
                case 20: sPotion = "nw_it_mpotion006";  break;
            }
        }
        else if (GetRange(3, nHD))
        {
           int nRandom = Random(20) + 1;
            switch (nRandom)
            {
                case 1: case 2: case 3: case 4: case 5: sPotion = "nw_it_mpotion002";  break;
                case 6: sPotion = "nw_it_mpotion009";  break;
                case 7: sPotion = "nw_it_mpotion005";  break;
                case 8: sPotion = "nw_it_mpotion007";  break;
                case 9: sPotion = "nw_it_mpotion008";  break;
                case 10: sPotion = "nw_it_mpotion010";  break;
                case 11: sPotion = "nw_it_mpotion011";  break;
                case 12: sPotion = "nw_it_mpotion013";  break;
                case 13: sPotion = "nw_it_mpotion014";  break;
                case 14: sPotion = "nw_it_mpotion015";  break;
                case 15: sPotion = "nw_it_mpotion016";  break;
                case 16: sPotion = "nw_it_mpotion017";  break;
                case 17: sPotion = "nw_it_mpotion018";  break;
                case 18: sPotion = "nw_it_mpotion019";  break;
                case 19: sPotion = "nw_it_mpotion004";  break;
                case 20: sPotion = "nw_it_mpotion006";  break;
            }
        }
        else // Range 4+ all the same.
        {
           int nRandom = Random(20) + 1;
            switch (nRandom)
            {
                case 1: case 2: case 3: case 4: case 5: sPotion = "nw_it_mpotion003"; break;
                case 6: sPotion = "nw_it_mpotion009";  break;
                case 7: sPotion = "nw_it_mpotion005";  break;
                case 8: sPotion = "nw_it_mpotion007";  break;
                case 9: sPotion = "nw_it_mpotion008";  break;
                case 10: sPotion = "nw_it_mpotion010";  break;
                case 11: sPotion = "nw_it_mpotion011";  break;
                case 12: sPotion = "nw_it_mpotion013";  break;
                case 13: sPotion = "nw_it_mpotion014";  break;
                case 14: sPotion = "nw_it_mpotion015";  break;
                case 15: sPotion = "nw_it_mpotion016";  break;
                case 16: sPotion = "nw_it_mpotion017";  break;
                case 17: sPotion = "nw_it_mpotion018";  break;
                case 18: sPotion = "nw_it_mpotion019";  break;
                case 19: sPotion = "nw_it_mpotion004";  break;
                case 20: sPotion = "nw_it_mpotion006";  break;
            }
        }

        dbSpeak("Create Potion");
        return dbCreateItemOnObject(sPotion, oTarget, oAdventurer);
    }
    
    //::///////////////////////////////////////////////
    //:: CreateTable2GenericItem
    //:: Copyright (c) 2002 Bioware Corp.
    //:://////////////////////////////////////////////
    /*
        Creates an item based upon the class of
        oAdventurer
    */
    //:://////////////////////////////////////////////
    //:: Created By:  Brent
    //:: Created On:
    //:://////////////////////////////////////////////
        object CreateGenericMiscItem(object oTarget, object oAdventurer, int nModifier=0)
        {
            int nHD = GetHitDice(oAdventurer) + nModifier;
            string sItem = "";
            if (GetRange(1, nHD))    // * 200
            {
                int nRandom = Random(9) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "nw_it_mglove004"; break;
                 case 2: sItem = "nw_it_mglove004"; break;
                 case 3: sItem = "nw_it_mglove005"; break;
                 case 4: sItem = "nw_it_mglove006"; break;
                 case 5: sItem = "nw_it_mglove007"; break;
                 case 6: sItem = "nw_it_mglove008"; break;
                 case 7: sItem = "nw_it_mglove009"; break;
                 case 8: sItem = "nw_mcloth006"; break;
                 case 9: sItem = "nw_it_mglove012"; break;
                }
            }
            else if (GetRange(2, nHD))   // * 800
            {
                int nRandom = Random(25) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "nw_mcloth006"; break;
                 case 2: sItem = "nw_it_mring009"; break;
                 case 3: sItem = "nw_it_mring009"; break;
                 case 4: sItem = "nw_it_mring010"; break;
                 case 5: sItem = "nw_it_mring011"; break;
                 case 6: sItem = "nw_it_mboots010"; break;
                 case 7: sItem = "nw_it_mneck024"; break;
                 case 8: sItem = "nw_mcloth007"; break;
                 case 9: sItem = "nw_it_mring024"; break;
                 case 10: sItem = "nw_it_mring012"; break;
                 case 11: sItem = "nw_mcloth008"; break;
                 case 12: sItem = "nw_it_mglove010"; break;
                 case 13: sItem = "nw_it_mglove011"; break;
                 case 14: sItem = "nw_it_mglove013"; break;
                 case 15: sItem = "nw_it_mglove014"; break;
                 case 16: sItem = "nw_it_mglove015"; break;
                 case 17: sItem = "nw_maarcl097"; break;
                 case 18: sItem = "nw_maarcl097"; break;
                 case 19: sItem = "nw_maarcl099"; break;
                 case 20: sItem = "nw_it_mneck032"; break;
                 case 21: sItem = "nw_mcloth010"; break;
                 case 22: sItem = "nw_it_mbracer002"; break;
                 case 23: sItem = "nw_it_mneck001"; break;
                 case 24: sItem = "nw_maarcl055"; break;
                 case 25: sItem = "nw_mcloth009"; break;
                }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                int nRandom = Random(44) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "nw_it_mring009"; break;
                 case 2: sItem = "nw_it_mring009"; break;
                 case 3: sItem = "nw_it_mring010"; break;
                 case 4: sItem = "nw_it_mring011"; break;
                 case 5: sItem = "nw_it_mboots010"; break;
                 case 6: sItem = "nw_it_mneck024"; break;
                 case 7: sItem = "nw_mcloth007"; break;
                 case 8: sItem = "nw_it_mring024"; break;
                 case 9: sItem = "nw_it_mring012"; break;
                 case 10: sItem = "nw_mcloth008"; break;
                 case 11: sItem = "nw_it_mglove010"; break;
                 case 12: sItem = "nw_it_mglove011"; break;
                 case 13: sItem = "nw_it_mglove013"; break;
                 case 14: sItem = "nw_it_mglove014"; break;
                 case 15: sItem = "nw_it_mglove015"; break;
                 case 16: sItem = "nw_it_contain003"; break;
                 case 17: sItem = "nw_maarcl097"; break;
                 case 18: sItem = "nw_maarcl099"; break;
                 case 19: sItem = "nw_it_mneck032"; break;
                 case 20: sItem = "nw_mcloth010"; break;
                 case 21: sItem = "nw_it_mbracer002"; break;
                 case 22: sItem = "nw_it_mneck001"; break;
                 case 23: sItem = "nw_maarcl055"; break;
                 case 24: sItem = "nw_mcloth009"; break;
                 case 25: sItem = "nw_it_mring001"; break;
                 case 26: sItem = "nw_it_mboots001"; break;
                 case 27: sItem = "nw_it_mbracer001"; break;
                 case 28: sItem = "nw_it_mneck007"; break;
                 case 29: sItem = "nw_maarcl096"; break;
                 case 30: sItem = "nw_it_mglove003"; break;
                 case 31: sItem = "nw_it_contain004"; break;
                 case 32: sItem = "nw_it_mneck031"; break;
                 case 33: sItem = "nw_it_mring006"; break;
                 case 34: sItem = "nw_it_mneck006"; break;
                 case 35: sItem = "nw_it_mneck029"; break;
                 case 36: sItem = "nw_it_mring013"; break;
                 case 37: sItem = "nw_it_mboots011"; break;
                 case 38: sItem = "nw_it_mneck025"; break;
                 case 39: sItem = "nw_it_mbelt009"; break;
                 case 40: sItem = "nw_it_mbelt010"; break;
                 case 41: sItem = "nw_it_mbelt011"; break;
                 case 42: sItem = "nw_it_mring025"; break;
                 case 43: sItem = "nw_it_mring025"; break;
                 case 44: sItem = "nw_maarcl031"; break;

                }

            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                int nRandom = Random(48) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "nw_it_mring001"; break;
                 case 2: sItem = "nw_it_mboots001"; break;
                 case 3: sItem = "nw_it_mbracer001"; break;
                 case 4: sItem = "nw_it_mneck007"; break;
                 case 5: sItem = "nw_maarcl096"; break;
                 case 6: sItem = "nw_it_mglove003"; break;
                 case 7: sItem = "nw_it_mneck031"; break;
                 case 8: sItem = "nw_it_mneck031"; break;
                 case 9: sItem = "nw_it_mring006"; break;
                 case 10: sItem = "nw_it_mneck006"; break;
                 case 11: sItem = "nw_it_mneck029"; break;
                 case 12: sItem = "nw_it_mring013"; break;
                 case 13: sItem = "nw_it_mboots011"; break;
                 case 14: sItem = "nw_it_mneck025"; break;
                 case 15: sItem = "nw_it_mbelt009"; break;
                 case 16: sItem = "nw_it_mbelt010"; break;
                 case 17: sItem = "nw_it_mbelt011"; break;
                 case 18: sItem = "nw_it_mring025"; break;
                 case 19: sItem = "nw_it_mring025"; break;
                 case 20: sItem = "nw_it_mbracer007"; break;
                 case 21: sItem = "nw_it_mbracer007"; break;
                 case 22: sItem = "nw_it_mneck012"; break;
                 case 23: sItem = "nw_maarcl088"; break;
                 case 24: sItem = "nw_it_mboots012"; break;
                 case 25: sItem = "nw_it_mneck026"; break;
                 case 26: sItem = "nw_it_mboots006"; break;
                 case 27: sItem = "nw_it_mbracer003"; break;
                 case 28: sItem = "nw_it_mneck008"; break;
                 case 29: sItem = "nw_it_mring008"; break;
                 case 30: sItem = "nw_maarcl056"; break;
                 case 31: sItem = "nw_maarcl092"; break;
                 case 32: sItem = "nw_it_mring014"; break;
                 case 33: sItem = "nw_it_mneck016"; break;
                 case 34: sItem = "nw_it_mboots013"; break;
                 case 35: sItem = "nw_it_mneck027"; break;
                 case 36: sItem = "nw_it_mbracer008"; break;
                 case 37: sItem = "nw_it_mneck013"; break;
                 case 38: sItem = "nw_maarcl089"; break;
                 case 39: sItem = "nw_it_mbelt012"; break;
                 case 40: sItem = "nw_it_mbelt013"; break;
                 case 41: sItem = "nw_it_mbelt014"; break;
                 case 42: sItem = "nw_it_mring027"; break;
                 case 43: sItem = "nw_it_mboots007"; break;
                 case 44: sItem = "nw_it_mbracer004"; break;
                 case 45: sItem = "nw_it_mneck009"; break;
                 case 46: sItem = "nw_it_mring018"; break;
                 case 47: sItem = "nw_maarcl093"; break;
                 case 48: sItem = "nw_it_mboots002"; break;

                }
            }
            else if (GetRange(5, nHD))   // * 2500 - 16500
            {
                int nRandom = Random(42) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "nw_it_mbracer007"; break;
                 case 2: sItem = "nw_it_mbracer007"; break;
                 case 3: sItem = "nw_it_mneck012"; break;
                 case 4: sItem = "nw_maarcl088"; break;
                 case 5: sItem = "nw_it_mboots012"; break;
                 case 6: sItem = "nw_it_mneck026"; break;
                 case 7: sItem = "nw_it_mboots006"; break;
                 case 8: sItem = "nw_it_mbracer003"; break;
                 case 9: sItem = "nw_it_mneck008"; break;
                 case 10: sItem = "nw_it_mring008"; break;
                 case 11: sItem = "nw_maarcl056"; break;
                 case 12: sItem = "nw_maarcl092"; break;
                 case 13: sItem = "nw_it_mring014"; break;
                 case 14: sItem = "nw_it_mneck016"; break;
                 case 15: sItem = "nw_it_mboots013"; break;
                 case 16: sItem = "nw_it_mneck027"; break;
                 case 17: sItem = "nw_it_mbracer008"; break;
                 case 18: sItem = "nw_it_mneck013"; break;
                 case 19: sItem = "nw_maarcl089"; break;
                 case 20: sItem = "nw_it_mbelt012"; break;
                 case 21: sItem = "nw_it_mbelt013"; break;
                 case 22: sItem = "nw_it_mbelt014"; break;
                 case 23: sItem = "nw_it_mring027"; break;
                 case 24: sItem = "nw_it_mboots007"; break;
                 case 25: sItem = "nw_it_mbracer004"; break;
                 case 26: sItem = "nw_it_mneck009"; break;
                 case 27: sItem = "nw_it_mring018"; break;
                 case 28: sItem = "nw_maarcl093"; break;
                 case 29: sItem = "nw_it_mboots002"; break;
                 case 30: sItem = "nw_it_mboots014"; break;
                 case 31: sItem = "nw_it_mneck028"; break;
                 case 32: sItem = "nw_it_mring015"; break;
                 case 33: sItem = "nw_it_mbracer009"; break;
                 case 34: sItem = "nw_it_mneck014"; break;
                 case 35: sItem = "nw_maarcl090"; break;
                 case 36: sItem = "nw_it_mring028"; break;
                 case 37: sItem = "nw_it_mneck017"; break;
                 case 38: sItem = "nw_it_mboots008"; break;
                 case 39: sItem = "nw_it_mbracer005"; break;
                 case 40: sItem = "nw_it_mneck010"; break;
                 case 41: sItem = "nw_it_mmidmisc02"; break;
                 case 42: sItem = "nw_it_mring019"; break;
                }
            }
            else if (GetRange(6, nHD))   // * 8000 - 25000
            {
                int nRandom = Random(30) + 1;
                switch (nRandom)
                {
                 case 1: sItem = "nw_it_mring027"; break;
                 case 2: sItem = "nw_it_mboots007"; break;
                 case 3: sItem = "nw_it_mbracer004"; break;
                 case 4: sItem = "nw_it_mneck009"; break;
                 case 5: sItem = "nw_it_mring018"; break;
                 case 6: sItem = "nw_maarcl093"; break;
                 case 7: sItem = "nw_it_mboots002"; break;
                 case 8: sItem = "nw_it_mboots014"; break;
                 case 9: sItem = "nw_it_mneck028"; break;
                 case 10: sItem = "nw_it_mring015"; break;
                 case 11: sItem = "nw_it_mbracer009"; break;
                 case 12: sItem = "nw_it_mneck014"; break;
                 case 13: sItem = "nw_maarcl090"; break;
                 case 14: sItem = "nw_it_mring028"; break;
                 case 15: sItem = "nw_it_mneck017"; break;
                 case 16: sItem = "nw_it_mboots008"; break;
                 case 17: sItem = "nw_it_mbracer005"; break;
                 case 18: sItem = "nw_it_mneck010"; break;
                 case 19: sItem = "nw_it_mmidmisc02"; break;
                 case 20: sItem = "nw_maarcl094"; break;
                 case 21: sItem = "nw_it_mring019"; break;
                 case 22: sItem = "nw_it_mring016"; break;
                 case 23: sItem = "nw_it_mbracer010"; break;
                 case 24: sItem = "nw_it_mneck015"; break;
                 case 25: sItem = "nw_maarcl091"; break;
                 case 26: sItem = "nw_it_mboots009"; break;
                 case 27: sItem = "nw_it_mbracer006"; break;
                 case 28: sItem = "nw_it_mneck011"; break;
                 case 29: sItem = "nw_maarcl095"; break;
                 case 30: sItem = "nw_it_mneck018"; break;
                }
             }
             dbSpeak("Create Misc");

             return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
         }

         // * this function just returns an item that is more appropriate
         // * for this class. Only wizards, sorcerers, clerics, monks, rogues and bards get this
        object CreateGenericClassItem(object oTarget, object oAdventurer, int nSpecific =0)
        {
            if (GetLevelByClass(CLASS_TYPE_DRUID, oAdventurer)>= 1)
            {
                if (nSpecific == 0)
                {
                    return CreateGenericDruidWeapon(oTarget, oAdventurer);
                }
                else
                {
                    return CreateSpecificDruidWeapon(oTarget, oAdventurer);
                }
            }
            else
            if (GetLevelByClass(CLASS_TYPE_WIZARD, oAdventurer)>= 1 || GetLevelByClass(CLASS_TYPE_SORCERER, oAdventurer) >= 1)
            {
                // * 30% chance of getting a magic scroll else get a weapon suited for a wizard
                if (Random(100) + 1 > 70)
                {
                    // * grab an arcane scroll as if the wizard had +4 levels
                    return CreateArcaneScroll(oTarget, oAdventurer, 4);
                }
                else
                if (nSpecific == 0)
                {
                    return CreateGenericWizardWeapon(oTarget, oAdventurer);
                }
                else
                {
                    return CreateSpecificWizardWeapon(oTarget, oAdventurer);
                }
            }
            else
            if (GetLevelByClass(CLASS_TYPE_CLERIC, oAdventurer)>= 1)
            {
                  int nRandom = Random(4) + 1;
                  string sItem = "nw_it_medkit001";
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_it_medkit001"; break;
                       case 2: sItem = "nw_it_medkit002"; break;
                       case 3: sItem = "nw_it_medkit003"; break;
                       case 4: sItem = "nw_it_medkit004"; break;
                   }
                  return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
            }
            else
            if (GetLevelByClass(CLASS_TYPE_MONK, oAdventurer)>= 1)
            {
                dbSpeak("in monk function");
                if (nSpecific == 0)
                {
                    return CreateGenericMonkWeapon(oTarget, oAdventurer);
                }
                else
                {
                    return CreateSpecificMonkWeapon(oTarget, oAdventurer);
                }
            }
            else
            if (GetLevelByClass(CLASS_TYPE_ROGUE, oAdventurer)>= 1)
            {
                // * give a misc item as if a couple levels higher
                return CreateGenericMiscItem(oTarget, oAdventurer, 2);
            }
            else
            if (GetLevelByClass(CLASS_TYPE_BARD, oAdventurer)>= 1)
            {
                // * give a misc item as if a couple levels higher
                return CreateGenericMiscItem(oTarget, oAdventurer, 2);
            }

            return OBJECT_INVALID;
        }

        object CreateGenericRodStaffWand(object oTarget, object oAdventurer, int nModifier = 0)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                int nRandom = Random(3) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wmgwn013"; break;
                    case 2: sItem = "nw_wmgwn006"; break;
                    case 3: sItem = "nw_it_gem002";  break;  // gem for variety
                }
            }
            else if (GetRange(2, nHD))   // * 800
            {
                int nRandom = Random(3) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wmgwn013"; break;
                    case 2: sItem = "nw_wmgwn006"; break;
                    case 3: sItem = "nw_it_gem002";  break;// gem for variety
                }
            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                int nRandom = Random(4) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wmgwn006"; break;
                    case 2: sItem = "nw_wmgwn004"; break;
                    case 3: sItem = "nw_wmgrd002"; break;
                    case 4: sItem = "nw_wmgwn012"; break;
                }
            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                int nRandom = Random(11) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wmgwn004"; break;
                    case 2: sItem = "nw_wmgwn002"; break;
                    case 3: sItem = "nw_wmgwn007"; break;
                    case 4: sItem = "nw_wmgwn003"; break;
                    case 5: sItem = "nw_wmgwn010"; break;
                    case 6: sItem = "nw_wmgwn011"; break;
                    case 7: sItem = "nw_wmgwn005"; break;
                    case 8: sItem = "nw_wmgwn008"; break;
                    case 9: sItem = "nw_wmgwn009"; break;
                    case 10: sItem = "nw_wmgrd002"; break;
                    case 11: sItem = "nw_wmgwn012"; break;
                }

            }
            else  // * 2500 - 16500
            {
                int nRandom = d8();
                switch (nRandom)
                {
                    case 1: sItem = "nw_wmgwn002"; break;
                    case 2: sItem = "nw_wmgwn007"; break;
                    case 3: sItem = "nw_wmgwn003"; break;
                    case 4: sItem = "nw_wmgwn010"; break;
                    case 5: sItem = "nw_wmgwn011"; break;
                    case 6: sItem = "nw_wmgwn005"; break;
                    case 7: sItem = "nw_wmgwn008"; break;
                    case 8: sItem = "nw_wmgwn009"; break;
                }

            }
          dbSpeak("Generic Rod staff wand");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }

        object CreateGenericMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthsh001"; break;
                       case 2: sItem = "nw_wblcl001"; break;
                       case 3: sItem = "nw_wdbqs001"; break;
                       case 4: sItem = "nw_wbwsl001"; break;
                       case 5: sItem = "nw_wswdg001"; break;
                       case 6: sItem = "nw_wspka001"; break;
                       case 7: sItem = "nw_wbwxh001"; break;
                       case 8: sItem = "nw_waxhn001"; break;
                       case 9: sItem = "nw_wbwxl001"; break;
                       case 10: sItem = "nw_wthmsh002"; break;
                   }

            }
            else if (GetRange(2, nHD))   // * 800
            {
                  int nRandom = Random(14) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthsh001"; break;
                       case 2: sItem = "nw_wblcl001"; break;
                       case 3: sItem = "nw_wdbqs001"; break;
                       case 4: sItem = "nw_wbwsl001"; break;
                       case 5: sItem = "nw_wswdg001"; break;
                       case 6: sItem = "nw_wspka001"; break;
                       case 7: sItem = "nw_wbwxh001"; break;
                       case 8: sItem = "nw_waxhn001"; break;
                       case 9: sItem = "nw_wbwxl001"; break;
                       case 10: sItem = "nw_wthmsh002"; break;
                       case 11: sItem = "nw_wbwmsl001"; break;
                       case 12: sItem = "nw_wbwmxh002"; break;
                       case 13: sItem = "nw_wthmsh008"; break;
                       case 14: sItem = "nw_wbwmxl002"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmsl001"; break;
                       case 2: sItem = "nw_wbwmxh002"; break;
                       case 3: sItem = "nw_wthmsh008"; break;
                       case 4: sItem = "nw_wbwmxl002"; break;
                       case 5: sItem = "nw_wthmsh009"; break;
                       case 6: sItem = "nw_wblmcl002"; break;
                       case 7: sItem = "nw_wdbmqs002"; break;
                       case 8: sItem = "nw_wswmdg002"; break;
                       case 9: sItem = "nw_wspmka002"; break;
                       case 10: sItem = "nw_waxmhn002"; break;
                       case 11: sItem = "nw_wbwmsl009"; break;
                       case 12: sItem = "nw_wbwmxh008"; break;
                       case 13: sItem = "nw_wbwmxl008"; break;
                   }


            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmsh009"; break;
                       case 2: sItem = "nw_wblmcl002"; break;
                       case 3: sItem = "nw_wdbmqs002"; break;
                       case 4: sItem = "nw_wswmdg002"; break;
                       case 5: sItem = "nw_wspmka002"; break;
                       case 6: sItem = "nw_waxmhn002"; break;
                       case 7: sItem = "nw_wbwmsl009"; break;
                       case 8: sItem = "nw_wbwmxh008"; break;
                       case 9: sItem = "nw_wbwmxl008"; break;
                       case 10: sItem = "nw_wbwmsl010"; break;
                       case 11: sItem = "nw_wbwmxh009"; break;
                       case 12: sItem = "nw_wbwmxl009"; break;
                       case 13: sItem = "nw_wblmcl010"; break;
                       case 14: sItem = "nw_wdbmqs008"; break;
                       case 15: sItem = "nw_wswmdg008"; break;
                       case 16: sItem = "nw_wspmka008"; break;
                       case 17: sItem = "nw_waxmhn010"; break;
                   }
            }
            else  // * 2500 - 16500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmsl010"; break;
                       case 2: sItem = "nw_wbwmxh009"; break;
                       case 3: sItem = "nw_wbwmxl009"; break;
                       case 4: sItem = "nw_wblmcl010"; break;
                       case 5: sItem = "nw_wdbmqs008"; break;
                       case 6: sItem = "nw_wswmdg008"; break;
                       case 7: sItem = "nw_wspmka008"; break;
                       case 8: sItem = "nw_waxmhn010"; break;
                       case 9: sItem = "nw_wblmcl011"; break;
                       case 10: sItem = "nw_wdbmqs009"; break;
                       case 11: sItem = "nw_wswmdg009"; break;
                       case 12: sItem = "nw_wspmka009"; break;
                       case 13: sItem = "nw_waxmhn011"; break;
                   }
            }
          dbSpeak("Generic Monk Weapon");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        object CreateSpecificMonkWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {

            string sItem = "";
            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 800
            {
                  int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmsh003"; break;
                       case 2: sItem = "nw_wthmsh006"; break;
                       case 3: return CreateGenericMonkWeapon(oTarget, oAdventurer, JUMP_LEVEL);
                  }

            }
            else if (GetRange(2, nHD))   // * 2500
            {
                  int nRandom = Random(8) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmsh003"; break;
                       case 2: sItem = "nw_wthmsh006"; break;
                       case 3: sItem = "nw_wthmsh004"; break;
                       case 4: sItem = "nw_wthmsh007"; break;
                       case 5: sItem = "NW_IT_MGLOVE016"; break;
                       case 6: sItem = "NW_IT_MGLOVE021"; break;
                       case 7: sItem = "NW_IT_MGLOVE026"; break;
                       case 8: return CreateGenericMonkWeapon(oTarget, oAdventurer, JUMP_LEVEL);
                   }

            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(21) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmsh006"; break;
                       case 2: sItem = "nw_wthmsh004"; break;
                       case 3: sItem = "nw_wthmsh007"; break;
                       case 4: sItem = "nw_wbwmsl005"; break;
                       case 5: sItem = "nw_wbwmxh005"; break;
                       case 6: sItem = "nw_wspmka004"; break;
                       case 7: sItem = "nw_wbwmxl005"; break;
                       case 8: sItem = "nw_wspmka007"; break;
                       case 9: sItem = "nw_wswmdg006"; break;
                       case 10: sItem = "nw_wspmka005"; break;
                       case 11: sItem = "NW_IT_MGLOVE016"; break;
                       case 12: sItem = "NW_IT_MGLOVE021"; break;
                       case 13: sItem = "NW_IT_MGLOVE026"; break;

                       case 14: sItem = "NW_IT_MGLOVE017"; break;
                       case 15: sItem = "NW_IT_MGLOVE022"; break;
                       case 16: sItem = "NW_IT_MGLOVE027"; break;

                       case 17: sItem = "NW_IT_MGLOVE018"; break;
                       case 18: sItem = "NW_IT_MGLOVE023"; break;
                       case 19: sItem = "NW_IT_MGLOVE028"; break;

                       case 20: sItem = "NW_IT_MGLOVE029"; break;
                       case 21: sItem = "NW_IT_MGLOVE030"; break;


                   }

            }
            else if (GetRange(4, nHD))   // * 2500 -16500
            {
                  int nRandom = Random(22) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmsl005"; break;
                       case 2: sItem = "nw_wbwmxh005"; break;
                       case 3: sItem = "nw_wspmka004"; break;
                       case 4: sItem = "nw_wbwmxl005"; break;
                       case 5: sItem = "nw_wspmka007"; break;
                       case 6: sItem = "nw_wswmdg006"; break;
                       case 7: sItem = "nw_wspmka005"; break;
                       case 8: sItem = "nw_wblmcl004"; break;
                       case 9: sItem = "nw_wblmcl003"; break;
                       case 10: sItem = "nw_wbwmsl003"; break;
                       case 11: sItem = "nw_wbwmxh003"; break;
                       case 12: sItem = "nw_waxmhn004"; break;
                       case 13: sItem = "nw_wbwmxl003"; break;

                       case 14: sItem = "NW_IT_MGLOVE017"; break;
                       case 15: sItem = "NW_IT_MGLOVE022"; break;

                       case 16: sItem = "NW_IT_MGLOVE018"; break;
                       case 17: sItem = "NW_IT_MGLOVE023"; break;
                       case 18: sItem = "NW_IT_MGLOVE028"; break;

                       case 19: sItem = "NW_IT_MGLOVE029"; break;
                       case 20: sItem = "NW_IT_MGLOVE030"; break;

                       case 21: sItem = "NW_IT_MGLOVE019"; break;
                       case 22: sItem = "NW_IT_MGLOVE024"; break;


                   }

            }
            else  // * 16000 +
            {
                  int nRandom = Random(24) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmxl003"; break;
                       case 2: sItem = "nw_wspmka006"; break;
                       case 3: sItem = "nw_wbwmxl004"; break;
                       case 4: sItem = "nw_wspmka003"; break;
                       case 5: sItem = "nw_wbwmxl007"; break;
                       case 6: sItem = "nw_waxmhn003"; break;
                       case 7: sItem = "nw_wblmcl005"; break;
                       case 8: sItem = "nw_wswmdg004"; break;
                       case 9: sItem = "nw_wbwmsl007"; break;
                       case 10: sItem = "nw_wbwmxh004"; break;
                       case 11: sItem = "nw_waxmhn005"; break;
                       case 12: sItem = "nw_wbwmxh007"; break;
                       case 13: sItem = "nw_wswmdg003"; break;
                       case 14: sItem = "nw_wswmdg007"; break;
                       case 15: sItem = "nw_wbwmsl006"; break;
                       case 16: sItem = "nw_wbwmsl008"; break;
                       case 17: sItem = "nw_wblmcl006"; break;
                       case 18: sItem = "nw_wbwmsl004"; break;
                       case 19: sItem = "nw_waxmhn006"; break;
                       case 20: sItem = "nw_wbwmxh006"; break;
                       case 21: sItem = "nw_wswmdg005"; break;
                       case 22: sItem = "nw_wbwmxl006"; break;

                       case 23: sItem = "NW_IT_MGLOVE020"; break;
                       case 24: sItem = "NW_IT_MGLOVE025"; break;

                   }

            }
           dbSpeak("Specific Monk Weapon");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }

        object CreateGenericDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                  int nRandom = Random(8) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthdt001"; break;
                       case 2: sItem = "nw_wblcl001"; break;
                       case 3: sItem = "nw_wdbqs001"; break;
                       case 4: sItem = "nw_wplss001"; break;
                       case 5: sItem = "nw_wswdg001"; break;
                       case 6: sItem = "nw_wspsc001"; break;
                       case 7: sItem = "nw_wswsc001"; break;
                       case 8: sItem = "nw_wthmdt002"; break;
                   }
            }
            else if (GetRange(2, nHD))   // * 800
            {
                  int nRandom = Random(11) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthdt001"; break;
                       case 2: sItem = "nw_wblcl001"; break;
                       case 3: sItem = "nw_wdbqs001"; break;
                       case 4: sItem = "nw_wplss001"; break;
                       case 5: sItem = "nw_wswdg001"; break;
                       case 6: sItem = "nw_wspsc001"; break;
                       case 7: sItem = "nw_wswsc001"; break;
                       case 8: sItem = "nw_wthmdt002"; break;
                       case 9: sItem = "nw_wthmdt005"; break;
                       case 10: sItem = "nw_wbwmsl001"; break;
                       case 11: sItem = "nw_wthmdt008"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmdt005"; break;
                       case 2: sItem = "nw_wbwmsl001"; break;
                       case 3: sItem = "nw_wthmdt008"; break;
                       case 4: sItem = "nw_wthmdt009"; break;
                       case 5: sItem = "nw_wthmdt006"; break;
                       case 6: sItem = "nw_wblmcl002"; break;
                       case 7: sItem = "nw_wdbmqs002"; break;
                       case 8: sItem = "nw_wplmss002"; break;
                       case 9: sItem = "nw_wswmdg002"; break;
                       case 10: sItem = "nw_wspmsc002"; break;
                       case 11: sItem = "nw_wswmsc002"; break;
                       case 12: sItem = "nw_wthmdt003"; break;
                       case 13: sItem = "nw_wbwmsl009"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(19) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmdt009"; break;
                       case 2: sItem = "nw_wthmdt006"; break;
                       case 3: sItem = "nw_wblmcl002"; break;
                       case 4: sItem = "nw_wdbmqs002"; break;
                       case 5: sItem = "nw_wplmss002"; break;
                       case 6: sItem = "nw_wswmdg002"; break;
                       case 7: sItem = "nw_wspmsc002"; break;
                       case 8: sItem = "nw_wswmsc002"; break;
                       case 9: sItem = "nw_wthmdt003"; break;
                       case 10: sItem = "nw_wbwmsl009"; break;
                       case 11: sItem = "nw_wthmdt007"; break;
                       case 12: sItem = "nw_wthmdt004"; break;
                       case 13: sItem = "nw_wbwmsl010"; break;
                       case 14: sItem = "nw_wblmcl010"; break;
                       case 15: sItem = "nw_wdbmqs008"; break;
                       case 16: sItem = "nw_wplmss010"; break;
                       case 17: sItem = "nw_wswmdg008"; break;
                       case 18: sItem = "nw_wspmsc010"; break;
                       case 19: sItem = "nw_wswmsc010"; break;
                   }

            }
            else  // * 2500 - 16500
            {
                  int nRandom = Random(15) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmdt007"; break;
                       case 2: sItem = "nw_wthmdt004"; break;
                       case 3: sItem = "nw_wbwmsl010"; break;
                       case 4: sItem = "nw_wblmcl010"; break;
                       case 5: sItem = "nw_wdbmqs008"; break;
                       case 6: sItem = "nw_wplmss010"; break;
                       case 7: sItem = "nw_wswmdg008"; break;
                       case 8: sItem = "nw_wspmsc010"; break;
                       case 9: sItem = "nw_wswmsc010"; break;
                       case 10: sItem = "nw_wblmcl011"; break;
                       case 11: sItem = "nw_wdbmqs009"; break;
                       case 12: sItem = "nw_wplmss011"; break;
                       case 13: sItem = "nw_wswmdg009"; break;
                       case 14: sItem = "nw_wspmsc011"; break;
                       case 15: sItem = "nw_wswmsc011"; break;
                   }

            }
          dbSpeak("Generic Druid weapon");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateSpecificDruidWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {

            string sItem = "";
            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericDruidWeapon(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 2500
            {
                return CreateGenericDruidWeapon(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmqs005"; break;
                       case 2: sItem = "nw_wdbmqs006"; break;
                       case 3: sItem = "nw_wbwmsl005"; break;
                       case 4: sItem = "nw_wswmdg006"; break;
                       case 5: return CreateGenericDruidWeapon(oTarget, oAdventurer, JUMP_LEVEL);
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 -16500
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmqs005"; break;
                       case 2: sItem = "nw_wdbmqs006"; break;
                       case 3: sItem = "nw_wbwmsl005"; break;
                       case 4: sItem = "nw_wswmdg006"; break;
                       case 5: sItem = "nw_wblmcl004"; break;
                       case 6: sItem = "nw_wdbmqs004"; break;
                       case 7: sItem = "nw_wblmcl003"; break;
                       case 8: sItem = "nw_wbwmsl003"; break;
                       case 9: sItem = "nw_wswmsc004"; break;
                       case 10: sItem = "nw_wplmss005"; break;
                   }

            }
            else  // * 16000 +
            {
                  int nRandom = Random(18) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmqs003"; break;
                       case 2: sItem = "nw_wblmcl005"; break;
                       case 3: sItem = "nw_wplmss007"; break;
                       case 4: sItem = "nw_wswmdg004"; break;
                       case 5: sItem = "nw_wbwmsl007"; break;
                       case 6: sItem = "nw_wplmss006"; break;
                       case 7: sItem = "nw_wswmsc006"; break;
                       case 8: sItem = "nw_wswmdg003"; break;
                       case 9: sItem = "nw_wswmdg007"; break;
                       case 10: sItem = "nw_wswmsc007"; break;
                       case 11: sItem = "nw_wbwmsl006"; break;
                       case 12: sItem = "nw_wbwmsl008"; break;
                       case 13: sItem = "nw_wdbmqs007"; break;
                       case 14: sItem = "nw_wblmcl006"; break;
                       case 15: sItem = "nw_wbwmsl004"; break;
                       case 16: sItem = "nw_wswmsc005"; break;
                       case 17: sItem = "nw_wplmss004"; break;
                       case 18: sItem = "nw_wswmdg005"; break;
                   }

            }
          dbSpeak("specific druid weapon");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }

        object CreateGenericWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblcl001"; break;
                       case 2: sItem = "nw_wdbqs001"; break;
                       case 3: sItem = "nw_wswdg001"; break;
                       case 4: sItem = "nw_wbwxh001"; break;
                       case 5: sItem = "nw_wbwxl001"; break;
                   }

            }
            else if (GetRange(2, nHD))   // * 800
            {
                  int nRandom = Random(6) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblcl001"; break;
                       case 2: sItem = "nw_wdbqs001"; break;
                       case 3: sItem = "nw_wswdg001"; break;
                       case 4: sItem = "nw_wbwxh001"; break;
                       case 5: sItem = "nw_wbwxl001"; break;
                       case 6: sItem = "nw_wbwmxl002"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(6) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmxl002"; break;
                       case 2: sItem = "nw_wblmcl002"; break;
                       case 3: sItem = "nw_wdbmqs002"; break;
                       case 4: sItem = "nw_wswmdg002"; break;
                       case 5: sItem = "nw_wbwmxh008"; break;
                       case 6: sItem = "nw_wbwmxl008"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblmcl002"; break;
                       case 2: sItem = "nw_wdbmqs002"; break;
                       case 3: sItem = "nw_wswmdg002"; break;
                       case 4: sItem = "nw_wbwmxh008"; break;
                       case 5: sItem = "nw_wbwmxl008"; break;
                       case 6: sItem = "nw_wbwmxh009"; break;
                       case 7: sItem = "nw_wbwmxl009"; break;
                       case 8: sItem = "nw_wblmcl010"; break;
                       case 9: sItem = "nw_wdbmqs008"; break;
                       case 10: sItem = "nw_wswmdg008"; break;
                   }

            }
            else  // * 2500 - 16500
            {
                  int nRandom = Random(8) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmxh009"; break;
                       case 2: sItem = "nw_wbwmxl009"; break;
                       case 3: sItem = "nw_wblmcl010"; break;
                       case 4: sItem = "nw_wdbmqs008"; break;
                       case 5: sItem = "nw_wswmdg008"; break;
                       case 6: sItem = "nw_wblmcl011"; break;
                       case 7: sItem = "nw_wdbmqs009"; break;
                       case 8: sItem = "nw_wswmdg009"; break;
                   }

            }
          dbSpeak("Generic Wizard or Sorcerer Weapon");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateSpecificWizardWeapon(object oTarget, object oAdventurer, int nModifier = 0)
        {

            string sItem = "";
            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericWizardWeapon(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 2500
            {
                return CreateGenericWizardWeapon(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmqs005"; break;
                       case 2: sItem = "nw_wdbmqs006"; break;
                       case 3: sItem = "nw_wbwmxh005"; break;
                       case 4: sItem = "nw_wbwmxl005"; break;
                       case 5: sItem = "nw_wswmdg006"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 -16500
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmqs005"; break;
                       case 2: sItem = "nw_wdbmqs006"; break;
                       case 3: sItem = "nw_wbwmxh005"; break;
                       case 4: sItem = "nw_wbwmxl005"; break;
                       case 5: sItem = "nw_wswmdg006"; break;
                       case 6: sItem = "nw_wblmcl004"; break;
                       case 7: sItem = "nw_wdbmqs004"; break;
                       case 8: sItem = "nw_wblmcl003"; break;
                       case 9: sItem = "nw_wbwmxh003"; break;
                       case 10: sItem = "nw_wbwmxl003"; break;
                   }

            }
            else  // * 16000 +
            {
                  int nRandom = Random(15) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmxl003"; break;
                       case 2: sItem = "nw_wdbmqs003"; break;
                       case 3: sItem = "nw_wbwmxl004"; break;
                       case 4: sItem = "nw_wbwmxl007"; break;
                       case 5: sItem = "nw_wblmcl005"; break;
                       case 6: sItem = "nw_wswmdg004"; break;
                       case 7: sItem = "nw_wbwmxh004"; break;
                       case 8: sItem = "nw_wbwmxh007"; break;
                       case 9: sItem = "nw_wswmdg003"; break;
                       case 10: sItem = "nw_wswmdg007"; break;
                       case 11: sItem = "nw_wdbmqs007"; break;
                       case 12: sItem = "nw_wblmcl006"; break;
                       case 13: sItem = "nw_wbwmxh006"; break;
                       case 14: sItem = "nw_wswmdg005"; break;
                       case 15: sItem = "nw_wbwmxl006"; break;
                   }

            }
          dbSpeak("Specific Wizard or Sorcerer Weapon");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }

        object CreateGenericSimple(object oTarget, object oAdventurer, int nModifier = 0)
        {
           string sItem = "";
           int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                int nRandom = d12();
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthdt001"; break;
                    case 2: sItem = "nw_wblcl001"; break;
                    case 3: sItem = "nw_wbwsl001"; break;
                    case 4: sItem = "nw_wplss001"; break;
                    case 5: sItem = "nw_wdbqs001"; break;
                    case 6: sItem = "nw_wswdg001"; break;
                    case 7: sItem = "nw_wblml001"; break;
                    case 8: sItem = "nw_wbwxh001"; break;
                    case 9: sItem = "nw_wspsc001"; break;
                    case 10: sItem = "nw_wblms001"; break;
                    case 11: sItem = "nw_wbwxl001"; break;
                    case 12: sItem = "nw_wthmdt002"; break;
                }

            }
            else if (GetRange(2, nHD))   // * 800
            {
                int nRandom = Random(17) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthdt001"; break;
                    case 2: sItem = "nw_wblcl001"; break;
                    case 3: sItem = "nw_wbwsl001"; break;
                    case 4: sItem = "nw_wplss001"; break;
                    case 5: sItem = "nw_wdbqs001"; break;
                    case 6: sItem = "nw_wswdg001"; break;
                    case 7: sItem = "nw_wblml001"; break;
                    case 8: sItem = "nw_wbwxh001"; break;
                    case 9: sItem = "nw_wspsc001"; break;
                    case 10: sItem = "nw_wblms001"; break;
                    case 11: sItem = "nw_wbwxl001"; break;
                    case 12: sItem = "nw_wthmdt002"; break;
                    case 13: sItem = "nw_wthmdt005"; break;
                    case 14: sItem = "nw_wbwmsl001"; break;
                    case 15: sItem = "nw_wbwmxh002"; break;
                    case 16: sItem = "nw_wthmdt008"; break;
                    case 17: sItem = "nw_wbwmxl002"; break;
                }
            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                int nRandom = Random(19) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthmdt005"; break;
                    case 2: sItem = "nw_wbwmsl001"; break;
                    case 3: sItem = "nw_wbwmxh002"; break;
                    case 4: sItem = "nw_wthmdt008"; break;
                    case 5: sItem = "nw_wbwmxl002"; break;
                    case 6: sItem = "nw_wthmdt009"; break;
                    case 7: sItem = "nw_wthmdt006"; break;
                    case 8: sItem = "nw_wblmcl002"; break;
                    case 9: sItem = "nw_wplmss002"; break;
                    case 10: sItem = "nw_wdbmqs002"; break;
                    case 11: sItem = "nw_wswmdg002"; break;
                    case 12: sItem = "nw_wblmml002"; break;
                    case 13: sItem = "nw_wspmsc002"; break;
                    case 14: sItem = "nw_wblmms002"; break;
                    case 15: sItem = "nw_wthmdt003"; break;
                    case 16: sItem = "nw_wthmdt003"; break;
                    case 17: sItem = "nw_wbwmsl009"; break;
                    case 18: sItem = "nw_wbwmxh008"; break;
                    case 19: sItem = "nw_wbwmxl008"; break;
                }
            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                int nRandom = Random(27) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthmdt009"; break;
                    case 2: sItem = "nw_wthmdt006"; break;
                    case 3: sItem = "nw_wblmcl002"; break;
                    case 4: sItem = "nw_wplmss002"; break;
                    case 5: sItem = "nw_wdbmqs002"; break;
                    case 6: sItem = "nw_wswmdg002"; break;
                    case 7: sItem = "nw_wblmml002"; break;
                    case 8: sItem = "nw_wspmsc002"; break;
                    case 9: sItem = "nw_wblmms002"; break;
                    case 10: sItem = "nw_wthmdt003"; break;
                    case 11: sItem = "nw_wthmdt003"; break;
                    case 12: sItem = "nw_wbwmsl009"; break;
                    case 13: sItem = "nw_wbwmxh008"; break;
                    case 14: sItem = "nw_wbwmxl008"; break;
                    case 15: sItem = "nw_wthmdt007"; break;
                    case 16: sItem = "nw_wthmdt004"; break;
                    case 17: sItem = "nw_wbwmsl010"; break;
                    case 18: sItem = "nw_wbwmxh009"; break;
                    case 19: sItem = "nw_wbwmxl009"; break;
                    case 20: sItem = "nw_wbwmsl005"; break;
                    case 21: sItem = "nw_wblmcl010"; break;
                    case 22: sItem = "nw_wplmss010"; break;
                    case 23: sItem = "nw_wdbmqs008"; break;
                    case 24: sItem = "nw_wswmdg008"; break;
                    case 25: sItem = "nw_wblmml011"; break;
                    case 26: sItem = "nw_wspmsc010"; break;
                    case 27: sItem = "nw_wblmms010"; break;



                }

            }
            else if (GetRange(5, nHD))   // * 2500 - 16500
            {
                int nRandom = Random(23) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthmdt007"; break;
                    case 2: sItem = "nw_wthmdt004"; break;
                    case 3: sItem = "nw_wbwmsl010"; break;
                    case 4: sItem = "nw_wbwmxh009"; break;
                    case 5: sItem = "nw_wbwmxl009"; break;
                    case 6: sItem = "nw_wbwmsl005"; break;
                    case 7: sItem = "nw_wblmcl010"; break;
                    case 8: sItem = "nw_wplmss010"; break;
                    case 9: sItem = "nw_wdbmqs008"; break;
                    case 10: sItem = "nw_wswmdg008"; break;
                    case 11: sItem = "nw_wblmml011"; break;
                    case 12: sItem = "nw_wspmsc010"; break;
                    case 13: sItem = "nw_wblmms010"; break;
                    case 14: sItem = "nw_wblmms010"; break;
                    case 15: sItem = "nw_wblmms010"; break;
                    case 16: sItem = "nw_wblmms010"; break;
                    case 17: sItem = "nw_wblmcl011"; break;
                    case 18: sItem = "nw_wplmss011"; break;
                    case 19: sItem = "nw_wdbmqs009"; break;
                    case 20: sItem = "nw_wswmdg009"; break;
                    case 21: sItem = "nw_wblmml012"; break;
                    case 22: sItem = "nw_wspmsc011"; break;
                    case 23: sItem = "nw_wblmms011"; break;



                }
            }
            else if (GetRange(6, nHD))   // * 8000 - 25000
            {
                int nRandom = Random(7) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wblmcl011"; break;
                    case 2: sItem = "nw_wplmss011"; break;
                    case 3: sItem = "nw_wdbmqs009"; break;
                    case 4: sItem = "nw_wswmdg009"; break;
                    case 5: sItem = "nw_wblmml012"; break;
                    case 6: sItem = "nw_wspmsc011"; break;
                    case 7: sItem = "nw_wblmms011"; break;



                }
            }
            dbSpeak("Create Generic SImple; Specific = " + IntToString(nModifier));

            return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateGenericMartial(object oTarget, object oAdventurer, int nModifier = 0)
        {
           string sItem = "";

            int nHD = GetHitDice(oAdventurer) +nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                int nRandom = Random(17) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthax001"; break;
                    case 2: sItem = "nw_wblhl001"; break;
                    case 3: sItem = "nw_waxhn001"; break;
                    case 4: sItem = "nw_wblfl001"; break;
                    case 5: sItem = "nw_waxbt001"; break;
                    case 6: sItem = "nw_wplhb001"; break;
                    case 7: sItem = "nw_wswss001"; break;
                    case 8: sItem = "nw_wblhw001"; break;
                    case 9: sItem = "nw_wblfh001"; break;
                    case 10: sItem = "nw_wswls001"; break;
                    case 11: sItem = "nw_wswsc001"; break;
                    case 12: sItem = "nw_waxgr001"; break;
                    case 13: sItem = "nw_wswrp001"; break;
                    case 14: sItem = "nw_wbwsh001"; break;
                    case 15: sItem = "nw_wswbs001"; break;
                    case 16: sItem = "nw_wswgs001"; break;
                    case 17: sItem = "nw_wbwln001"; break;
                }

            }
            else if (GetRange(2, nHD))   // * 800
            {
                int nRandom = Random(20) + 1;
                switch (nRandom)
                {
                    case 1: sItem = "nw_wthax001"; break;
                    case 2: sItem = "nw_wblhl001"; break;
                    case 3: sItem = "nw_waxhn001"; break;
                    case 4: sItem = "nw_wblfl001"; break;
                    case 5: sItem = "nw_waxbt001"; break;
                    case 6: sItem = "nw_wplhb001"; break;
                    case 7: sItem = "nw_wswss001"; break;
                    case 8: sItem = "nw_wblhw001"; break;
                    case 9: sItem = "nw_wblfh001"; break;
                    case 10: sItem = "nw_wswls001"; break;
                    case 11: sItem = "nw_wswsc001"; break;
                    case 12: sItem = "nw_waxgr001"; break;
                    case 13: sItem = "nw_wswrp001"; break;
                    case 14: sItem = "nw_wbwsh001"; break;
                    case 15: sItem = "nw_wswbs001"; break;
                    case 16: sItem = "nw_wswgs001"; break;
                    case 17: sItem = "nw_wbwln001"; break;
                    case 18: sItem = "nw_wthmax002"; break;
                    case 19: sItem = "nw_wbwmsh002"; break;
                    case 20: sItem = "nw_wbwmln002"; break;
                }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                int nRandom = Random(20) + 1;
                switch (nRandom)
                {
                         case 1: sItem = "nw_wthmax002"; break;
                         case 2: sItem = "nw_wbwmsh002"; break;
                         case 3: sItem = "nw_wbwmln002"; break;
                         case 4: sItem = "nw_wblmhl002"; break;
                         case 5: sItem = "nw_waxmhn002"; break;
                         case 6: sItem = "nw_wblmfl002"; break;
                         case 7: sItem = "nw_waxmbt002"; break;
                         case 8: sItem = "nw_wplmhb002"; break;
                         case 9: sItem = "nw_wblmhw002"; break;
                         case 10: sItem = "nw_wblmfh002"; break;
                         case 11: sItem = "nw_wswmls002"; break;
                         case 12: sItem = "nw_wswmsc002"; break;
                         case 13: sItem = "nw_waxmgr002"; break;
                         case 14: sItem = "nw_wswmrp002"; break;
                         case 15: sItem = "nw_wswmbs002"; break;
                         case 16: sItem = "nw_wswmgs002"; break;
                         case 17: sItem = "nw_wthmax008"; break;
                         case 18: sItem = "nw_wbwmsh008"; break;
                         case 19: sItem = "nw_wbwmln008"; break;
                         case 20: sItem = "nw_wswmss002"; break;

                 }

            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                int nRandom = Random(33) + 1;
                switch (nRandom)
                {
                     case 1: sItem = "nw_wblmhl002"; break;
                     case 2: sItem = "nw_waxmhn002"; break;
                     case 3: sItem = "nw_wblmfl002"; break;
                     case 4: sItem = "nw_waxmbt002"; break;
                     case 5: sItem = "nw_wplmhb002"; break;
                     case 6: sItem = "nw_wblmhw002"; break;
                     case 7: sItem = "nw_wblmfh002"; break;
                     case 8: sItem = "nw_wswmls002"; break;
                     case 9: sItem = "nw_wswmsc002"; break;
                     case 10: sItem = "nw_waxmgr002"; break;
                     case 11: sItem = "nw_wswmrp002"; break;
                     case 12: sItem = "nw_wswmbs002"; break;
                     case 13: sItem = "nw_wswmgs002"; break;
                     case 14: sItem = "nw_wthmax008"; break;
                     case 15: sItem = "nw_wbwmsh008"; break;
                     case 16: sItem = "nw_wbwmln008"; break;
                     case 17: sItem = "nw_wbwmsh009"; break;
                     case 18: sItem = "nw_wbwmln009"; break;
                     case 19: sItem = "nw_wblmhl010"; break;
                     case 20: sItem = "nw_waxmhn010"; break;
                     case 21: sItem = "nw_wblmfl010"; break;
                     case 22: sItem = "nw_waxmbt010"; break;
                     case 23: sItem = "nw_wplmhb010"; break;
                     case 24: sItem = "nw_wblmhw011"; break;
                     case 25: sItem = "nw_wblmfh010"; break;
                     case 26: sItem = "nw_wswmls010"; break;
                     case 27: sItem = "nw_waxmgr009"; break;
                     case 28: sItem = "nw_wswmbs009"; break;
                     case 29: sItem = "nw_wswmgs011"; break;
                     case 30: sItem = "nw_wswmrp010"; break;
                    case 31: sItem = "nw_wswmsc010"; break;
                    case 32: sItem = "nw_wswmss002"; break;
                    case 33: sItem = "nw_wswmss009"; break;
                 }

            }
            else if (GetRange(5, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(20) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmsh009"; break;
                       case 2: sItem = "nw_wbwmln009"; break;
                       case 3: sItem = "nw_wblmhl010"; break;
                       case 4: sItem = "nw_waxmhn010"; break;
                       case 5: sItem = "nw_wblmfl010"; break;
                       case 6: sItem = "nw_waxmbt010"; break;
                       case 7: sItem = "nw_wplmhb010"; break;
                       case 8: sItem = "nw_wblmhw011"; break;
                       case 9: sItem = "nw_wblmfh010"; break;
                       case 10: sItem = "nw_wswmls010"; break;
                       case 11: sItem = "nw_waxmgr009"; break;
                       case 12: sItem = "nw_wswmbs009"; break;
                       case 13: sItem = "nw_wswmgs011"; break;
                       case 14: sItem = "nw_wthmax009"; break;
                        case 15: sItem = "nw_wswmrp010"; break;
                        case 16: sItem = "nw_wswmrp011"; break;
                        case 17: sItem = "nw_wswmsc010"; break;
                        case 18: sItem = "nw_wswmss009"; break;
                        case 19: sItem = "nw_wswmsc011"; break;
                        case 20: sItem = "nw_wswmss011"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(14) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmax009"; break;
                       case 2: sItem = "nw_waxmhn011"; break;
                       case 3: sItem = "nw_wblmfl011"; break;
                       case 4: sItem = "nw_waxmbt011"; break;
                       case 5: sItem = "nw_wplmhb011"; break;
                       case 6: sItem = "nw_wblmhw012"; break;
                       case 7: sItem = "nw_wblmfh011"; break;
                       case 8: sItem = "nw_wswmls012"; break;
                       case 9: sItem = "nw_waxmgr011"; break;
                       case 10: sItem = "nw_wswmbs010"; break;
                       case 11: sItem = "nw_wswmgs012"; break;
                        case 12: sItem = "nw_wswmrp011"; break;
                        case 13: sItem = "nw_wswmsc011"; break;
                        case 14: sItem = "nw_wswmss011"; break;
                   }

            }

            dbSpeak("Create Generic Martial");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateGenericExotic(object oTarget, object oAdventurer, int nModifier = 0)
        {
            string sItem = "";

            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthsh001"; break;
                       case 2: sItem = "nw_wspka001"; break;
                       case 3: sItem = "nw_wspku001"; break;
                       case 4: sItem = "nw_wplsc001"; break;
                       case 5: sItem = "nw_wdbax001"; break;
                       case 6: sItem = "nw_wdbma001"; break;
                       case 7: sItem = "nw_wswka001"; break;
                       case 8: sItem = "nw_wthmsh002"; break;
                       case 9: sItem = "nw_wdbsw001"; break;
                   }

            }
            else if (GetRange(2, nHD))   // * 800
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthsh001"; break;
                       case 2: sItem = "nw_wspka001"; break;
                       case 3: sItem = "nw_wspku001"; break;
                       case 4: sItem = "nw_wplsc001"; break;
                       case 5: sItem = "nw_wdbax001"; break;
                       case 6: sItem = "nw_wdbma001"; break;
                       case 7: sItem = "nw_wswka001"; break;
                       case 8: sItem = "nw_wthmsh002"; break;
                       case 9: sItem = "nw_wdbsw001"; break;
                       case 10: sItem = "nw_wthmsh005"; break;
                       case 11: sItem = "nw_wspmka002"; break;
                       case 12: sItem = "nw_wspmku002"; break;
                       case 13: sItem = "nw_wplmsc002"; break;
                       case 14: sItem = "nw_wdbmax002"; break;
                       case 15: sItem = "nw_wdbmma002"; break;
                       case 16: sItem = "nw_wswmka002"; break;
                       case 17: sItem = "nw_wdbmsw002"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbsw001"; break;
                       case 2: sItem = "nw_wthmsh005"; break;
                       case 3: sItem = "nw_wspmka002"; break;
                       case 4: sItem = "nw_wspmku002"; break;
                       case 5: sItem = "nw_wplmsc002"; break;
                       case 6: sItem = "nw_wdbmax002"; break;
                       case 7: sItem = "nw_wdbmma002"; break;
                       case 8: sItem = "nw_wswmka002"; break;
                       case 9: sItem = "nw_wdbmsw002"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmsh005"; break;
                       case 2: sItem = "nw_wspmka002"; break;
                       case 3: sItem = "nw_wspmku002"; break;
                       case 4: sItem = "nw_wplmsc002"; break;
                       case 5: sItem = "nw_wdbmax002"; break;
                       case 6: sItem = "nw_wdbmma002"; break;
                       case 7: sItem = "nw_wswmka002"; break;
                       case 8: sItem = "nw_wdbmsw002"; break;
                       case 9: sItem = "nw_wthmsh008"; break;
                       case 10: sItem = "nw_wspmka008"; break;
                       case 11: sItem = "nw_wspmku008"; break;
                       case 12: sItem = "nw_wplmsc010"; break;
                       case 13: sItem = "nw_wdbmax010"; break;
                       case 14: sItem = "nw_wdbmma010"; break;
                       case 15: sItem = "nw_wswmka010"; break;
                       case 16: sItem = "nw_wdbmsw010"; break;
                       case 17: sItem = "nw_wthmsh009"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wspmka008"; break;
                       case 2: sItem = "nw_wspmku008"; break;
                       case 3: sItem = "nw_wplmsc010"; break;
                       case 4: sItem = "nw_wdbmax010"; break;
                       case 5: sItem = "nw_wdbmma010"; break;
                       case 6: sItem = "nw_wswmka010"; break;
                       case 7: sItem = "nw_wdbmsw010"; break;
                       case 8: sItem = "nw_wthmsh009"; break;
                       case 9: sItem = "nw_wspmka009"; break;
                       case 10: sItem = "nw_wspmku009"; break;
                       case 11: sItem = "nw_wplmsc011"; break;
                       case 12: sItem = "nw_wdbmax011"; break;
                       case 13: sItem = "nw_wdbmma011"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 8000 - 25000
            {
            int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmsw010"; break;
                       case 2: sItem = "nw_wthmsh009"; break;
                       case 3: sItem = "nw_wspmka009"; break;
                       case 4: sItem = "nw_wspmku009"; break;
                       case 5: sItem = "nw_wplmsc011"; break;
                       case 6: sItem = "nw_wdbmax011"; break;
                       case 7: sItem = "nw_wdbmma011"; break;
                       case 8: sItem = "nw_wswmka011"; break;
                       case 9: sItem = "nw_wdbmsw011"; break;
                   }

            }
                  dbSpeak("Create generic exotic");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateGenericLightArmor(object oTarget, object oAdventurer, int nModifier = 0)
        {
            string sItem = "";

            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_aarcl009"; break;
                       case 2: sItem = "nw_ashsw001"; break;
                       case 3: sItem = "nw_aarcl001"; break;
                       case 4: sItem = "nw_aarcl002"; break;
                       case 5: sItem = "nw_aarcl012"; break;
                   }

            }
            else if (GetRange(2, nHD))   // * 800
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_aarcl009"; break;
                       case 2: sItem = "nw_ashsw001"; break;
                       case 3: sItem = "nw_aarcl001"; break;
                       case 4: sItem = "nw_aarcl002"; break;
                       case 5: sItem = "nw_aarcl012"; break;
                       case 6: sItem = "nw_maarcl043"; break;
                       case 7: sItem = "nw_ashmsw002"; break;
                       case 8: sItem = "nw_maarcl044"; break;
                       case 9: sItem = "nw_maarcl045"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(8) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl043"; break;
                       case 2: sItem = "nw_ashmsw002"; break;
                       case 3: sItem = "nw_maarcl044"; break;
                       case 4: sItem = "nw_maarcl045"; break;
                       case 5: sItem = "nw_maarcl072"; break;
                       case 6: sItem = "nw_ashmsw008"; break;
                       case 7: sItem = "nw_maarcl071"; break;
                       case 8: sItem = "nw_maarcl075"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl072"; break;
                       case 2: sItem = "nw_ashmsw008"; break;
                       case 3: sItem = "nw_maarcl071"; break;
                       case 4: sItem = "nw_maarcl075"; break;
                       case 5: sItem = "nw_maarcl084"; break;
                       case 6: sItem = "nw_ashmsw009"; break;
                       case 7: sItem = "nw_maarcl083"; break;
                       case 8: sItem = "nw_maarcl087"; break;
                       case 9: sItem = "nw_maarcl079"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl084"; break;
                       case 2: sItem = "nw_ashmsw009"; break;
                       case 3: sItem = "nw_maarcl083"; break;
                       case 4: sItem = "nw_maarcl087"; break;
                       case 5: sItem = "nw_maarcl079"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl084"; break;
                       case 2: sItem = "nw_ashmsw009"; break;
                       case 3: sItem = "nw_maarcl083"; break;
                       case 4: sItem = "nw_maarcl087"; break;
                       case 5: sItem = "nw_maarcl079"; break;
                   }

            }
                  dbSpeak("Create Generic light");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateGenericMediumArmor(object oTarget, object oAdventurer, int nModifier = 0)
        {
            int nHD = GetHitDice(oAdventurer) + nModifier;
            string sItem = "";
            if (GetRange(1, nHD))    // * 200
            {
                 int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_arhe001"; break;
                       case 2: sItem = "nw_arhe002"; break;
                       case 3: sItem = "nw_arhe003"; break;
                       case 4: sItem = "nw_arhe004"; break;
                       case 5: sItem = "nw_arhe005"; break;
                       case 6: sItem = "nw_aarcl008"; break;
                       case 7: sItem = "nw_ashlw001"; break;
                       case 8: sItem = "nw_aarcl003"; break;
                       case 9: sItem = "nw_aarcl004"; break;
                       case 10: sItem = "nw_aarcl010"; break;
                   }
            }
            else if (GetRange(2, nHD))   // * 800
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_arhe001"; break;
                       case 2: sItem = "nw_arhe002"; break;
                       case 3: sItem = "nw_arhe003"; break;
                       case 4: sItem = "nw_arhe004"; break;
                       case 5: sItem = "nw_arhe005"; break;
                       case 6: sItem = "nw_aarcl008"; break;
                       case 7: sItem = "nw_ashlw001"; break;
                       case 8: sItem = "nw_aarcl003"; break;
                       case 9: sItem = "nw_aarcl004"; break;
                       case 10: sItem = "nw_aarcl010"; break;
                       case 11: sItem = "nw_maarcl047"; break;
                       case 12: sItem = "nw_ashmlw002"; break;
                       case 13: sItem = "nw_maarcl046"; break;
                       case 14: sItem = "nw_maarcl048"; break;
                       case 15: sItem = "nw_maarcl035"; break;
                       case 16: sItem = "nw_maarcl049"; break;
                       case 17: sItem = "nw_maarcl050"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl047"; break;
                       case 2: sItem = "nw_ashmlw002"; break;
                       case 3: sItem = "nw_maarcl046"; break;
                       case 4: sItem = "nw_maarcl048"; break;
                       case 5: sItem = "nw_maarcl035"; break;
                       case 6: sItem = "nw_maarcl049"; break;
                       case 7: sItem = "nw_maarcl050"; break;
                       case 8: sItem = "nw_maarcl070"; break;
                       case 9: sItem = "nw_ashmlw008"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                   int nRandom = Random(14) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl035"; break;
                       case 2: sItem = "nw_maarcl049"; break;
                       case 3: sItem = "nw_maarcl050"; break;
                       case 4: sItem = "nw_maarcl070"; break;
                       case 5: sItem = "nw_ashmlw008"; break;
                       case 6: sItem = "nw_maarcl067"; break;
                       case 7: sItem = "nw_maarcl073"; break;
                       case 8: sItem = "nw_maarcl065"; break;
                       case 9: sItem = "nw_maarcl066"; break;
                       case 10: sItem = "nw_maarcl082"; break;
                       case 11: sItem = "nw_ashmlw009"; break;
                       case 12: sItem = "nw_maarcl085"; break;
                       case 13: sItem = "nw_maarcl077"; break;
                       case 14: sItem = "nw_maarcl078"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(11) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl070"; break;
                       case 2: sItem = "nw_ashmlw008"; break;
                       case 3: sItem = "nw_maarcl067"; break;
                       case 4: sItem = "nw_maarcl073"; break;
                       case 5: sItem = "nw_maarcl065"; break;
                       case 6: sItem = "nw_maarcl066"; break;
                       case 7: sItem = "nw_maarcl082"; break;
                       case 8: sItem = "nw_ashmlw009"; break;
                       case 9: sItem = "nw_maarcl085"; break;
                       case 10: sItem = "nw_maarcl077"; break;
                       case 11: sItem = "nw_maarcl078"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(11) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl070"; break;
                       case 2: sItem = "nw_ashmlw008"; break;
                       case 3: sItem = "nw_maarcl067"; break;
                       case 4: sItem = "nw_maarcl073"; break;
                       case 5: sItem = "nw_maarcl065"; break;
                       case 6: sItem = "nw_maarcl066"; break;
                       case 7: sItem = "nw_maarcl082"; break;
                       case 8: sItem = "nw_ashmlw009"; break;
                       case 9: sItem = "nw_maarcl085"; break;
                       case 10: sItem = "nw_maarcl077"; break;
                       case 11: sItem = "nw_maarcl078"; break;
                   }

            }
                  dbSpeak("Create Generic medium");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateGenericHeavyArmor(object oTarget, object oAdventurer, int nModifier = 0)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer) + nModifier;

            if (GetRange(1, nHD))    // * 200
            {
                  int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashto001"; break;
                       case 2: sItem = "nw_aarcl005"; break;
                       case 3: sItem = "nw_aarcl011"; break;
                   }

            }
            else if (GetRange(2, nHD))   // * 800
            {
                  int nRandom = Random(6) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashto001"; break;
                       case 2: sItem = "nw_aarcl005"; break;
                       case 3: sItem = "nw_aarcl011"; break;
                       case 4: sItem = "nw_aarcl006"; break;
                       case 5: sItem = "nw_ashmto002"; break;
                       case 6: sItem = "nw_maarcl051"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_aarcl005"; break;
                       case 2: sItem = "nw_aarcl011"; break;
                       case 3: sItem = "nw_aarcl006"; break;
                       case 4: sItem = "nw_ashmto002"; break;
                       case 5: sItem = "nw_maarcl051"; break;
                       case 6: sItem = "nw_maarcl052"; break;
                       case 7: sItem = "nw_aarcl007"; break;
                       case 8: sItem = "nw_maarcl053"; break;
                       case 9: sItem = "nw_ashmto008"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(15) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl051"; break;
                       case 2: sItem = "nw_maarcl052"; break;
                       case 3: sItem = "nw_aarcl007"; break;
                       case 4: sItem = "nw_maarcl053"; break;
                       case 5: sItem = "nw_ashmto008"; break;
                       case 6: sItem = "nw_maarcl064"; break;
                       case 7: sItem = "nw_maarcl074"; break;
                       case 8: sItem = "nw_maarcl069"; break;
                       case 9: sItem = "nw_maarcl068"; break;
                       case 10: sItem = "nw_ashmto003"; break;
                       case 11: sItem = "nw_ashmto009"; break;
                       case 12: sItem = "nw_maarcl076"; break;
                       case 13: sItem = "nw_maarcl086"; break;
                       case 14: sItem = "nw_maarcl081"; break;
                       case 15: sItem = "nw_maarcl080"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashmto008"; break;
                       case 2: sItem = "nw_maarcl064"; break;
                       case 3: sItem = "nw_maarcl074"; break;
                       case 4: sItem = "nw_maarcl069"; break;
                       case 5: sItem = "nw_maarcl068"; break;
                       case 6: sItem = "nw_ashmto009"; break;
                       case 7: sItem = "nw_maarcl076"; break;
                       case 8: sItem = "nw_maarcl086"; break;
                       case 9: sItem = "nw_maarcl081"; break;
                       case 10: sItem = "nw_maarcl080"; break;
                   }


            }
            else if (GetRange(6, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashmto009"; break;
                       case 2: sItem = "nw_maarcl076"; break;
                       case 3: sItem = "nw_maarcl086"; break;
                       case 4: sItem = "nw_maarcl081"; break;
                       case 5: sItem = "nw_maarcl080"; break;
                   }

            }
                  dbSpeak("Create Generic heavy");

           return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        // *
        // * SPECIC TREASURE ITEMS (re: Named Items)
        // *
        object CreateSpecificMiscItem(object oTarget,object oAdventurer)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer);

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericMiscItem(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: return CreateGenericMiscItem(oTarget, oAdventurer, JUMP_LEVEL);
                       case 2: sItem = "nw_maarcl057"; break;
                       case 3: sItem = "nw_it_mbelt005"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl057"; break;
                       case 2: sItem = "nw_it_mbelt005"; break;
                       case 3: sItem = "nw_maarcl101"; break;
                       case 4: sItem = "nw_maarcl102"; break;
                       case 5: sItem = "nw_maarcl103"; break;
                       case 6: sItem = "nw_it_mglove001"; break;
                       case 7: sItem = "nw_maarcl100"; break;
                       case 8: sItem = "nw_it_mbracer011"; break;
                       case 9: sItem = "nw_it_mmidmisc04"; break;
                       case 10: sItem = "nw_it_mring003"; break;
                       case 11: sItem = "nw_it_mbelt006"; break;
                       case 12: sItem = "nw_it_mbelt002"; break;
                       case 13: sItem = "nw_it_mmidmisc03"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(19) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl101"; break;
                       case 2: sItem = "nw_maarcl101"; break;
                       case 3: sItem = "nw_maarcl102"; break;
                       case 4: sItem = "nw_maarcl103"; break;
                       case 5: sItem = "nw_it_mglove001"; break;
                       case 6: sItem = "nw_maarcl100"; break;
                       case 7: sItem = "nw_it_mbracer011"; break;
                       case 8: sItem = "nw_it_mmidmisc04"; break;
                       case 9: sItem = "nw_it_mring003"; break;
                       case 10: sItem = "nw_it_mbelt006"; break;
                       case 11: sItem = "nw_it_mbelt002"; break;
                       case 12: sItem = "nw_it_mmidmisc03"; break;
                       case 13: sItem = "nw_it_mring002"; break;
                       case 14: sItem = "nw_it_mbelt004"; break;
                       case 15: sItem = "nw_it_mring005"; break;
                       case 16: sItem = "nw_it_mboots005"; break;
                       case 17: sItem = "nw_it_mring007"; break;
                       case 18: sItem = "nw_it_mneck003"; break;
                       case 19: sItem = "nw_it_mbelt007"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(15) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_it_mbelt002"; break;
                       case 2: sItem = "nw_it_mbelt002"; break;
                       case 3: sItem = "nw_it_mmidmisc03"; break;
                       case 4: sItem = "nw_it_mring002"; break;
                       case 5: sItem = "nw_it_mbelt004"; break;
                       case 6: sItem = "nw_it_mring005"; break;
                       case 7: sItem = "nw_it_mboots005"; break;
                       case 8: sItem = "nw_it_mring007"; break;
                       case 9: sItem = "nw_it_mneck003"; break;
                       case 10: sItem = "nw_it_mbelt007"; break;
                       case 11: sItem = "nw_it_mboots004"; break;
                       case 12: sItem = "nw_it_mboots003"; break;
                       case 13: sItem = "nw_it_mneck005"; break;
                       case 14: sItem = "nw_it_mbelt008"; break;
                       case 15: sItem = "nw_it_mring020"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 16000 and up
            {
                  int nRandom = Random(19) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_it_mboots004"; break;
                       case 2: sItem = "nw_it_mboots004"; break;
                       case 3: sItem = "nw_it_mboots003"; break;
                       case 4: sItem = "nw_it_mneck005"; break;
                       case 5: sItem = "nw_it_mbelt008"; break;
                       case 6: sItem = "nw_it_mring020"; break;
                       case 7: sItem = "nw_it_mbelt001"; break;
                       case 8: sItem = "nw_it_mring017"; break;
                       case 9: sItem = "nw_mcloth001"; break;
                       case 10: sItem = "nw_it_mneck019"; break;
                       case 11: sItem = "nw_it_mneck002"; break;
                       case 12: sItem = "nw_it_mneck004"; break;
                       case 13: sItem = "nw_it_mmidmisc01"; break;
                       case 14: sItem = "nw_mcloth002"; break;
                       case 15: sItem = "nw_mcloth003"; break;
                       case 16: sItem = "nw_mcloth004"; break;
                       case 17: sItem = "nw_it_mbelt003"; break;
                       // * new items
                       case 18: sItem = "NW_IT_MBELT020"; break;
                       case 19: sItem = "NW_IT_MBELT021"; break;
                   }

            }
                return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateSpecificRodStaffWand(object oTarget, object oAdventurer)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer);

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericRodStaffWand(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 200 - 2500
            {
                return CreateGenericRodStaffWand(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(4) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wmgst004"; break;
                       case 2: sItem = "nw_wmgst006"; break;
                       case 3: sItem = "nw_wmgmrd003"; break;
                       case 4: sItem = "nw_wmgst004"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(7) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wmgmrd003"; break;
                       case 2: sItem = "nw_wmgst006"; break;
                       case 3: sItem = "nw_wmgmrd003"; break;
                       case 4: sItem = "nw_wmgst004"; break;
                       case 5: sItem = "nw_wmgst005"; break;
                       case 6: sItem = "nw_wmgmrd004"; break;
                       case 7: sItem = "nw_wmgrd002"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(8) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblmcl012"; break;
                       case 2: sItem = "nw_wmgmrd003"; break;
                       case 3: sItem = "nw_wmgst004"; break;
                       case 4: sItem = "nw_wmgst005"; break;
                       case 5: sItem = "nw_wblmcl012"; break;
                       case 6: sItem = "nw_wmgmrd004"; break;
                       case 7: sItem = "nw_wmgst002"; break;
                       case 8: sItem = "nw_wmgmrd005"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 16000 and up
            {
                  int nRandom = Random(6) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wmgmrd004"; break;
                       case 2: sItem = "nw_wmgst002"; break;
                       case 3: sItem = "nw_wmgmrd005"; break;
                       case 4: sItem = "nw_wmgmrd002"; break;
                       case 5: sItem = "nw_wmgst003"; break;
                       case 6: sItem = "nw_wblmcl012"; break;
                   }

            }
                return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }


        object CreateSpecificSimple(object oTarget, object oAdventurer)
        {
           string sItem = "";
            int nHD = GetHitDice(oAdventurer);

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericSimple(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 200 - 2500
            {
                return CreateGenericSimple(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmqs005"; break;
                       case 2: sItem = "nw_wdbmqs005"; break;
                       case 3: sItem = "nw_wdbmqs006"; break;
                       case 4: sItem = "nw_wbwmxh005"; break;
                       case 5: sItem = "nw_wbwmxl005"; break;
                       case 6: sItem = "nw_wswmdg006"; break;
                       case 7: sItem = "nw_wblmml006"; break;
                       case 8: sItem = "nw_wspmsc004"; break;
                       case 9: sItem = "nw_wblmms007"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(22) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmqs006"; break;
                       case 2: sItem = "nw_wdbmqs005"; break;
                       case 3: sItem = "nw_wdbmqs006"; break;
                       case 4: sItem = "nw_wbwmxh005"; break;
                       case 5: sItem = "nw_wbwmxl005"; break;
                       case 6: sItem = "nw_wswmdg006"; break;
                       case 7: sItem = "nw_wblmml006"; break;
                       case 8: sItem = "nw_wspmsc004"; break;
                       case 9: sItem = "nw_wblmms007"; break;
                       case 10: sItem = "nw_wblmms003"; break;
                       case 11: sItem = "nw_wblmcl004"; break;
                       case 12: sItem = "nw_wspmsc006"; break;
                       case 13: sItem = "nw_wspmsc006"; break;
                       case 14: sItem = "nw_wdbmqs004"; break;
                       case 15: sItem = "nw_wblmcl003"; break;
                       case 16: sItem = "nw_wbwmsl003"; break;
                       case 17: sItem = "nw_wbwmxh003"; break;
                       case 18: sItem = "nw_wspmsc003"; break;
                       case 19: sItem = "nw_wplmss005"; break;
                       case 20: sItem = "nw_wplmss005"; break;
                       case 21: sItem = "nw_wbwmxl003"; break;
                       case 22: sItem = "nw_wblmml004"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(27) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblmms003"; break;
                       case 2: sItem = "nw_wblmms003"; break;
                       case 3: sItem = "nw_wblmcl004"; break;
                       case 4: sItem = "nw_wspmsc006"; break;
                       case 5: sItem = "nw_wspmsc006"; break;
                       case 6: sItem = "nw_wdbmqs004"; break;
                       case 7: sItem = "nw_wblmcl003"; break;
                       case 8: sItem = "nw_wbwmsl003"; break;
                       case 9: sItem = "nw_wbwmxh003"; break;
                       case 10: sItem = "nw_wspmsc003"; break;
                       case 11: sItem = "nw_wplmss005"; break;
                       case 12: sItem = "nw_wplmss005"; break;
                       case 13: sItem = "nw_wbwmxl003"; break;
                       case 14: sItem = "nw_wblmml004"; break;
                       case 15: sItem = "nw_wdbmqs003"; break;
                       case 16: sItem = "nw_wbwmxl004"; break;
                       case 17: sItem = "nw_wbwmxl007"; break;
                       case 18: sItem = "nw_wblmml005"; break;
                       case 19: sItem = "nw_wblmcl005"; break;
                       case 20: sItem = "nw_wplmss007"; break;
                       case 21: sItem = "nw_wswmdg004"; break;
                       case 22: sItem = "nw_wbwmsl007"; break;
                       case 23: sItem = "nw_wblmml007"; break;
                       case 24: sItem = "nw_wblmml007"; break;
                       case 25: sItem = "nw_wbwmxh004"; break;
                       case 26: sItem = "nw_wplmss006"; break;
                       case 27: sItem = "nw_wbwmxh007"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 16000 and up
            {
                  int nRandom = Random(31) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wbwmxl003"; break;
                       case 2: sItem = "nw_wbwmxl003"; break;
                       case 3: sItem = "nw_wblmml004"; break;
                       case 4: sItem = "nw_wdbmqs003"; break;
                       case 5: sItem = "nw_wbwmxl004"; break;
                       case 6: sItem = "nw_wbwmxl007"; break;
                       case 7: sItem = "nw_wblmml005"; break;
                       case 8: sItem = "nw_wblmcl005"; break;
                       case 9: sItem = "nw_wplmss007"; break;
                       case 10: sItem = "nw_wswmdg004"; break;
                       case 11: sItem = "nw_wbwmsl007"; break;
                       case 12: sItem = "nw_wblmml007"; break;
                       case 13: sItem = "nw_wblmml007"; break;
                       case 14: sItem = "nw_wbwmxh004"; break;
                       case 15: sItem = "nw_wplmss006"; break;
                       case 16: sItem = "nw_wbwmxh007"; break;
                       case 17: sItem = "nw_wblmms006"; break;
                       case 18: sItem = "nw_wswmdg003"; break;
                       case 19: sItem = "nw_wswmdg007"; break;
                       case 20: sItem = "nw_wblmms004"; break;
                       case 21: sItem = "nw_wbwmsl006"; break;
                       case 22: sItem = "nw_wbwmsl008"; break;
                       case 23: sItem = "nw_wblmml008"; break;
                       case 24: sItem = "nw_wdbmqs007"; break;
                       case 25: sItem = "nw_wblmcl006"; break;
                       case 26: sItem = "nw_wbwmsl004"; break;
                       case 27: sItem = "nw_wbwmxh006"; break;
                       case 28: sItem = "nw_wplmss004"; break;
                       case 29: sItem = "nw_wswmdg005"; break;
                       case 30: sItem = "nw_wbwmxl006"; break;
                       case 31: sItem = "nw_wspmsc005"; break;

                   }

            }
                return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        object CreateSpecificMartial(object oTarget, object oAdventurer)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer);

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericMartial(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: return CreateGenericMartial(oTarget, oAdventurer, JUMP_LEVEL);
                       case 2: sItem = "nw_wthmax005"; break;
                       case 3: sItem = "nw_wthmax007"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(14) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmax003"; break;
                       case 2: sItem = "nw_wthmax005"; break;
                       case 3: sItem = "nw_wthmax007"; break;
                       case 4: sItem = "nw_wthmax003"; break;
                       case 5: sItem = "nw_wthmax004"; break;
                       case 6: sItem = "nw_wthmax006"; break;
                       case 7: sItem = "nw_wswmrp004"; break;
                       case 8: sItem = "nw_wswmrp004"; break;
                       case 9: sItem = "nw_wblmfl004"; break;
                       case 10: sItem = "nw_wblmhl004"; break;
                       case 11: sItem = "nw_wbwmsh003"; break;
                       case 12: sItem = "nw_wblmhw006"; break;
                       case 13: sItem = "nw_wblmhw006"; break;
                       case 14: sItem = "nw_wbwmln004"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(28) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblmfl005"; break;
                       case 2: sItem = "nw_wthmax007"; break;
                       case 3: sItem = "nw_wthmax003"; break;
                       case 4: sItem = "nw_wthmax004"; break;
                       case 5: sItem = "nw_wthmax006"; break;
                       case 6: sItem = "nw_wswmrp004"; break;
                       case 7: sItem = "nw_wswmrp004"; break;
                       case 8: sItem = "nw_wblmfl004"; break;
                       case 9: sItem = "nw_wblmhl004"; break;
                       case 10: sItem = "nw_wbwmsh003"; break;
                       case 11: sItem = "nw_wblmhw006"; break;
                       case 12: sItem = "nw_wblmhw006"; break;
                       case 13: sItem = "nw_wbwmln004"; break;
                       case 14: sItem = "nw_wblmfl005"; break;
                       case 15: sItem = "nw_wswmgs006"; break;
                       case 16: sItem = "nw_waxmgr003"; break;
                       case 17: sItem = "nw_wplmhb004"; break;
                       case 18: sItem = "nw_wblmhw005"; break;
                       case 19: sItem = "nw_wblmfh004"; break;
                       case 20: sItem = "nw_wblmfh008"; break;
                       case 21: sItem = "nw_wbwmsh006"; break;
                       case 22: sItem = "nw_wswmsc004"; break;
                       case 23: sItem = "nw_waxmgr006"; break;
                       case 24: sItem = "nw_wswmrp005"; break;
                       case 25: sItem = "nw_wswmls007"; break;
                       case 26: sItem = "nw_wswmgs004"; break;
                       case 27: sItem = "nw_waxmhn004"; break;
                       case 28: sItem = "nw_wswmbs005"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(42) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblmhw006"; break;
                       case 2: sItem = "nw_wblmhw006"; break;
                       case 3: sItem = "nw_wblmhw006"; break;
                       case 4: sItem = "nw_wbwmln004"; break;
                       case 5: sItem = "nw_wblmfl005"; break;
                       case 6: sItem = "nw_wswmgs006"; break;
                       case 7: sItem = "nw_waxmgr003"; break;
                       case 8: sItem = "nw_wplmhb004"; break;
                       case 9: sItem = "nw_wblmhw005"; break;
                       case 10: sItem = "nw_wblmfh004"; break;
                       case 11: sItem = "nw_wblmfh008"; break;
                       case 12: sItem = "nw_wbwmsh006"; break;
                       case 13: sItem = "nw_wswmsc004"; break;
                       case 14: sItem = "nw_waxmgr006"; break;
                       case 15: sItem = "nw_wswmrp005"; break;
                       case 16: sItem = "nw_wswmls007"; break;
                       case 17: sItem = "nw_wswmgs004"; break;
                       case 18: sItem = "nw_waxmhn004"; break;
                       case 19: sItem = "nw_wswmbs005"; break;
                       case 20: sItem = "nw_wblmhl005"; break;
                       case 21: sItem = "nw_wblmhl011"; break;
                       case 22: sItem = "nw_wswmss005"; break;
                       case 23: sItem = "nw_wplmhb003"; break;
                       case 24: sItem = "nw_wbwmln007"; break;
                       case 25: sItem = "nw_wbwmln007"; break;
                       case 26: sItem = "nw_wbwmsh007"; break;
                       case 27: sItem = "nw_waxmbt006"; break;
                       case 28: sItem = "nw_wswmbs006"; break;
                       case 29: sItem = "nw_wblmfl007"; break;
                       case 30: sItem = "nw_waxmhn003"; break;
                       case 31: sItem = "nw_wblmhl006"; break;
                       case 32: sItem = "nw_wblmfl006"; break;
                       case 33: sItem = "nw_wswmls005"; break;
                       case 34: sItem = "nw_wswmss004"; break;
                       case 35: sItem = "nw_wbwmln006"; break;
                       case 36: sItem = "nw_wblmhw003"; break;
                       case 37: sItem = "nw_wblmfh006"; break;
                       case 38: sItem = "nw_wswmsc006"; break;
                       case 39: sItem = "nw_waxmhn005"; break;
                       case 40: sItem = "nw_wblmfh003"; break;
                       case 41: sItem = "nw_wswmls006"; break;
                       case 42: sItem = "nw_wswmrp007"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 16000 and up
            {
                  int nRandom = Random(55) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wblmhl005"; break;
                       case 2: sItem = "nw_wblmhl005"; break;
                       case 3: sItem = "nw_wblmhl011"; break;
                       case 4: sItem = "nw_wswmss005"; break;
                       case 5: sItem = "nw_wplmhb003"; break;
                       case 6: sItem = "nw_wbwmln007"; break;
                       case 7: sItem = "nw_wbwmln007"; break;
                       case 8: sItem = "nw_wbwmsh007"; break;
                       case 9: sItem = "nw_waxmbt006"; break;
                       case 10: sItem = "nw_wswmbs006"; break;
                       case 11: sItem = "nw_wblmfl007"; break;
                       case 12: sItem = "nw_waxmhn003"; break;
                       case 13: sItem = "nw_wblmhl006"; break;
                       case 14: sItem = "nw_wblmfl006"; break;
                       case 15: sItem = "nw_wswmls005"; break;
                       case 16: sItem = "nw_wswmss004"; break;
                       case 17: sItem = "nw_wbwmln006"; break;
                       case 18: sItem = "nw_wblmhw003"; break;
                       case 19: sItem = "nw_wblmfh006"; break;
                       case 20: sItem = "nw_wswmsc006"; break;
                       case 21: sItem = "nw_waxmhn005"; break;
                       case 22: sItem = "nw_wblmfh003"; break;
                       case 23: sItem = "nw_wswmls006"; break;
                       case 24: sItem = "nw_wswmrp007"; break;
                       case 25: sItem = "nw_wswmgs005"; break;
                       case 26: sItem = "nw_wswmgs005"; break;
                       case 27: sItem = "nw_waxmgr005"; break;
                       case 28: sItem = "nw_wplmhb007"; break;
                       case 29: sItem = "nw_wswmsc007"; break;
                       case 30: sItem = "nw_wswmrp006"; break;
                       case 31: sItem = "nw_wswmss006"; break;
                       case 32: sItem = "nw_wblmhl009"; break;
                       case 33: sItem = "nw_wswmbs007"; break;
                       case 34: sItem = "nw_wbwmln005"; break;
                       case 35: sItem = "nw_wblmfh005"; break;
                       case 36: sItem = "nw_wswmgs003"; break;
                       case 37: sItem = "nw_waxmbt003"; break;
                       case 38: sItem = "nw_wswmls004"; break;
                       case 39: sItem = "nw_wbwmsh005"; break;
                       case 40: sItem = "nw_wbwmsh005"; break;
                       case 41: sItem = "nw_waxmbt004"; break;
                       case 42: sItem = "nw_waxmbt004"; break;
                       case 43: sItem = "nw_wblmhl003"; break;
                       case 44: sItem = "nw_wblmhl003"; break;
                       case 45: sItem = "nw_wswmbs003"; break;
                       case 46: sItem = "nw_waxmbt005"; break;
                       case 47: sItem = "nw_waxmhn006"; break;
                       case 48: sItem = "nw_wswmss003"; break;
                       case 49: sItem = "nw_wswmsc005"; break;
                       case 50: sItem = "nw_wplmhb006"; break;
                       case 51: sItem = "nw_wbwmsh004"; break;
                       case 52: sItem = "nw_wswmbs004"; break;
                       case 53: sItem = "nw_wbwmln003"; break;
                       case 54: sItem = "nw_wblmhw004"; break;
                       case 55: sItem = "nw_waxmgr004"; break;
                   }

            }
                return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        object CreateSpecificExotic(object oTarget, object oAdventurer)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer);

            if (GetRange(1, nHD))    // * 800
            {
                  int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: return CreateGenericExotic(oTarget, oAdventurer, JUMP_LEVEL);
                       case 2: sItem = "nw_wthmsh003"; break;
                       case 3: sItem = "nw_wthmsh006"; break;
                   }

            }
            else if (GetRange(2, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: return CreateGenericExotic(oTarget, oAdventurer, JUMP_LEVEL);
                       case 2: sItem = "nw_wthmsh003"; break;
                       case 3: sItem = "nw_wthmsh006"; break;
                       case 4: sItem = "nw_wthmsh004"; break;
                       case 5: sItem = "nw_wthmsh007"; break;
                   }

            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(14) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wthmsh006"; break;
                       case 2: sItem = "nw_wthmsh006"; break;
                       case 3: sItem = "nw_wthmsh004"; break;
                       case 4: sItem = "nw_wthmsh007"; break;
                       case 5: sItem = "nw_wspmku006"; break;
                       case 6: sItem = "nw_wdbmma003"; break;
                       case 7: sItem = "nw_wswmka005"; break;
                       case 8: sItem = "nw_wspmka004"; break;
                       case 9: sItem = "nw_wspmka007"; break;
                       case 10: sItem = "nw_wdbmax006"; break;
                       case 11: sItem = "nw_wdbmsw006"; break;
                       case 12: sItem = "nw_wspmku005"; break;
                       case 13: sItem = "nw_wdbmsw007"; break;
                       case 14: sItem = "nw_wspmka005"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(16) + 1;
                  switch (nRandom)
                  {
                       case 1:sItem = "nw_wthmsh007"; break;
                       case 2: sItem = "nw_wthmsh007"; break;
                       case 3: sItem = "nw_wspmku006"; break;
                       case 4: sItem = "nw_wdbmma003"; break;
                       case 5: sItem = "nw_wswmka005"; break;
                       case 6: sItem = "nw_wspmka004"; break;
                       case 7: sItem = "nw_wspmka007"; break;
                       case 8: sItem = "nw_wdbmax006"; break;
                       case 9: sItem = "nw_wdbmsw006"; break;
                       case 10: sItem = "nw_wspmku005"; break;
                       case 11: sItem = "nw_wdbmsw007"; break;
                       case 12: sItem = "nw_wspmka005"; break;
                       case 13: sItem = "nw_wplmsc003"; break;
                       case 14: sItem = "nw_wdbmax005"; break;
                       case 15: sItem = "nw_wspmku004"; break;
                       case 16: sItem = "nw_wdbmma005"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(17) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wplmsc003"; break;
                       case 2: sItem = "nw_wspmka005"; break;
                       case 3: sItem = "nw_wplmsc003"; break;
                       case 4: sItem = "nw_wdbmax005"; break;
                       case 5: sItem = "nw_wspmku004"; break;
                       case 6: sItem = "nw_wdbmma005"; break;
                       case 7: sItem = "nw_wdbmma005"; break;
                       case 8: sItem = "nw_wdbmax004"; break;
                       case 9: sItem = "nw_wdbmma004"; break;
                       case 10: sItem = "nw_wswmka007"; break;
                       case 11: sItem = "nw_wdbmsw005"; break;
                       case 12: sItem = "nw_wspmka006"; break;
                       case 13: sItem = "nw_wspmka003"; break;
                       case 14: sItem = "nw_wdbmax007"; break;
                       case 15: sItem = "nw_wplmsc006"; break;
                       case 16: sItem = "nw_wspmku007"; break;
                       case 17: sItem = "nw_wdbmma006"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 16000 and up
            {
                  int nRandom = Random(21) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_wdbmma005"; break;
                       case 2: sItem = "nw_wdbmma005"; break;
                       case 3: sItem = "nw_wdbmma005"; break;
                       case 4: sItem = "nw_wdbmax004"; break;
                       case 5: sItem = "nw_wdbmma004"; break;
                       case 6: sItem = "nw_wswmka007"; break;
                       case 7: sItem = "nw_wdbmsw005"; break;
                       case 8: sItem = "nw_wspmka006"; break;
                       case 9: sItem = "nw_wspmka003"; break;
                       case 10: sItem = "nw_wdbmax007"; break;
                       case 11: sItem = "nw_wplmsc006"; break;
                       case 12: sItem = "nw_wspmku007"; break;
                       case 13: sItem = "nw_wdbmma006"; break;
                       case 14: sItem = "nw_wspmku003"; break;
                       case 15: sItem = "nw_wswmka006"; break;
                       case 16: sItem = "nw_wplmsc005"; break;
                       case 17: sItem = "nw_wplmsc005"; break;
                       case 18: sItem = "nw_wswmka004"; break;
                       case 19: sItem = "nw_wswmka004"; break;
                       case 20: sItem = "nw_wdbmsw004"; break;
                       case 21: sItem = "nw_wplmsc004"; break;
                   }

            }
                return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        object CreateSpecificLightArmor(object oTarget, object oAdventurer)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer);

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericLightArmor(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 200 - 2500
            {
                  int nRandom = Random(3) + 1;
                  switch (nRandom)
                  {
                       case 1: return CreateGenericLightArmor(oTarget, oAdventurer, JUMP_LEVEL);
                       case 2: sItem = "nw_ashmsw011"; break;
                       case 3: sItem = "nw_ashmsw010"; break;
                   }
            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_ashmsw011"; break;
                       case 2: sItem = "nw_ashmsw011"; break;
                       case 3: sItem = "nw_ashmsw010"; break;
                       case 4: sItem = "nw_maarcl011"; break;
                       case 5: sItem = "nw_ashmsw006"; break;
                       case 6: sItem = "nw_maarcl017"; break;
                       case 7: sItem = "nw_ashmsw005"; break;
                       case 8: sItem = "nw_maarcl013"; break;
                       case 9: sItem = "nw_maarcl012"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl011"; break;
                       case 2: sItem = "nw_maarcl011"; break;
                       case 3: sItem = "nw_ashmsw006"; break;
                       case 4: sItem = "nw_maarcl017"; break;
                       case 5: sItem = "nw_ashmsw005"; break;
                       case 6: sItem = "nw_maarcl013"; break;
                       case 7: sItem = "nw_maarcl012"; break;
                       case 8: sItem = "nw_ashmsw004"; break;
                       case 9: sItem = "nw_maarcl006"; break;
                       case 10: sItem = "nw_maarcl032"; break;
                       case 11: sItem = "nw_maarcl003"; break;
                       case 12: sItem = "nw_maarcl002"; break;
                       case 13: sItem = "nw_maarcl007"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(11) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl012"; break;
                       case 2: sItem = "nw_maarcl012"; break;
                       case 3: sItem = "nw_ashmsw004"; break;
                       case 4: sItem = "nw_maarcl006"; break;
                       case 5: sItem = "nw_maarcl032"; break;
                       case 6: sItem = "nw_maarcl003"; break;
                       case 7: sItem = "nw_maarcl002"; break;
                       case 8: sItem = "nw_maarcl005"; break;
                       case 9: sItem = "nw_ashmsw003"; break;
                       case 10: sItem = "nw_maarcl001"; break;
                       case 11: sItem = "nw_maarcl034"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 16000 and up
            {
                  int nRandom = Random(11) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl005"; break;
                       case 2: sItem = "nw_maarcl005"; break;
                       case 3: sItem = "nw_ashmsw003"; break;
                       case 4: sItem = "nw_maarcl001"; break;
                       case 5: sItem = "nw_maarcl034"; break;
                       case 6: sItem = "nw_maarcl008"; break;
                       case 7: sItem = "nw_ashmsw007"; break;
                       case 8: sItem = "nw_maarcl033"; break;
                       case 9: sItem = "nw_mcloth005"; break;
                       case 10: sItem = "nw_maarcl009"; break;
                       case 11: sItem = "nw_maarcl004"; break;
                   }

            }
              return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateSpecificMediumArmor(object oTarget, object oAdventurer)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer);

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericMediumArmor(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 200 - 2500
            {
                return CreateGenericMediumArmor(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(5) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_armhe008"; break;
                       case 2: sItem = "nw_armhe008"; break;
                       case 3: sItem = "nw_armhe007"; break;
                       case 4: sItem = "nw_armhe009"; break;
                       case 5: sItem = "nw_armhe010"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(9) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_armhe008"; break;
                       case 2: sItem = "nw_armhe008"; break;
                       case 3: sItem = "nw_armhe007"; break;
                       case 4: sItem = "nw_armhe009"; break;
                       case 5: sItem = "nw_armhe010"; break;
                       case 6: sItem = "nw_armhe006"; break;
                       case 7: sItem = "nw_ashmlw007"; break;
                       case 8: sItem = "nw_ashmlw005"; break;
                       case 9: sItem = "nw_maarcl016"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(12) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_armhe009"; break;
                       case 2: sItem = "nw_armhe009"; break;
                       case 3: sItem = "nw_armhe010"; break;
                       case 4: sItem = "nw_armhe006"; break;
                       case 5: sItem = "nw_ashmlw007"; break;
                       case 6: sItem = "nw_ashmlw005"; break;
                       case 7: sItem = "nw_maarcl016"; break;
                       case 8: sItem = "nw_maarcl036"; break;
                       case 9: sItem = "nw_ashmlw004"; break;
                       case 10: sItem = "nw_maarcl037"; break;
                       case 11: sItem = "nw_maarcl040"; break;
                       case 12: sItem = "nw_ashmlw006"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 16000 and up
            {
                  int nRandom = Random(12) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl016"; break;
                       case 2: sItem = "nw_maarcl016"; break;
                       case 3: sItem = "nw_maarcl036"; break;
                       case 4: sItem = "nw_ashmlw004"; break;
                       case 5: sItem = "nw_maarcl037"; break;
                       case 6: sItem = "nw_maarcl040"; break;
                       case 7: sItem = "nw_ashmlw006"; break;
                       case 8: sItem = "nw_ashmlw003"; break;
                       case 9: sItem = "nw_maarcl014"; break;
                       case 10: sItem = "nw_maarcl039"; break;
                       case 11: sItem = "nw_maarcl010"; break;
                       case 12: sItem = "nw_maarcl015"; break;
                   }

            }
                  return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        object CreateSpecificHeavyArmor(object oTarget, object oAdventurer)
        {
            string sItem = "";
            int nHD = GetHitDice(oAdventurer);

            if (GetRange(1, nHD))    // * 800
            {
                return CreateGenericHeavyArmor(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(2, nHD))   // * 200 - 2500
            {
                return CreateGenericHeavyArmor(oTarget, oAdventurer, JUMP_LEVEL);
            }
            else if (GetRange(3, nHD))   // * 800 - 10000
            {
                  int nRandom = Random(6) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl026"; break;
                       case 2: sItem = "nw_maarcl026"; break;
                       case 3: sItem = "nw_maarcl021"; break;
                       case 4: sItem = "nw_ashmto003"; break;
                       case 5: sItem = "nw_maarcl029"; break;
                       case 6: sItem = "nw_maarcl020"; break;
                   }

            }
            else if (GetRange(4, nHD))   // * 2500 - 16500
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl021"; break;
                       case 2: sItem = "nw_maarcl026"; break;
                       case 3: sItem = "nw_maarcl021"; break;
                       case 4: sItem = "nw_ashmto003"; break;
                       case 5: sItem = "nw_maarcl029"; break;
                       case 6: sItem = "nw_maarcl020"; break;
                       case 7: sItem = "nw_ashmto006"; break;
                       case 8: sItem = "nw_maarcl041"; break;
                       case 9: sItem = "nw_ashmto005"; break;
                       case 10: sItem = "nw_ashmto007"; break;
                       case 11: sItem = "nw_ashmto010"; break;
                       case 12: sItem = "nw_maarcl022"; break;
                       case 13: sItem = "nw_maarcl018"; break;
                   }

            }
            else if (GetRange(5, nHD))   // * 8000 - 25000
            {
                  int nRandom = Random(13) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl020"; break;
                       case 2: sItem = "nw_maarcl020"; break;
                       case 3: sItem = "nw_ashmto006"; break;
                       case 4: sItem = "nw_maarcl041"; break;
                       case 5: sItem = "nw_ashmto005"; break;
                       case 6: sItem = "nw_ashmto007"; break;
                       case 7: sItem = "nw_ashmto010"; break;
                       case 8: sItem = "nw_maarcl022"; break;
                       case 9: sItem = "nw_maarcl018"; break;
                       case 10: sItem = "nw_maarcl024"; break;
                       case 11: sItem = "nw_ashmto011"; break;
                       case 12: sItem = "nw_maarcl042"; break;
                       case 13: sItem = "nw_maarcl054"; break;
                   }

            }
            else if (GetRange(6, nHD))   // * 16000 and up
            {
                  int nRandom = Random(10) + 1;
                  switch (nRandom)
                  {
                       case 1: sItem = "nw_maarcl018"; break;
                       case 2: sItem = "nw_maarcl018"; break;
                       case 3: sItem = "nw_maarcl024"; break;
                       case 4: sItem = "nw_ashmto011"; break;
                       case 5: sItem = "nw_maarcl042"; break;
                       case 6: sItem = "nw_maarcl054"; break;
                       case 7: sItem = "nw_ashmto004"; break;
                       case 8: sItem = "nw_maarcl025"; break;
                       case 9: sItem = "nw_maarcl028"; break;
                       case 10: sItem = "nw_maarcl027"; break;
                   }

            }
            return dbCreateItemOnObject(sItem, oTarget, oAdventurer);
        }
        
        // * if nSpecific is = 1 then spawn in 'named' items at the higher levels
    object CreateTable2Item(object oTarget, object oAdventurer, int nSpecific=0)
    {
        dbSpeak("In CreateTable2Item");
        string sItem = "";
        int nProbMisc = 0;
        int nProbClass = 0;
        int nProbRodStaffWand = 0;
        int nProbSimple = 0;
        int nProbMartial = 0;
        int nProbExotic = 0;
        int nProbLight = 0;
        int nProbMedium = 0;
        int nProbHeavy = 0;

        int nSpecialRanger = 0; // 2 Means to treat the ranger as a barbarian. A 1 is to treat it as a fighter


        // * May 2002: Changed using Preston's multiclass function
        // * it randomly chooses one of your classes
        int nClass =  nDetermineClassToUse(oAdventurer);


        // * SPECIAL RANGER BEHAVIOR
        // * If the ranger has the Heavy Armor proficiency, will treat the ranger
        if ( nClass == CLASS_TYPE_RANGER && GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY))
        {
            nSpecialRanger = 1;
        }
        else
        if (nClass == CLASS_TYPE_RANGER)
        {
            nSpecialRanger = 2;
        }



        //* SETUP probabilities based on Class
        if ( nClass == CLASS_TYPE_FIGHTER || nClass == CLASS_TYPE_PALADIN || nSpecialRanger == 1)
        {
            dbSpeak("I am fighter or paladin or heavy ranger");
            nProbMisc = 20;
            nProbClass = 0;
            nProbRodStaffWand = 5;
            nProbSimple = 5;
            nProbMartial = 20;
            nProbExotic = 10;
            nProbLight = 5;
            nProbMedium = 15;
            nProbHeavy = 20;
        }
        else
        if (nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_SORCERER)
        {
            dbSpeak("I am wizard or sorcerer");
            nProbMisc = 40;
            nProbClass = 30;
            nProbRodStaffWand = 15;
            nProbSimple = 3;
            nProbMartial = 3;
            nProbExotic = 3;
            nProbLight = 2;
            nProbMedium = 2;
            nProbHeavy = 2;
        }
        else
        if (nClass == CLASS_TYPE_BARBARIAN || nSpecialRanger == 2)
        {
            dbSpeak("I am barbarian or light ranger");

            nProbMisc = 20;
            nProbClass = 0;
            nProbRodStaffWand = 5;
            nProbSimple = 17;
            nProbMartial = 27;
            nProbExotic = 15;
            nProbLight = 8;
            nProbMedium = 5;
            nProbHeavy = 3;
        }
        else
        if (nClass == CLASS_TYPE_CLERIC)
        {
            dbSpeak("I am cleric");

            nProbMisc = 20;
            nProbClass = 10;
            nProbRodStaffWand = 10;
            nProbSimple = 25;
            nProbMartial = 7;
            nProbExotic = 5;
            nProbLight = 5;
            nProbMedium = 8;
            nProbHeavy = 10;
        }
        else
        if (nClass == CLASS_TYPE_DRUID)
        {
            dbSpeak("I am druid");

            nProbMisc = 20;
            nProbClass = 25;
            nProbRodStaffWand = 15;
            nProbSimple = 10;
            nProbMartial = 5;
            nProbExotic = 5;
            nProbLight = 10;
            nProbMedium = 5;
            nProbHeavy = 5;
        }
        else
        if (nClass == CLASS_TYPE_MONK)
        {
            dbSpeak("I am monk");
            nProbMisc = 20;
            nProbClass = 50;
            nProbRodStaffWand = 2;
            nProbSimple = 7;
            nProbMartial = 2;
            nProbExotic = 7;
            nProbLight = 4;
            nProbMedium = 4;
            nProbHeavy = 4;
        }
        else
        if (nClass == CLASS_TYPE_ROGUE)
        {
            dbSpeak("I am rogue");

            nProbMisc = 25;
            nProbClass = 10;
            nProbRodStaffWand = 10;
            nProbSimple = 25;
            nProbMartial = 5;
            nProbExotic = 5;
            nProbLight = 10;
            nProbMedium = 5;
            nProbHeavy = 5;
        }
        else
        if (nClass == CLASS_TYPE_BARD)
        {
            dbSpeak("I am bard");

            nProbMisc = 25;
            nProbClass = 5;
            nProbRodStaffWand = 5;
            nProbSimple = 25;
            nProbMartial = 10;
            nProbExotic = 10;
            nProbLight = 10;
            nProbMedium = 5;
            nProbHeavy = 5;
        }
        else
        {
            dbSpeak("No Valid Class");
        }
        dbSpeak("Table2Item: After Class Distribution");
        //* Create Items based on Probabilities
        int nRandom = d100();
        if (nRandom <= nProbMisc)
        {
            if (nSpecific == 0) return CreateGenericMiscItem(oTarget, oAdventurer);
            else return CreateSpecificMiscItem(oTarget, oAdventurer);

        }
        else
        if (nRandom <= nProbMisc + nProbClass)
        {   // * no need for a seperate specific function here
            return CreateGenericClassItem(oTarget, oAdventurer, nSpecific);
        }
        else
        if (nRandom <= nProbMisc + nProbClass + nProbRodStaffWand)
        {
            if (nSpecific == 0) return CreateGenericRodStaffWand(oTarget, oAdventurer);
            else return CreateSpecificRodStaffWand(oTarget, oAdventurer);
        }
        else
        if (nRandom <= nProbMisc + nProbClass + nProbRodStaffWand + nProbSimple)
        {
            if (nSpecific == 0) return CreateGenericSimple(oTarget, oAdventurer);
            else return CreateSpecificSimple(oTarget, oAdventurer);
        }
        else
        if (nRandom <= nProbMisc + nProbClass + nProbRodStaffWand + nProbSimple + nProbMartial)
        {

             if (nSpecific == 0) return CreateGenericMartial(oTarget, oAdventurer);
             else return CreateSpecificMartial(oTarget, oAdventurer);
        }
        else
        if (nRandom <= nProbMisc + nProbClass + nProbRodStaffWand + nProbSimple + nProbMartial + nProbExotic)
        {
            if (nSpecific == 0) return CreateGenericExotic(oTarget, oAdventurer);
            else return CreateSpecificExotic(oTarget, oAdventurer);
        }
        else
        if (nRandom <= nProbMisc + nProbClass + nProbRodStaffWand + nProbSimple + nProbMartial + nProbExotic + nProbLight)
        {
            if (nSpecific == 0) return CreateGenericLightArmor(oTarget, oAdventurer);
            else return CreateSpecificLightArmor(oTarget, oAdventurer);
        }
        else
        if (nRandom <= nProbMisc + nProbClass + nProbRodStaffWand + nProbSimple + nProbMartial + nProbExotic + nProbLight + nProbMedium)
        {
            if (nSpecific == 0) return CreateGenericMediumArmor(oTarget, oAdventurer);
            else return CreateSpecificMediumArmor(oTarget, oAdventurer);
        }
        else
        if (nRandom <= nProbMisc + nProbClass + nProbRodStaffWand + nProbSimple + nProbMartial + nProbExotic + nProbLight + nProbMedium + nProbHeavy)
        {
            if (nSpecific == 0) return CreateGenericHeavyArmor(oTarget, oAdventurer);
            else return CreateSpecificHeavyArmor(oTarget, oAdventurer);
        }
        else
        {
            dbSpeak("Generic Generic or Specific; error: 3524");
        }
        return OBJECT_INVALID;
    }

//::///////////////////////////////////////////////
//:: GenerateTreasure
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Generate Treasure
   NOTE: When used by NPCs, the treasure is scaled
   to how powerful the NPC is.

   If used by containers, it is scaled by how
   powerful the PC is.

   PARAMETERS
   oLastOpener = The creature that opened the container
   oCreateOn = The place to put the treasure. If this is
    invalid then the treasure is placed on oLastOpener
*/
//:://////////////////////////////////////////////
//:: Created By:  Andrew
//:: Created On:
//:://////////////////////////////////////////////
void GenerateTreasure(int nTreasureType, object oLastOpener, object oCreateOn, string limitAcquire = "")
{

    dbSpeak("*********************NEW TREASURE*************************");

    // * abort treasure if no one opened the container
    if (GetIsObjectValid(oLastOpener) == FALSE)
    {
        dbSpeak("Aborted.  No valid Last Opener");
        return;
    }

    // * if no valid create on object, then create on oLastOpener
    if (oCreateOn == OBJECT_INVALID)
    {
        oCreateOn = oLastOpener;
    }

    // * if an Animal then generate 100% animal treasure

    // not done yet
    // * VARIABLES
   int nProbBook =   0;
   int nProbAnimal = 0;
   int nProbJunk =   0;
   int nProbGold = 0;
   int nProbGem = 0;
   int nProbJewel = 0;
   int nProbArcane = 0;
   int nProbDivine = 0;
   int nProbAmmo = 0;
   int nProbKit = 0;
   int nProbPotion = 0;
   int nProbTable2 = 0;

   int nSpecific = 0;
   int i = 0;
   int nNumberItems = GetNumberOfItems(nTreasureType);

   // * Set Treasure Type Values
   if (nTreasureType == TREASURE_LOW)
   {
    nProbBook   = LOW_PROB_BOOK;
    nProbAnimal = LOW_PROB_ANIMAL;
    nProbJunk   = LOW_PROB_JUNK;
    nProbGold   = LOW_PROB_GOLD;
    nProbGem    = LOW_PROB_GEM;
    nProbJewel  = LOW_PROB_JEWEL;
    nProbArcane = LOW_PROB_ARCANE;
    nProbDivine  = LOW_PROB_DIVINE;
    nProbAmmo = LOW_PROB_AMMO ;
    nProbKit = LOW_PROB_KIT;
    nProbPotion = LOW_PROB_POTION;
    nProbTable2 = LOW_PROB_TABLE2;
   }
   else if (nTreasureType == TREASURE_MEDIUM)
   {
    nProbBook   = MEDIUM_PROB_BOOK;
    nProbAnimal = MEDIUM_PROB_ANIMAL;
    nProbJunk   = MEDIUM_PROB_JUNK;
    nProbGold   = MEDIUM_PROB_GOLD;
    nProbGem    = MEDIUM_PROB_GEM;
    nProbJewel  = MEDIUM_PROB_JEWEL;
    nProbArcane = MEDIUM_PROB_ARCANE;
    nProbDivine  = MEDIUM_PROB_DIVINE;
    nProbAmmo = MEDIUM_PROB_AMMO ;
    nProbKit = MEDIUM_PROB_KIT;
    nProbPotion = MEDIUM_PROB_POTION;
    nProbTable2 = MEDIUM_PROB_TABLE2;
   }
   else if (nTreasureType == TREASURE_HIGH)
   {
    nProbBook   = HIGH_PROB_BOOK;
    nProbAnimal = HIGH_PROB_ANIMAL;
    nProbJunk   = HIGH_PROB_JUNK;
    nProbGold   = HIGH_PROB_GOLD;
    nProbGem    = HIGH_PROB_GEM;
    nProbJewel  = HIGH_PROB_JEWEL;
    nProbArcane = HIGH_PROB_ARCANE;
    nProbDivine  = HIGH_PROB_DIVINE;
    nProbAmmo = HIGH_PROB_AMMO ;
    nProbKit = HIGH_PROB_KIT;
    nProbPotion = HIGH_PROB_POTION;
    nProbTable2 = HIGH_PROB_TABLE2;
   }
   else if (nTreasureType == TREASURE_BOSS)
   { dbSpeak("boss");
    nProbTable2 = 100;
    nSpecific = 1;
   }
   else if (nTreasureType == TREASURE_BOOK)
   {
    nProbBook = 90;
    nProbArcane = 6;
    nProbDivine = 4;
   }

   dbSpeak("Generate Treasure nSpecific = " + IntToString(nSpecific));

   for (i = 1; i <= nNumberItems; i++)
   {
     int nRandom = d100();
     object treasure;
     if (nRandom <= nProbBook)
        treasure = CreateBook(oCreateOn, oLastOpener);                                // * Book
     else if (nRandom <= nProbBook + nProbAnimal)
        treasure = CreateAnimalPart(oCreateOn, oLastOpener);                          // * Animal
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk)
        treasure = CreateJunk(oCreateOn, oLastOpener);                                // * Junk
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold)
        treasure = CreateGold(oCreateOn, oLastOpener, nTreasureType);    // * Gold
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem)
        treasure = CreateGem(oCreateOn, oLastOpener, nTreasureType);     // * Gem
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel)
        treasure = CreateJewel(oCreateOn, oLastOpener, nTreasureType);   // * Jewel
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane)
        treasure = CreateArcaneScroll(oCreateOn, oLastOpener);   // * Arcane Scroll
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine)
        treasure = CreateDivineScroll(oCreateOn, oLastOpener);   // * Divine Scroll
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine + nProbAmmo)
        treasure = CreateAmmo(oCreateOn, oLastOpener);   // * Ammo
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine + nProbAmmo + nProbKit)
        treasure = CreateKit(oCreateOn, oLastOpener);   // * Healing, Trap, or Thief kit
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine + nProbAmmo + nProbKit + nProbPotion)
        treasure = CreatePotion(oCreateOn, oLastOpener);   // * Potion
     else if (nRandom <= nProbBook + nProbAnimal + nProbJunk + nProbGold + nProbGem + nProbJewel + nProbArcane + nProbDivine + nProbAmmo + nProbKit + nProbPotion + nProbTable2)
     {
        treasure = CreateTable2Item(oCreateOn, oLastOpener, nSpecific);   // * Weapons, Armor, Misc - Class based
     }
     else
      dbSpeak("other stuff");

      //MessageAll("limitAcquire='" + limitAcquire + "'");
      if (limitAcquire != "") {
        SetLocalString(treasure, "LIMIT_ACQUIRE", limitAcquire);
      }
   }
}

void GenerateLowTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_LOW, oLastOpener, oCreateOn);
}
void GenerateMediumTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_MEDIUM, oLastOpener, oCreateOn);
}
void GenerateHighTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_HIGH, oLastOpener, oCreateOn);
}
void GenerateBossTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_BOSS, oLastOpener, oCreateOn);
}
void GenerateBookTreasure(object oLastOpener, object oCreateOn=OBJECT_INVALID)
{
 GenerateTreasure(TREASURE_BOOK, oLastOpener, oCreateOn);
}
//::///////////////////////////////////////////////
//:: GenerateNPCTreasure
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
   Preferrably called from OnSpawn scripts.
   Use the random treasure functions to generate
   appropriate treasure for the creature to drop.
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: January 2002
//:://////////////////////////////////////////////

void GenerateNPCTreasure(int nTreasureValue=1, object oTreasureGetter=OBJECT_SELF, object oKiller=OBJECT_SELF)
{
    //DestroyObject(OBJECT_SELF);
    // * if I am an animal ,then give me animal stuff instead
    if (GetObjectType(oTreasureGetter) == OBJECT_TYPE_CREATURE)
    {
        if (
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_UNDEAD) ||
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_ANIMAL) ||
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_BEAST) ||
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_MAGICAL_BEAST) ||
            (GetRacialType(oTreasureGetter) == RACIAL_TYPE_VERMIN)
           )
        {
            //CreateAnimalPart(oTreasureGetter);
            // April 23 2002: Removed animal parts. They are silly.
            return;
        }
    }

    if (nTreasureValue == 1)
    {
        // April 2002: 30% chance of not getting any treasure now
        // if a creature
        if (Random(100)+1 >= 75)
        {
            GenerateTreasure(TREASURE_LOW, oTreasureGetter, oKiller);
        }
    }
    else
    if (nTreasureValue == 2)
    {
        GenerateTreasure(TREASURE_MEDIUM, oTreasureGetter, oKiller);
    }
    else
    if (nTreasureValue == 3)
    {
        GenerateTreasure(TREASURE_HIGH, oTreasureGetter, oKiller);
    }
    else
    if (nTreasureValue == 4)
    {
        GenerateBossTreasure(oKiller, oTreasureGetter);
    }

}

// *
// * Theft Prevention
// *

//::///////////////////////////////////////////////
//:: ShoutDisturbed
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////

// * Container shouts if disturbed
void ShoutDisturbed()
{
    if (GetIsDead(OBJECT_SELF) == TRUE)
    {
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTarget))
        {
           if (GetFactionEqual(oTarget, OBJECT_SELF) == TRUE)
           {
               // * Make anyone who is a member of my faction hostile if I am violated
           object oAttacker = GetLastAttacker();
           SetIsTemporaryEnemy(oAttacker,oTarget);
           AssignCommand(oTarget, ActionAttack(oAttacker));
           }
           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
    else (GetIsOpen(OBJECT_SELF) == TRUE);
    {
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTarget))
        {
           if (GetFactionEqual(oTarget, OBJECT_SELF) == TRUE)
           {
               // * Make anyone who is a member of my faction hostile if I am violated
           object oAttacker = GetLastOpenerOrKiller();
           SetIsTemporaryEnemy(oAttacker,oTarget);
           AssignCommand(oTarget, ActionAttack(oAttacker));

           }
           oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
        }
    }
}


//::///////////////////////////////////////////////
//:: Determine Class to Use
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines which of a NPCs three classes to
    use in the random treasure system
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 4, 2002
//:://////////////////////////////////////////////

int nDetermineClassToUse(object oCharacter)
{
    int nClass;
    int nTotal = GetHitDice(oCharacter);
    dbSpeak("Hit dice " + IntToString(nTotal));
    if (nTotal < 1)
    {
        nTotal = 1;
    }
    float fTotal = IntToFloat(nTotal);
    if (GetIsObjectValid(oCharacter) == FALSE)
    {
        dbSpeak("DetermineClassToUse: This character is invalid");
    }
    int nClass1 =  GetClassByPosition(1, oCharacter);
    int nState1 = FloatToInt((IntToFloat(GetLevelByClass(nClass1, oCharacter)) / fTotal) * 100);
    dbSpeak("Level 1 Class Level = " + IntToString(GetLevelByClass(nClass1,oCharacter)));

    PrintString("GENERIC SCRIPT DEBUG STRING ********** " +  GetTag(oCharacter) + "Class 1 " + IntToString(nState1));
    dbSpeak("State 1 " + IntToString(nState1));
    int nClass2 = GetClassByPosition(2, oCharacter);
    int nState2 = FloatToInt((IntToFloat(GetLevelByClass(nClass2, oCharacter)) / fTotal) * 100) + nState1;
    PrintString("GENERIC SCRIPT DEBUG STRING ********** " + GetTag(oCharacter) + "Class 2 " + IntToString(nState2));

    int nClass3 = GetClassByPosition(3, oCharacter);
    int nState3 = FloatToInt((IntToFloat(GetLevelByClass(nClass3, oCharacter)) / fTotal) * 100) + nState2;
    PrintString("GENERIC SCRIPT DEBUG STRING ********** " + GetTag(oCharacter) + "Class 3 " + IntToString(nState3));

    int nUseClass = d100();
    PrintString("GENERIC SCRIPT DEBUG STRING ********** " + "D100 Roll " +IntToString(nUseClass));


    dbSpeak("Before comparison : " + IntToString(nClass1));
    if(nUseClass <= nState1)
    {
        nClass = nClass1;
    }
    else if(nUseClass > nState1 && nUseClass <= nState2)
    {
        nClass = nClass2;
    }
    else
    {
        nClass = nClass3;
    }
    dbSpeak("Class from determineClass " + IntToString(nClass));
    return nClass;
}

int LOOT_INC_MAIN_DEBUGGING = TRUE;
//int GetMaxAllowedLevel (object oCaller);
//int GetMinimumLevel (object oCaller);
//int GetMinimumNumberOfItemsToGenerate (object oCaller);
//int GetMaximumNumberOfItemsToGenerate (object oCaller);
//int GetTotalAvailableItems (object oCaller);
//string GetUniqueItemFromList (object oCaller,int iNumber);

void GenerateUniqueTreasure(object oCaller, object oTarget, object oPC) {
    int iMinimumLevel = GetMinimumLevel (oCaller);
    int iNumberOfItemsToGenerate = 1;
    int iMinimum = GetMinimumNumberOfItemsToGenerate (oCaller);
    int iMaximum = GetMaximumNumberOfItemsToGenerate (oCaller);
    if (iNumberOfItemsToGenerate < iMinimum) iNumberOfItemsToGenerate = iMinimum;
    if (iNumberOfItemsToGenerate > iMaximum) iNumberOfItemsToGenerate = iMaximum;

    int iNumItemsInList = GetTotalAvailableItems (oCaller);

    int iRandomNumber;
    string sItemTemplate;
    int iCounter;

    for (iCounter = 0; iCounter < iNumberOfItemsToGenerate; iCounter ++) {
        iRandomNumber = Random (iNumItemsInList)+1;
        sItemTemplate = GetUniqueItemFromList (oCaller, iRandomNumber);
        object treasure = CreateLoot(sItemTemplate, oTarget, oPC);
        if (LOOT_INC_MAIN_DEBUGGING == TRUE)
            WriteTimestampedLogEntry (GetTag (oCaller) + " generated " + sItemTemplate);
    }
}

void GenTreasure(int nTreasureType, object oCreateOn, object oLastOpener) {
    if (nTreasureType == TREASURE_UNIQUE) {
        GenerateUniqueTreasure(OBJECT_SELF, oCreateOn, oLastOpener);
        if (oCreateOn == GetLastOpenedBy()) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_WORD), oCreateOn);
        }
    } else {
        GenerateTreasure(nTreasureType, oLastOpener, oCreateOn);
    }
}

void TreasureChest(int nTreasureType, object oCreateOn = OBJECT_SELF) {
    //SendMessageToPC(GetFirstPC(), "TreasureChest() enter");

    if (GetLocalInt(OBJECT_SELF, "NW_DO_ONCE") != 0) {
        return;
    }

    SetLocalInt(OBJECT_SELF, "NW_DO_ONCE", 1);

    object oLastOpener = GetLastOpenerOrKiller();
    object oMember = GetFirstFactionMember(oLastOpener, TRUE);

    while (GetIsObjectValid(oMember)) {
      GenTreasure(nTreasureType, oCreateOn, oMember);
      oMember = GetNextFactionMember(oLastOpener, TRUE);
    }
}

void TreasureChestLow() {
    TreasureChest(TREASURE_LOW);
}
void TreasureChestMedium() {
    TreasureChest(TREASURE_MEDIUM);
}
void TreasureChestHigh() {
    TreasureChest(TREASURE_HIGH);
}
void TreasureChestBoss() {
    TreasureChest(TREASURE_BOSS);
}
void TreasureChestBook() {
    TreasureChest(TREASURE_BOOK);
}
void TreasureChestUnique() {
    TreasureChest(TREASURE_UNIQUE, OBJECT_SELF);
}

object CreateLootChest() {
    // Locate the area we are in
    object oArea = GetArea(OBJECT_SELF);

    // Locate where in the are we are
    vector vPosition = GetPosition(OBJECT_SELF);

    // Identify the direction we are facing
    float fOrientation = GetFacing(OBJECT_SELF) - 180.0;
    if (fOrientation < 0.0) fOrientation = fOrientation + 360.0;

    // Create a new location with this information
    location loc = Location(oArea, vPosition, fOrientation);

    // 2, 4, 6
    // plc_lootbag4     // 16
    // x0_treasure_high // 10
    // x0_tres_anyhigh
    // plc_chest4
    // x3_plc_chest001
    // plc_treasurelrg / 191
    // x0_tres_goldlow // 189
    // x0_tres_goldmid // 190
    //object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, "x0_treasure_high", loc);
    object oChest = CreateObject(OBJECT_TYPE_PLACEABLE, "x0_tres_goldmed", loc);
    SetObjectVisualTransform(oChest, OBJECT_VISUAL_TRANSFORM_SCALE, 3.0);
    SetLocked(oChest, FALSE);
    SetName(oChest, "Loot");
    SetHardness(0, oChest);
    return oChest;
}

void FixDeadCreature(object creature) {
    //SendMessageToPC(GetFirstPC(), "FixDeadCreature()");
    //SetIsDestroyable(FALSE, FALSE, FALSE);
    SetIsDestroyable(TRUE, FALSE, FALSE);
    //DestroyObject(creature);
    return;

    object oItem = GetFirstItemInInventory(creature);
    int any = FALSE;
    while (GetIsObjectValid(oItem)) {
        string resref = GetResRef(oItem);
        int droppable = GetDroppableFlag(oItem);
        if (droppable) {
            any = TRUE;
        }
        //SendMessageToPC(GetFirstPC(), "DEAD ITEM " + GetName(oItem) + " drop:" + IntToString(droppable));
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }

    int gold = GetGold(creature);

    if (gold > 0) {
        any = TRUE;
        //SendMessageToPC(GetFirstPC(), "DEAD GOLD " + IntToString(gold));
    }

    if (!any) SetIsDestroyable(FALSE, FALSE, FALSE);
}

int IsEmpty(object creature) {
    // GetLastKiller() returns OBJECT_INVALID if called from other than OnDeath
    // isOnDeathUsage is true when we are called from OnDeath
    int isOnDeathUsage = GetIsObjectValid(GetLastKiller());
    if (isOnDeathUsage && GetLocalInt(creature, "JEFF_LOOT")) {
        return FALSE;
    }

    //SendMessageToPC(GetFirstPC(), "Is_Empty()  creature:" + IntToString(isOnDeathUsage));
    //int isContainer = GetIsObjectValid(GetLastOpenedBy());
    //SendMessageToPC(GetFirstPC(), "Is_Empty() container:" + IntToString(isContainer));

    object oItem = GetFirstItemInInventory(creature);
    while (OBJECT_INVALID != oItem) {
        int droppable = GetDroppableFlag(oItem);
        if (droppable) {
            //SendMessageToPC(GetFirstPC(), "Is_Empty() '" + GetName(oItem) + "'");
            return FALSE;
        }
        if (GetLocalInt(oItem, "JEFF_LOOT") > 0) {
            //SendMessageToPC(GetFirstPC(), "Is_Empty() JEFF '" + GetName(oItem) + "'");
            return FALSE;
        }
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }

    int i;
    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oItem = GetItemInSlot(i, creature);
        if (GetIsObjectValid(oItem) && GetDroppableFlag(oItem)) {
            //SendMessageToPC(GetFirstPC(), "Is_Empty() INV '" + GetName(oItem) + "'");
            return FALSE;
        }
    }

    if (GetGold(creature) > 0) {
        //SendMessageToPC(GetFirstPC(), "Is_Empty() gold");
        return FALSE;
    }

    //SendMessageToPC(GetFirstPC(), "Is_Empty() TRUE");
    return TRUE;
}

void PopulateLootForParty(object target, object oPC = OBJECT_INVALID) {
    if (GetLocalInt(OBJECT_SELF, "POPULATE_LOOT_ONCE") > 0) return;
    SetLocalInt(OBJECT_SELF, "POPULATE_LOOT_ONCE", 1);

    if (oPC == OBJECT_INVALID)
        oPC = GetLastOpenerOrKiller();

    if (!GetIsPC(oPC))
        oPC = GetFirstPC();

    int is_creature = IsDeadCreature();

    object oChest;
    //if (is_creature)
     //   oChest = CreateLootChest();
    //else
        oChest = target;

    //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() is_creature:" + IntToString(is_creature));
    int lootNum;
    for (lootNum = 1; lootNum < 8; lootNum++) {
        string lootKey = "loot" + IntToString(lootNum);
        string lootResRef = GetLocalString(target, lootKey);
        if (lootResRef == "") break;
       //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() 2 " + lootResRef);
        int nStackSize = GetLocalInt(target, lootKey + "_size");
        if (nStackSize < 1) nStackSize = 1;

        object oMember = GetFirstFactionMember(oPC, TRUE);
        int plot = GetLocalInt(target, lootKey + "_plot");
        int ident = GetLocalInt(target, lootKey + "_identified");
        while (GetIsObjectValid(oMember)) {
            //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() 3");
            object loot = CreateLoot(lootResRef, oChest, oMember, nStackSize);
            if(ident) SetIdentified(loot, TRUE);
            if(plot) SetPlotFlag(loot, TRUE);
            oMember = GetNextFactionMember(oPC, TRUE);
        }
    }

    int gold = GetLocalInt(target, "loot_gold");
    //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() gold = " + IntToString(gold));
    if (gold > 0) {
        object oMember = GetFirstFactionMember(oPC, TRUE);
        while (GetIsObjectValid(oMember)) {
            //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() gold #2 " + IntToString(gold));
            CreateLoot("nw_it_gold001", oChest, oMember, gold);
            oMember = GetNextFactionMember(oPC, TRUE);
        }
    }

    if (is_creature) {
        if (DoAllPlayersHaveLootGenie(GetFirstPC())) {
            //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() DoAllPlayersHaveLootGenie()");
            SetIsDestroyable(TRUE, FALSE, FALSE);
        // destroy loot bag if no loot added
        } else if (IsEmpty(oChest)) {
            //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() SetIsDestroyable()");
            SetIsDestroyable(TRUE, FALSE, FALSE);
            //FixDeadCreature(OBJECT_SELF);
            //DestroyObject(oChest);
        } else {
            object obj = GetFirstItemInInventory(oChest);
            //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() name:" + GetName(obj) + ", drop:" + IntToString(GetDroppableFlag(obj)) + ", gold:" + IntToString(GetGold(oChest)));
        }
    } else {
        //SendMessageToPC(GetFirstPC(), "PopulateLootForParty() not creature");
    }
}

int IsGold(string resref) {
    return -1 != FindSubString(resref, "it_gold");
}

int IsStackable(string resref) {
    resref = GetStringLowerCase(resref);

    if (-1 != FindSubString(resref, "it_gold")) return TRUE;
    if (-1 != FindSubString(resref, "it_medkit")) return TRUE;
    if (-1 != FindSubString(resref, "it_gem")) return TRUE;
    if (-1 != FindSubString(resref, "it_mpotion")) return TRUE;
    if (-1 != FindSubString(resref, "it_sparscr")) return TRUE;
    if (-1 != FindSubString(resref, "it_spdvscr")) return TRUE;
    if (-1 != FindSubString(resref, "_wammar")) return TRUE;
    if (-1 != FindSubString(resref, "_wamar")) return TRUE;

    return FALSE;
}

int IsStackableObject(object obj) {
    switch (GetBaseItemType(obj)) {
        case BASE_ITEM_ARROW:
        case BASE_ITEM_BOLT:
        case BASE_ITEM_BULLET:
        case BASE_ITEM_GEM:
        case BASE_ITEM_GOLD:
        case BASE_ITEM_POTIONS:
        case BASE_ITEM_SCROLL:
        case BASE_ITEM_SPELLSCROLL:
        case BASE_ITEM_THIEVESTOOLS:
        case BASE_ITEM_HEALERSKIT:
            //SendMessageToPC(GetFirstPC(), "stackable name=" + GetName(obj) + " resref=" + GetResRef(obj) + " ItemType=" + IntToString(GetBaseItemType(obj)));
            return TRUE;
            break;

        case BASE_ITEM_INVALID:
        default:
            return FALSE;
            break;
    }
    //SendMessageToPC(GetFirstPC(), "not stackable name=" + GetName(obj) + " resref=" + GetResRef(obj) + " ItemType=" + IntToString(GetBaseItemType(obj)));
    return FALSE;
}

int DoAllPlayersHaveLootGenie(object oPC) {
    object oMember = GetFirstFactionMember(oPC);
    while (GetIsObjectValid(oMember)) {
        if (GetItemPossessedBy(oMember, "D1_LOOT_GENIE") == OBJECT_INVALID)
            return FALSE;

        oMember = GetNextFactionMember(oPC);
    }

    return TRUE;
}

// For each item in the container, re-create a copy for each player and destroy the original item
// for each item in the current inventory set "loot.*" properties
// then PopulateLootForParty() will create items for each party member based on loot.* properties
void MoveInventoryLootToProperties() {
    //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() ENTER " + GetTag(OBJECT_SELF));
    if (GetLocalInt(OBJECT_SELF, "MOVE_LOOT_ONCE") > 0) return;
    SetLocalInt(OBJECT_SELF, "MOVE_LOOT_ONCE", 1);

    int allPlayersHaveLootGenie = DoAllPlayersHaveLootGenie(GetFirstPC());

    int gold = GetGold();
    if (gold > 0) {
        //SendMessageToPC(GetFirstPC(), "found gold " + IntToString(gold));
        TakeGold(gold, OBJECT_SELF, TRUE);
        //SendMessageToPC(GetFirstPC(), "gold left " + IntToString(GetGold()));
        SetLocalInt(OBJECT_SELF, "loot_gold", gold + GetLocalInt(OBJECT_SELF, "loot_gold"));
    }

    // Determine next available properties loot slot
    int loop = 1;
    while (GetLocalString(OBJECT_SELF, "loot" + IntToString(loop)) != "") {
        loop = loop + 1;
    }

    int isDeadCreature = IsDeadCreature();
    //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() 2 isDeadCreature=" + IntToString(isDeadCreature));
    object oItem = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oItem)) {
        string resref = GetResRef(oItem);
        //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() loop " + resref + " " + GetName(oItem) + " " + IntToString(GetItemStackSize(oItem)) + " " + IntToString(GetBaseItemType(oItem)));
        if (IsGold(resref)) {
            gold = gold + GetItemStackSize(oItem);
            SetLocalInt(OBJECT_SELF, "loot_gold", gold);
            //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() set gold stack size 0");
            SetItemStackSize(oItem, 0);
        } else {
            //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() 3 " + resref + " " + GetName(oItem) + " droppable:" + IntToString(GetDroppableFlag(oItem)));
            if (!isDeadCreature || GetDroppableFlag(oItem)) {
                //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() 5 DROPPABLE " + GetName(oItem));
                SetLocalString(OBJECT_SELF, "loot" + IntToString(loop), resref);
                SetLocalInt(OBJECT_SELF, "loot" + IntToString(loop) + "_size", GetItemStackSize(oItem));
                loop = loop + 1;
            }
        }

        // once you delete a stackable item it cannot be added back
        if (allPlayersHaveLootGenie || !IsStackableObject(oItem))
            DestroyObject(oItem);

        oItem = GetNextItemInInventory(OBJECT_SELF);
    }

    //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() PART2");

    int slot;
    for (slot = 0; slot < NUM_INVENTORY_SLOTS; ++slot) {
        oItem = GetItemInSlot(slot, OBJECT_SELF);
        string resref = GetResRef(oItem);
        string name = GetName(oItem);

        //if (resref != "" || name != "")
            //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() equip '" + resref + "' '" + name + "' drop:" + IntToString(GetDroppableFlag(oItem)));

        if (GetIsObjectValid(oItem) && GetDroppableFlag(oItem)) {
            if (!IsGold(GetResRef(oItem))) {
                //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() don't drop " + GetResRef(oItem));
                SetDroppableFlag(oItem, FALSE); // DestroyObject not working, but this prevents duplicate loot distribution.
            } else {
                //SendMessageToPC(GetFirstPC(), "MoveInventoryLootToProperties() do drop " + GetResRef(oItem));
            }
            SetLocalString(OBJECT_SELF, "loot" + IntToString(loop), GetResRef(oItem));
            SetLocalInt(OBJECT_SELF, "loot" + IntToString(loop) + "_size", GetItemStackSize(oItem));
            loop = loop + 1;
        }
        if (allPlayersHaveLootGenie || !IsStackableObject(oItem))
            DestroyObject(oItem);
    }

    //SendMessageToPC(GetFirstPC(), "FINAL gold " + IntToString(GetLocalInt(OBJECT_SELF, "loot_gold")));

}
