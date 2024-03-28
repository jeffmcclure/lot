////////////////////////////////////////////////////////////////////////////////
// include file: inc_modulequest
////////////////////////////////////////////////////////////////////////////////

//
// module-wide quest handling (for all players)
//

// -----------------------------------------------------------------------------

// Writes an entry into the journal (with all players)
// and an appropriate journal /Questvariable stores in the module object
//
// string sQuest:  Name of the journalization (must with the designation
//                 the Quests in the journal editor agree)
// int nEntry:     Number of the journalization (must with a number
//                 from the journal editor agree)
// object oPC:     Player character object (which player is no matter,
//                 because the journalization is set with all players)
//                 (this parameter is only therefore available, over
//                 to make possible it the function principleal to register,
//                 journalizations only for an individual player character
//                 This here however not used)
// int bOverwrite: TRUE permits it, a lower entry number into that
//                 To register journal, Standardwert=FALSE

void SetModuleQuest(string sQuest,int nEntry,object oPC, int bOverwrite=FALSE)
{
  object oModule = GetModule();
  if ((GetLocalInt(oModule,sQuest) < nEntry) || bOverwrite)
  {
    AddJournalQuestEntry(sQuest,nEntry,oPC,TRUE,TRUE,bOverwrite);
    SetLocalInt(oModule,sQuest,nEntry);
  }
}

// -----------------------------------------------------------------------------

// The entry number of the journal for the Quest supplies sQuest
//
// string sQuest:  Name of the journalization (must with the designation
//                 the Quests in the journal editor agree)

int GetModuleQuest(string sQuest)
{
  return GetLocalInt(GetModule(),sQuest);
}

// -----------------------------------------------------------------------------

// Writes an entry into the journal of the player oPC
// on the basis the current module Queststatus sQuest
// (if a player is added later, or a player
// a Disconnect had. Call by modules Event: OnClientEnter)
//
// stringer sQuest:     Name of the journalization (must agree with the
//                      designation the Quests in the journal editor)
// object oPC:          Player character object

void UpdateModuleQuest(string sQuest,object oPC)
{
  int nEntry = GetLocalInt(GetModule(),sQuest);
  if (nEntry > 0)
  {
    AddJournalQuestEntry(sQuest,nEntry,oPC,FALSE,FALSE,FALSE);
  }
}

// -----------------------------------------------------------------------------

// the quantity specified in the journal editor gives all players on
// points of experience. With nPercent can to be specified,
// that only a proportional portion of this value be given is.
//
// stringer sQuest: Name of the journalization (must agree with the designation
//                 the Quests in the journal editor)
// object oPC:     Player character object (which player is no matter,
//                 the points of experience becomes all players given)
//                 (this parameter is present only therefore to give in order
//                 to make possible it the function principleal,
//                 points of experience only for an individual player character
//                 This here however not used)

void RewardModuleQuest(string sQuest,object oPC,float fPercent=1.0)
{
  if (fPercent <= 0.0) return;
  if (fPercent >  1.0) fPercent = 1.0;

  int   nXP = GetJournalQuestExperience(sQuest);
  float fXP = IntToFloat(nXP) * fPercent;
  oPC       = GetFirstPC();

  while (GetIsObjectValid(oPC))
  {
    GiveXPToCreature(oPC,FloatToInt(fXP));
    oPC = GetNextPC();
  }
}

// -----------------------------------------------------------------------------

