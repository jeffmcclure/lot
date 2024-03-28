//::///////////////////////////////////////////////
//:: Name xp_i0_levelup
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
Allows henchmen to level up useing XP instead
of leveling up as the master does.
*/
//:://////////////////////////////////////////////
//:: Created By: chris (cward)
//:: Created On: August 2003
//:://////////////////////////////////////////////
void XPLevelUpHenchman(object oCreature);
//void main(){} //This main() is for testing purposes only.
void XPLevelUpHenchman(object oCreature = OBJECT_SELF)
{
  int bReadyAllSpells = TRUE;
  int nHenchLag = GetLocalInt(oCreature, "nHenchLag");
  int nHenchMax = GetLocalInt(oCreature, "nHenchMax");
  int nHXP = GetLocalInt(oCreature, "nHenchXP");
  int nLevel = GetHitDice(oCreature);
  int nNewClass = GetLocalInt(oCreature, "NewClass");
  int nInc = 1;
  if(nNewClass == 0)
  {
    nNewClass = GetClassByPosition(1, oCreature);
  }
  if(nLevel == 1  && nHXP > 999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 2  && nHXP > 2999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 3  && nHXP > 5999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 4  && nHXP > 9999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 5  && nHXP > 14999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 6  && nHXP > 20999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 7  && nHXP > 27999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 8  && nHXP > 35999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 9  && nHXP > 44999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 10  && nHXP > 54999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 11  && nHXP > 65999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 12  && nHXP > 77999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 13  && nHXP > 90999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 14  && nHXP > 104999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 15  && nHXP > 119999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 16  && nHXP > 135999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 17  && nHXP > 152999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 18  && nHXP > 170999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
  if(nLevel = 19  && nHXP > 189999 && GetLocalInt(oCreature, "level_up") == nLevel)
  {
  LevelUpHenchman(oCreature, nNewClass, TRUE);
  AssignCommand(oCreature, SpeakString("Leveling Up"));
  nInc++;
  SetLocalInt(oCreature, "level_up", nInc);
  }
}
