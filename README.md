
Based on [The Lord of Terror](https://neverwintervault.org/project/nwn1/module/lord-terror-diablo-campaign) by [Tolitz Rosel](mailto:tolitzrosel@gmail.com)

The [Lord of Terror 2](https://github.com/jeffmcclure/lot) by [Jeff McClure](mailto:jeffmcclure.github@gmail.com)

Current Version 2.0.5 - April 28, 2024

## Stay a while and listen
This module is mostly the same as Tolitz Rosel's last released version 1.06 from November 27, 2004.

## Major Changes Since 1.06
### Technical
* Using [Neverwinter Toolkit](https://github.com/jeffmcclure/nwt) to manage project in source format
* Using github for [module source code](https://github.com/jeffmcclure/lot)
* Using github for [hak source code](https://github.com/jeffmcclure/lothak)
* Only one module-specific hak file needed, lot2.hak
* All media resources are part of the new lot2.hak, no need for separate music or video files
* Module version number uses [Semantic Versioning Standard](https://semver.org)
* Only tested on NWN:EE - likely does not work on older versions

### Visual / Graphics
* Updated henchmen portraits
* Improved graphics due to upgraded [CEP 3.1.1c](https://neverwintervault.org/project/nwnee/hakpak/combined/cep-3-community-expansion-pack)

### Quality of Life
* New starting item "Cloak of Fast Feet" - walk around quicker
* Portal location moved to center of town
* Portal does not despawn when player returns to dungeon
* New item Loot Genie, when held in inventory your loot is automatically picked up and put into your inventory;  available from Witch via quest or purchase.
* Dead monsters containing no loot are not clickable and cannot be opened
* Killed monsters and corpses disappear shortly after looting to improve visibility and reduce memory/processing
* Chests and containers are disabled and not clickable after looting
* Conversation options with NPCs that lead to quests are prefixed with green [Quest] text
* Journal entry and map pin recording location of dead henchman

### Multi-player Focused
* Quests shared with party
* Quest-level rewards shared with entire party
* Per-player loot generated in many situations (players can only pick up their assigned loot)
* Keep TheeMon around for late joiners
 
### Gameplay
* Souls-like death system where lost gold and XP can be recovered at your most recent death location
* Harsher death penalty, but loss can be fully recovered via soulslike death system
* A few new minor quests at game opening
* New early quest "Should old acquaintance be forgot..." to help players find all key NPCs in town
* Bug squashed that would sometimes prevent henchmen Jarulf and Jenna from joining
 
### Role Playing
* New haggling/appraise system for all stores (makes use of Appraise skill and Charisma bonus modifier)
* Some chests must now be picked open, and may not be bashed open (makes use of Lockpick skill)
* Reduce difficulty of some Persuade communications to make persuasion possible

## Roadmap / Future Enhancements

## Known Issues
* The ending movie fails to play and shows error that lot2ending.wbm cannot be found, however the file is present into the lot2.hak.  This appears to be a bug in nwn itself.   The movie file will be found if it is installed in the movies/ directory, however nwn:ee is documented to be capable to read the movie from the hak, and the intro movie is read directly from the hak without issue.
 
## See also
* [CHANGES.md](https://github.com/jeffmcclure/lot/blob/master/CHANGES.md)
* [INSTALL.md](https://github.com/jeffmcclure/lot/blob/master/INSTALL.md)

## For reference
* [The Lord of Terror 1.06](https://neverwintervault.org/project/nwn1/module/lord-terror-diablo-campaign)
