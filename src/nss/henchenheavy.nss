#include "hench_i0_equip"

void main()
{
    SetLocalInt(OBJECT_SELF, "LightOffHand", FALSE);
    ClearWeaponStates();
    HenchEquipDefaultWeapons();
}
