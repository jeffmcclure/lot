/* This is the items activator, if you don't want to use this, put it in your onitemactivated script
   with an "IF" statement.


*/

void main()
{
object oPC=GetItemActivator(); //Gets the PC
location lLoc= GetLocation(oPC); //Gets the current location of the PC that activated the object.
string sTag="afk_butterflies"; //Sets the string of the placeable object "afk_butterflies".
CreateObject(OBJECT_TYPE_PLACEABLE,sTag,lLoc,FALSE);//Creates the butterflies at the pc's location.
AssignCommand(oPC, ActionInteractObject(GetObjectByTag(sTag)));//forces the pc who created (used) the butterflies activator, or automaticaly open their inventory.
}

