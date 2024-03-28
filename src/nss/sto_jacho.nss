#include "jeff"

void main()
{
    object oStore = GetNearestObjectByTag("STO_JACHOSTORE");
    if (GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
        jeffAppraiseOpenStore(oStore, GetPCSpeaker());
    }
    else
    {
        ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
    }
}
