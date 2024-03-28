void main()
{
    int level = GetHitDice(OBJECT_SELF);

    while(level < 7)
    {
        LevelUpHenchman(OBJECT_SELF,GetClassByPosition(1),TRUE);
        level++;
    }

    object oTarget1 = GetObjectByTag("Kiraths_Bones");
    DestroyObject(oTarget1, 0.0);

}

