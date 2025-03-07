//::///////////////////////////////////////////////////
//:: LootableDeath (modified X0_C2_DTH_LOOTDC)
//:: OnDeath handler.
//:: Leave a lootable corpse that will decay.  For use
//:: with Zombie Feed script set.
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Modified By: Lupin-III (lupin_3rd@hotmail.com)
//::///////////////////////////////////////////////////

#include "nw_i0_generic"
#include "x0_i0_corpses"

void main()
{

    // * make sure this can happen only once.
    if (GetLocalInt(OBJECT_SELF, "NW_L_DEATHEVENTFIRED") == 10) return;
    SetLocalInt(OBJECT_SELF, "NW_L_DEATHEVENTFIRED",10) ;

    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        object oKiller = GetLastKiller();
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    // Leave a lootable corpse that will decay
    KillAndReplaceLootable(OBJECT_SELF, TRUE, TRUE);
}
