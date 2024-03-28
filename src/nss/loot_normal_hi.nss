#include "loot_inc_data"
#include "loot_inc_main"
#include "loot_inc_gen_mod"
// #include "nw_o2_coninclude"
// Uncomment the above line if you would prefer to use the standard BioWare
// treasure scripts. If you do so delete the line that includes "loot_inc_gen_mod"

void main()
{
    // Get Area-Wide respawn time for loot. If none is specified
    // in loot_inc_data, then it will use the default of one hour.

    float fRespawnTime = GetRespawnTime (OBJECT_SELF);

    if (GetLocalInt(OBJECT_SELF, "NW_DO_ONCE") != 0)
        {
            return;
        }

    SetLocalInt(OBJECT_SELF, "NW_DO_ONCE", 1);
    ShoutDisturbed();
    AssignCommand( OBJECT_SELF, DelayCommand(fRespawnTime, SetLocalInt(OBJECT_SELF, "NW_DO_ONCE", 0) ) );
    object oLastOpener = GetLastOpener();

    // Gets a random member of the party, instead of the person
    // who opened the chest.

    object oLuckyMember = GetRandomPartyMember(oLastOpener);

    // Get maximum level allowed for looting chests in area.
    // If none is specified in loot_inc_data, then it will use
    // the default of the maximum level being 100. If the party
    // has a member that is too high, all they get is boots.

    if (GetIsOverMaxAllowedLevel (oLastOpener, OBJECT_SELF))
        {
        CreateItemOnObject ("WornOutBoots", OBJECT_SELF, 1);
        return;
        }

    // Generate the treasure on the object.

    GenerateHighTreasure(oLuckyMember, OBJECT_SELF);
}

