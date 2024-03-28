////////////////////////////////////////////////////////////////////////////////
// Module Event: OnActivateItem
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oItem       = GetItemActivated();
  object oPC         = GetItemActivator();
  object oTownPortal;

  if (GetTag(oItem) == "ITM_BookOfTownPortal")
  {
    if (GetTag(GetArea(oPC)) != "TRISTRAM")
      {
        if (GetTag(GetArea(oPC)) != "NOTOWNPORTAL")
          {
      // if player already has a town portal destroy it
      oTownPortal = GetLocalObject(oPC,"TownPortal");
      if (oTownPortal != OBJECT_INVALID) DestroyObject(oTownPortal);

      // create new town portal at player location
      oTownPortal = CreateObject(OBJECT_TYPE_PLACEABLE,"townportal",GetLocation(oPC));
      SetLocalObject(oPC,"TownPortal",oTownPortal);
      switch (d6())
      {
        case 1: AssignCommand(oTownPortal,PlaySound("sco_lgrinholy01")); break;
        case 2: AssignCommand(oTownPortal,PlaySound("sco_lgsprholy01")); break;
        case 3: AssignCommand(oTownPortal,PlaySound("sco_lgupholy01"));  break;
        case 4: AssignCommand(oTownPortal,PlaySound("sco_lgrinodd01"));  break;
        case 5: AssignCommand(oTownPortal,PlaySound("sco_lgsprodd01"));  break;
        case 6: AssignCommand(oTownPortal,PlaySound("sco_mehanodd03"));  break;
      }
      DelayCommand(0.3,
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),oTownPortal));
      DelayCommand(0.5,SignalEvent(oTownPortal,EventUserDefined(9000)));

      // if there is no town portal in Tristram create one
      oTownPortal = GetLocalObject(OBJECT_SELF,"TownPortal");
      if (!GetIsObjectValid(oTownPortal))
      {
        oTownPortal = CreateObject(OBJECT_TYPE_PLACEABLE,"townportal",GetLocation(GetObjectByTag("WP_TownPortal")));
        SetLocalObject(OBJECT_SELF,"TownPortal",oTownPortal);
        DelayCommand(0.6,SignalEvent(oTownPortal,EventUserDefined(9000)));
          }
        }
    else
    {
      FloatingTextStringOnCreature("The spell fizzles!  The town portal does not work here!", oPC);
      }
    }
    else
    {
      FloatingTextStringOnCreature("The spell fizzles!  You're already in town!", oPC);
      }
    }
ExecuteScript("dmfi_activate", OBJECT_SELF);
ExecuteScript("69_activateheal", OBJECT_SELF);
//ExecuteScript("s_apocalypse", OBJECT_SELF);
//ExecuteScript("s_teleport", OBJECT_SELF);
ExecuteScript(GetTag(GetItemActivated()), OBJECT_SELF);
}
