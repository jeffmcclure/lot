//Notes from Loki: Implementation modified by LokiHakanin.
//Functions will now run on ANY PC entering the area, and will
//sort through all his gear in search of dupes.
//If one is found, it will be destroyed, and a logged entry
//will be made noting the time, item name, and player name.
//This message will also be sent to all DMs.

#include "zep_inc_craft"

void main()
{
  object oPC = GetEnteringObject();
  ZEP_PurifyAllItems(oPC,TRUE,TRUE);
}
