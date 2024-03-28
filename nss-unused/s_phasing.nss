//::///////////////////////////////////////////////
//:: FileName:spell_phase
//:://////////////////////////////////////////////
//::Trigger this with the EVENT_DAMAGED and EVENT_SPELL_CAST_AT.
//::Make sure the EVENT_DAMAGED flag is uncommented in default9.
//::
//::Sends the caller to a random, nearby location even if the new
//::location is not in line-of-sight.
//:://////////////////////////////////////////////
//:: Created By: Devin Loiacano
//:: Created On: February 27, 2004
//:://////////////////////////////////////////////

void CastPhase();

void main()
{
//Will only cast if object is tagged Lazarus
if(GetTag(OBJECT_SELF)=="NPC_LAZARUS")
CastPhase();
}

void CastPhase()
{
object oTarget = GetAttackTarget();
location lTarget;
vector vOldPosition;
vector vNewPosition;
float fAttackerFacing;
float fNewX;
float fNewY;

PlaySound("as_mg_telepout1");

vOldPosition = GetPosition(OBJECT_SELF);

//Set how far to teleport
if(d2()==2)
fNewX = vOldPosition.x + IntToFloat(4 + d4());
else
fNewX = vOldPosition.x - IntToFloat(4 + d4());

if(d2()==2)
fNewY = vOldPosition.y + IntToFloat(4 + d4());
else
fNewY = vOldPosition.y - IntToFloat(4 + d4());

vNewPosition = Vector(fNewX, fNewY, vOldPosition.z);

lTarget = Location(GetArea(OBJECT_SELF), vNewPosition, 0.0);

JumpToLocation(lTarget);
SetFacingPoint(GetPosition(oTarget));
}
