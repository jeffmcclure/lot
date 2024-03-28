void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "greatconflict");

if (nInt == 0)
   {
   SetLocalInt(oPC, "greatconflict", 1);
   CreateItemOnObject("thegreatconflict", oPC);
   }
else
   {
   SetLocalInt(oPC, "greatconflict", 1);
   }
}
