#include "jeff"

void main()
{
    object oStore = GetNearestObjectByTag("STO_TREMAYNEPREMIUM");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        jeffAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
