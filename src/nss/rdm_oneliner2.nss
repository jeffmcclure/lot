#include "nw_i0_generic"

// The name of the 2DA file that one-liner messages will be read from if no
// other filename is specified.
const string CS_ONLR_DEFAULT_FILE = "lot_oneliner2";

// Retrieve a value from a 2DA file, checking the cache to determine whether
// the value is currently stored. If the value is not in the cache, it is read from
// the file on disk and stored in the memory cache. If lazy caching is inactive
// for the file, all values are assumed to be present in memory and so an empty
// string indicating that no value exists is returned.
//
// cache The object on which to store cache data.
// file The name of the 2DA file from which to read.
// col The column name within the 2DA file to read.
// row The row number within the 2DA file from which to read.
// returns The value from the 2DA file, or an empty string if no value
// exists at the specified row and column.
string cs_onlr_Get2DAString(object cache, string file, string col, int row) {
   string varName = file + col + IntToString(row);
   string value = GetLocalString(cache, varName);
   if (value == "****") {
       // We have a null placeholder so return an empty string.
       value = "";
   }
   else if (value == "") {
       // Nothing in memory so grab a copy from file. This will always
       // hit disk for "" values. Eh.
       value = Get2DAString(file, col, row);

       // Cache this value in memory.
       if (value == "") {
           // Store a null value placeholder.
           SetLocalString(cache, varName, "****");
       }
       else {
           // Store the actual value.
           SetLocalString(cache, varName, value);
       }
   }

   return value;
}

// Select a random message from the 2DA file and make the NPC speak it.
// To add or remove messages from this list, edit the 2DA file. Don't
// forget to update the number fo entries contained in the first entry in
// the 2DA file.
void SpeakOneLiner(string file=CS_ONLR_DEFAULT_FILE) {
   object mod = GetModule();
   int numLines = StringToInt(cs_onlr_Get2DAString(mod, file, "MESSAGE", 0));
   int which = Random(numLines) + 1;
   ActionSpeakString(cs_onlr_Get2DAString(mod, file, "MESSAGE", which));
}

void main() {
   // If petrified, exit.
   if (GetHasEffect(EFFECT_TYPE_PETRIFY, OBJECT_SELF)) {
       return;
   }

   // If dead, exit.
   if (GetIsDead(OBJECT_SELF)) {
       return;
   }

   // See if what we just 'heard' matches any of our predefined patterns.
   int nMatch = GetListenPatternNumber();
   object oShouter = GetLastSpeaker();

   if (nMatch == -1) {
       if (GetCommandable(OBJECT_SELF)) {
           ClearActions(CLEAR_NW_C2_DEFAULT4_29);
           SpeakOneLiner();
       }
       else if (GetHasEffect(EFFECT_TYPE_CHARMED)) {
           ClearActions(CLEAR_NW_C2_DEFAULT4_29);
           SpeakOneLiner();
       }
   }
   else if (GetIsObjectValid(oShouter) &&
            !GetIsPC(oShouter) &&
            GetIsFriend(oShouter)
   ) {
       // Respond to shouts from friendly non-PCs only.
       object oIntruder = OBJECT_INVALID;

       // Determine the intruder if any.
       if (nMatch == 4) {
           oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
       }
       else if (nMatch == 5) {
           oIntruder = GetLastHostileActor(oShouter);
           if (!GetIsObjectValid(oIntruder)) {
               oIntruder = GetAttemptedAttackTarget();
               if (!GetIsObjectValid(oIntruder)) {
                   oIntruder = GetAttemptedSpellTarget();
                   if (!GetIsObjectValid(oIntruder)) {
                       oIntruder = OBJECT_INVALID;
                   }
               }
           }
       }

       // Actually respond to the shout.
       RespondToShout(oShouter, nMatch, oIntruder);
   }

   // Send the user-defined event if appropriate.
   if (GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT)) {
       SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_DIALOGUE));
   }
}
