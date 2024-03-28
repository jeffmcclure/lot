/////////////////////////////////////////////////////////
//Place in "Actions Taken" of the NPCs first convo node
//Make sure tag is correct and remove the nw_walk_wp
//script from the End Conversation Normally handle.
/////////////////////////////////////////////////////////
void main()
{
   object oChair = GetNearestObjectByTag("NPC_CHAIR");
   //Make sure no one is in chair, if not sit-down.
   if(!GetIsObjectValid(GetSittingCreature(oChair)))
     {
     ClearAllActions(); //This is so he don't spin in his chair, following you.
     ActionSit(oChair);
     }
}
//End

