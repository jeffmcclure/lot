//::///////////////////////////////////////////////
//:: Death Script
//:: NW_O0_DEATH.NSS
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a player dies.

    BK: October 8 2002: Overriden for Expansion
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: November 6, 2001
//:: Modified: 69MEH69 AUG2003
//:://////////////////////////////////////////////

#include "inc_cloak_ff"

//Set PC_BLEEDING = 1 to initiate PC Raise Dead/Resurrection by a healer henchman
//Set PC_BLEEDING = 0 to initiate default BIOWARE PC death
const int PC_BLEEDING = 1;

void Raise(object oPlayer)
{
        effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);

        effect eBad = GetFirstEffect(oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPlayer);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer);
        CloakOfFastFeet(oPlayer);

        //Search for negative effects
        while(GetIsEffectValid(eBad))
        {
            if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE ||
                GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
                GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
                GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
                GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
                {
                    //Remove effect if it is negative.
                    RemoveEffect(oPlayer, eBad);
                }
            eBad = GetNextEffect(oPlayer);
        }
        //Fire cast spell at event for the specified target
        SignalEvent(oPlayer, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oPlayer);
}

void main() {

    object oPlayer = GetLastPlayerDied();
    string sPlayer = GetName(oPlayer);
    // * increment global tracking number of times that I died
    SetLocalInt(oPlayer, "NW_L_PLAYER_DIED", GetLocalInt(oPlayer, "NW_L_PLAYER_DIED") + 1);
    if(PC_BLEEDING == 1)
    {
     //Henchman Cleric Code
     object oHealer = GetHenchman(oPlayer);
     string sName;
     location lLoc;
     int nRoll;
     while(oHealer != OBJECT_INVALID)
     {
      sName = GetName(oHealer);
      if(GetClassByPosition(1, oHealer) == CLASS_TYPE_CLERIC || GetClassByPosition(2, oHealer) == CLASS_TYPE_CLERIC || GetClassByPosition(3, oHealer) == CLASS_TYPE_CLERIC || GetClassByPosition(1, oHealer) == CLASS_TYPE_DRUID  || GetClassByPosition(2, oHealer) == CLASS_TYPE_DRUID || GetClassByPosition(3, oHealer) == CLASS_TYPE_DRUID)
      {
        nRoll = d2(1);
        AssignCommand(oHealer, ClearAllActions());
        if(nRoll == 1)
        {
         SendMessageToPC(oPlayer, sName+ " is casting Raise Dead onto " +sPlayer);
         AssignCommand(oHealer, ActionCastSpellAtObject(SPELL_RAISE_DEAD, oPlayer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));
         return;
        }
        else if(nRoll == 2)
        {
         SendMessageToPC(oPlayer, sName+ " is casting Resurrection onto " +sPlayer);
         AssignCommand(oHealer, ActionCastSpellAtObject(SPELL_RESURRECTION, oPlayer, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, FALSE));
         return;
        }
       }
       oHealer = GetHenchman(oHealer);
     }
    }
    //End Henchman Cleric Code

    // * make friendly to Each of the 3 common factions
    AssignCommand(oPlayer, ClearAllActions());
    // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
    if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPlayer);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPlayer);
    }
    if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPlayer) <= 10)
    {   SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
        SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPlayer);
    }

    // * BK: Automation Control. Autopcs ignore death
    if (GetLocalInt(oPlayer, "NW_L_AUTOMATION") == 10) {
        SendMessageToPC(GetFirstPC(), "raising....");
        Raise(oPlayer);
        DelayCommand(1.0, ExecuteScript("crawl", OBJECT_SELF));
        return; // Raise and return
    }

    string sArea = GetTag(GetArea(oPlayer));

    //if (sArea == "M4Q1D2" || sArea == "M3Q3C" || sArea == "MAP_M1Q6A") {
        ////Raise(oPlayer);
        ////string sDestTag = "M4QD07_ENTER";
        ////object oSpawnPoint = GetObjectByTag(sDestTag);
        ////AssignCommand(oPlayer, DelayCommand(1.0, JumpToLocation(GetLocation(oSpawnPoint))));
        //// * MAY 2002: Just popup the YOU ARE DEAD panel at this point
        ////DelayCommand(2.5, PopUpDeathGUIPanel(oPlayer,FALSE, TRUE, 66487));
        //return;
    //}

    int points = GetCurrentHitPoints(oPlayer);
    if (points > 0) {
        return;
    } else {
        FloatingTextStringOnCreature("YOU DIED", oPlayer, FALSE);

        object soulsDeath = GetLocalObject(oPlayer, "DEATH_LOCATION");
        if (GetIsObjectValid(soulsDeath)) DestroyObject(soulsDeath);

        // Locate the area we are in
        object oArea = GetArea(oPlayer);

        // Locate where in the are we are
        vector vPosition = GetPosition(oPlayer);

        // Identify the direction we are facing
        //float fOrientation = GetFacing(OBJECT_SELF) - 180.0;
        //if (fOrientation < 0.0) fOrientation = fOrientation + 360.0;

        // Create a new location with this information
        location lTarget = Location(oArea, vPosition, 0.0);
        //location lTarget = GetLocation(oPlayer);

        object obj = CreateObject(OBJECT_TYPE_PLACEABLE, "soulsdeath", lTarget);
        SetName(obj, GetName(oPlayer) + " bought it here.  RIP.");
        SetLocalString(obj, "PLAYER_NAME", GetName(oPlayer));
        SetLocalObject(oPlayer, "DEATH_LOCATION", obj);

        DelayCommand(0.1, MusicBattleStop(GetArea(oPlayer)));
        DelayCommand(5.0, PopUpDeathGUIPanel(oPlayer,TRUE,TRUE,64521));
    }

}
