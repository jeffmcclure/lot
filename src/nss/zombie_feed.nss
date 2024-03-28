//::///////////////////////////////////////////////
//:: Zombies feed! 1.2    zombie_feed.nss
//:: by Lupin III
//:: lupin_3rd@hotmail.com
//:://////////////////////////////////////////////
/*
  Zombies will move over to the nearest corpse and start
  diggin' in.  This version requires Shadows of Undrentide.

  To use place the following line in the OnSpawn script
  of a creature before the final }

      ExecuteScript("zombie_feed", OBJECT_SELF);

*/
//:://////////////////////////////////////////////
#include "x0_i0_corpses"

void main ()
{
int nRandom = d20(1);
object oZombieFood = GetNearestCorpse();
location llocation = GetLocation(GetNearestCorpse());
effect eRegen = EffectRegenerate(1, 4.0);
effect eZombieFeed = EffectVisualEffect(VFX_COM_CHUNK_RED_SMALL);

if (oZombieFood == OBJECT_INVALID)
  {
      switch (d6())
      {
    case 1:
      ActionWait(5.0);
      if (nRandom<=14){PlaySound("c_zombtyr_bat1");}
      break;
    case 2:
      if (nRandom<=14){PlaySound("c_zombwar_bat1");}
      SpeakString("..the.. hunger...");       //comment this line if you don't want random zombie one liners
      ActionWait(6.0);
      break;
    case 3:
      ActionWait(4.0);
      if (nRandom<=14){PlaySound("c_zombie_atk1");}
      SpeakString("...need flesh");          //comment this line if you don't want random zombie one liners
      ActionWait(2.0);
      break;
    case 4:
      if (nRandom<=14){PlaySound("c_zombie_atk2");}
      ActionWait(10.0);
      break;
    case 5:
      ActionWait(8.0);
      if (nRandom<=14){PlaySound("c_zombie_atk3");}
      break;
    case 6:
      ActionWait(1.0);
      if (nRandom<=14){PlaySound("c_zombie_slct");}
      ActionWait(2.0);
      SpeakString("unghh..");            //comment this line if you don't want random zombie one liners
      break;
      }
    ActionRandomWalk();
    DelayCommand(19.5, ClearAllActions());
    if (nRandom<=10){DelayCommand(20.0, ExecuteScript("zombie_feed", OBJECT_SELF));}
    if (nRandom>=11){DelayCommand(25.0, ExecuteScript("zombie_feed", OBJECT_SELF));}
  }
else
if(GetIsDead(OBJECT_SELF) == FALSE)
  {
  ActionForceMoveToObject(oZombieFood, FALSE, 1.0f, 30.0f);
  SetFacingPoint(GetPosition(oZombieFood));
  if (nRandom==2) {DelayCommand(15.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eZombieFeed, oZombieFood, 1.0));}  //comment this line if you don't like the visual effects
  if (nRandom==6) {DelayCommand(10.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eZombieFeed, oZombieFood, 1.0));}  //comment this line if you don't like the visual effects
  if (nRandom<=13){ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0,19.0f);}
  if (nRandom<=13){ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRegen, OBJECT_SELF, 16.0);}
  if (nRandom>=18){ActionRandomWalk();}
  switch (d6())
      {
    case 1:
      ActionWait(5.0);
      if (nRandom<=14){PlaySound("c_zombtyr_bat1");}
      break;
    case 2:
      if (nRandom<=14){PlaySound("c_zombwar_bat1");}
      SpeakString("..braaiinss..");       //comment this line if you don't want random zombie one liners
      ActionWait(6.0);
      break;
    case 3:
      ActionWait(4.0);
      if (nRandom<=14){PlaySound("c_zombie_atk1");}
      SpeakString("..fleesshh");          //comment this line if you don't want random zombie one liners
      ActionWait(2.0);
      break;
    case 4:
      if (nRandom<=14){PlaySound("c_zombie_atk2");}
      ActionWait(10.0);
      break;
    case 5:
      ActionWait(8.0);
      if (nRandom<=14){PlaySound("c_zombie_atk3");}
      break;
    case 6:
      ActionWait(1.0);
      if (nRandom<=14){PlaySound("c_zombie_slct");}
      ActionWait(2.0);
      SpeakString("mnauhh...");            //comment this line if you don't want random zombie one liners
      break;
    }
  DelayCommand(19.5, ClearAllActions());
  if (nRandom<=10){DelayCommand(20.0, ExecuteScript("zombie_feed", OBJECT_SELF));}
  if (nRandom>=11){DelayCommand(25.0, ExecuteScript("zombie_feed", OBJECT_SELF));}
  }
}
