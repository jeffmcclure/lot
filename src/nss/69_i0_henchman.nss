//::///////////////////////////////////////////////
//:: Module Builders Henchman Kit v1.9
//:: 69_I0_HENCHMAN
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//void main() { }
/*
   This is the include file for the
   henchmen who can join the player.

   ASSUMPTION: All these functions
   are meant to be ran by the henchman.
   OBJECT_SELF is assumed to be the henchman.

   RULES: Henchman are dialog controlled only!
   No locals/globals should be set outside of the
   henchman's own dialog file!
*/
//:://////////////////////////////////////////////
//:: Created By:  Brent
//:: Created On:  February 2002
//:: Modified by: 69MEH69  21Jun2003
//:://////////////////////////////////////////////
#include "nw_i0_plot"
#include "nw_i0_generic"
#include "x0_i0_common"
//:: User Controlled Variables
//:: These are now set in 69_hen_spawnin
    // Defines maximum number of henchman the PC may have
    //int INT_NUM_HENCHMEN = GetLocalInt(OBJECT_SELF, "nNumHench");
    int INT_NUM_HENCHMEN = 1;

    /* Defines how many levels behind the PC the henchman lags
       Default of 1 specifies that the PC must be 1 level higher
       than the henchman to hire them
       Can be -3, -2, -1, 0, 1, 2, 3 etc., to use comment in*/
    //int HENCH_LAG = 0;
    //Set this in the individual OnSpawn script or comment out.
    int HENCH_LAG = GetLocalInt(OBJECT_SELF, "nHenchLag");

    /* Defines the highest level the henchman can be
       Minimum of 1, Maximum of 20
       Insure that you have this number of blueprints for your henchman */
    int HENCH_MAX = GetLocalInt(OBJECT_SELF, "nHenchMax");

//:: END User Variables

/**** variable names and suffixes ****/
string sHenchmanDeathVarname = "NW_L_HEN_I_DIED";
string sIsHiredVarname = "X0_IS_CURRENTLY_HIRED";
string sLastMasterVarname = "X0_LAST_MASTER_TAG";
string sHenchmanKilledSuffix = "_GOTKILLED";
string sHenchmanResurrectedSuffix = "_RESURRECTED";
string sHenchmanDyingVarname = "X0_HEN_IS_DYING";
string sStoredHenchmanVarname = "69_HEN_STORED";
string sStoredHenchmanName = "69_HEN_NAME_STORED";
string MH_MODE_ATTACK = "MH_MODE_ATTACK";

// Amount of time to pass between respawn checks
float DELAY_BETWEEN_RESPAWN_CHECKS = 3.0f;

// * duration henchmen play their die animations
float HENCHMEN_DIE_ANIM_DURATION = 6500000000.0f;

// The maximum length of the wait before respawn
float MAX_RESPAWN_WAIT = 60.0f;

// 69MEH69: DoLevelUp levels henchman to appropriate level
void DoLevelUp(object oPC, object MeLevel = OBJECT_SELF);

//69MEH69: Gets PC Master from multiple henchmen
object GetRealMaster(object henchman = OBJECT_SELF);

/*** DEATH FUNCTIONS ***/
// * Wrapper function added to fix bugs in the dying-state
// * process. Need to figure out whenever his value changes.
void SetHenchmanDying(object oHench=OBJECT_SELF, int bIsDying=TRUE);

// Set on the henchman to indicate s/he died; can also be used to
// unset this variable.
void SetDidDie(int bDie=TRUE, object oHench=OBJECT_SELF);

// Returns TRUE if the henchman died.
// UNLIKE original, does NOT reset the value -- use
// SetDidDie(FALSE) to do that.
int GetDidDie(object oHench=OBJECT_SELF);

// Set got killed
void SetKilled(object oPC, object oHench=OBJECT_SELF, int bKilled=TRUE);

// Determine if this PC got the henchman killed
int GetKilled(object oPC, object oHench=OBJECT_SELF);

// Set that this PC resurrected the henchman
void SetResurrected(object oPC, object oHench=OBJECT_SELF, int bResurrected=TRUE);

// Determine if this PC resurrected the henchman
int GetResurrected(object oPC, object oHench=OBJECT_SELF);

// Respawn the henchman, by preference at the master's current
// respawn point, or at the henchman's starting location otherwise.
void RespawnHenchman(object oHench=OBJECT_SELF);

// Keep dead by playing the appropriate death animation for the
// maximum wait until respawn.
void KeepDead(object oHench=OBJECT_SELF);

// Stop keeping dead by playing the 'woozy' standing animation.
void StopKeepingDead(object oHench=OBJECT_SELF);

// See if our maximum wait time has passed
int GetHasMaxWaitPassed(int nChecks);

// Set up before the respawn
void PreRespawnSetup(object oHench=OBJECT_SELF);

// Clean up after the respawn.
void PostRespawnCleanup(object oHench=OBJECT_SELF);

// Determine if this henchman is currently dying
int GetIsHenchmanDying(object oHench=OBJECT_SELF);

//Moves items in oHench inventory to oContainer inventory
void MoveHenchmanItems(object oContainer, object oHench);

// Store all items in the henchman's inventory in the campaign DB,
// skipping those items which have the henchman's tag in their
// name.
// This is paired with RetrieveHenchmanItems for the leveling-up
// process.
void StoreHenchmanItems(object oPC, object oHench);

// Retrieve (and then delete) all henchman inventory items out of
// the campaign DB, putting them in the inventory of the henchman.
// This is paired with StoreHenchmanItems for the leveling-up
// process.
void RetrieveHenchmanItems(object oPC, object oHench);

/**** HIRING FUNCTIONS ****/

// Determine whether the henchman is currently working
// for this PC.
int GetWorkingForPlayer(object oPC, object oHench=OBJECT_SELF);

// Indicate whether the player has ever hired this henchman in this
// campaign.
void SetPlayerHasHiredInCampaign(object oPC, object oHench=OBJECT_SELF, int bHired=TRUE);

// Sets the Henchman to be working for this PC
void SetWorkingForPlayer(object oPC, object oHench=OBJECT_SELF);

/***** MODULE TRANSFER FUNCTIONS *****/

// Call this function when the PC is about to leave a module
// to enable restoration of the henchman on re-entry into the
// sequel module. Both modules must use the same campaign db
// for this to work.
void StoreCampaignHenchman(object oPC);

// Call this function when a PC enters a sequel module to restore
// the henchman (complete with inventory). The function
// StoreCampaignHenchman must have been called first, and both
// modules must use the same campaign db. (See notes in x0_i0_campaign.)
//
// The restored henchman will automatically be re-hired and will be
// created next to the PC.
void RetrieveCampaignHenchman(object oPC);

void RetrieveCampaignHenchmanNames(object oPC);

/**********************************************************************
 * FUNCTION DEFINITIONS
 **********************************************************************/
object PC()
{
    return GetRealMaster();
}

// * had to add this commandable wrapper to track down a bug in the henchmen
void WrapCommandable(int bCommand, object oHench)
{
/*   string s ="";
    if (bCommand)
        s = "TRUE";
    else
        s = "FALSE";
    SendMessageToPC(GetFirstPC(), GetName(OBJECT_SELF) + " commandable set to " + s);*/
    while (GetCommandable(oHench) != bCommand)
    {
        SetCommandable(bCommand, oHench);
    }
}

void brentDebug(string s)
{
   // SendMessageToPC(GetFirstPC(), s);
}

//::///////////////////////////////////////////////
//:: Set/GetBeenHired
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Henchmen can only be hired once, ever.
  This checks or sets the local on the henchmen
  that keeps track whether they've ever been hired.
  STORED: On Henchman
  RETURNS: Boolean
*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
void SetBeenHired(int bHired=TRUE, object oTarget=OBJECT_SELF)
{
    SetLocalInt(oTarget,"NW_L_HENHIRED",10);
}
int GetBeenHired(object oTarget=OBJECT_SELF)
{
    return GetLocalInt(oTarget,"NW_L_HENHIRED") == 10;
}
// * This local is on the player
// * it is true if this particular henchman
// * is working for the player
void SetWorkingForPlayer(object oPC, object oHench=OBJECT_SELF)
{
    SetLocalInt(oPC,"NW_L_HIRED" + GetTag(OBJECT_SELF),10);
    SetLocalInt(oHench, "NW_FORMERHENCH_CHECK", FALSE);
}
int GetWorkingForPlayer(object oPC, object oHench=OBJECT_SELF)
{
    return GetLocalInt(oPC,"NW_L_HIRED" + GetTag(OBJECT_SELF)) == 10;
}

// * to see if the player is the former master of the henchman
object GetFormerMaster(object oHench = OBJECT_SELF)
{
   return GetLocalObject(oHench,"NW_L_FORMERMASTER");
}

void SetFormerMaster(object oPC, object oHench)
{
   SetLocalObject(oHench,"NW_L_FORMERMASTER", oPC);
   SetLocalInt(oHench, "NW_FORMERHENCH_CHECK", TRUE);
}

// Set whether the henchman quit this player's employ
void SetDidQuit(object oPC, object oHench=OBJECT_SELF, int bQuit=TRUE)
{
    if (!GetIsObjectValid(oHench)) {return;}
    SetFormerMaster(oPC, oHench);
    SetBooleanValue(oPC, GetTag(oHench) + sDidQuitSuffix, bQuit);
}

// Determine if the henchman quit
int GetDidQuit(object oPC, object oHench=OBJECT_SELF)
{
    if (!GetIsObjectValid(oHench)) {return FALSE;}
    return GetBooleanValue(oPC, GetTag(oHench) + sDidQuitSuffix);
}

//Written by 69MEH69 03Sep2002
//Checks to see whether or not the PC can hire the NPC
int GetCanWork(object oHirer, object oHiree)
{
 int nHench = GetLocalInt(oHirer, "nHench");
 //string sHench = IntToString(nHench);
 //SendMessageToPC(oHirer, "You have " +sHench+ " henchmen");
 int nHirer = GetHitDice(oHirer);
 int nHiree = GetHitDice(oHiree);
 int nLevel = nHirer - nHiree;
 if((nLevel < HENCH_LAG) || (nHench == INT_NUM_HENCHMEN))
 {
   return FALSE;
 }
 return TRUE;
}

//69MEH69 GetRealMaster Code
object GetRealMaster(object henchman=OBJECT_SELF)
{
    object master = GetMaster(henchman);
    if (GetIsObjectValid(master))
    {
        while (GetIsObjectValid(GetMaster(master)))
        {
            master = GetMaster(master);
        }
    }
    return master;
}

//::///////////////////////////////////////////////
//:: Level Up Functions
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  These functions check if henchmen is 'capable'
  of levelling up and also can level him up
  by swapping him with a different file (always
  one level less than the player).
  Can only level up if player is 2 or more levels
  higher than henchman.
  MIN = Level 4
  MAX = Level 14
  RETURNS: Boolean
  */
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On:
//:://////////////////////////////////////////////
int GetCanLevelUp(object oPC, object oMeLevel = OBJECT_SELF)
{
    int nMasterLevel = GetHitDice(oPC);
    int nMyLevel = GetHitDice(oMeLevel);
    //string sMasterLevel = IntToString(nMasterLevel);
    //string sMyLevel = IntToString(nMyLevel);
    //SendMessageToPC(oPC, "My level is " +sMasterLevel+ ", Hench level is " +sMyLevel);
    if ((nMasterLevel > (nMyLevel + HENCH_LAG)) && (nMyLevel < HENCH_MAX))  //was (nMasterLevel >=  (nMyLevel + 2))
    {
        return TRUE;
    }
    else
     return FALSE;
}

void MoveHenchmanItems(object oContainer, object oHench)
{
 object oItem, oNewItem;
 int i;

 oItem = GetFirstItemInInventory(oHench);
 while(GetIsObjectValid(oItem))
 {
  oNewItem = CopyItem(oItem, oContainer);
  DestroyObject(oItem, 0.2);
  //AssignCommand(oHench, ActionGiveItem(oItem, oContainer));
  oItem = GetNextItemInInventory(oHench);
 }

 for (i=0; i < NUM_INVENTORY_SLOTS; i++)
 {
   oItem = GetItemInSlot(i, oHench);
   if (GetIsObjectValid(oItem))
   {
    if(oItem != GetItemInSlot(INVENTORY_SLOT_CHEST, oHench))
    {
     ActionGiveItem(oItem, oContainer);
    }
   }
 }
}

// Store all items in the henchman's inventory in the campaign DB.
void StoreHenchmanItems(object oPC, object oHench)
{
    string sHenchTag = GetTag(oHench);

    string sTag;
    object oItem;
    int nNth = 0;
    string sItemName; string sVarname;

    // Mark and store equipped items
    int i;
    for (i=0; i < NUM_INVENTORY_SLOTS; i++) {
        oItem = GetItemInSlot(i, oHench);
        if (GetIsObjectValid(oItem)) {
            sItemName = GetTag(oItem);
            //SendMessageToPC(oPC, "Found equipped item " + sItemName);

            // store the slot number + 1 so when we
            // retrieve a 0 can be treated as unequipped
            SetLocalInt(oPC, "HENCH_HAS_EQUIPPED_" + sItemName, i+1);

            if (FindSubString(sItemName, sHenchTag) == -1) {
                // put it in the db
                sVarname = sHenchTag + "_ITEM_" + IntToString(nNth);
                SendMessageToPC(oPC, "Storing equipped item: " + sItemName
                        + ", varname " + sVarname);
                nNth++;
                StoreCampaignDBObject(oPC, sVarname, oItem);
            }
        }
    }

    // Store all the henchman inventory in the campaign db
    oItem = GetFirstItemInInventory(oHench);
    while (GetIsObjectValid(oItem)) {
        sItemName = GetTag(oItem);
        //SendMessageToPC(oPC, "Found item " + sItemName);
        if (FindSubString(sItemName, sHenchTag) == -1) {
            // put it in the db
            sVarname = sHenchTag + "_ITEM_" + IntToString(nNth);
            //SendMessageToPC(oPC, "Storing item: " + sItemName + ", varname " + sVarname);
            nNth++;
            StoreCampaignDBObject(oPC, sVarname, oItem);
        }

        oItem = GetNextItemInInventory(oHench);
    }
}


// Retrieve (and then delete) all henchman inventory items out of
// the campaign DB, putting them in the inventory of the henchman.
void RetrieveHenchmanItems(object oPC, object oHench)
{
    location lHench  = GetLocation(oHench);
    string sHenchTag = GetTag(oHench);
    int nNth = 0; int nSlot = -1;
    object oCurItem = OBJECT_INVALID;

    string sVarname = sHenchTag + "_ITEM_0";

    object oItem = RetrieveCampaignDBObject(oPC, sVarname, lHench, oHench);
    string sItemName = GetTag(oItem);

    //SendMessageToPC(oPC, "Retrieving item " + sItemName + ", varname: " + sVarname);
    while (GetIsObjectValid(oItem)) {
        DeleteCampaignDBVariable(oPC, sVarname);
        nNth++;
        sVarname = sHenchTag + "_ITEM_" + IntToString(nNth);
        oItem = RetrieveCampaignDBObject(oPC, sVarname, lHench, oHench);
        sItemName = GetTag(oItem);
        //SendMessageToPC(oPC, "Retrieving item " + sItemName + ", varname: " + sVarname);
    }

    // Now run through inventory and restore equipped items
    oItem = GetFirstItemInInventory(oHench);
    while (GetIsObjectValid(oItem)) {
        sItemName = GetTag(oItem);

        // Above, we stored the slot + 1 so we could treat a 0
        // as meaning "not equipped".
        nSlot = GetLocalInt(oPC, "HENCH_HAS_EQUIPPED_" + sItemName) - 1;
        if (nSlot != -1) {
            //SendMessageToPC(oPC, "Item was equipped in slot " + IntToString(nSlot));
            DeleteLocalInt(oPC, "HENCH_HAS_EQUIPPED_" + sItemName);
            oCurItem = GetItemInSlot(nSlot, oHench);
            if (GetIsObjectValid(oCurItem)) {
                AssignCommand(oHench, ActionUnequipItem(oCurItem));
            }
            AssignCommand(oHench, ActionEquipItem(oItem, nSlot));
        }
        oItem = GetNextItemInInventory(oHench);
    }
}

/***** MODULE TRANSFER FUNCTIONS *****/

// Call this function when the PC is about to leave a module
// to enable restoration of the henchman on re-entry into the
// sequel module. Both modules must use the same campaign db
// for this to work.
void StoreCampaignHenchman(object oPC)
{
    object oHench = GetHenchman(oPC);
    int nHench = 1;
    string sHench;
    if (!GetIsObjectValid(oHench)) {
        DBG_msg("No valid henchman to store");
        return;
     }
    while(GetIsObjectValid(oHench))
    {
    sHench == IntToString(nHench);
    SetCampaignDBString(oPC, sStoredHenchmanName +sHench, GetName(oHench));
    DBG_msg("Storing henchman "+sHench+": " + GetTag(oHench));
    int ret = StoreCampaignDBObject(oPC, sStoredHenchmanVarname + sHench, oHench);
    SendMessageToPC(oPC, GetName(oHench));
    if (!ret) {
        DBG_msg("Error attempting to store henchman");
    } else {
        DBG_msg("Henchman stored successfully");
    }
    oHench = GetHenchman(oHench);
    nHench++;
    }

}

// Call this function when a PC enters a sequel module to restore
// the henchman (complete with inventory). The function
// StoreCampaignHenchman must have been called first, and both
// modules must use the same campaign db. (See notes in x0_i0_campaign.)
//
// The restored henchman will automatically be re-hired and will be
// created next to the PC.
//
// Any object in the module with the same tag as the henchman will be
// destroyed (to remove duplicates).
void RetrieveCampaignHenchman(object oPC)
{
    location lLoc = GetLocation(oPC);
    int nHench = 1;
    string sHench = IntToString(nHench);
    object oHench = RetrieveCampaignDBObject(oPC, sStoredHenchmanVarname +sHench, lLoc);
    while(GetIsObjectValid(oHench))
    {
    // Delete the henchman object from the db
    DelayCommand(0.5, DeleteCampaignDBVariable(oPC, sStoredHenchmanVarname));

    if (GetIsObjectValid(oHench)) {
        DelayCommand(0.5, AddHenchman(oPC, oHench));

        object oHenchDupe = GetNearestObjectByTag(GetTag(oHench),
                                                  oHench);
        if (GetIsObjectValid(oHenchDupe) && oHenchDupe != oHench) {
            DestroyObject(oHenchDupe);
        }
    } else {
        SendMessageToPC(oPC, "No valid henchman retrieved");
    }
    nHench++;
    sHench = IntToString(nHench);
    oPC = oHench;
    oHench = RetrieveCampaignDBObject(oPC, sStoredHenchmanVarname +sHench, lLoc);
    }
}

void RetrieveCampaignHenchmanNames(object oPC)
{
 SendMessageToPC(oPC, "The Campaign Data Base Name is " +GetCampaignDBName());
 int nHench = 1;
 string sHench = IntToString(nHench);
 string sHenchName = GetCampaignDBString(oPC, sStoredHenchmanName +sHench);
 if(sHenchName == "")
 {
  SendMessageToPC(oPC, "There are no henchman names saved. " +sStoredHenchmanName);
 }
 else{SendMessageToPC(oPC, "The henchmen are: ");}
 while(GetCampaignDBString(oPC, sStoredHenchmanName + sHench) != "")
 {
  SendMessageToPC(oPC, sHenchName);
  nHench++;
  sHench = IntToString(nHench);
  sHenchName = GetCampaignDBString(oPC, sStoredHenchmanName + sHench);
 }
}
//::///////////////////////////////////////////////
//:: CopyLocals
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Copies locals from the 'earlier'
    level henchmen to the newer henchman.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:
//:://////////////////////////////////////////////
void CopyLocals(object oSource, object oTarget)
{
//    AssignCommand(PC(), SpeakString("in here"));
//    AssignCommand(oTarget, SpeakString("I exist"));
    if (GetIsObjectValid(oTarget) == FALSE)
    {
        AssignCommand(PC(), SpeakString("Target invalid"));
    }
    else
    if (GetIsObjectValid(oSource) == FALSE)
    {
        AssignCommand(PC(), SpeakString("Source invalid"));
    }
  SetBeenHired(GetBeenHired(oSource), oTarget);
  SetLocalInt(oTarget, "NW_ASSOCIATE_MASTER", GetLocalInt(oSource, "NW_ASSOCIATE_MASTER"));
  SetLocalInt(oTarget, "HenchRange", GetLocalInt(oSource, "HenchRange"));
  SetLocalInt(oTarget, "DoNotCastMelee", GetLocalInt(oSource, "DoNotCastMelee"));
  }
// * assumes that a succesful GetCanLevelUp has already
// * been tested.    Will level up character to one level
// * less than player.
// * meLevel defaults to object self unless another object is passed in
// * returns the new creature

// 69MEH69: DoLevelUp levels henchman to appropriate level
void DoLevelUp(object oPC, object MeLevel = OBJECT_SELF)
{
   int  i;
   int nMasterLevel = GetHitDice(oPC);
   int nLevel =  nMasterLevel - HENCH_LAG; //was 1
   int nNewClass = GetLocalInt(MeLevel, "NewClass");
   object oItem,oCopy;
   int nNewLevel;
   string sNewLevel;

   //AssignCommand(MeLevel, SetIsDestroyable(TRUE, FALSE, FALSE));
   if(nNewClass == 0)
   {
    nNewClass = GetClassByPosition(1, MeLevel);
   }

   // * Copy variables to the PC for 'safekeeping'
  //CopyLocals(MeLevel, oPC);

   // * will not spawn henchmen higher than this
   // * level (+ INT_FUDGE) (i.e., 14)
   if (nLevel >= HENCH_MAX)   //was 11
     nLevel = HENCH_MAX;     //was 11

   // * if already the highest level henchmen
   // * then do nothing.
   if (GetHitDice(MeLevel) >= nLevel)
   {
    return;
   }
   //ClearAllActions();
   nNewLevel = GetHitDice(MeLevel);

   //object oMaster = GetMaster(MeLevel);
   //SpeakString("Levelling Up");
   while(nNewLevel < nLevel)
   {
    nNewLevel = LevelUpHenchman(MeLevel, nNewClass, TRUE);
    sNewLevel = IntToString(nNewLevel);
    //SendMessageToPC(oPC, GetName(MeLevel) + " level is " + sNewLevel);

    if(nNewLevel == 0)
    {
     SendMessageToPC(oPC, GetName(MeLevel) + " level up failed");
     return;
    }
   }

   //DelayCommand(0.4, CopyLocals(oPC, MeLevel));
   return;

}

// Used when the henchman quits
void QuitHenchman(object oPC, object oHench=OBJECT_SELF)
{
    SetDidQuit(oPC, oHench, TRUE);
    //FireHenchman(oPC, oHench);
}

// Indicate whether the player has ever hired this henchman in this
// campaign.
void SetPlayerHasHiredInCampaign(object oPC, object oHench=OBJECT_SELF, int bHired=TRUE)
{
    if (!GetIsObjectValid(oHench)) {return;}
    SetCampaignBooleanValue(oPC, GetTag(oHench) + sHasHiredSuffix, bHired);
}

// Indicate whether the player has ever hired this henchman in this
// campaign.
int GetPlayerHasHiredInCampaign(object oPC, object oHench=OBJECT_SELF)
{
    if (!GetIsObjectValid(oHench)) {return FALSE;}
    return GetCampaignBooleanValue(oPC, GetTag(oHench) + sHasHiredSuffix);
}

/*** DEATH FUNCTIONS ***/

// Set on the henchman to indicate s/he died; can also be used to
// unset this variable.
void SetDidDie(int bDie=TRUE, object oHench=OBJECT_SELF)
{
    SetBooleanValue(oHench, sHenchmanDeathVarname, bDie);
}

// Returns TRUE if the henchman died
int GetDidDie(object oHench=OBJECT_SELF)
{
    return GetBooleanValue(oHench, sHenchmanDeathVarname);
}

// Set got killed
void SetKilled(object oPC, object oHench=OBJECT_SELF, int bKilled=TRUE)
{
    SetBooleanValue(oPC, GetTag(oHench) + sHenchmanKilledSuffix, bKilled);
}

// Determine if this PC got the henchman killed
int GetKilled(object oPC, object oHench=OBJECT_SELF)
{
    return GetBooleanValue(oPC, GetTag(oHench) + sHenchmanKilledSuffix);
}

// Set that this PC resurrected the henchman
void SetResurrected(object oPC, object oHench=OBJECT_SELF, int bResurrected=TRUE)
{
    SetBooleanValue(oPC, GetTag(oHench) + sHenchmanResurrectedSuffix, bResurrected);
}

// Determine if this PC resurrected the henchman
int GetResurrected(object oPC, object oHench=OBJECT_SELF)
{
    return GetBooleanValue(oPC, GetTag(oHench) + sHenchmanResurrectedSuffix);
}

// Keep dead by playing the appropriate death animation for the
// maximum wait until respawn.
void KeepDead(object oHench=OBJECT_SELF)
{   // SpawnScriptDebugger();
    DelayCommand(0.1, WrapCommandable(TRUE, oHench));
    DelayCommand(0.2,
        AssignCommand(oHench,
                      ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,
                                          1.0, HENCHMEN_DIE_ANIM_DURATION)));
    DelayCommand(0.3, WrapCommandable(FALSE, oHench));
}

// Stop keeping dead by playing the 'woozy' standing animation.
void StopKeepingDead(object oHench=OBJECT_SELF)
{
    DelayCommand(0.1, WrapCommandable(TRUE, oHench));
    DelayCommand(0.2,
                 AssignCommand(oHench,
                               PlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,
                                             1.0, 6.0)));
    DelayCommand(0.3, WrapCommandable(FALSE, oHench));
}

// Does a partial restoration to get rid of negative effects
void PartialRes(object oHench)
{
    RemoveEffects(oHench);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oHench);
}

// See if our maximum wait time has passed
int GetHasMaxWaitPassed(int nChecks)
{
    return ( (nChecks * DELAY_BETWEEN_RESPAWN_CHECKS) >= MAX_RESPAWN_WAIT ) ;
}

void PreRespawnSetup(object oHench=OBJECT_SELF)
{
    // Mark us as in the process of dying
    SetHenchmanDying(oHench, TRUE);

    // Indicate the henchman died

    // Mark henchman PLOT & Busy
    //SetPlotFlag(oHench, TRUE);
    SetAssociateState(NW_ASC_IS_BUSY, FALSE, oHench);

    // Make henchman's corpse stick around,
    // be raiseable, and selectable
    AssignCommand(oHench, SetIsDestroyable(FALSE, TRUE, TRUE));

    //AssignCommand(oHench, ClearActions(CLEAR_X0_I0_HENCHMAN_PreRespawn, TRUE));
}


void PostRespawnCleanup(object oHench=OBJECT_SELF)
{
    string sTag = GetTag(oHench);
    object oBackpack = GetObjectByTag(sTag+ "BAG");

    DelayCommand(0.5, RemoveEffects(oHench));

    DelayCommand(1.0,
                 SetHenchmanDying(oHench, FALSE));

    // Clear henchman being busy
    DelayCommand(1.1,
                 SetAssociateState(NW_ASC_IS_BUSY, FALSE, oHench));

    // Clear the plot flag
    DelayCommand(1.2, SetPlotFlag(oHench, FALSE));

    DelayCommand(1.3, SetLocalInt(oHench, MH_MODE_ATTACK, TRUE));
    DelayCommand(1.4, SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE));
    DelayCommand(1.5, SetIsDestroyable(TRUE, TRUE, TRUE));
    if(GetIsObjectValid(oBackpack))
    {
     DelayCommand(1.6, MoveHenchmanItems(oHench, oBackpack));
     DelayCommand(2.0, AssignCommand(oHench, ActionPickUpItem(oBackpack)));
     DelayCommand(2.5, DestroyObject(oBackpack));
    }
}

// Determine if this henchman is currently dying
int GetIsHenchmanDying(object oHench=OBJECT_SELF)
{
    int bHenchmanDying = GetAssociateState(NW_ASC_MODE_DYING, oHench);
    if (bHenchmanDying == TRUE)
    {
        brentDebug("henchman is dying");
        return TRUE;
    }
    else
    {
        brentDebug("Henchman is not dying");
        return FALSE;
    }
}

// * Wrapper function added to fix bugs in the dying-state
// * process. Need to figure out whenever his value changes.
void SetHenchmanDying(object oHench=OBJECT_SELF, int bIsDying=TRUE)
{
    SetAssociateState(NW_ASC_MODE_DYING, bIsDying, oHench);
    brentDebug("In SetHenchmanDying. Value for " + GetName(oHench) + " is " + IntToString(bIsDying));
   // GetIsHenchmanDying();
}
