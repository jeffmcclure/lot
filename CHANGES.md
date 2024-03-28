# Changelog
## 2.0.0 &mdash; 2024-02-14
* [ ] TODO : check all chests to ensure party loot
* [ ] TODO : change to party loot for caverns 1 entry mini-boss
* [ ] TODO Multi-player: on entry copy all quests from other players
* [ ] TODO : level up players to match the highest level when they enter
* [ ] TODO : remove unused code (.nss, etc)
* Multi-player: Chests create private loot for each player
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
* Stores: Merchants/stores take into consideration Appraise, Persuade, and Charisma
* Stores: Show dice roll and DC check for Merchant/store appraise
* Henchmen, NPC: Show persuade check dice roll for henchmen and other standard checks
* Henchmen, Bug: Fixed bug where if you back out of the conversation with Jarulf or Janna at the second prompt, it breaks their conversation and you cannot talk to them again.
* Henchmen, Bug: Add defensive logic to henchman script to resolve bug where henchman will not rejoin after being separated from PC
* Quests: New quest "Find Remy"
* Quests: New section of cathedral "The Rectory" with map point for the entry in Tristram (for Find Remy)
* Quests: New quest "Should old acquaintance be forgot..." - designed to encourage players to meet the key town NPC and collect free XP
* Add starting chests with loot in the tavern chest room
* Added new chests that must be picked and cannot be bashed open
* Gift to player Cloak of Fast Feet during game opening conversation with TheeMon
* Using lot2.hak file with integrated ambient music and videos.  No longer using lotcephak1.hak, lothak.hak lotwav.hak
* rename area files for better names (.are, .gic, .git)

## 1.0.7 &mdash; 2024-02-01 
* Use [nwt](https://github.com/jeffmcclure/nwt) and [GitHub](https://github.com/jeffmcclure/lot5) for module development
* Module version number now using [Semantic Versioning Standard](https://semver.org)
* Remove invalid references from LOT 1.06
* Fix compilation issues from LOT 1.06
* Update to CEP 3.1.1c
* Attribution to Jeff McClure for new versions of Lord of Terror
* Start with Tolitz Rosel's "The Lord of Terror" version 1.06
