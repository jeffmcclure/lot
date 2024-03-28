#include "rl_inc_spchest"
// rl_spawnchest
// Created by R.Lowe 5th March 2003
// Updated 6th March with more error checking
// This does the work of respawning the chest as necessary and putting any
// missing items in
// If a create fails because the spawner cannot get a ResRef for the
// chest, a brazier will be created instead.

void main()
{
  string sResRef;
  string sItemResRef;
  int x;

  object oChest;
  int stacksize;


  oChest=GetLocalObject(OBJECT_SELF,"altarandariel");
  sResRef=GetLocalString(OBJECT_SELF,"MYRESREF");
  if (sResRef=="" && oChest==OBJECT_INVALID)
    {
    WriteTimestampedLogEntry("Error, No ResRef for chest");
    CreateObject(OBJECT_TYPE_PLACEABLE,"plc_brazier", GetLocation(OBJECT_SELF));
    DestroyObject(OBJECT_SELF,0.5);
    }


  if (oChest==OBJECT_INVALID)
    {
    oChest=CreateObject(OBJECT_TYPE_PLACEABLE,sResRef,GetLocation(OBJECT_SELF));
    SetLocalObject(oChest,"spawner",OBJECT_SELF);
    }

  if (oChest==OBJECT_INVALID)
    {
    WriteTimestampedLogEntry("Error, Could not create chest!");
    DestroyObject(OBJECT_SELF,0.5);
    return;
    }

  x=0;
  sItemResRef=GetLocalString(OBJECT_SELF, "RESREF_"+IntToString(x));
  while (sItemResRef!="0" && x<400)
    {
    stacksize=GetLocalInt(OBJECT_SELF,"RESREF_STACK_"+IntToString(x));
    if (stacksize==0) stacksize=1;
    if ( ChestHasObject (sItemResRef,oChest)==0 )
      {
      WriteTimestampedLogEntry("Creating "+sItemResRef+" stacksize "+IntToString(stacksize));
      SetLocalInt(CreateItemOnObject(sItemResRef,oChest,stacksize),"CHESTITEM",1);
      }
    x++;
    sItemResRef=GetLocalString(OBJECT_SELF, "RESREF_"+IntToString(x));
    }
  if (x>=400)
    {
    WriteTimestampedLogEntry("No termination found in TAG list when respawning chest");
    }
  }

