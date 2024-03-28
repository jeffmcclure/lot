//
// Auldar: This script is called to set a flag on the henchmen so we know
// if my updated henchmen have been installed, and if so which version


void main ()
{
    if (GetLevelByClass(CLASS_TYPE_BARD) > 0)
    {
        SetLocalFloat(OBJECT_SELF, "AuldarVersion",0.51);
    }
    else
    {
        SetLocalFloat(OBJECT_SELF, "AuldarVersion",0.5);    
    }
}
