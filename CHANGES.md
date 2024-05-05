[Back to README.md](README.md)

# Changelog
## 2.0.6 &mdash; 2024-05-XX
* bugfix: when tome of portal is depleted it does not disappear from inventory
* (todo) appraise system buy-back price
* improve looting of corpses in theoutskirts001
 
## 2.0.5 &mdash; 2024-05-03
* Loot system - allow lootable monster corpses and other monster Treasure Models (default, treasure...) 
* tighten up loot system
* start organizing utc source files into subdirectories
* Simplify Jarulf's conversation from a user standpoint
* Roleplay : tome of identify is very expensive to buy
* Tome of Identify and Tome of Healing are much rarer drops
* Wand of resurrection from Remy is now droppable (no longer cursed)
* Eliminate duplicate nw_it_book.* objects
* Cloak of Fast Feet no longer provides 2nd attack, it only provides fast movement.

## 2.0.4 &mdash; 2024-04-13
* Reduce difficulty of Cain's persuasion check for a free identify to make it possible (but still difficult) for level 1 characters to get a free identify
* Journal entry and map pin recording location of dead henchman
* Chests and containers are disabled and not clickable after looting
* Allow henchman gear to be taken and sold (remove cursed and plot flags)
* Use .dlgs format for some conversation parts

## 2.0.3 &mdash; 2024-04-07
* Quest: "Should old acquaintance be forgot..." now shows the names of NPCs remaining to speak with
* Souls-like death system where gold and XP can be recovered at your most recent death location
* Harsher death penalty
* Griswold's "free" items are marked as plot items to prevent sale-for-profit
* Improve looting of corpses
* Do not loot henchmen

## 2.0.2 &mdash; 2024-04-04
### Player
* New item Loot Genie, when held in inventory your loot is automatically picked up and put into your inventory;  available from Witch via quest or purchase
* New Quest "Loot Genie" available from Adria
* Monster corpses that are empty are not clickable and cannot be opened
* Added Achievement "Dude Perfect"
* Added Achievement "Raw Deal"
* Do not destroy town portal when player uses it to return to dungeon
* Start adding green [Quest] indicators in conversations for dialog that leads to quests
### Developer
* Use nwt (Neverwinter Toolkit) version 0.0.4
* Remove nw_i0_generic.nss
* Start using new simplified dialog format .dlgs

## 2.0.1 &mdash; 2024-03-24
* Fixed issue where some monsters were not dropping loot
* Do not zoom conversations for henchmen, Ogden, or Griswold
* Balancing: Reduce King Leoric back to original class levels and STR, but retain HP scale based on party size

## 2.0.0 &mdash; 2024-03-22
* Multi-player: Party-Loot system - loot is generated for each party member and must first be picked-up by the intended player
* Multi-player: Chests create private loot for each player
* Multi-player: Monsters drop private loot for each player
* Multi-player: Don't destroy TheeMon ; allow him to remain for late joiners
* Multi-player: Allow late joiners to receive free loot from TheeMon, but don't distribute double nor greeting xp
* Multi-player: Each player must speak to TheeMon to get free loot
* Multi-player: Each player must speak to TheeMon before leaving starting area
* Multi-player: Quests usually given to all party members; exceptions are by design
* Multi-player, Bosses: For the butcher encounter, spawn one butcher for each member of the party
* Multi-player, Bosses: Scale King Leoric hit points for party size.
* Multi-player: Reward all party members with gold/xp instead of just one player
* Bosses: New mini-boss Death Clean Leader in Catacomb I
* Bosses: Scale King Leoric to 200% size
* Bosses: Butcher and Leoric now immune to critical hits
* Stores: Merchants/stores take into consideration Appraise, Persuade, and Charisma
* Stores: Show dice roll and DC check for Merchant/store appraise
* Henchmen, NPC: Show persuade check dice roll for henchmen and other standard checks
* Henchmen, Bug: Fixed bug where if you back out of the conversation with Jarulf or Janna at the second prompt, it breaks their conversation and you cannot talk to them again.
* Henchmen, Bug: Add defensive logic to henchman script to resolve bug where henchman will not rejoin after being separated from PC
* Quests: New quest "Find Remy"
* Quests: New section of cathedral "The Rectory" with map point for the entry in Tristram (for Find Remy)
* Quests: New quest "Should old acquaintance be forgot..." - designed to encourage players to meet the key town NPC and collect free XP
* Quests: Butcher - fixed issue where NPC can open butcher door, suppressing spawning of The Butcher
* General: Add starting chests with loot in the tavern chest room
* General: Added new chests that must be picked and cannot be bashed open
* General: Gift to player Cloak of Fast Feet during game opening conversation with TheeMon
* Housekeeping: Using lot2.hak file with integrated ambient music and videos.  No longer using lotcephak1.hak, lothak.hak lotwav.hak
* Housekeeping: rename area files for better names (.are, .gic, .git)
* Housekeeping: Removed 541 unused .nss scripts

## 1.0.7 &mdash; 2024-02-01 
* Use [nwt](https://github.com/jeffmcclure/nwt) and [GitHub](https://github.com/jeffmcclure/lot5) for module development
* Module version number now using [Semantic Versioning Standard](https://semver.org)
* Remove invalid references from LOT 1.06
* Fix compilation issues from LOT 1.06
* Update to CEP 3.1.1c
* Attribution to Jeff McClure for new versions of Lord of Terror
* Start with Tolitz Rosel's "The Lord of Terror" version 1.06
