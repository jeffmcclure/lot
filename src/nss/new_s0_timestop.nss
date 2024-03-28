//::///////////////////////////////////////////////
//:: Time Stop
//:: NW_S0_TimeStop.nss
//:: Modified Time Stop
//:://////////////////////////////////////////////
/*
The caster is turned into a penguin
*/
//:://////////////////////////////////////////////
//:: Created By: Arch!ve, (NWN) Griffsu , RL: Greg S.
//:: Created On: Dec 23, 2002
//:://////////////////////////////////////////////

void main()
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
EffectPolymorph(POLYMORPH_TYPE_PENGUIN),OBJECT_SELF,10.0);
}
