#include "inc_party"
void main() {
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget( OBJECT_SELF );
    location lLoc = GetLocation( oTarget );

    int nInt=GetLocalInt(oClicker, "NW_JOURNAL_ENTRYQST_MAINMODULE");

    if (nInt > 0) {
        AssignCommand( oClicker, JumpToLocation( lLoc ) );
    } else {
        if (!GetIsPC(oClicker)) return;
        SendMessageToPC(oClicker, "Do you know what you're getting yourself into?  Perhaps you need to talk to someone first before going in!");
    }
}
