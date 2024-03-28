object oTarget;
void main()
{

object oPC = GetExitingObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "generika1");

if (nInt == 1)
   {
   oTarget = GetObjectByTag("GILLETTE");
   DestroyObject(oTarget, 0.0);

   oTarget = GetObjectByTag("MAYNARD");
   DestroyObject(oTarget, 0.0);

   oTarget = GetObjectByTag("ELIMAE");
   DestroyObject(oTarget, 0.0);

   oTarget = GetObjectByTag("GROKKO");
   DestroyObject(oTarget, 0.0);

   oTarget = GetObjectByTag("CAMP_GENERIKA1");
   DestroyObject(oTarget, 0.0);

   ExecuteScript("mod_cleanup", OBJECT_SELF);

   }
else
   {
   ExecuteScript("mod_cleanup", OBJECT_SELF);
   }

}

