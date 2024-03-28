/////////////////////////////////////////////////////
// NPC ACTIVITIES 5.0 - OnPhysicalAttack Anvil
//--------------------------------------------------
// By Deva Bryson Winblood.
/////////////////////////////////////////////////////
// SCRIPT: npcact_use_panvi
/////////////////////////////////////////////////////

void main()
{
    effect eSpark=EffectVisualEffect(VFX_COM_SPARKS_PARRY);
    object oMe=OBJECT_SELF;
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSpark,oMe,1.0);
}
