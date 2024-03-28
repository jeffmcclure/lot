object oTarget;
void main()
{

object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "generika2");

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

   ExecuteScript("trg_revealmap", OBJECT_SELF);

   }
else
   {
   ExecuteScript("trg_revealmap", OBJECT_SELF);
   }

}

