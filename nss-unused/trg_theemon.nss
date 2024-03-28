void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYQST_MAINMODULE");

if (!(nInt < 1))
   return;

AssignCommand(GetObjectByTag("NPC_THEEMON"), ActionSpeakString("Hello my friend?  Can I talk to you for a second?"));

}
