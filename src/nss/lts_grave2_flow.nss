int StartingConditional()
{
    object oFlower =  GetItemPossessedBy(GetPCSpeaker(),"lordi_gyflowers");

    if (oFlower != OBJECT_INVALID)
    {
        AssignCommand(GetPCSpeaker(),ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,2.0f));
        effect eEff = EffectVisualEffect(VFX_DUR_ENTANGLE);
        DestroyObject(oFlower);
        DelayCommand(2.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEff, OBJECT_SELF, 120.0f));
        return TRUE;
    }
    else
        return FALSE;

}
