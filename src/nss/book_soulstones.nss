void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "soulstones");

if (nInt == 0)
   {
   SetLocalInt(oPC, "soulstones", 1);
   CreateItemOnObject("thebindingthree", oPC);
   }
else
   {
   SetLocalInt(oPC, "soulstones", 1);
   }
}
