object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

   oTarget = GetObjectByTag("CAIN");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_CAIN")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_CAIN")));

   oTarget = GetObjectByTag("GRISWOLD");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_GRISWOLD")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_GRISWOLD")));

   oTarget = GetObjectByTag("OGDEN");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_OGDEN")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_OGDEN")));

   oTarget = GetObjectByTag("GILLIAN");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_GILLIAN")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_GILLIAN")));

   oTarget = GetObjectByTag("TREMAYNE");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_TREMAYNE")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_TREMAYNE")));

   oTarget = GetObjectByTag("PEPIN");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_PEPIN")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_PEPIN")));

   oTarget = GetObjectByTag("WIRT");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_WIRT")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_WIRT")));

   oTarget = GetObjectByTag("DEESE");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_DEESE")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_DEESE")));

   oTarget = GetObjectByTag("LESTER");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_DEESE")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_DEESE")));

   oTarget = GetObjectByTag("CELIA");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_CELIA")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_CELIA")));

   oTarget = GetObjectByTag("COWMAN");
   SetAILevel(oTarget,AI_LEVEL_NORMAL);
   //AssignCommand(oTarget, ClearAllActions());
   //AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("EVENING_CELIA")));
   //AssignCommand(oTarget, ActionJumpToObject(GetObjectByTag("EVENING_CELIA")));

   ExploreAreaForPlayer(GetArea(oPC), oPC);
   SetLocalInt(oPC, "wirthome", 0);
   ExecuteScript("ent_shadowfang", OBJECT_SELF);
}
