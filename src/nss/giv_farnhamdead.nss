void main()
{

object oPC = GetPCSpeaker();

ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0f, 1.0f);

object oTarget;
oTarget = OBJECT_SELF;

DestroyObject(oTarget, 0.0);

CreateItemOnObject("corpsefarnham", oPC);
//AddJournalQuestEntry("QST_ISLAND", 3, oPC, TRUE, FALSE);

}
