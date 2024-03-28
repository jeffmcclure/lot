void main()
{

object oPC = GetClickingObject();

if (!GetIsPC(oPC)) return;

SendMessageToPC(oPC, "This quest area will be available very soon...");

}

