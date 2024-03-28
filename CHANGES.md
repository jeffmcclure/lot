# Changelog
## 2.0.0 &mdash; 2024-02-14
* Don't destroy TheeMon ; allow him to remain for late joiners
* Allow late joiners to receive free loot from TheeMon, but don't distribute double nor greeting xp
* Each player must speak to TheeMon to get free loot
* Fixed bug where if you back out of the conversation with Jarulf or Janna at the second prompt, it breaks their conversation and you cannot talk to them again.
* [ ] TODO : Each player should speak to TheeMon before leaving starting area
* [ ] TODO : level up players to match the highest level when they enter
* Quests usually given to all party members; exceptions are by design
* [ ] TODO : remove unused code (.nss, etc)
* For the butcher encounter, spawn one butcher for each member of the party
* Scale King Leoric to 200% size.
* Scale King Leoric hit points for party size.
* Merchants/stores take into consideration Appraise, Persuade, and Charisma
* Show dice roll and DC check for Merchant/store appraise
* Show persuade check dice roll for henchmen and other standard checks
* New Quest "Find Remy"
* New section of cathedral "The Rectory" with map point for the entry in Tristram
* Reward all party members with gold/xp instead of just one player
* Certain chests must now be picked and cannot be bashed open
* Gift to player Cloak of Fast Feet during game opening conversation with Theo
* Add defensive logic to henchman script to resolve bug where henchman will not rejoin after being separated from PC

## 1.0.7 &mdash; 2024-02-01 
* Use [nwt](https://github.com/jeffmcclure/nwt) and [GitHub](https://github.com/jeffmcclure/lot5) for module development
* Module version number now using [Semantic Versioning Standard](https://semver.org)
* Remove invalid references from LOT 1.06
* Fix compilation issues from LOT 1.06
* Update to CEP 3.1.1c
* Attribution to Jeff McClure for new versions of Lord of Terror
* Start with Tolitz Rosel's "The Lord of Terror" version 1.06