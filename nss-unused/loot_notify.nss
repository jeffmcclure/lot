//::///////////////////////////////////////////////
//:: Name: Party notification on loot accquisition
//:: FileName: loot_notify
//:: Copyright (c) 2002 Jeremy Sager
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Jeremy Sager Jeremy_21117@hotmail.com
//:: Created On: 08/19/2002
//:: Version 1.2 08/22/2001
//:://////////////////////////////////////////////

/*

This script notifies party members every time an item is accquired
by a party member UNLESS it meets one of the conditions defined below.
Examples would be not reporting store bought items, or items given from
one PC to another. Feel free to add your own conditionals in below.

It should be placed in the Module's OnAcquire Event unless you're
using HCR or you have another script of your own in there...

If you are using this with the HCR ruleset, follow these instructions:

#1  Open the file hcr_inc_on_acq.
#2  In the function preEvent() , add the following
    line before the line that says return TRUE:

        ExecuteScript ("loot_notify",GetModule());
#3  Save hcr_inc_on_acq
#4  Recompile hcr_on_acq_item.

If you want to use this with something else in your mod's
OnAcquire event, take the ExecuteScript line above and put
it wherever you want in your script!

By default this script reports every item into the log.
If you want to turn off this feature, simply comment out the two
lines that begin "WriteTimestampedLogEntry".

If you are not using the Server Option System, you must comment out
the appropriate line (near the bottom of the script)

VERSION CHANGES:

1.2
Major major rewrite...
Stack size now reports.
Created a conditionals section that causes no reporting to take place.
    This got rid of a number of inane reporting conditions, such as
    familiars reporting items they possess upon summoning, PCs trading
    items among each other (or even handing them around to be identified),
    someone by themselves, and the object being a store.
    Add or subtract as you wish.
Extensive commenting added.
Added something in for future compatability with my upcoming Persistent World Helper system.


1.1
Fixed the problem with unidentified items reporting their identity to party members.

*/


void main () // Comment this line out if you are using with HCR
//int preEvent() // Uncomment this line if you are using with HCR
{
    string sMessage; // This string will eventually be populated with the message sent to the PC.
    object oItemOwner = GetModuleItemAcquiredFrom(); // The object that gave the item.
    object oItem = GetModuleItemAcquired(); // The item that was accquired.
    object oPC = GetItemPossessor(oItem); // The PC that got the item.
    string sItemName = GetName (oItem); // The name of oItem in string form, for reporting to the party.
    string sPlayerName = GetName (oPC); // The name of oPC in string form, for reporting to the party .
    string sItemOwnerName = GetName (oItemOwner); // The name oItemOwner in string form, you get the idea.
    object oPartyMember = GetFirstFactionMember (oPC); // This actually is the same as oPC, but will be used in the while loop.
    int iStackSize = GetNumStackedItems(oItem); // Stack size
    int iBaseItemType = GetBaseItemType (oItem); // Gets the base item type.
    string sBaseItemType; // This string will include the name of the item's base type. This will be populated in the switch statement below. For use in reporting unidentified items.
    if (!GetIsObjectValid(oItemOwner)) sItemOwnerName = "the ground"; // It had to come from somewhere.
    int iPartySize = 0; // Used to compute party size
    while (GetIsObjectValid(oPartyMember)) // This bit computes the party size.
        {
        if (GetIsPC (oPartyMember)) iPartySize ++ ;
        oPartyMember = GetNextFactionMember (oPC);
        }

    ///////////////////////////////////////////////////////////////////
    /////////// CONDITIONS UNDER WHICH NO REPORTING OCCURS ////////////
    ///////////////////////////////////////////////////////////////////

    // Yes, I know this could be one huge conditional statement...
    // It's easier to modify this way - you don't have to make sure
    // all of your parentheses match and your logic is straight.


    // CONDITIONS 1 and 3 CURRENTLY COMMENTED OUT BECAUSE GetModuleItemAcquiredFrom doesn't work right.

    //if (GetIsPC(oItemOwner)) return; // Do not report if it came from another player.

    if (!GetIsPC(oPC))return; // Do not report items that are given to henchmen/familiars/animal companions.

    if (GetObjectType (oItemOwner) == OBJECT_TYPE_STORE) return; // Do not report if the item came from a store.

    if (iPartySize == 1) return; // Do not report if PC is alone.

    ///////////////////////////////////////////////////////////////////
    //////// END OF CONDITIONS UNDER WHICH NO REPORTING OCCURS ////////
    ///////////////////////////////////////////////////////////////////

    switch (iBaseItemType) // Populating sBaseItemType. This will be used to report the kind item in the case of an unidentified item.
        {
        case BASE_ITEM_AMULET: sBaseItemType = "amulet"; break;
        case BASE_ITEM_ARMOR: sBaseItemType = "suit of armor"; break;
        case BASE_ITEM_ARROW: sBaseItemType = "arrow(s)"; break;
        case BASE_ITEM_BASTARDSWORD: sBaseItemType = "bastard sword"; break;
        case BASE_ITEM_BATTLEAXE: sBaseItemType = "battleaxe"; break;
        case BASE_ITEM_BELT: sBaseItemType = "belt"; break;
        case BASE_ITEM_BOLT: sBaseItemType = "bolt(s)"; break;
        case BASE_ITEM_BOOK: sBaseItemType = "book"; break;
        case BASE_ITEM_BOOTS: sBaseItemType = "pair of boots"; break;
        case BASE_ITEM_BRACER: sBaseItemType = "set of bracers"; break;
        case BASE_ITEM_BULLET: sBaseItemType = "bullet(s)"; break;
        case BASE_ITEM_CLUB: sBaseItemType = "club"; break;
        case BASE_ITEM_DAGGER: sBaseItemType = "dagger"; break;
        case BASE_ITEM_DART: sBaseItemType = "dart(s)"; break;
        case BASE_ITEM_DIREMACE: sBaseItemType = "dire mace"; break;
        case BASE_ITEM_DOUBLEAXE: sBaseItemType = "double axe"; break;
        case BASE_ITEM_GLOVES: sBaseItemType = "pair of gloves"; break;
        case BASE_ITEM_GREATAXE: sBaseItemType = "greataxe"; break;
        case BASE_ITEM_CLOAK: sBaseItemType = "cloak"; break;
        case BASE_ITEM_GREATSWORD: sBaseItemType = "greatsword"; break;
        case BASE_ITEM_HALBERD: sBaseItemType = "halbred"; break;
        case BASE_ITEM_HANDAXE: sBaseItemType = "handaxe"; break;
        case BASE_ITEM_HEAVYCROSSBOW: sBaseItemType = "heavy crossbow"; break;
        case BASE_ITEM_HEAVYFLAIL: sBaseItemType = "heavy flail"; break;
        case BASE_ITEM_HELMET: sBaseItemType = "helmet"; break;
        case BASE_ITEM_KAMA: sBaseItemType = "kama"; break;
        case BASE_ITEM_KATANA: sBaseItemType = "katana"; break;
        case BASE_ITEM_KUKRI: sBaseItemType = "kukri"; break;
        case BASE_ITEM_LARGESHIELD: sBaseItemType = "large shield"; break;
        case BASE_ITEM_LIGHTCROSSBOW: sBaseItemType = "light crossbow"; break;
        case BASE_ITEM_LONGSWORD: sBaseItemType = "long sword"; break;
        case BASE_ITEM_MAGICROD: sBaseItemType = "rod"; break;
        case BASE_ITEM_MAGICSTAFF: sBaseItemType = "staff"; break;
        case BASE_ITEM_MAGICWAND: sBaseItemType = "magic wand"; break;
        case BASE_ITEM_MISCLARGE: sBaseItemType = "miscellaneous large item(s)"; break;
        case BASE_ITEM_MISCMEDIUM: sBaseItemType = "miscellaneous medium item(s)"; break;
        case BASE_ITEM_MISCSMALL: sBaseItemType = "miscellaneous small item(s)"; break;
        case BASE_ITEM_MISCTALL: sBaseItemType = "miscellaneous tall item(s)"; break;
        case BASE_ITEM_MISCTHIN: sBaseItemType = "miscellaneous thin item(s)"; break;
        case BASE_ITEM_MISCWIDE: sBaseItemType = "miscellaneous wide item(s)"; break;
        case BASE_ITEM_MORNINGSTAR: sBaseItemType = "morningstar"; break;
        case BASE_ITEM_POTIONS: sBaseItemType = "potion"; break;
        case BASE_ITEM_QUARTERSTAFF: sBaseItemType = "quarterstaff"; break;
        case BASE_ITEM_RAPIER: sBaseItemType = "rapier"; break;
        case BASE_ITEM_RING: sBaseItemType = "ring"; break;
        case BASE_ITEM_SCIMITAR: sBaseItemType = "scimitar"; break;
        case BASE_ITEM_SCROLL: sBaseItemType = "scroll(s)"; break;
        case BASE_ITEM_SCYTHE: sBaseItemType = "scythe"; break;
        case BASE_ITEM_SHORTBOW: sBaseItemType = "shortbow"; break;
        case BASE_ITEM_SHORTSPEAR: sBaseItemType = "short spear"; break;
        case BASE_ITEM_SHORTSWORD: sBaseItemType = "short sword"; break;
        case BASE_ITEM_SHURIKEN: sBaseItemType = "shuriken"; break;
        case BASE_ITEM_SICKLE: sBaseItemType = "sickle"; break;
        case BASE_ITEM_SLING: sBaseItemType = "sling"; break;
        case BASE_ITEM_SMALLSHIELD: sBaseItemType = "small shield"; break;
        case BASE_ITEM_SPELLSCROLL: sBaseItemType = "spell scroll(s)"; break;
        case BASE_ITEM_THIEVESTOOLS: sBaseItemType = "thieves tools"; break;
        case BASE_ITEM_THROWINGAXE: sBaseItemType = "throwing axe(s)"; break;
        case BASE_ITEM_TORCH: sBaseItemType = "torch"; break;
        case BASE_ITEM_TOWERSHIELD: sBaseItemType = "tower shield"; break;
        case BASE_ITEM_TRAPKIT: sBaseItemType = "trap kit"; break;
        case BASE_ITEM_TWOBLADEDSWORD: sBaseItemType = "two bladed sword"; break;
        case BASE_ITEM_WARHAMMER: sBaseItemType = "warhammer"; break;
        }

        // Sets up the message to send to the party members...
        // Sends a different message based on whether the item is identified or not.
        // If it's not, the script reports the base item type instead of the item itself.

        // AT CURRENT IT DOES NOT REPORT THE SOURCE OF THE ITEM BECAUSE GetModuleItemAcquiredFrom DOES NOT WORK.

        if (GetIdentified(oItem)) sMessage = sPlayerName + " has acquired " + IntToString (iStackSize) + " " + sItemName; //+ " from " + sItemOwnerName;
        if (!GetIdentified(oItem)) sMessage = sPlayerName + " has acquired " + IntToString (iStackSize) + " unidentified " + sBaseItemType; // + " from " + sItemOwnerName;

        // Uncomment the next line if you want this reporting to the log.
        WriteTimestampedLogEntry (sPlayerName + " has acquired " + IntToString (iStackSize) + " " + sItemName + " from " + sItemOwnerName);

        // Cycle through the party and report the item that has been accquired.
        oPartyMember = GetFirstFactionMember (oPC);
        while (GetIsObjectValid(oPartyMember))
            {
            oPartyMember = GetNextFactionMember (oPC);
            // If you are using the Server Option Stone System YOU MUST UNCOMMENT THE NEXT LINE.
            // if (GetLocalInt (GetModule(),GetPCPublicCDKey (oPartyMember) + "iLootMessaging") == 1) // If using this with the Server Messaging System, then do not send the message if they have it set to off.
                SendMessageToPC (oPartyMember, sMessage);
            }
}
