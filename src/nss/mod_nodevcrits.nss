void main()
{
     object oPC = GetPCLevellingUp(); //Get the PC
     if (!GetIsPC(oPC))
         return; //Ignore NPCs
     int nExitLoop = 0;
     if (GetHasFeat(955, oPC))
          nExitLoop = 1; //Dwarven Waraxe
     if (GetHasFeat(996, oPC))
          nExitLoop = 1; //Whip

     int nFeat = 495; //495 is the first dev. crit. feat
     while ((!nExitLoop) && (nFeat<532)) //531 is the last dev. crit. feat, repeat for all dev. crits between 495 and 531
     {
        if (GetHasFeat(nFeat, oPC))
        {
            nExitLoop = 1;
        }
        else
        {
            nFeat++;
        }
     }

    if (nExitLoop) //If a Dev. Crit. was chosen
    {
        string sString = "Devastating Critical is not a usable feat in this module";
        AssignCommand(oPC,SpeakString(sString,TALKVOLUME_WHISPER)); //Send warning message
        int nLevel = GetHitDice(oPC); //Get level
        int nXP = GetXP(oPC); //Save XP so we can restore it afterwards
        int nDelevelXP = (nLevel-1) * (nLevel - 2) * 500; //Work out how much XP will delevel the PC
        SetXP(oPC, nDelevelXP); //Set that level
        DelayCommand(3.5,GiveXPToCreature(oPC, nXP - nDelevelXP)); //Restore the XP so the player can relevel
    }
}

