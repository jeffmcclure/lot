////////////////////////////////////////////////////////////////////////////////
// Module Event: OnClientEnter
////////////////////////////////////////////////////////////////////////////////

#include "inc_modulequest"

void main()
{
  object oPC = GetEnteringObject();

  SendMessageToPC(oPC,
    "--== Welcome to the World of Sanctuary. ==--\n\n"+

    "The coming of the Three marked a time of evil in the history of Sanctuary "+
    "unlike any other. The cataclysm that followed their arrival brought immense "+
    "change to the world when the Three unleashed their hellish followers upon "+
    "the world. These followers wrought great destruction upon the lands of "+
    "Sanctuary. That which was not consumed by the arrival of this malevolence "+
    "was often twisted and altered by the effects of the resulting chaotic forces. "+
    "Many of the native creatures inhabiting the world became vile and depraved "+
    "shadows of their natural forms. A world that once allowed the unfettered "+
    "development and expansion of mankind became a place where only the strongest "+
    "could survive. The areas most tainted by the Prime Evils' arrival in the "+
    "mortal realm are the Western Kingdoms, the desert regions of Aranoch, and "+
    "the jungles of Kejhistan.\n\n"+

    "Unnatural and evil forces are influencing most, if not all, of Sanctuary's "+
    "beasts to at least some degree. Many have witnessed creatures outside their "+
    "native habitats, assisting the minions of Hell's wrath. Such sights grow more "+
    "common as one nears a lair of demonic nobility. Greater demons gather these "+
    "controlled beasts to their location in an effort to protect themselves. "+
    "These powerful monsters harbor deadly capabilities, and occasionally appear "+
    "in unexpected areas. Let the adventurer beware!\n\n"+

    "--== Act IV: Enter Hell ==--"
  );

  // update player's journal
  UpdateModuleQuest("JOR_Hellforge",oPC);
  UpdateModuleQuest("JOR_Izual"    ,oPC);
  UpdateModuleQuest("JOR_Diablo"   ,oPC);




  // ---------------------------------------------------------------------------
  // debug

  if (GetName(oPC)=="Amaruil" ||
      GetName(oPC)=="Vesuvius" ||
      GetName(oPC)=="Perin Ti'Sha") {SetLocalObject(GetModule(),"DebugPC",oPC);}

  /* how to use:
  SendMessageToPC(GetLocalObject(GetModule(),"DebugPC"),
    "Debug Message");
  */
}
