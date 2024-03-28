//::///////////////////////////////////////////////
//:: FileName:staff_tele
//:://////////////////////////////////////////////
//::This is the item version of teleport.
//::
//::Teleport will send oCaster to a target location.
//:://////////////////////////////////////////////
//:: Created By: Devin Loiacano
//:: Created On: February 27, 2004
//:://////////////////////////////////////////////
void CastTele();

void main()
{
CastTele();
}

void CastTele()
{
object oCaster = GetItemActivator();
location lTarget = GetItemActivatedTargetLocation();

ActionDoCommand(PlaySound("as_mg_telepout1"));
AssignCommand(oCaster, ActionJumpToLocation(lTarget));
}
