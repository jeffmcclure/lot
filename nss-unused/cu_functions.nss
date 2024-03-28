
// Functions Script for Birthright of the North
// Ben W-Husey (B G P Hughes)

//This function is used to reward a party with xp for an action, describe why the xp was given, and set a variable so it is only given once for the action.
// Inputs are:  sGotEntry = The name of the Local Variable,
//              oPCGotEntry = the PC that called this function (speaker, chest opener, etc)
//              nXPToGive = xp for each party member
//              sTextMessage = Message to display, telling why xp was given

void PartyGotEntry(string sGotEntry,object oPCGotEntry, int nXPToGive, string sTextMessage)
{
    object oPartyMember = GetFirstFactionMember(oPCGotEntry, TRUE); // oPartyMember is the PC that called this function

    while (GetIsObjectValid(oPartyMember) == TRUE) // While there are more members in the party
  {
    GiveXPToCreature(oPartyMember,nXPToGive); //Give xp to each member
    SetLocalInt(oPartyMember,sGotEntry,1);  // Sets a local variable in case you want to check for it (i.e. give the bonus once only)
    FloatingTextStringOnCreature(sTextMessage, oPartyMember, TRUE); //Tell the player what the xp was for with a string above his PC's head
    oPartyMember = GetNextFactionMember(oPCGotEntry, TRUE); // Find next party member
  }
}

//This function is used to to set a local variable on every member of a party - particularly useful to stop every party member having to have the same conversation.
// Inputs are:  sGotEntry = The name of the Local Variable,
//              oPCGotEntry = the PC that called this function (speaker, chest opener, etc)
//              nValue = value to set variable to

void AllParty(string sGotEntry,object oPCGotEntry, int nValue)
{
  SetLocalInt(oPCGotEntry, sGotEntry, nValue);
  object oPartyMember = GetFirstFactionMember(oPCGotEntry, TRUE);
  while (GetIsObjectValid(oPartyMember) == TRUE)
  {
    SetLocalInt(oPartyMember,sGotEntry,nValue);  // Sets a local variable on each party member
    oPartyMember = GetNextFactionMember(oPCGotEntry, TRUE);
  }
}
