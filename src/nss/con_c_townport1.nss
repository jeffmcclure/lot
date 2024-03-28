////////////////////////////////////////////////////////////////////////////////
// conversation condition
////////////////////////////////////////////////////////////////////////////////

int StartingConditional()
{
  object oPC           = GetPCSpeaker();
  int    nTokenMax     = GetLocalInt(oPC,"TokenMax");
  int    nTokenCounter = GetLocalInt(oPC,"TokenCounter");

  SetLocalInt(oPC,"TokenCounter",++nTokenCounter);

  return (nTokenCounter <= nTokenMax);
}
