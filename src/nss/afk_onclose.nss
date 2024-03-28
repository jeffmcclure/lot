/*
Onclose of the afk_butterflies.
Lame Copywrite(C) 6-6-03
Thaum@msn.com
*/

void main()
{
object oPC= GetLastOpenedBy(); //gets last PC to Open the afk_butterflies
AssignCommand(oPC, SpeakString("I'm Back.",TALKVOLUME_TALK));//forces PC to say "the string "
CreateItemOnObject("afk_activator",oPC,1);  //re-creates the afk_activator object in the pc's inventory.
                                            // I use an item that has a single use, then is destroyed, to keep PC's from creating multicopies of the butterflies.
                                            // I'll work on it more later perhaps, this was really just to satisfy a simple need.
DelayCommand(0.3f,DestroyObject(OBJECT_SELF,1.0)); //Destroy's the butterflies

}
