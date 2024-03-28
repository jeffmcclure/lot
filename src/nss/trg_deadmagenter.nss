void main()
{
object oPC = GetEnteringObject();
effect eFail = SupernaturalEffect(EffectSpellFailure());
ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFail, oPC);
}
