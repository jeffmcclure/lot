//::///////////////////////////////////////////////
//:: Dying Script
//:: 69_o0_dying.nss
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a character is dying. Dying
    is when the character is between 0 and -9 hit
    points; -10 and below is death. To use, redirect
    the OnDying event script of the module to this script.
*/
//:://////////////////////////////////////////////
//:: Author : 69MEH69 AUG2003
//:://////////////////////////////////////////////
#include "69_inc_henai"

//Set PC_BLEEDING = 1 to initiate PC Bleeding
//Set PC_BLEEDING = 0 to initiate default BIOWARE PC death
const int PC_BLEEDING = 1;

void SetHP(string sID, object oPlayer)
{
    SetLocalInt(GetModule(),"LastHP"+sID,GetCurrentHitPoints(oPlayer));
}

void bleed(int iBleedAmt)
{
    effect eBleedEff;

    // HCR Stuff
    object oPlayer=OBJECT_SELF;
    string sPlayer = GetName(oPlayer);
    int iCHP=GetCurrentHitPoints(oPlayer);
    string sName=GetName(oPlayer);
    string sCDK=GetPCPublicCDKey(oPlayer);
    string sID=sName+sCDK;
    int iLHP=GetLocalInt(GetModule(),"LastHP"+sID);

    /* keep executing recursively until character is dead or at +1 hit points */
    if (GetCurrentHitPoints() <= 0) {

        /* a positive bleeding amount means damage, otherwise heal the character */
        if (iBleedAmt > 0)
        {
            eBleedEff = EffectDamage(iBleedAmt);
        }
        else
        {
            eBleedEff = EffectHeal(-iBleedAmt);  /* note the negative sign */
        }

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eBleedEff, OBJECT_SELF);

        /* -10 hit points is the death threshold, at or beyond it the character dies */
        if (GetCurrentHitPoints() <= -10) {
            PlayVoiceChat(VOICE_CHAT_DEATH); /* scream one last time */
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), OBJECT_SELF); /* make death dramatic */
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF); /* now kill them */
            return;
        }

        if (iBleedAmt > 0) { /* only check if character has not stablized */
           if ((d10(1) == 1) || (iCHP > iLHP))/* 10% chance to stablize */
                {
                iBleedAmt = -iBleedAmt; /* reverse the bleeding process */
                FloatingTextStringOnCreature("Your wounds have stabilized!", OBJECT_SELF);
                PlayVoiceChat(VOICE_CHAT_LAUGH); /* laugh at death -- this time */
                }
            else
            {
                //Henchman Cleric Code
               if(GetCurrentHitPoints() <= -5)
               {
                object oHealer = GetHenchman(oPlayer);
                int nSpeak;
                string sName;
                talent tHeal;
                while(oHealer != OBJECT_INVALID)
                {
                 sName = GetName(oHealer);
                 if(GetClassByPosition(1, oHealer) == CLASS_TYPE_CLERIC || GetClassByPosition(2, oHealer) == CLASS_TYPE_CLERIC || GetClassByPosition(3, oHealer) == CLASS_TYPE_CLERIC || GetClassByPosition(1, oHealer) == CLASS_TYPE_DRUID  || GetClassByPosition(2, oHealer) == CLASS_TYPE_DRUID || GetClassByPosition(3, oHealer) == CLASS_TYPE_DRUID)
                 {
                  if(GetIsTalentValid(tHeal))
                  {
                   AssignCommand(oHealer, ClearAllActions());
                   tHeal = GetCreatureTalentBest(TALENT_CATEGORY_BENEFICIAL_HEALING_TOUCH, 20, oHealer);
                   SendMessageToPC(oPlayer, sName+ " is casting healing onto " +sPlayer);
                   AssignCommand(oHealer, ActionUseTalentOnObject(tHeal, oPlayer));
                   //AssignCommand(oHealer, ActionCastSpellAtObject(SPELL_CURE_MODERATE_WOUNDS, oPlayer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));
                  }
                  else if(nSpeak == 0)
                  {
                    nSpeak = 1;
                    AssignCommand(oHealer, ActionSpeakString("I'm out of healing spells!", TALKVOLUME_TALK));
                    DelayCommand(2.5, PlayVoiceChat(VOICE_CHAT_CANTDO, oHealer));
                  }

                 }
                 oHealer = GetHenchman(oHealer);
                }
               }
                //End Henchman Cleric Code

                if(GetCurrentHitPoints() <= 0)
                {
                 switch (d6(1))
                    {
                    case 1: PlayVoiceChat(VOICE_CHAT_PAIN1); break;
                    case 2: PlayVoiceChat(VOICE_CHAT_PAIN2); break;
                    case 3: PlayVoiceChat(VOICE_CHAT_PAIN3); break;
                    case 4: PlayVoiceChat(VOICE_CHAT_HEALME); break;
                    case 5: PlayVoiceChat(VOICE_CHAT_NEARDEATH); break;
                    case 6: PlayVoiceChat(VOICE_CHAT_HELP); break;
                    }
                }
            }
        }
        SetHP(sID, oPlayer);
        DelayCommand(6.0,bleed(iBleedAmt)); /* do this again next round */
    }
    else
    {
        // Determines combat round for nearest enemy when PC becomes conscious
        object oAttacker = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC, oPlayer, 1, CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, CREATURE_TYPE_IS_ALIVE, TRUE);
        AssignCommand(oAttacker, DetermineCombatRound(oPlayer, 10));
    }
}


void main()
{
   object oDying = GetLastPlayerDying();
   if(PC_BLEEDING == 0)
   {
    effect eDeath = EffectDeath(FALSE, FALSE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, GetLastPlayerDying());
   }
   else if(PC_BLEEDING == 1)
   {
    AssignCommand(oDying, ClearAllActions());
    AssignCommand(oDying, bleed(1));
   }
}
