//::///////////////////////////////////////////////////
//:: ZombieOnDeath - Modified X0_C2_DTH_LOOTDC
//:: OnDeath handler.
//:: Leave a lootable corpse that will decay after a
//:: short delay.  Modified for zombie feed script.
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Modified by: Lupin-III (lupin_3rd@hotmail.com)
//::///////////////////////////////////////////////////

//#include "nw_i0_generic"
//#include "x0_i0_corpses"

void main() {
    ExecuteScript("xp_partyextra", OBJECT_SELF);
    ExecuteScript("loot_normal_low", OBJECT_SELF);
    ExecuteScript("loot_partyfi1", OBJECT_SELF);

    //SetLocalInt(OBJECT_SELF, "deceased", 1);
    //SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    //SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    //if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT)) {
        //SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    //}

    // Leave a lootable corpse that will decay after a brief wait
    //KillAndReplaceLootable(OBJECT_SELF, TRUE, TRUE);
}
