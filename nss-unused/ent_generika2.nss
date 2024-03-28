object oTarget;
void main()
{

object oPC = GetEnteringObject();
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

   ExecuteScript("trg_revealmap", OBJECT_SELF);

   }
else
   {
   ExecuteScript("trg_revealmap", OBJECT_SELF);
   }

}

