/*
Heartbeat script of the afk_butterflies placeable.
I know, I know...HB's are bad, but this makes everything work properly so  8)
Lame Copywrite(C) 6-6-03
Thaum@msn.com
*/
void main()
{
object oPC= GetLastOpenedBy();
   AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0f, 6.0f));//makes PC continue to sit
}
