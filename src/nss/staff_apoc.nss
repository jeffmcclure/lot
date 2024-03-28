//::///////////////////////////////////////////////
//:: FileName:staff_apoc
//:://////////////////////////////////////////////
//::This is the item version of Apocalypse. Works on items tagged staff_apoc* .
//::
//::Apocalypse is set to do fire damage as well as divine. The fire damage is
//::halved with a successful reflex save.
//::
//::I could not figure out a way to get the damage to float above the targets
//::either in the default blue numbers or by floating text. Closest I could get
//::was getting all the damages to float over the caster's head. For now, all
//::combat info is displayed by SendMessageToPC.
//:://////////////////////////////////////////////
//:: Created By: Devin Loiacano
//:: Created On: February 24, 2004
//:://////////////////////////////////////////////

void CastApoc();
int GetCalculatedDC(object oCaster);
void SendMessageToParty(object oCaller, string sMessage);

void main()
{
CastApoc();
}

void CastApoc()
{
object oCaster = GetItemActivator();
object oTarget;
location lCaster = GetLocation(oCaster);
effect eApoc = EffectVisualEffect(498); //Flame visual effect
effect eFireDam;
effect eDivineDam;
int nFireDam;
int nFireDamAdj;
int nDivineDam;
int nTotalDam;
int nCasterDC = GetCalculatedDC(oCaster);
int nCasterLevel;
string sCaster = GetName(oCaster);
string sTarget;
string sFireDam;
string sDivineDam;
string sTotalDam;
string sCasterDC = IntToString(nCasterDC);
float fDist = 10 + IntToFloat(nCasterDC)/2; //20 to 32.5 meters

//Get oCaster's level
nCasterLevel = GetLevelByPosition(1,oCaster);
nCasterLevel += GetLevelByPosition(2,oCaster);
nCasterLevel += GetLevelByPosition(3,oCaster);

//Line of sight set to FALSE so that it works through walls like in Diablo
oTarget = GetFirstObjectInShape(SHAPE_SPHERE, fDist, lCaster, FALSE, OBJECT_TYPE_CREATURE);
while(GetIsObjectValid(oTarget))
{
//if(hostile)
if(GetReputation(oCaster, oTarget) < 11)
{
sTarget = GetName(oTarget);

//Set the damages.
//Adjust the fire damage if successful reflex save. The fire damage
//is calculated so that half damage is taken even with evasion.
nFireDam = d10(((nCasterDC+20)*(nCasterLevel/2+25))/250);
nFireDam += d2(((nCasterDC+20)*(nCasterLevel/2+25)%250)/50);
nFireDamAdj = GetReflexAdjustedDamage(nFireDam, oTarget, nCasterDC, SAVING_THROW_REFLEX);
if(nFireDamAdj != nFireDam)
{
nFireDam = nFireDam/2;
SendMessageToParty(oCaster, sTarget + ": Reflex Save vs. Apocalypse: *success* vs. DC:" + sCasterDC);
}
sFireDam = IntToString(nFireDam);

//Set divine damage
nDivineDam = d10(((nCasterDC+20)*(nCasterLevel/2+25))/250);
nDivineDam += d2(((nCasterDC+20)*(nCasterLevel/2+25)%250)/50);
sDivineDam = IntToString(nDivineDam);

//Set the total damage
nTotalDam = nFireDam + nDivineDam;
sTotalDam = IntToString(nTotalDam);

//Set the effects
eFireDam = EffectDamage(nFireDam, DAMAGE_TYPE_FIRE, DAMAGE_POWER_ENERGY);
eDivineDam = EffectDamage(nDivineDam, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_ENERGY);

//Create the visual effect
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApoc, oTarget, 1.0);

//Apply damage effects. There is a delay because sometimes the damage gets
//applied somehow before the visual effect is applied, which may mean that
//the object is already dead. In which case, the visual effect may not
//fire at all.
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eFireDam, oTarget));
DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDivineDam, oTarget));

SendMessageToParty(oCaster, sCaster + " damages " + sTarget + ": " + sTotalDam + "(" + sFireDam + " Fire + " + sDivineDam + " Divine)");
}

oTarget=GetNextObjectInShape(SHAPE_SPHERE, fDist, lCaster, FALSE, OBJECT_TYPE_CREATURE);
}
}

////////////////////////////////////////////////////////////////////////////////
//Calculates the save DC by comparing oCaster's mage levels and ranks in
//the Use Magic Device skill. Balanced to give mages and rogues an opportunity
//to do more damage than warriors.
//
//DC Range for mages: 25 to 45
//Note: DC of 45 only possible with 40 mage levels
//
//DC Range for UMD : 20 to ~41
//Note: DC of ~41 is very unlikely as you would need a UMD >= 63
//43(chosen at level-up) + 2(skill focus) + 10(Epic SF) + ~10(Charisma modifier)
//
//DC Range default : 20 to 20
//Note: If no mage levels and less than 3 Use Magic Device ranks DC will be 20
////////////////////////////////////////////////////////////////////////////////
int GetCalculatedDC(object oCaster)
{
int nDC;
int nMageLevel;
int nUMDRank;

//Get oCaster's mage levels
nMageLevel += GetLevelByClass(CLASS_TYPE_BARD, oCaster);
nMageLevel += GetLevelByClass(CLASS_TYPE_CLERIC, oCaster);
nMageLevel += GetLevelByClass(CLASS_TYPE_DRUID, oCaster);
nMageLevel += GetLevelByClass(CLASS_TYPE_PALADIN, oCaster);
nMageLevel += GetLevelByClass(CLASS_TYPE_RANGER, oCaster);
nMageLevel += GetLevelByClass(CLASS_TYPE_SORCERER, oCaster);
nMageLevel += GetLevelByClass(CLASS_TYPE_WIZARD, oCaster);

//Get oCaster's Use Magic Device rank
nUMDRank = GetSkillRank(SKILL_USE_MAGIC_DEVICE, oCaster);

if(nMageLevel > 0 && nMageLevel/2 > (nUMDRank/3)-5)
{
nDC = 25 + (nMageLevel/2);
//Debugging Output
//SendMessageToPC(oCaster, "Using MageLevel DC");
}
else if(nUMDRank > 2)
{
nDC = 20 + nUMDRank/3;
//SendMessageToPC(oCaster, "Using UMD DC");
}
else
{
nDC = 20;
//SendMessageToPC(oCaster, "Using Default DC");
}

return nDC;
}

void SendMessageToParty(object oCaller, string sMessage)
{
object oMember = GetFirstFactionMember(oCaller);

while(GetIsObjectValid(oMember))
{
SendMessageToPC(oMember, sMessage);
oMember = GetNextFactionMember(oMember);
}
}
