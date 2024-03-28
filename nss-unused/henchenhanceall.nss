#include "hench_i0_enhanc"


void main()
{    
    ClearAllActions();
    SetLocalInt(OBJECT_SELF, "X2_BUFFING_TYPE", 3);
    SetLocalObject(OBJECT_SELF, "Henchman_Spell_Target", OBJECT_INVALID);
    ExecuteScript("hench_o0_enhanc", OBJECT_SELF);
}
