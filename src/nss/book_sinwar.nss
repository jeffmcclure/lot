void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "sinwar");

if (nInt == 0)
   {
   SetLocalInt(oPC, "sinwar", 1);
   CreateItemOnObject("thesinwar", oPC);
   }
else
   {
   SetLocalInt(oPC, "sinwar", 1);
   }
}
