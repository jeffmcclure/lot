void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

SetLocalInt(oPC, "lazarus", 2);

object oItem;
oItem = GetItemPossessedBy(oPC, "KEY_LAZARUS_STAFF");

if (GetIsObjectValid(oItem))
   DestroyObject(oItem);

SendMessageToPC(oPC, "Abandon your foolish quest!  All that awaits you is the wrath of my master!");

SendMessageToPC(oPC, "You are too late to save the child.  Now you will join him, in hell!");

}
