/*==========================================================================*/
/* Script Name    : Fiery Reign of Terror                                   */
/* Filename       : vox_firestorm                                           */
/* Version Info   : 1.0                                                     */
/* Date Created   : Monday, September 6th, 2004                             */
/* Date Modified  : ...                                                     */
/* Author         : Sotae (exileink@aol.com)                                */
/* Description    : This script is graphics intensive and should be used    */
/*                  SELDOMLY!!  It will create a hell on earth type ambience*/
/*                  where fire falls from the sky and erupts from the earth.*/
/*                                                                          */
/* Instructions: Simple place this script in the OnEnter of an area and     */
/* once the first PC enters the area, the Firefalls begin taking effect.    */
/* After each delay, the Firefalls will check to see if any PC's remain in  */
/* the area.  If there are no PC's, the Firefalls stop until the next PC    */
/* enters the area and starts the Firefalls again.                          */
/*==========================================================================*/
void FireStorm (object oArea, int iDamagePower, int iDamageRadius, int iRows, int iColumns, int iFrequency);
void FireDamage(int iDamage, int iDamageRadius, location lTarget);
/*==========================================================================*/
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

/*-- Configuration Variables --*/
    int iDamagePower = 6;       // This variable determines how many d6's to roll.
    int iDamageRadius = 20;     // This variable determines how big the explosion is.
    int iRows = 10;              // Width of Area
    int iColumns = 8;           // Length of Area
    int iFrequency = 10;        // Average number of seconds between explosions.
/*-- Main script --*/
    object oArea = OBJECT_SELF;
    int iRunning = GetLocalInt(oArea, "FireStorming");
    if (iRunning == TRUE)
        { return; }
    else
        {
        SetLocalInt(oArea, "FireStorming", TRUE);
        FireStorm(oArea, iDamagePower, iDamageRadius, iRows, iColumns, iFrequency);
        }
}
/*==========================================================================*/
void FireStorm (object oArea, int iDamagePower, int iDamageRadius, int iRows, int iColumns, int iFrequency)
{
    // Variables needed for the FireStorm.
    float fX = IntToFloat(Random(iRows * 10) + 1);
    float fY = IntToFloat(Random(iColumns * 10) + 1);
    location lTarget = Location(oArea, Vector(fX, fY, 0.0f), 0.0);
    location lCaster = Location(oArea, Vector(fX, fY, 31.0f), 0.0);
    float fDelay = GetDistanceBetweenLocations(lTarget, lCaster)/20;
    int iDamage = d6(iDamagePower);
    effect eVisual;
    // Generate a random effect.
    int iRandom = Random(4) + 1;
    switch (iRandom)
        {
        case 1: eVisual = EffectVisualEffect(VFX_FNF_FIREBALL); break;
        case 2: eVisual = EffectVisualEffect(VFX_FNF_FIRESTORM); break;
        case 3: eVisual = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE); break;
        case 4: eVisual = EffectVisualEffect(VFX_FNF_METEOR_SWARM); break;
        // case 5: eVisual = EffectVisualEffect(VFX_FNF_HORRID_WILTING); break;
        }
    // Do the proper stuff for the proper effect.  This is mostly only in here
    // to time the explosion of the Fireball on the ground with the projectile.
    if (iRandom == 1)
        {
        // Fireball stuff.  Create a fake caster to get the projectile falling.
        // Then destroy the fake caster and after the proper delay, create the
        // fireball explosion.
        object oCaster = CreateObject(OBJECT_TYPE_PLACEABLE, "fake_caster", lCaster);
        AssignCommand(oCaster, ActionCastFakeSpellAtLocation(SPELL_FIREBALL, lTarget));
        DestroyObject(oCaster, 1.0f);
        DelayCommand(fDelay, FireDamage(iDamage, iDamageRadius, lTarget));
        DelayCommand(fDelay, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVisual, lTarget));
        }
    else
        {
        // Non-fireball stuff
        FireDamage(iDamage, iDamageRadius, lTarget);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVisual, lTarget);
        }
    // If the Area is empty, don't run the next iteration of the Firefall
    // function.  Otherwise, recourse back and let's do it again.
    object oTest = GetFirstObjectInArea(oArea);
    while (oTest != OBJECT_INVALID)
        {
        // Exit the loop the moment you find the first PC.
        if (GetIsPC(oTest) == TRUE)
            { break; }
        oTest = GetNextObjectInArea(oArea);
        }
    if (GetIsPC(oTest) == FALSE)
        { SetLocalInt(oArea, "FireStorming", FALSE); }
    else
        {
        float fRandDelay = IntToFloat(Random(iFrequency) + (iFrequency / 2) + 1);
        DelayCommand(fRandDelay, FireStorm(oArea, iDamagePower, iDamageRadius, iRows, iColumns, iFrequency));
        }
}
// Apply damage and visual burn effects.
void FireDamage(int iDamage, int iDamageRadius, location lTarget)
{
    // Some variable stuff.
    effect eBurn = EffectVisualEffect(VFX_IMP_FLAME_M);
    float fRange = IntToFloat(iDamageRadius);
    // Now test to see if any creatures or objects are within the blast radius.
    object oTest = GetFirstObjectInShape(SHAPE_SPHERE, fRange, lTarget, TRUE);
    while (oTest != OBJECT_INVALID)
        {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDamage, DAMAGE_TYPE_FIRE), oTest);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBurn, oTest, 2.0f);
        oTest = GetNextObjectInShape(SHAPE_SPHERE, fRange, lTarget, TRUE);
        }
}
