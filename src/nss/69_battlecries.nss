//Module Builders Henchman Kit v1.9
//void main(){}
/* This file allows for the easy editing of various dialog spoken by
   henchman including Battlecries yelled during battle
*/

//Called by nw_ch_ac2
void BattleCry()    //Changed to determine battlecry by class of henchman
{
      int iSpeakProb = Random(35) +1; // Probability of Battle Cry. MUST be a number from 1 to at least 8
      string sDeity = GetDeity(OBJECT_SELF);
      if(sDeity == "")
      {
       sDeity = "God";
      }
      if (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_FIGHTER || GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_RANGER  || GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_BARBARIAN)
        switch (iSpeakProb) {
           case 1: SpeakString("Take this, fool!"); break;
           case 2: SpeakString("Say hello to my little friend!"); break;
           case 3: SpeakString("To hell with you, hideous fiend!"); break;
           case 4: SpeakString("Come here. Come here I say!"); break;
           case 5: SpeakString("Meet cold steel!"); break;
           case 6: SpeakString("To Arms!"); break;
           case 7: SpeakString("Outstanding!"); break;
           case 8: SpeakString("You CAN do better than this, can you not?"); break;
           case 9: SpeakString("Embrace Death, and long for it!"); break;
           case 10: SpeakString("Press forward and give no quarter!"); break;
           case 11: SpeakString("By the name of " +sDeity+ ", you shall perish!"); break;

           default: break;
        }

      if (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_ROGUE)
        switch (iSpeakProb) {
           case 1: SpeakString("I got a little present for you here!"); break;
           case 2: SpeakString("Gotcha"); break;
           case 3: SpeakString("Think twice before messing with me!"); break;
           case 4: SpeakString("Silent and Deadly!"); break;
           case 5: SpeakString("Your momma raised ya to become THIS?"); break;
           case 6: SpeakString("Hey! Where's your manners!"); break;
           case 7: SpeakString("How about a little knife in the back victim"); break;
           case 8: SpeakString("You're an ugly little beastie, ain't ya?"); break;
           case 9: SpeakString("By the name of " +sDeity+ ", you shall perish!"); break;

           default: break;
        }

        if(GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_BARD)
        switch (iSpeakProb) {
           case 1: SpeakString("I got a little song for you here!"); break;
           case 2: SpeakString("Press forward and give no quarter!"); break;
           case 3: SpeakString("Think twice before messing with me!"); break;
           case 4: SpeakString("Silent and Deadly!"); break;
           case 5: SpeakString("Gather around and hear a song of valor."); break;
           case 6: SpeakString("Hey! Where's your manners!"); break;
           case 7: SpeakString("Your chances of success are dwindling."); break;
           case 8: SpeakString("These fools deserve no less."); break;
           case 9: SpeakString("By the name of " +sDeity+ ", you shall perish!"); break;

           default: break;
        }


      if (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_PALADIN)
        switch (iSpeakProb) {
           case 1: SpeakString("By the name of " +sDeity+ ", you shall perish!"); break;
           case 2: SpeakString(sDeity+ ", look kindly upon your servant!"); break;
           case 3: SpeakString(sDeity+ " comes to take you!"); break;
           case 4: SpeakString("Fight on! For our victory is at hand!"); break;
           case 5: SpeakString("Prepare yourself! Your time is near!"); break;
           case 6: SpeakString("The light of justice shall overcome you!"); break;
           case 7: SpeakString("Evil shall perish from the land!"); break;
           case 8: SpeakString("Make peace with your god!"); break;
           case 9: SpeakString("By the name of all that is holy, you shall perish!"); break;
           case 10: SpeakString("The smell of evil permeates your presence!"); break;
           case 11: SpeakString("Press forward and give no quarter!"); break;

           default: break;

        }

      if (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_CLERIC)
        switch (iSpeakProb) {
           case 1: SpeakString("This is not the time for healing!"); break;
           case 2: SpeakString("You have chosen pain!"); break;
           case 3: SpeakString("You attack us, only to die!"); break;
           case 4: SpeakString("Must you chase destruction? Very well!"); break;
           case 5: SpeakString("It does not please me to crush you like this."); break;
           case 6: SpeakString("Do not provoke me!"); break;
           case 7: SpeakString("I am at my wit's end with you all!"); break;
           case 8: SpeakString("Do you even know what you face?"); break;
           case 9: SpeakString("Prepare yourself! Your time is near!"); break;
           case 10: SpeakString("By the name of " +sDeity+ ", you shall perish!"); break;
           case 11: SpeakString(sDeity+ ", look kindly upon your servant!"); break;
           case 12: SpeakString(sDeity+ " comes to take you!"); break;

           default: break;
        }

      if (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_DRUID)
        switch (iSpeakProb) {
           case 1: SpeakString("Nature will have vengeance upon you now!"); break;
           case 2: SpeakString("What is your grievance? Begone!"); break;
           case 3: SpeakString("I won't allow you to harm anyone else!"); break;
           case 4: SpeakString("Retreat or feel my wrath!"); break;
           case 5: SpeakString("By " +sDeity+ ", you will not pass unchecked."); break;
           case 6: SpeakString("I am nature's weapon."); break;
           case 7: SpeakString(sDeity+ " willing, you'll soon be undone!"); break;
           case 8: SpeakString("Destroyer of all that is green, you shall die!"); break;
           case 9: SpeakString("By the name of " +sDeity+ ", you shall perish!"); break;

           default: break;
        }

      if (GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_WIZARD || GetClassByPosition(1, OBJECT_SELF) == CLASS_TYPE_SORCERER)
        switch (iSpeakProb) {
           case 1: SpeakString("You face a mage of considerable power!"); break;
           case 2: SpeakString("I find your resistance illogical."); break;
           case 3: SpeakString("I bind the powers of the very Planes!"); break;
           case 4: SpeakString("Fighting for now, and research for later."); break;
           case 5: SpeakString("Sad to destroy a fine specimen such as yourself."); break;
           case 6: SpeakString("Your chances of success are dwindling."); break;
           case 7: SpeakString("These fools deserve no less."); break;
           case 8: SpeakString("Now you are making me lose my patience."); break;
           case 9: SpeakString("Do or Do Not, there is no try."); break;
           case 10: SpeakString("By the name of " +sDeity+ ", you shall perish!"); break;
           case 11: SpeakString("Strike me down now and I shall become more powerful than you could ever imagine!"); break;

           default: break;
        }
}

//Various Henchman Responses (Edit the response as you wish)
void HenchmanTalk(int nTalk) //Henchman speaks the relative challenge of the encounter
{

 string sDeity = GetDeity(OBJECT_SELF);
      if(sDeity == "")
      {
       sDeity = "God";
      }
 int nRoll = d4(1);
 switch(nTalk)
 { //speaking the relative challenge of an encounter (1-4)
  case 1: SpeakString("Don't make me laugh!"); break;   //Easy
  case 2: SpeakString("We'll best them yet!"); break;   //Moderate
  case 3: SpeakString("Watch out for this one!"); break;//Challenging
  case 4: SpeakString(sDeity+ " help us!"); break;  //Difficult
  case ASSOCIATE_COMMAND_FOLLOWMASTER:
     if(nRoll == 1){SpeakString("Coming!");}
     else if(nRoll == 2){SpeakString("Yes!");}
     else if(nRoll == 3){SpeakString("Run Away!");}
     else if(nRoll == 4){SpeakString("I am in retreat!");}
     break;
  default: break;
 }
}
