const int CS_ONLR_NUMBER_OF_NODES = 4;

const string CS_ONLR_NODE = "cs_onlr_node";
const string CS_ONLR_COUNT = "cs_onlr_count";

int StartingConditional() {
   // This variable is set to TRUE only once the node to be displayed has
   // actually been found.
   int result = FALSE;

   // Determine the node that we are looking for. If no node has been
   // randomly generated, this must be the first time the script has been
   // invoked this time around and so we generate a random number now.
   // Since the node number is always between 1 - CS_ONLR_NUMBER_OF_NODES,
   // we just see if the value is 0 and is so, generate a number.
   int node = GetLocalInt(OBJECT_SELF, CS_ONLR_NODE);
   if (!node) {
       // Generate a random number between 1 and CS_ONLR_NUMBER_OF_NODES.
       node = Random(CS_ONLR_NUMBER_OF_NODES) + 1;
       SetLocalInt(OBJECT_SELF, CS_ONLR_NODE, node);
   }

   // The node that we are up to in the search. This counter starts at 0
   // while the node number starts at 1, so we have to add 1 when comparing.
   int count = GetLocalInt(OBJECT_SELF, CS_ONLR_COUNT);

   if (node == (count + 1)) {
       // We have found the node that we're looking for so clean up
       // the local variables used to prepare for the next time a
       // one-liner is needed.
       DeleteLocalInt(OBJECT_SELF, CS_ONLR_NODE);
       DeleteLocalInt(OBJECT_SELF, CS_ONLR_COUNT);
       result = TRUE;
   }
   else {
       // We have not yet found the node so increment the node counter
       // and store it so the next time this script is invoked (from the
       // next node's Appears When) it knows where it was up to.
       count++;
       SetLocalInt(OBJECT_SELF, CS_ONLR_COUNT, count);
   }

   return result;
}
