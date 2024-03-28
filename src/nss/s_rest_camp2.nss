void main()
{
  object oPC = GetLastUsedBy();

  if (GetIsPC(oPC) && GetIsObjectValid (oPC))
  {
    SetLocalInt (oPC, "restallow", 1);
    AssignCommand (oPC, ActionRest());
  }

    // 5 Uses until gone
    int iInUse = GetLocalInt(OBJECT_SELF, "uses");
    int iUsed = iInUse + 1;


  if (GetLocalInt(OBJECT_SELF, "uses") != 9)
  {
    SetLocalInt(OBJECT_SELF, "uses", iUsed);
  }

  else if (GetLocalInt(OBJECT_SELF, "uses") == 9)
  {
    DestroyObject(OBJECT_SELF);
  }

}
