void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "darkexile");

if (nInt == 0)
   {
   SetLocalInt(oPC, "darkexile", 1);
   CreateItemOnObject("thedarkexile", oPC);
   }
else
   {
   SetLocalInt(oPC, "darkexile", 1);
   }
}
