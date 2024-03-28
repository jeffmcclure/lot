// rl_inc_spchest
// Created by R.Lowe 5th March 2003
// This file should be included in any containers OnUsed/OnDeath script
// that you want to respawn placed loot.
// Two function calls should then be inserted into these scripts.
//
// DestroyPotions() should be used after any random treasure generation
// (ie at the bottom of the standard NWN scripts) if you wish potions to
// have a chance of being destroyed when a chest is forced open.
//
// ChestRespawner() can be used in two ways. It can be placed before the
// standard Bioware random gen script, in which case it will only respawn
// things manually placed in the inventory.
// Or it can be used afterwards, in which case it will respawn the random stuff.
// note that this will not be random a second time, the same objects will always
// spawn.
//
// One way of using this is to use the first along with a DelayCommand resetting
// the NW_DO_ONCE variable.


// This float determines how long after the chest was last touched
// to respawn the chest if necessary and any placed items in the inventory.

float RL_CHESTSPAWNDELAY=5.0;

// Function to check if a placed inventory item has been looted or not

int ChestHasObject(string sResRef, object oChest)
  {
  object oObj;

  oObj=GetFirstItemInInventory(oChest);

  while (oObj!=OBJECT_INVALID)
    {
    WriteTimestampedLogEntry("Checking "+GetResRef(oObj)+"="+sResRef);

    if (GetLocalInt(oObj,"CHESTITEM") && GetResRef(oObj)==sResRef)
      {
      return 1;
      }
    oObj=GetNextItemInInventory(oChest);
    }

  return 0;
  }


// Function called from OnUsed or OnDeath
// If chest is opened by destruction, will
// destroy potions 50% of the time.

void DestroyPotions()
  {

  object oInvItem;
  location lMyLocation;
  int iBIT;
  int smash=0;

    if (GetLastKiller()==OBJECT_INVALID)
      {
      return;
      }


    if (GetHasInventory(OBJECT_SELF) == TRUE)
    {

    if (GetFirstItemInInventory(OBJECT_SELF) != OBJECT_INVALID)
      {
      oInvItem = GetFirstItemInInventory(OBJECT_SELF);
      while (oInvItem != OBJECT_INVALID)
        {
        iBIT = GetBaseItemType(oInvItem);


       if (iBIT == BASE_ITEM_POTIONS && d4() <3)
         {
         if (smash==0) SpeakString("You hear the smashing of glass");
         DestroyObject(oInvItem);
         smash=1;
         }
       else
         {
         oInvItem = GetNextItemInInventory(OBJECT_SELF);
         }
       }
     }
   }
 }

//Function called from OnOpened or OnDeath
// Creates the chest respawner if necessary and
// then sets up the delayed command.

void ChestRespawner()
  {
  int x;
  int stacksize;
  object oObj;
  object oSpawner;


  if ( GetLocalInt(OBJECT_SELF,"Respawner") ==0)
    {

    SetLocalInt(OBJECT_SELF,"Respawner",1);


     // Slap down invis object to respawn
    location loc=GetLocation(OBJECT_SELF);

    object oSpawner;

    oSpawner=CreateObject(OBJECT_TYPE_PLACEABLE,"chestspawner",GetLocation(OBJECT_SELF));
    if (oSpawner==OBJECT_INVALID) WriteTimestampedLogEntry("Failed Spawner creation");

    SetLocalObject(OBJECT_SELF,"spawner",oSpawner);

    SetLocalObject(oSpawner,"Chest",OBJECT_SELF);

    // Remember what the chest had in it and resref

    x=0;
    stacksize=0;

    oObj=GetFirstItemInInventory();
    while (oObj!=OBJECT_INVALID)
      {
      stacksize=GetNumStackedItems(oObj);
      SetLocalInt(oSpawner,"RESREF_STACK_"+IntToString(x),stacksize);
      SetLocalString(oSpawner,"RESREF_"+IntToString(x),GetResRef(oObj));
      SetLocalInt(oObj,"CHESTITEM",1);
      x++;
      oObj=GetNextItemInInventory(OBJECT_SELF);
      }
    SetLocalString(oSpawner,"RESREF_"+IntToString(x++),"0");
    SetLocalString(oSpawner,"MYRESREF",GetResRef(OBJECT_SELF));



    AssignCommand(oSpawner,ClearAllActions());

    AssignCommand(oSpawner, DelayCommand(RL_CHESTSPAWNDELAY,ActionDoCommand(ExecuteScript("rl_spawnchest",oSpawner))));

    if (GetLastKiller()!=OBJECT_INVALID)
      {

      SetLocalObject(oSpawner,"Chest",OBJECT_INVALID);
      }

    }
  else
    {
    oSpawner=GetLocalObject(OBJECT_SELF,"spawner");
    AssignCommand(oSpawner,ClearAllActions());

    WriteTimestampedLogEntry("Assigning respawn command");
    if (oSpawner==OBJECT_INVALID) WriteTimestampedLogEntry("Invalid spawner object");
    AssignCommand(oSpawner, DelayCommand(RL_CHESTSPAWNDELAY,ActionDoCommand(ExecuteScript("rl_spawnchest",oSpawner))));

    if (GetLastKiller()!=OBJECT_INVALID)
      {
      SetLocalObject(oSpawner,"Chest",OBJECT_INVALID);
      }

    }





  }

