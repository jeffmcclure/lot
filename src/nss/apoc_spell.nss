//::///////////////////////////////////////////////
//:: FileName:apoc_spell
//:://////////////////////////////////////////////
//::This is Diablo's version of Apocalypse. Execute this script in Diablo's
//::user define under the perception and end-of-combat round flags. Be sure
//::Diablo's name is "Diablo" or change line 19.
//::Apocalypse will do fire and negative energy damage. The fire damage is
//::halved with a successful reflex save.
//:://////////////////////////////////////////////
//:: Created By: Devin Loiacano
//:: Created On: February 24, 2004
//:://////////////////////////////////////////////

void CastApoc();

void main()
{
//Will only cast if object is named Diablo
if(GetTag(OBJECT_SELF)=="NPC_DIABLO")
CastApoc();
}

void CastApoc()
{
object oPercep = GetAttackTarget();
object oTarget;
effect eApoc = EffectVisualEffect(498); //Flame visual effect
effect eFireDam;
effect eNegDam;
int nFireDam;
int nFireDamAdj;
int nFireDC;
int nNegDam;
float fDist=35.0;

//Play sound and casting animation
ClearAllActions(FALSE);
ActionDoCommand(PlaySound("c_devil_atk3"));
ActionPlayAnimation(ANIMATION_LOOPING_CONJURE2,1.5);

//Line of sight set to FALSE so that it works through walls like in Diablo
oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fDist, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
while(GetIsObjectValid(oTarget))
{
//If(hostile)
if(GetReputation(OBJECT_SELF, oTarget) < 11)
{
//Set the damages. Adjust the fire damage if successful reflex save. The fire damage
//is done so that rogues still take half damage even if successful save.
nFireDam = 20 + d20(2);
nFireDC = 36;
nFireDamAdj = GetReflexAdjustedDamage(nFireDam, oTarget, nFireDC, SAVING_THROW_REFLEX);
if(nFireDamAdj != nFireDam)
nFireDam = nFireDam/2;

nNegDam = 20 + d20(2);

//Set the effects
eFireDam = EffectDamage(nFireDam, DAMAGE_TYPE_FIRE, DAMAGE_POWER_ENERGY);
eNegDam = EffectDamage(nNegDam, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_ENERGY);

//Create the visual effect
ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApoc, oTarget, 1.0));

//Apply damage effects.
ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireDam, oTarget));
ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT, eNegDam , oTarget));
}

oTarget=GetNextObjectInShape(SHAPE_SPHERE, fDist, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_CREATURE);
}

//Set to attack. If you don't you will just stand and do nothing.
if(GetIsObjectValid(oPercep))
ActionAttack(oPercep);
else
ActionAttack(oTarget);
}
