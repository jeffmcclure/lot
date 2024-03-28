object oTarget;
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (GetIsNight())
   {
   oTarget = GetObjectByTag("CAIN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_CAIN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_CAIN")));

   oTarget = GetObjectByTag("GRISWOLD");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_GRISWOLD")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_GRISWOLD")));

   oTarget = GetObjectByTag("OGDEN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_OGDEN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_OGDEN")));

   oTarget = GetObjectByTag("GILLIAN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_GILLIAN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_GILLIAN")));

   oTarget = GetObjectByTag("TREMAYNE");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_TREMAYNE")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_TREMAYNE")));

   oTarget = GetObjectByTag("PEPIN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_PEPIN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_PEPIN")));

   oTarget = GetObjectByTag("WIRT");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_WIRT")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_WIRT")));

   oTarget = GetObjectByTag("DEESE");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_DEESE")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_DEESE")));

   oTarget = GetObjectByTag("CELIA");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_CELIA")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_CELIA")));

   ExploreAreaForPlayer(GetArea(oPC), oPC);
   SetLocalInt(oPC, "wirthome", 0);

   }
else if (GetIsDay())
   {
   oTarget = GetObjectByTag("CAIN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_CAIN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_CAIN")));

   oTarget = GetObjectByTag("GRISWOLD");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_GRISWOLD")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_GRISWOLD")));

   oTarget = GetObjectByTag("OGDEN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_OGDEN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_OGDEN")));

   oTarget = GetObjectByTag("GILLIAN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_GILLIAN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_GILLIAN")));

   oTarget = GetObjectByTag("TREMAYNE");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_TREMAYNE")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_TREMAYNE")));

   oTarget = GetObjectByTag("PEPIN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_PEPIN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_PEPIN")));

   oTarget = GetObjectByTag("WIRT");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_WIRT")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_WIRT")));

   oTarget = GetObjectByTag("DEESE");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_DEESE")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_DEESE")));

   oTarget = GetObjectByTag("CELIA");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_CELIA")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_CELIA")));

   ExploreAreaForPlayer(GetArea(oPC), oPC);
   SetLocalInt(oPC, "wirthome", 0);

   }
   else
   {
   oTarget = GetObjectByTag("CAIN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_CAIN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_CAIN")));

   oTarget = GetObjectByTag("GRISWOLD");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_GRISWOLD")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_GRISWOLD")));

   oTarget = GetObjectByTag("OGDEN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_OGDEN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_OGDEN")));

   oTarget = GetObjectByTag("GILLIAN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_GILLIAN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_GILLIAN")));

   oTarget = GetObjectByTag("TREMAYNE");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_TREMAYNE")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_TREMAYNE")));

   oTarget = GetObjectByTag("PEPIN");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_PEPIN")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_PEPIN")));

   oTarget = GetObjectByTag("WIRT");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_WIRT")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_WIRT")));

   oTarget = GetObjectByTag("DEESE");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_DEESE")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_DEESE")));

   oTarget = GetObjectByTag("CELIA");
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("DAY_CELIA")));
   AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("DAY_CELIA")));

   ExploreAreaForPlayer(GetArea(oPC), oPC);
   SetLocalInt(oPC, "wirthome", 0);
   }

}
