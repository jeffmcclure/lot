/////////////////////////////////////////////
// Make oven Fire appear
/////////////////////////////////////////////
// By Deva Bryson Winblood
/////////////////////////////////////////////
// Requires a waypoint labeled MAKE_OVENFIRE
// where you want the flames to appear for a
// moment.
/////////////////////////////////////////////
// SCRIPT: npcact_use_oven
/////////////////////////////////////////////

void main()
{
     object oWP=GetNearestObjectByTag("MAKE_OVENFIRE",OBJECT_SELF,1);
     effect eSmokePuff=EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
     if (oWP!=OBJECT_INVALID)
     { // it is present
         ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eSmokePuff,GetLocation(oWP),3.0);
         object oFire=CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamesmall",GetLocation(oWP));
         DelayCommand(16.0,DestroyObject(oFire));
     } // it is present
}
