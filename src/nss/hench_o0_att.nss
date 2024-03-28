#include "hench_i0_equip"


void main()
{
    object oIntruder = GetLocalObject(OBJECT_SELF, "AIIntruderObj");
    DeleteLocalObject(OBJECT_SELF, "AIIntruderObj");
    
    HenchEquipDefaultWeapons();
    ActionAttack(oIntruder);
}
