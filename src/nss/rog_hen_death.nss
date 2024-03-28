//::///////////////////////////////////////////////
//:: Henchman Death Script
//::
//:: 69_hen_death
//::
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: <description>
//:://////////////////////////////////////////////
//::
//:: Created By: 69MEH69 Jul2003 Henchman Death Option
//:://////////////////////////////////////////////
#include "69_inc_henai"

void BringBack();
void HenchmanBleed(object oHench = OBJECT_SELF);
void HenchHeal(object oHench = OBJECT_SELF);
void HenchmanDeath(object oHench = OBJECT_SELF);
void HenchRejoin(object oHench = OBJECT_SELF);
void HenchSalvation(object oHench);
void HenchmanLootBag(object oHench);
//Set HENCH_SALVATION = 1 to allow for the possibility of
//henchman recovering from wounds each round
//Set HENCH_SALVATION = 0 to allow only one check for the
//possibility of henchman recovering from wounds
const int HENCH_SALVATION  = 1;

void main()
{
    //Henchman Death Option: Set HENCH_BLEED = 1 for henchman bleeding
    //                       Set HENCH_BLEED = 0 for default BIOWARE death
    int HENCH_BLEED = 1;

    object oPC = GetRealMaster(OBJECT_SELF);
    string sName = GetName(OBJECT_SELF);
    object oArea = GetArea(OBJECT_SELF);
    string sTag = GetTag(OBJECT_SELF);

    if(HENCH_BLEED == 0)
    {
     if (GetIsObjectValid(GetMaster()) == TRUE)
     {
        object oMe = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetMaster());
        if (oMe == OBJECT_SELF
            // * this is to prevent 'double hits' from stopping
            // * the henchmen from moving to the temple of tyr
            // * I.e., henchmen dies 'twice', once after leaving  your party
            || GetDidDie(OBJECT_SELF))//GetLocalInt(OBJECT_SELF, "NW_L_HEN_I_DIED") == TRUE
        {

            HenchmanDeath(oMe);
            SetDidDie(TRUE, oMe);
            SetHenchmanDying(oMe, FALSE);
            SetPlotFlag(oMe, TRUE);
            SetAssociateState(NW_ASC_IS_BUSY, TRUE);
            SetIsDestroyable(FALSE, TRUE, TRUE);

            ClearAllDialogue(oPC, OBJECT_SELF);
            ClearAllActions();
            DelayCommand(0.5, ActionDoCommand(SetCommandable(TRUE)));
            DelayCommand(9.0, ActionDoCommand(SetAssociateState(NW_ASC_IS_BUSY, FALSE)));

            DelayCommand(9.1, SetPlotFlag(oMe, FALSE));

            DelayCommand(10.0, BringBack());
            DelayCommand(10.5, SetCommandable(FALSE));


         }
         else
         // * I am a familiar, give 1d6 damage to my master
         if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR, GetMaster()) == OBJECT_SELF)
         {
            // April 2002: Made it so that familiar death can never kill the player
            // only wound them.
            int nDam =d6();
            if (nDam >= GetCurrentHitPoints(GetMaster()))
            {
                nDam = GetCurrentHitPoints(GetMaster()) - 1;
            }
            effect eDam = EffectDamage(nDam);
            FloatingTextStrRefOnCreature(63489, GetMaster(), FALSE);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDam, GetMaster());
         }
        } //End HENCH_BLEED = 0
       }
       else if(HENCH_BLEED == 1)
       {
        if (GetIsObjectValid(GetMaster()) == TRUE)
        {
         object oMe = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, GetMaster());
         if (oMe == OBJECT_SELF || GetDidDie(OBJECT_SELF))
         {
          ClearAllDialogue(oPC, OBJECT_SELF);
          ClearAllActions();
          PreRespawnSetup(OBJECT_SELF);
          HenchmanDeath(OBJECT_SELF);
          SetLocalObject(oArea, "DOA" +sTag, OBJECT_SELF);

          if(GetCurrentHitPoints(OBJECT_SELF) <= -10)
          {
                SetDidDie(TRUE, OBJECT_SELF);
                SetHenchmanDying(OBJECT_SELF, FALSE);
                PlaySound("dth_rogue");
                //PlayVoiceChat(VOICE_CHAT_DEATH); /* scream one last time */
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), OBJECT_SELF); /* make death dramatic */
                ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF); /* now kill them */
                SendMessageToPC(oPC, sName+ " has died!");
                HenchmanLootBag(OBJECT_SELF);
                return;
          }
          DelayCommand(0.5, VoiceHealMe(TRUE));
          if(GetCurrentHitPoints(OBJECT_SELF) > 0)
          {
            SetLocalInt(oArea, "nCHP" +sTag, -1);
          }
          else
          {
            SetLocalInt(oArea, "nCHP" +sTag, GetCurrentHitPoints(OBJECT_SELF));
          }

          HenchSalvation(OBJECT_SELF);

          if(GetIsHenchmanDying(OBJECT_SELF) == TRUE && GetDidDie(OBJECT_SELF) == FALSE)
          {
              SendMessageToPC(oPC, sName+ " is dying");
              DelayCommand(1.0, HenchmanBleed(OBJECT_SELF));
          }

         }
        }
       } //End HENCH_BLEED = 1

}

void BringBack()
{
    // : REMINDER: The delay is here   for a reason
    DelayCommand(0.1, RemoveEffects(OBJECT_SELF));
    DelayCommand(0.2, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectResurrection(), OBJECT_SELF));
    DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectHeal(GetMaxHitPoints(OBJECT_SELF)), OBJECT_SELF));
    DelayCommand(1.0, SetLocalInt(OBJECT_SELF, MH_MODE_ATTACK, TRUE));
    DelayCommand(1.5, SetAssociateState(NW_ASC_USE_RANGED_WEAPON, FALSE));
    DelayCommand(5.1, SetIsDestroyable(TRUE, TRUE, TRUE));

    object oWay = GetObjectByTag("NW_DEATH_TEMPLE");
    if (GetIsObjectValid(oWay) == TRUE)
    {
        // * if in Source stone area, respawn at opening to area
        if (GetTag(GetArea(OBJECT_SELF)) == "MYAREA")
        {
            DelayCommand(0.2, JumpToObject(GetObjectByTag("MYTAG"), FALSE));
        }
        else
            DelayCommand(0.2, JumpToObject(oWay, FALSE));
    }
    else
        DelayCommand(0.3, ActionSpeakString("UT: No place to go"));
}

void HenchmanBleed(object oHench = OBJECT_SELF)
{
  object oPC = GetFormerMaster(oHench);
  string sTag = GetTag(oHench);
  object oArea = GetArea(oHench);
  string sName = GetName(oHench);

  if(HENCH_SALVATION == 1)
  {
   HenchSalvation(oHench);
  }
  /*switch (d6(1))
  {
     case 1: PlayVoiceChat(VOICE_CHAT_PAIN1); break;
     case 2: PlayVoiceChat(VOICE_CHAT_PAIN2); break;
     case 3: PlayVoiceChat(VOICE_CHAT_PAIN3); break;
     case 4: PlayVoiceChat(VOICE_CHAT_HEALME); break;
     case 5: PlayVoiceChat(VOICE_CHAT_NEARDEATH); break;
     case 6: PlayVoiceChat(VOICE_CHAT_HELP); break;
  }*/
  if(GetIsHenchmanDying(OBJECT_SELF) == TRUE && GetDidDie(OBJECT_SELF) == FALSE)
  {
   int nCHP = GetLocalInt(oArea, "nCHP" +sTag);
   SetLocalInt(oArea, "nCHP" +sTag, nCHP - 1);
   nCHP = GetLocalInt(oArea, "nCHP" +sTag);
   string sCHP = IntToString(nCHP);
   SendMessageToPC(oPC, sName+ " has " +sCHP+ " hit points!");
   //int nHP = GetCurrentHitPoints(oHench);
   //string sHP = IntToString(nHP);
   //SendMessageToPC(oPC, sName+ " has " +sHP+ " hit points");
   if(GetLocalInt(oArea, "nCHP" +sTag) >= 1)
   {
    ClearAllActions();
    SendMessageToPC(oPC, sName+ " is healed!");
    PostRespawnCleanup(oHench);
    PartialRes(oHench);
    HenchRejoin(oHench);
    if(GetLocalInt(oArea, "nCHP" +sTag) >= 20)
    {
     ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oHench)), oHench);
    }
    return;
   }
   else if(GetLocalInt(oArea, "nCHP" +sTag) <= -10)
   {
    SetDidDie(TRUE, oHench);
    SetHenchmanDying(oHench, FALSE);
    SendMessageToPC(oPC, sName+ " is beyond healing!");
    PlaySound("dth_rogue");
    //PlayVoiceChat(VOICE_CHAT_DEATH); /* scream one last time */
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), OBJECT_SELF); /* make death dramatic */
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF); /* now kill them */
    HenchmanLootBag(oHench);
     return;
   }
   else
   {
    SendMessageToPC(oPC, sName+ " is dying");
    DelayCommand(1.0, HenchmanBleed(oHench));
   }
  }
}

void HenchHeal(object oHench = OBJECT_SELF)
{
 object oPC = GetFormerMaster(oHench);
 string sName = GetName(oHench);
 object oArea = GetArea(oHench);
 string sTag = GetTag(oHench);
 int nCHP = GetLocalInt(oArea, "nCHP" +sTag);
 SetLocalInt(oArea, "nCHP" +sTag, nCHP + 1);
 nCHP = GetLocalInt(oArea, "nCHP" +sTag);
 string sCHP = IntToString(nCHP);
 SendMessageToPC(oPC, sName+ " has " +sCHP+ " hit points!");
 if(nCHP >= 1)
 {
  PostRespawnCleanup(oHench);
  PartialRes(oHench);
  HenchRejoin(oHench);
   return;
 }
 else
 {
  SendMessageToPC(oPC, sName+ " is healing");
  DelayCommand(6.0, HenchHeal(oHench));
 }

}

void HenchmanDeath(object oHench = OBJECT_SELF)
{
            object myMaster = GetMaster(oHench);
            object myHenchman = GetHenchman(oHench);
            object oPC = GetRealMaster(oHench);
            // Henchman death notification
            string sHenchName = GetName(oHench);
            SendMessageToPC(oPC, sHenchName+ " has fallen!");
            // Decrement number of henchmen
            int nHench = GetLocalInt(oPC, "nHench");
            string sHench = IntToString(nHench);
            SendMessageToPC(oPC, "Number of henchman was " +sHench);
            SetLocalInt(oPC, "nHench", nHench - 1);
            int nNHench = GetLocalInt(oPC, "nHench");
            string sNHench = IntToString(nNHench);
            SendMessageToPC(oPC, "Number of henchman is now " +sNHench);
            SetFormerMaster(oPC, oHench);
            RemoveHenchman(myMaster);
            if (GetIsObjectValid(myHenchman))
            {
                RemoveHenchman(oHench, myHenchman);
                if (GetIsObjectValid(myMaster))
                {
                    AddHenchman(myMaster, myHenchman);
                }
            }
            if(GetStealthMode(oHench) == STEALTH_MODE_DISABLED)
            {
             DelayCommand(5.0, ActionDoCommand(SetAssociateState(NW_ASC_AGGRESSIVE_STEALTH, FALSE)));
            }
            else
            {
              DelayCommand(5.0, ActionDoCommand(SetAssociateState(NW_ASC_AGGRESSIVE_STEALTH, FALSE)));
              DelayCommand(5.1, ActionDoCommand(ActionUseSkill(SKILL_HIDE, oHench)));
            }
            if(GetLocalInt(oHench,"Scouting"))
            {
             SetLocalInt(oHench, "Scouting", FALSE);
            }
}

void HenchRejoin(object oHench = OBJECT_SELF)
{
 SetAssociateListenPatterns();
 bkSetListeningPatterns();
    // * Companions, come in, by default with Attack Nearest Enemy && Follow Master modes
 SetLocalInt(OBJECT_SELF,"NW_COM_MODE_COMBAT",ASSOCIATE_COMMAND_ATTACKNEAREST);
 SetLocalInt(OBJECT_SELF,"NW_COM_MODE_MOVEMENT",ASSOCIATE_COMMAND_FOLLOWMASTER);

 object oPC = GetFormerMaster(oHench);
 object oMaster = oPC;
 int nHench = GetLocalInt(oPC, "nHench");
 while(GetIsObjectValid(GetHenchman(oMaster)) == TRUE)
 {
    oMaster = GetHenchman(oMaster);
 }
    //SetWorkingForPlayer and SetBeenHired added for ondeath conversation
    SetWorkingForPlayer(oPC);
    SetBeenHired();
    SetLocalObject(OBJECT_SELF, "PCMaster", oPC);
    SetLocalInt(oPC, "nHench", nHench +1);
    AddHenchman(oMaster);
}

void HenchSalvation(object oHench)
{
 object oPC = GetFormerMaster(oHench);
 string sTag = GetTag(oHench);
 object oArea = GetArea(oHench);
 string sName = GetName(oHench);
 int nSalvation = d10(1);
 if(nSalvation == 1 && GetDidDie(oHench) == FALSE)
 {
   int nGender = GetGender(oHench);
   string sGender;
   if(nGender == GENDER_FEMALE)
   {
     sGender = "her";
   }
   else if(nGender == GENDER_MALE)
   {
     sGender = "his";
   }
   else
   {
     sGender = "it's";
   }
   SetHenchmanDying(oHench, FALSE);
   PlayVoiceChat(VOICE_CHAT_LAUGH);
   SendMessageToPC(oPC, sName+ " has avoided death and is recovering from " +sGender+ " wounds!");
   DelayCommand(6.0, HenchHeal(oHench));

  }
}

void HenchmanLootBag(object oHench)
{
 object oPC = GetFormerMaster(oHench);
 location lLoc = GetStepRightLocation(oHench);
 string sTag = GetTag(oHench);
// object oLootBag = CreateObject(OBJECT_TYPE_ITEM, "henchmanbackpack", lLoc, FALSE, sTag+ "BAG");
// MoveHenchmanItems(oLootBag, oHench);
}
