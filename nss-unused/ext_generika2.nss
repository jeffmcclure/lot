object oTarget;
void main()
{

object oPC = GetExitingObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "generika2");

if (nInt == 1)
   {
   oTarget = GetObjectByTag("GILLETTEX");
   DestroyObject(oTarget, 0.0);

   oTarget = GetObjectByTag("MAYNARDX");
   DestroyObject(oTarget, 0.0);

   oTarget = GetObjectByTag("ELIMAEX");
   DestroyObject(oTarget, 0.0);

   oTarget = GetObjectByTag("GROKKOX");
   DestroyObject(oTarget, 0.0);

   //oTarget = GetObjectByTag("CAMP_GENERIKA1");
   //DestroyObject(oTarget, 0.0);

   ExecuteScript("mod_cleanup", OBJECT_SELF);

   }
else
   {
   ExecuteScript("mod_cleanup", OBJECT_SELF);
   }

}

