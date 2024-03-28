//::///////////////////////////////////////////////
//:: hench_i0_henutil (parts from the original NW_I0_HENCHMAN)
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//void main() { } int GetIsHumanoid(int nRacial) { return 0; }
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
//:://////////////////////////////////////////////
// * ---------
// * CONSTANTS
// * ---------

#include "hench_i0_ident"
#include "hench_i0_strings"


int GetIsHumanoid(int nRacial);


// Check to see if the item was successfully equipped.

void CheckIsEquipped(object oItem, int iSlot, string sDescr)
{

  object oWorn = GetItemInSlot(iSlot);

  if (oWorn != oItem) {
    if (oWorn == OBJECT_INVALID ||
        GetGoldPieceValue(oWorn) / GetNumStackedItems(oWorn) < GetGoldPieceValue(oItem)/GetNumStackedItems(oItem))
        SpeakString(sHenchUnableToEquip1 + sDescr + sHenchUnableToEquip2);
    else
      SpeakString(sHenchUnableToEquip3 + sDescr + sHenchUnableToEquip4);
  } else
    SpeakString(sHenchAbleToEquip + sDescr + ".");
}


// Equip an item in iSlot, or optionally in iOtherSlot if iSlot is full.
void EquipIfWorthIt(object oItem, int iSlot, string sDescr,
    int iOtherSlot=500)
{
    string sName;

    // These variables store the value of the most valuable
    // object in the NPC's inventory examined thus far. They are set
    // to -1 at the beginning of inventory control.
    string sSlotVar = "Invent"+IntToString(iSlot);
    string sSlotVarName = "InventName"+IntToString(iSlot);
    string sOtherVar = "Invent"+IntToString(iOtherSlot);
    int iStoredValue = GetLocalInt(OBJECT_SELF,sSlotVar);
    int iOtherValue = GetLocalInt(OBJECT_SELF,sOtherVar);
    int iNewValue = 0;

    // Don't want to reveal the object's name unless it's already
    // identified. Again, assign unidentified items a nominal value of 1.
    if (GetIdentified(oItem)) {
      sName = GetName(oItem);
      iNewValue = GetGoldPieceValue(oItem) / GetNumStackedItems(oItem);
    }
    else {
      sName = "unidentified "+sDescr;
      iNewValue = 1;
    }

    // If we are already equipping something in the given slot, get its value.
    // Unidentified items have a nominal value of 1. Note: this only works with
    // items equipped before inventory control.
    if (iStoredValue == -1) {
      object oOld = GetItemInSlot(iSlot);
      if (GetIsObjectValid(oOld) && !GetLocalInt(oOld,"DestroyItem") &&
      oOld != GetLocalObject(OBJECT_SELF,"Decency")) {
        TalentIdentify(oOld);
    //SpeakString(GetName(oOld)+GetName(oItem)+IntToString(GetGoldPieceValue(oOld)/GetNumStackedItems(oOld))+
        //            " "+IntToString(GetGoldPieceValue(oItem)/GetNumStackedItems(oItem)));
    if (GetIdentified(oOld)) {
      iStoredValue = GetGoldPieceValue(oOld) / GetNumStackedItems(oOld);
          SetLocalString(OBJECT_SELF,sSlotVarName,GetName(oOld));
        }
    else {
      iStoredValue = 1;
          SetLocalString(OBJECT_SELF,sSlotVarName,"unidentifed "+GetName(oOld));
        }
    SetLocalInt(OBJECT_SELF,sSlotVar,iStoredValue);
      }
    }

    // If we already have considered an item of this type, we need to
    // juggle the inventory.
    if (iStoredValue >= 0) {

      // If we have another slot in which we can equip this item,
      // and if the item in the other slot is not better than the item in
      // the current iSlot, then run the function on that other slot.

      if (iNewValue > iOtherValue && iOtherSlot != 500)
    if (iOtherValue < iStoredValue) {
      EquipIfWorthIt(oItem,iOtherSlot,sDescr);
      return;
    }

      // If the item is better than what we had before, tell the player so and
      // store its value. Otherwise, tell the player and do nothing else.

      if (iNewValue > iStoredValue)
    SpeakString(sHenchSelectItem1 + sName + ".");
      else if (iNewValue < iStoredValue) {
    SpeakString(sHenchSelectItem2 + GetLocalString(OBJECT_SELF, sSlotVarName) +
                sHenchSelectItem3 + sName+ ".");
    return;
      }
      else if (iStoredValue > 0)
        SpeakString(sHenchDecisions);
    }

    // Now attempt to equip the items, and after a suitable time, check
    // to see if the the attempt succeeds.
    SetLocalInt(OBJECT_SELF,sSlotVar,iNewValue);

    SetLocalString(OBJECT_SELF,sSlotVarName,sName);
    ActionDoCommand(ActionEquipItem(oItem,iSlot));
    DelayCommand(2.,CheckIsEquipped(oItem,iSlot,sName));
}


// Try to figure out what to do with an item.
void EquipItems(object oSource)
{
  int i;
  object oItem;

  DestroyObject(oSource,0.0);

  for (i = 0; i < NUM_INVENTORY_SLOTS; ++i)
    SetLocalInt(OBJECT_SELF,"Invent"+IntToString(i),-1);

  SetLocalInt(OBJECT_SELF,"GotAWeapon",FALSE);

  oItem = GetFirstItemInInventory();

  while (GetIsObjectValid(oItem)) {
    if (!GetLocalInt(oItem,"DestroyItem")) {
      TalentIdentify(oItem);
      switch (GetBaseItemType(oItem)) {

      case BASE_ITEM_ARMOR:
        EquipIfWorthIt(oItem,INVENTORY_SLOT_CHEST, sHenchEquipArmor);
        break;

      case BASE_ITEM_LARGESHIELD:
      case BASE_ITEM_SMALLSHIELD:
      case BASE_ITEM_TOWERSHIELD:
        SpeakString(sHenchEquipShield);
        break;

      case BASE_ITEM_CLOAK:
        EquipIfWorthIt(oItem,INVENTORY_SLOT_CLOAK, sHenchEquipCloak);
        break;

      case BASE_ITEM_BOOTS:
        EquipIfWorthIt(oItem,INVENTORY_SLOT_BOOTS, sHenchEquipBoots);
        break;

      case BASE_ITEM_BRACER:
      case BASE_ITEM_GLOVES:
        EquipIfWorthIt(oItem,INVENTORY_SLOT_ARMS, sHenchEquipHandwear);
        break;

      case BASE_ITEM_HELMET:
        EquipIfWorthIt(oItem,INVENTORY_SLOT_HEAD, sHenchEquipHelmet);
        break;

      case BASE_ITEM_BELT:
        EquipIfWorthIt(oItem,INVENTORY_SLOT_BELT, sHenchEquipBelt);
        break;

      case BASE_ITEM_RING:
        EquipIfWorthIt(oItem,INVENTORY_SLOT_LEFTRING, sHenchEquipRing, INVENTORY_SLOT_RIGHTRING);
        break;

      case BASE_ITEM_AMULET:
        EquipIfWorthIt(oItem,INVENTORY_SLOT_NECK, sHenchEquipAmulet);
        break;

        // These items are auto-equipped by the ActionEquipMostDamagingRanged() command
      case BASE_ITEM_ARROW:
      case BASE_ITEM_BULLET:
      case BASE_ITEM_BOLT:

        // THESE SHOULD BE EDITED SO THAT THE HENCHMAN DEALS WITH THEM
        // PROPERLY. FOR NOW THEY ARE IGNORED
      case BASE_ITEM_CREATUREITEM:
      case BASE_ITEM_GEM:
      case BASE_ITEM_KEY:
      case BASE_ITEM_MAGICROD:
      case BASE_ITEM_MAGICSTAFF:
      case BASE_ITEM_MAGICWAND:
      case BASE_ITEM_POTIONS:
      case BASE_ITEM_SPELLSCROLL:
      case BASE_ITEM_THIEVESTOOLS:
      case BASE_ITEM_TRAPKIT:
      case BASE_ITEM_TORCH:     // done by equip shield
        break;
      default:
        if (!GetLocalInt(OBJECT_SELF,"GotAWeapon"))
        {
            SpeakString(sHenchEquipWeapon);
            SetLocalInt(OBJECT_SELF,"GotAWeapon",TRUE);
      }
      break;
      }
   }
   oItem = GetNextItemInInventory();
  }
  SpeakString(sHenchEquipWait);
}


void DestroyDecency(int bIndicateNoClothes)
{
    object oDecency = GetLocalObject(OBJECT_SELF,"Decency");

    if (GetItemInSlot(INVENTORY_SLOT_CHEST) != oDecency)
    {
        DestroyObject(oDecency);
        DeleteLocalObject(OBJECT_SELF,"Decency");
    }
    else if (bIndicateNoClothes && GetIsHumanoid(GetRacialType(OBJECT_SELF)))
    {
        SpeakString(sHenchEquipDecency);
    }
}


    // Copy associate's inventory.
void CopyAssociateItems(object oPC, object oAssociate)
{
    object oItem;
    int i;
    for(i = 0; i < NUM_INVENTORY_SLOTS; ++i)
    {
        oItem = GetItemInSlot(i, oAssociate);
        if (oItem != OBJECT_INVALID)
        {
            switch (GetBaseItemType(oItem))
            {
            case BASE_ITEM_CREATUREITEM:
            case BASE_ITEM_CBLUDGWEAPON:
            case BASE_ITEM_CSLASHWEAPON:
            case BASE_ITEM_CSLSHPRCWEAP:
            case BASE_ITEM_CPIERCWEAPON:
                break;
            case BASE_ITEM_DAGGER:
                // prevent pixie dagger from being given up
                if (!GetDroppableFlag(oItem))
                {
                    break;
                }
            default:
                CopyItem(oItem, oPC);
                break;
            }
        }
    }
        // Now go through the backpack.
    oItem = GetFirstItemInInventory(oAssociate);
    while (oItem != OBJECT_INVALID)
    {
        CopyItem(oItem, oPC);
        oItem = GetNextItemInInventory(oAssociate);
    }
}


    // Copy familiar/animal companion's inventory.
void CopyFamiliarAnimalCompanionItems(object oPC)
{
    if (!GetIsObjectValid(oPC))
    {
        return;
    }
    
    object oAssociate;
    
    oAssociate = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    if (GetIsObjectValid(oAssociate))
    {
        CopyAssociateItems(oPC, oAssociate);
    }
    oAssociate = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    if (GetIsObjectValid(oAssociate))
    {
        CopyAssociateItems(oPC, oAssociate);
    }
}


void DestroyAssociates(object oCreature)
{
// Checking for henchman summons/familiars/animal companions/dominated
// and destroying them to prevent them going hostile.
    if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oCreature)))
    {
        effect eUnSum = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        location lUnSum = GetLocation(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oCreature));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnSum, lUnSum, 5.0);
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oCreature));
    }
    if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCreature)))
    {
        effect eUnSum = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        location lUnSum = GetLocation(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCreature));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnSum, lUnSum, 5.0);
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oCreature));
    }
    if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oCreature)))
    {
        effect eUnSum = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        location lUnSum = GetLocation(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oCreature));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnSum, lUnSum, 5.0);
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oCreature));
    }
    if (GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_DOMINATED, oCreature)))
    {
        effect eUnSum = EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
        location lUnSum = GetLocation(GetAssociate(ASSOCIATE_TYPE_DOMINATED, oCreature));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnSum, lUnSum, 5.0);
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_DOMINATED, oCreature));
    }
}
