//::///////////////////////////////////////////////
//:: Pentagram star
//:: penta_inc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
     Comments: CracyD@Krynnhaven.com
*/
//:://////////////////////////////////////////////
//:: Created By: CracyD
//:: Created On: 07-01-2003
//:: Last update: 10-06-2003
//:://////////////////////////////////////////////

// Returns a random scale index, where fScale is max and the output can deviate downto fScale-(fScale-0.1)
// So RandomScale(1.5) can give 1.5 downto 0.1
float RandomScale(float fScale =1.5);

// Returns a random beam effect index, where nLash indicates whether VFX_BEAM_FIRE_LASH can be returned
int RandomBeam(int nLash=FALSE);

// This function will produce a pentagram at
// lTargetLoc using nBeamFX for fDuration seconds.
// If nPerm is TRUE fDuration is ignored and the pentagram(and pentagon) is permanent.
// nScale determines the size of the pentagram (nScale = 2.0 => Double size etc.)
// nPentagon is a boolean which determines wheter to draw a pentagon with the pentagram
// nPentagonFX is the effect used for the Pentagon (Beam Effect)
// You can use RandomScale() to get random sizes for the pentagram.
// You can also use RandomBeam() to produce a random beam effect.
// Note: Requires placable "nonstaticinvis"
void pentagram(location lTargetLoc, int nBeamFX=VFX_BEAM_FIRE, int nPerm=FALSE,  float fDuration=600.0,float fScale=1.5,int nPentagon = FALSE,int nPentagonFX=VFX_BEAM_EVIL);

float RandomScale(float fScale =1.5)
{
    return fScale-(IntToFloat(Random(FloatToInt(fScale*10)))/10) ;
}


int RandomBeam(int nLash=FALSE)
{
    // Number of beams to choose from (7 without lash)
    int nRandomNum=1;
    if(nLash)  // Increase to 8
        nRandomNum=2;
    // Generate random number to return
    int nEffect=Random(nRandomNum)+209;
    if(nEffect==209) // Using 209 for the odd placed lightning index
        nEffect = 73; // nEffect = VFX_BEAM_LIGHTNING
    return nEffect;
}

void pentagram(location lTargetLoc, int nBeamFX=VFX_BEAM_FIRE, int nPerm=FALSE, float fDuration=600.0,float fScale=1.5, int nPentagon = FALSE, int nPentagonFX=VFX_BEAM_EVIL)
{
    // Determine duration
    int nDurationType = DURATION_TYPE_TEMPORARY;
    if (nPerm)
        nDurationType = DURATION_TYPE_PERMANENT;
    // Get center
    object oArea = GetAreaFromLocation(lTargetLoc);
    // Define vertices for pentagram
    vector v = GetPositionFromLocation(lTargetLoc);
    v = Vector(v.x,v.y+7.0*fScale,v.z);
    location l1= Location(oArea,v,0.0);
    v = Vector(v.x-4.0*fScale,v.y-12.5*fScale,v.z);
    location l2= Location(oArea,v,0.0);
    v = Vector(v.x+10.5*fScale,v.y+8.0*fScale,v.z);
    location l3= Location(oArea,v,0.0);
    v = Vector(v.x-13*fScale,v.y,v.z);
    location l4= Location(oArea,v,0.0);
    v = Vector(v.x+10.5*fScale,v.y-8.0*fScale,v.z);
    location l5= Location(oArea,v,0.0);
    // Create verticies objects
    object oS1 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l1);
    object oS2 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l2);
    object oS3 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l3);
    object oS4 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l4);
    object oS5 = CreateObject(OBJECT_TYPE_PLACEABLE,"nonstaticinvis",l5);
    // Connect vertices with beams
    effect eVis1 = EffectBeam(nBeamFX,oS1,BODY_NODE_CHEST);
    effect eVis2 = EffectBeam(nBeamFX,oS2,BODY_NODE_CHEST);
    effect eVis3 = EffectBeam(nBeamFX,oS3,BODY_NODE_CHEST);
    effect eVis4 = EffectBeam(nBeamFX,oS4,BODY_NODE_CHEST);
    effect eVis5 = EffectBeam(nBeamFX,oS5,BODY_NODE_CHEST);
    // Make pentagram visible
    DelayCommand(0.5,ApplyEffectToObject(nDurationType,eVis1,oS2,fDuration));
    DelayCommand(1.5,ApplyEffectToObject(nDurationType,eVis2,oS3,fDuration));
    DelayCommand(2.5,ApplyEffectToObject(nDurationType,eVis3,oS4,fDuration));
    DelayCommand(3.5,ApplyEffectToObject(nDurationType,eVis4,oS5,fDuration));
    DelayCommand(4.5,ApplyEffectToObject(nDurationType,eVis5,oS1,fDuration));
    if(nPentagon) // Make pentagon if selected
    {
        // Create pentagon beams
        effect eVisPen1 = EffectBeam(nPentagonFX,oS1,BODY_NODE_CHEST);
        effect eVisPen2 = EffectBeam(nPentagonFX,oS2,BODY_NODE_CHEST);
        effect eVisPen3 = EffectBeam(nPentagonFX,oS3,BODY_NODE_CHEST);
        effect eVisPen4 = EffectBeam(nPentagonFX,oS4,BODY_NODE_CHEST);
        effect eVisPen5 = EffectBeam(nPentagonFX,oS5,BODY_NODE_CHEST);
        // Make pentagon visible
        ApplyEffectToObject(nDurationType,eVisPen1,oS3,fDuration);
        ApplyEffectToObject(nDurationType,eVisPen2,oS4,fDuration);
        ApplyEffectToObject(nDurationType,eVisPen3,oS5,fDuration);
        ApplyEffectToObject(nDurationType,eVisPen4,oS1,fDuration);
        ApplyEffectToObject(nDurationType,eVisPen5,oS2,fDuration);
    }
    // Remove objects
    if(!nPerm)
    {
        DelayCommand(fDuration,DestroyObject(oS1));
        DelayCommand(fDuration,DestroyObject(oS2));
        DelayCommand(fDuration,DestroyObject(oS3));
        DelayCommand(fDuration,DestroyObject(oS4));
        DelayCommand(fDuration,DestroyObject(oS5));
    }
}
