#include "inc_party"
#include "nw_i0_tool"
void main()
{
object oPC=GetPCSpeaker();
string sTag=GetTag(OBJECT_SELF);

SetPartyInt(oPC, sTag, 1);
AddJournalQuestEntry("QST_MAGICBANNER", 1, oPC, TRUE, FALSE);

}

