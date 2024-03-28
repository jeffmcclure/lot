void main()
{
    object ocontroldeathblock = GetObjectByTag("controldeathblock");
    int level = GetHitDice(OBJECT_SELF);
    int Kirath_HitDice_at_Death = GetLocalInt(ocontroldeathblock, "Save Kirath Hit Dice level for rez");

    while(level < Kirath_HitDice_at_Death)
    {
        LevelUpHenchman(OBJECT_SELF,GetClassByPosition(1),TRUE);
        level++;
    }

    // Set the variables
    SetLocalInt(ocontroldeathblock, "kirath died", 0);

    object oTarget1 = GetObjectByTag("Kiraths_Bones");
    DestroyObject(oTarget1, 0.0);

    SetIsDestroyable(FALSE, TRUE, TRUE);

}

