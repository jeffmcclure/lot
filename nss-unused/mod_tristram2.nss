object oTarget;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetIsNight())
   {
   oTarget = GetObjectByTag("CAIN");
   DelayCommand(1.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_CAIN")));
   DelayCommand(1.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_CAIN"))));

   oTarget = GetObjectByTag("GRISWOLD");
   DelayCommand(1.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_GRISWOLD")));
   DelayCommand(1.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_GRISWOLD"))));

   oTarget = GetObjectByTag("OGDEN");
   DelayCommand(2.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_OGDEN")));
   DelayCommand(2.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_OGDEN"))));

   oTarget = GetObjectByTag("GILLIAN");
   DelayCommand(2.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_GILLIAN")));
   DelayCommand(2.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_GILLIAN"))));

   oTarget = GetObjectByTag("TREMAYNE");
   DelayCommand(3.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_TREMAYNE")));
   DelayCommand(3.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_TREMAYNE"))));

   oTarget = GetObjectByTag("PEPIN");
   DelayCommand(3.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_PEPIN")));
   DelayCommand(3.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_PEPIN"))));

   oTarget = GetObjectByTag("WIRT");
   DelayCommand(4.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_WIRT")));
   DelayCommand(4.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_WIRT"))));

   oTarget = GetObjectByTag("DEESE");
   DelayCommand(4.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_DEESE")));
   DelayCommand(4.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_DEESE"))));

   ExploreAreaForPlayer(GetArea(oPC), oPC);
   SetLocalInt(oPC, "wirthome", 0);

   }
else if (GetIsDay())
   {
   oTarget = GetObjectByTag("CAIN");
   DelayCommand(1.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_CAIN")));
   DelayCommand(1.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_CAIN"))));

   oTarget = GetObjectByTag("GRISWOLD");
   DelayCommand(1.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_GRISWOLD")));
   DelayCommand(1.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_GRISWOLD"))));

   oTarget = GetObjectByTag("OGDEN");
   DelayCommand(2.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_OGDEN")));
   DelayCommand(2.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_OGDEN"))));

   oTarget = GetObjectByTag("GILLIAN");
   DelayCommand(2.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_GILLIAN")));
   DelayCommand(2.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_GILLIAN"))));

   oTarget = GetObjectByTag("TREMAYNE");
   DelayCommand(3.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_TREMAYNE")));
   DelayCommand(3.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_TREMAYNE"))));

   oTarget = GetObjectByTag("PEPIN");
   DelayCommand(3.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_PEPIN")));
   DelayCommand(3.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_PEPIN"))));

   oTarget = GetObjectByTag("WIRT");
   DelayCommand(4.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_WIRT")));
   DelayCommand(4.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_WIRT"))));

   oTarget = GetObjectByTag("DEESE");
   DelayCommand(4.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_DEESE")));
   DelayCommand(4.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_DEESE"))));

   ExploreAreaForPlayer(GetArea(oPC), oPC);
   SetLocalInt(oPC, "wirthome", 0);

   }
   else
   {
   oTarget = GetObjectByTag("CAIN");
   DelayCommand(1.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_CAIN")));
   DelayCommand(1.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_CAIN"))));

   oTarget = GetObjectByTag("GRISWOLD");
   DelayCommand(1.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_GRISWOLD")));
   DelayCommand(1.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_GRISWOLD"))));

   oTarget = GetObjectByTag("OGDEN");
   DelayCommand(2.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_OGDEN")));
   DelayCommand(2.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_OGDEN"))));

   oTarget = GetObjectByTag("GILLIAN");
   DelayCommand(2.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_GILLIAN")));
   DelayCommand(2.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_GILLIAN"))));

   oTarget = GetObjectByTag("TREMAYNE");
   DelayCommand(3.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_TREMAYNE")));
   DelayCommand(3.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_TREMAYNE"))));

   oTarget = GetObjectByTag("PEPIN");
   DelayCommand(3.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_PEPIN")));
   DelayCommand(3.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_PEPIN"))));

   oTarget = GetObjectByTag("WIRT");
   DelayCommand(4.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_WIRT")));
   DelayCommand(4.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_WIRT"))));

   oTarget = GetObjectByTag("DEESE");
   DelayCommand(4.0,AssignCommand(oTarget, ClearAllActions()));
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_DEESE")));
   DelayCommand(4.0,AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_DEESE"))));

   ExploreAreaForPlayer(GetArea(oPC), oPC);
   SetLocalInt(oPC, "wirthome", 0);
   }

}
