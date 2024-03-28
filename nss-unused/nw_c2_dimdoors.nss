// Dimension Doors spawn in
// This is the DimDoors varient. It requires "nw_c2_dimdoor" in the UDE

// Flags combat round event, and then fires the default spawn in script.

#include "J_INC_CONSTANTS"

void main()
{
    // Spawn in condition
    SetSpawnInCondition(AI_FLAG_UDE_END_COMBAT_ROUND_EVENT, AI_UDE_MASTER);

    // Execute the default On Spawn file.
    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
