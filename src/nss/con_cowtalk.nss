void main()
{

object oPC = GetPCSpeaker();

if (d100()<=35)
   {
   AssignCommand(oPC, ActionSpeakString("I'm not thirsty."));

   }
else if (d100()<=35)
   {
   AssignCommand(oPC, ActionSpeakString("I'm no milkmaid."));

   }
else
   {
   AssignCommand(oPC, ActionSpeakString("Yep, that's a cow alright."));

   }

}

