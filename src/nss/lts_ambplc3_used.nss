/*  _________________________________________________________________________
   /                                                                         \
                         << Legend of the Red Dragon ReVisited >>

    Author:
        Dom Queron, dom(at)gulbsoft(dot)de, http://www.gulbsoft.de

    Description:

        Graveyard Themed Ambient Placeable Package (3) OnUsed Script
        Holds several OnUse Scripts in order to cut down the number of
        scripts in the module.

    version:
        $v1.0 00-00-00

    module information:
         http://gulbsoft.de/phpBB2x/g_viewcat.php?t=225


   \_________________________________________________________________________/

*/


int LORD_INT_XP_FOR_RETURNING_CORPSES = 50; // how much XP is awarded to a PC returning a corpse to an empty grave


int LORD_INT_GRAVESAYINGS = 22; //number of different texts available

// Grave Inscriptions ... <%name%> (random name) and <%killer%> (playername) are valid variables
string LORD_SZGRAVE_00 = "Here lies <%name%>";
string LORD_SZGRAVE_01 = "RIP <%name%>, you will never be forgotten!";
string LORD_SZGRAVE_02 = "<%name%>, farewell good friend";
string LORD_SZGRAVE_03 = "Goodbye dear <%name%>, we will remember you! ";
string LORD_SZGRAVE_04 = "This grave belongs to <%name%> who died a very unfortunate death";
string LORD_SZGRAVE_05 = "<%name%>, may your bones rot here forever!";
string LORD_SZGRAVE_06 = "You cannot deciper what was once written on the grave ";
string LORD_SZGRAVE_07 = "Here lies <%name%>'s sister, missed forever!";
string LORD_SZGRAVE_08 = "<%name%> lies here. Only the good die young!";
string LORD_SZGRAVE_09 = "<%name%>, who fell victim to the plague last year";
string LORD_SZGRAVE_10 = "This gravestone is to damaged to decipher what was inscribed on it";
string LORD_SZGRAVE_11 = "Rest in peace <%name%>, another young life lost too early";
string LORD_SZGRAVE_12 = "<%name%> the younger. He never scored" ;
string LORD_SZGRAVE_13 = "The <%name%> family grave" ;
string LORD_SZGRAVE_14 = "The inscription on this gravestone has been removed" ;
string LORD_SZGRAVE_15 = "Two unnamed adventurers rest here.";
string LORD_SZGRAVE_16 = "<%name%>'s cat.";
string LORD_SZGRAVE_17 = "The inscription says that <%name%>'s body rests in this grave";
string LORD_SZGRAVE_18 = "Here lies another victim of <%name%>'s bad ale";
string LORD_SZGRAVE_19 = "RIP <%name%>, may your soul safely travel to heaven";
string LORD_SZGRAVE_20 = "This is the last resting place of <%name%>. May he burn in hell";
string LORD_SZGRAVE_21 = "The remains of <%name%> rest here, it is said he was killed by <%killer%>";



// Ambient Comments ... <%area%> and <%playername%> are valid variables
string LORD_SZGYAMBIENT_00 = "I hate this graveyard odor!";
string LORD_SZGYAMBIENT_01 = "Why must graveyards always be that chilling?";
string LORD_SZGYAMBIENT_02 = "<%area%> ... a fitting description for this place.";
string LORD_SZGYAMBIENT_03 = "These graveyards! You always await the dead raising from their graves...";
string LORD_SZGYAMBIENT_04 = "This is not a nice place to work at!";
string LORD_SZGYAMBIENT_05 = "Only a necromancer could feel comfortable in this place.";


// Ambient Comments ... <%area%> and <%playername%> are valid variables
string LORD_SZGYAMBIENTC_00 = "I have a bad feeling about this place!";
string LORD_SZGYAMBIENTC_01 = "There is something wrong here ... I can feel it!";
string LORD_SZGYAMBIENTC_02 = "I know we should not have come here ... This place is creepy!";
string LORD_SZGYAMBIENTC_03 = "Something is amiss here ... I better be careful!";
string LORD_SZGYAMBIENTC_04 = "<%playername%> does'nt like this place ... it's creepy!";
string LORD_SZGYAMBIENTC_05 = "This place is haunted ... or something even worse. I feel it!";


void CreatePLCWrapper(string sTag, location lLoc, float fDestTime=0.0f)
{
    object oPlc = CreateObject(OBJECT_TYPE_PLACEABLE,sTag,lLoc);
    if (fDestTime>0.0f)
        DestroyObject(oPlc,fDestTime);
}

string ReplaceString(string sText, string sOld, string sNew)
{
    int nLen = GetStringLength(sOld);

    int nRep = FindSubString(sText,sOld);
    if (nRep != -1)
    {
        string sLeft = GetStringLeft(sText,nRep);
        string sRight = GetStringRight(sText,GetStringLength(sText)-nRep-(nLen));
        sText = sLeft + sNew + sRight;
    }
    return sText;
}

// create some random grave treasure
int GyardCreateRandomTreasure(object oTarget)
{
    int n = d20();
    string sTag ="";
    switch (n)
    {
        case 1:  sTag = "nw_it_msmlmisc20";  break; // fish
        case 2:  sTag = "nw_it_gold001";  break; // goldpiece
        case 3:  sTag = "nw_it_msmlmisc21"; break; // rags
        case 4:  sTag = "nw_it_thnmisc001"; break;// empty bottle
        case 5:  sTag = "nw_cloth023"; break; // rags
        case 6:  sTag = "nw_cloth009"; break;
        case 7:  sTag = "nw_wthdt001"; break; // dart
        case 8:  sTag = "nw_it_gem003"; break; // gem
        case 9:  sTag = "nw_it_mpotion021"; break; // ale
        case 10: sTag = "nw_it_mpotion023"; break; // wine
    }

    if (sTag != "")
    {
        CreateItemOnObject(sTag,oTarget);
        if (d20()<10)
            CreateItemOnObject("nw_it_gold001",oTarget, d10());

        return TRUE;
    }

return FALSE;
}

string LordGetAmbGraveText(object oGrave = OBJECT_SELF)
{
   int nSaying = GetLocalInt(oGrave,"LORD_GRAVE_SAYING");
   object oUser = GetLastUsedBy();
   string sName = GetLocalString(oGrave,"LORD_GRAVE_NAME");
   if (nSaying  == 0)
   {
        nSaying = Random(LORD_INT_GRAVESAYINGS);
        SetLocalInt(oGrave,"LORD_GRAVE_SAYING",nSaying );
   }

   if (sName =="")
   {
        sName = RandomName();
        SetLocalString(oGrave,"LORD_GRAVE_NAME",sName);
        SetLocalString(oGrave,"LORD_GRAVE_FIRSTUSE_NAME",GetName(oUser));
   }

    string sText = "Unlabeled Grave";
    switch (nSaying)
    {
        case 1: sText = LORD_SZGRAVE_00;break;
        case 2: sText = LORD_SZGRAVE_01;break;
        case 3: sText = LORD_SZGRAVE_02;break;
        case 4: sText = LORD_SZGRAVE_03;break;
        case 5: sText = LORD_SZGRAVE_04;break;
        case 6: sText = LORD_SZGRAVE_05;break;
        case 7: sText = LORD_SZGRAVE_06;break;
        case 8: sText = LORD_SZGRAVE_07;break;
        case 9: sText = LORD_SZGRAVE_08;break;
        case 10: sText = LORD_SZGRAVE_09;break;
        case 11: sText = LORD_SZGRAVE_10;break;
        case 12:  sText = LORD_SZGRAVE_11;break;
        case 13: sText = LORD_SZGRAVE_12;break;
        case 14: sText = LORD_SZGRAVE_13;break;
        case 15:  sText = LORD_SZGRAVE_14;break;
        case 16: sText = LORD_SZGRAVE_15;break;
        case 17:  sText = LORD_SZGRAVE_16;break;
        case 18: sText = LORD_SZGRAVE_17;break;
        case 19: sText = LORD_SZGRAVE_18;break;
        case 20:  sText = LORD_SZGRAVE_19;break;
        case 21:  sText = LORD_SZGRAVE_20;break;
        case 22:  sText = LORD_SZGRAVE_21;break;
    }

    sText = ReplaceString(sText, "<%name%>", sName);
    string sKiller = GetLocalString(oGrave,"LORD_GRAVE_FIRSTUSE_NAME");
    sText = ReplaceString(sText, "<%killer%>", sKiller);

    return sText;
}


void DoBurnObject()
{
            object oUser = GetLastUsedBy();
            AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,2.0f));

            SetPlotFlag(OBJECT_SELF,FALSE);
            effect eFlame2 = EffectVisualEffect(VFX_IMP_FLAME_M);
            effect eSmoke =  EffectVisualEffect(VFX_FNF_SMOKE_PUFF);
            object oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamesmall",GetLocation(OBJECT_SELF));
            DelayCommand(2.0f,PlaySound("al_na_firesmldr"));
            DelayCommand(2.0f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSmoke, OBJECT_SELF));
            DestroyObject(oFlame,5.0f);
            DelayCommand(4.0f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSmoke, OBJECT_SELF));
            oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_flamemedium",GetLocation(OBJECT_SELF));
            DestroyObject(oFlame,8.0f);
            DelayCommand(4.0f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFlame2, OBJECT_SELF));
            DelayCommand(6.0f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSmoke, OBJECT_SELF));
            DelayCommand(7.0f,ApplyEffectToObject(DURATION_TYPE_PERMANENT,eFlame2, OBJECT_SELF));
            DestroyObject(OBJECT_SELF,8.0f);
            oFlame = CreateObject(OBJECT_TYPE_PLACEABLE,"plc_weathmark",GetLocation(OBJECT_SELF));
            DestroyObject(oFlame, 30.0f);
}

void main()
{

    string sTag = GetTag(OBJECT_SELF);
    object oUser = GetLastUsedBy();

    // Random Gravestone
    if (sTag == "lordo_randgrave")
    {
        ActionSpeakString(LordGetAmbGraveText());
        return;
    }
    // Random Gravestone2
    if (sTag == "lordo_randgraveb")
    {
        if (GetLocalInt(OBJECT_SELF,"NW_L_AMION") == 0)
    {
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        DelayCommand(0.4,SetPlaceableIllumination(OBJECT_SELF, TRUE));
        SetLocalInt(OBJECT_SELF,"NW_L_AMION",1);
        DelayCommand(0.5,RecomputeStaticLighting(GetArea(OBJECT_SELF)));
    }
    else
    {
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        DelayCommand(0.4,SetPlaceableIllumination(OBJECT_SELF, FALSE));
        SetLocalInt(OBJECT_SELF,"NW_L_AMION",0);
        DelayCommand(0.9,RecomputeStaticLighting(GetArea(OBJECT_SELF)));
    }
        DelayCommand(1.2f,ActionSpeakString(LordGetAmbGraveText()));
        return;
    }

    // Empty Grave

    else if (sTag == "lordo_egrave")
    {

        if (GetItemPossessedBy(oUser,"lordi_corpse") != OBJECT_INVALID)
        {
         AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,3.0f));
         DelayCommand(0.5f, PlaySound("as_cv_mineshovl3"));
         DestroyObject(GetItemPossessedBy(oUser,"lordi_corpse"), 2.0f);
         DelayCommand(3.0f, GiveXPToCreature(oUser, LORD_INT_XP_FOR_RETURNING_CORPSES));
         location lLoc = GetLocation(OBJECT_SELF);
         DestroyObject(OBJECT_SELF, 3.0f);
         DelayCommand(3.5f,CreatePLCWrapper("lordo_randgrave2",lLoc));
        }
        else
        {
            AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW));
            if (d2()==1)
                AssignCommand(oUser, ActionSpeakString("A fresh empty grave, I wonder for whom..."));
            else
                AssignCommand(oUser, ActionSpeakString("This grave is empty"));
        }

    }

    // Random Grave
    else if (sTag == "lordo_randgrave2")
    {
        ActionStartConversation(oUser,"",TRUE);
        return;
    }
    else if (sTag == "lordo_corpsewag")
    {
         AssignCommand(oUser, ActionSpeakString("Lets see..."));
         AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD,1.0f,3.0f));
         effect eInsects = EffectAreaOfEffect(AOE_PER_CREEPING_DOOM,"lord_dummy","lord_dummy","lord_dummy");
         DelayCommand(0.1f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eInsects,GetLocation(OBJECT_SELF),4.0f));
         DelayCommand(3.0f,PlaySound("al_an_flies1"));
         if (d2()==1)
             AssignCommand(oUser, ActionSpeakString("This is ... disgusting!"));
         else
             AssignCommand(oUser, ActionSpeakString("That smell ... arg!"));

         if (FortitudeSave(oUser,14,SAVING_THROW_TYPE_POISON) == 0)
         {
             string sSnd = "as_pl_hangoverm1";
             if (GetGender(oUser) != GENDER_MALE)
                sSnd = "as_pl_hangoverf1";

             AssignCommand(oUser,PlaySound(sSnd));
             AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_BOW,1.0f,3.0f));
             effect eVomit = EffectVisualEffect(VFX_COM_BLOOD_LRG_GREEN);
             DelayCommand(3.0f, PlaySound(sSnd));
             DelayCommand(3.0f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVomit,oUser,15.0f));
             DelayCommand(3.2f,FloatingTextStringOnCreature("*vomit*", oUser));
             DelayCommand(3.3f, ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVomit,oUser,15.0f));
             AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK,1.0f,5.0f));
             AssignCommand(oUser, ActionSpeakString("I'm just not used to this!"));
        }
        else
        {
          AssignCommand(oUser,PlayVoiceChat(VOICE_CHAT_LAUGH));
          AssignCommand(oUser,ActionWait(1.5f));
          AssignCommand(oUser,ActionSpeakString ("Good that I'm blessed with a strong stomach"));
        }

       return;
    }
    // Corpse
    else if (sTag == "lordo_corpse")
    {
         if (FindSubString(GetStringUpperCase(GetName(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser))),"TORCH") != -1)
         {
            AssignCommand(oUser, ActionSpeakString("Ashes to ashes, dust to dust..."));
            DoBurnObject();
            return;
         }
        AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.5f,3.0f));
        DestroyObject(OBJECT_SELF);
        CreateItemOnObject("lordi_corpse",oUser);
        return;
    }
    // Impaled Corpse
    else if (sTag == "lordo_impcorpse")
    {

            if (GetAlignmentLawChaos(oUser) == ALIGNMENT_CHAOTIC)
            {
                 if (FindSubString(GetStringUpperCase(GetName(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser))),"TORCH") != -1)
                 {
                    AssignCommand(oUser, ActionSpeakString("Let's roast Spikey a bit!"));
                    DoBurnObject();
                    return;
                 }

                 AssignCommand(oUser, ActionSpeakString("Let's check Spikey for valueables..."));
                 {
                   AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.5f,3.0f));
                   effect eVomit = EffectVisualEffect(VFX_COM_BLOOD_LRG_RED);
                   DelayCommand(1.5f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVomit,OBJECT_SELF));
                   DelayCommand(2.3f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVomit,OBJECT_SELF));
                   DelayCommand(2.3f,AssignCommand(oUser,PlayVoiceChat(VOICE_CHAT_LAUGH)));
                   DelayCommand(2.5f,AssignCommand(oUser, ActionSpeakString("Nothing ... except for that stake")));

                 }
            }
            else if (GetAlignmentLawChaos(oUser) == ALIGNMENT_NEUTRAL)
            {
                     if (FindSubString(GetStringUpperCase(GetName(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser))),"TORCH") != -1)
                     {
                        AssignCommand(oUser, ActionSpeakString("Back to dust poor fellow!"));
                        DoBurnObject();
                        return;
                     }

                  AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT));
                  AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT));
                  AssignCommand(oUser,ActionSpeakString("What a waste of valuable human resources"));
            }
            else if (GetAlignmentLawChaos(oUser) == ALIGNMENT_LAWFUL)
            {
                  AssignCommand(oUser,ActionSpeakString("Indeed an act of pure evil and vileness!!"));
                  AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL,1.5f, 3.0f));
                  AssignCommand(oUser,ActionSpeakString("This man deserves better, I shall remove him from that spike!"));
                  AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.5f,3.0f));
                  location lLoc = GetLocation(OBJECT_SELF);
                  DelayCommand(4.5f, DestroyObject(OBJECT_SELF,0.1f));
                  DelayCommand(4.6f, CreatePLCWrapper("lordo_corpse",lLoc));

            }


    }
    //diseased corpse
    else if (sTag == "lordo_dcorpse")
    {

         if (FindSubString(GetStringUpperCase(GetName(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oUser))),"TORCH") != -1)
         {
            AssignCommand(oUser, ActionSpeakString("I better burn this corpse before somebody gets infected"));
            AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,2.0f));

            DoBurnObject();

         }
            if (GetLocalInt(OBJECT_SELF,"LORD_OBJECT_TRIGGERED"))
         {
             AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
             AssignCommand(oUser, ActionSpeakString("This corpse looks maggot infested and already looted, I shouldn't touch it"));
             return;
         }

         AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,4.0f));

         effect eInsects = EffectAreaOfEffect(AOE_PER_CREEPING_DOOM,"lord_dummy","lord_dummy","lord_dummy");
         DelayCommand(2.0f,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eInsects,GetLocation(OBJECT_SELF),4.0f));
         DelayCommand(2.0f,PlaySound("al_an_flies1"));

         if (d2()==1)
             AssignCommand(oUser, ActionSpeakString("Eeek insects!"));
         else
            AssignCommand(oUser, PlayVoiceChat(VOICE_CHAT_BADIDEA));

         if (FortitudeSave(oUser,14,SAVING_THROW_TYPE_DISEASE) == 0)
         {
            effect eDisease;
            if (d2()==1)
                eDisease = EffectDisease(DISEASE_BURROW_MAGGOTS);
            else
                eDisease = EffectDisease(DISEASE_FILTH_FEVER);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDisease,oUser);
        }

        object oItem = GetFirstItemInInventory();
        if (oItem == OBJECT_INVALID)
        {
           if (d2()==1)
                AssignCommand(oUser, ActionSpeakString("Nothing except maggots!"));
           else
               AssignCommand(oUser, ActionSpeakString("Nothing, I should burn this insect infested corpse"));

        }
        SetLocalInt(OBJECT_SELF,"LORD_OBJECT_TRIGGERED", TRUE);
        return;

    }
    // Torture Equipment
    else if (sTag == "lordo_torteq1")
    {
       effect eDmg = EffectDamage(1);
       object oBlood;
       int n = Random(6);
       switch (n)
       {
           case 0:
                AssignCommand(oUser,ActionSpeakString("Poor fellow, looks like a really squishy experience"));
                AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,4.0f));
                DelayCommand(1.0f,ActionDoCommand(PlaySound("as_cv_winch1")));
                AssignCommand(oUser,ActionSpeakString("It's jammed!"));
                break;
           case 1:
                AssignCommand(oUser,ActionSpeakString("I wonder how this works..."));
                AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID));
                AssignCommand(oUser,ActionDoCommand(PlaySound("bf_med_insect")));
                AssignCommand(oUser,PlayVoiceChat(VOICE_CHAT_PAIN1));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg, oUser);
                DelayCommand(0.6f,CreatePLCWrapper("plc_bloodstain",GetLocation(oUser),10.0f));
                DelayCommand(0.6f,FloatingTextStringOnCreature("*Squish*", oUser));
                DelayCommand(1.0f, AssignCommand(oUser,ActionSpeakString("Wow, watch it, this thing is dangerous!")));
                break;
           case 2:
                AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID,1.0f,4.0f));
                AssignCommand(oUser,ActionSpeakString("This torture equipment seems quite successful in making people remain silent"));
                break;
           case 3:
                AssignCommand(oUser,PlayVoiceChat(VOICE_CHAT_BADIDEA));
                break;
           case 4:
                AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID));
                AssignCommand(oUser,ActionDoCommand(PlaySound("bf_med_insect")));
                AssignCommand(oUser,PlayVoiceChat(VOICE_CHAT_PAIN2));
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDmg, oUser);
                DelayCommand(0.6f,FloatingTextStringOnCreature("*Squish*", oUser));
                DelayCommand(0.6f,CreatePLCWrapper("plc_bloodstain",GetLocation(oUser),10.0f));
                DelayCommand(1.0f, AssignCommand(oUser,ActionSpeakString("Ouch, my fingers!")));

                break;
           case 5:
               AssignCommand(oUser,ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
               AssignCommand(oUser,ActionSpeakString("A most uncomfortable and unfortunate death"));
               break;
       }
       return;

    }
    // ambient comment trigger
    else if (sTag == "lordt_gyardcom1")
    {


        int nBreak = GetLocalInt(OBJECT_SELF,"LORD_TRIGGER_SLEEPING");
        if (nBreak)
            return;

        object oPC = GetEnteringObject(); // I know it is ugly as the script is labeled *_used, but on the other hand,
                                          // its one less script in the module <g>

        if (!GetIsPC(oPC) || GetIsDM(oPC)) // we do not want monster's or DM's  to comment on the grayeyard they live in ...
            return;
        int n = Random(6);
        string sText;
        switch (n)
        {
           case 0: sText =LORD_SZGYAMBIENT_00;
                   break;
           case 1: sText =LORD_SZGYAMBIENT_01;
                   break;
           case 2: sText =LORD_SZGYAMBIENT_02;
                   break;
           case 3: sText =LORD_SZGYAMBIENT_03;
                   break;
           case 4: sText =LORD_SZGYAMBIENT_04;
                   break;
           case 5: sText =LORD_SZGYAMBIENT_05;
                   break;
        }
        //replace variables
        sText =     ReplaceString(sText, "<%playername%>", GetName(oPC));
        sText =     ReplaceString(sText, "<%area%>", GetName(GetArea(oPC)));
        if (!GetIsInCombat(oPC))
            AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionSpeakString(sText));
        // deactivate trigger
        SetLocalInt(OBJECT_SELF,"LORD_TRIGGER_SLEEPING",TRUE);

        //reactivate trigger after 20 seconds
        DelayCommand(20.0f,DeleteLocalInt(OBJECT_SELF,"LORD_TRIGGER_SLEEPING"));
    }
    else if (sTag == "lordt_gyardcom2")
    {


        int nBreak = GetLocalInt(OBJECT_SELF,"LORD_TRIGGER_SLEEPING");
        if (nBreak)
            return;

        object oPC = GetEnteringObject(); // I know it is ugly as the script is labeled *_used, but on the other hand,
                                          // its one less script in the module <g>

        if (!GetIsPC(oPC) || GetIsDM(oPC)) // we do not want monster's or DM's  to comment on the grayeyard they live in ...
            return;
        int n = Random(6);
        string sText;
        switch (n)
        {
           case 0: sText =LORD_SZGYAMBIENTC_00;
                   break;
           case 1: sText =LORD_SZGYAMBIENTC_01;
                   break;
           case 2: sText =LORD_SZGYAMBIENTC_02;
                   break;
           case 3: sText =LORD_SZGYAMBIENTC_03;
                   break;
           case 4: sText =LORD_SZGYAMBIENTC_04;
                   break;
           case 5: sText =LORD_SZGYAMBIENTC_05;
                   break;
        }
        //replace variables
        sText =     ReplaceString(sText, "<%playername%>", GetName(oPC));
        sText =     ReplaceString(sText, "<%area%>", GetName(GetArea(oPC)));
        if (!GetIsInCombat(oPC))
            AssignCommand(oPC, ClearAllActions());
        AssignCommand(oPC, ActionSpeakString(sText));
        // deactivate trigger
        SetLocalInt(OBJECT_SELF,"LORD_TRIGGER_SLEEPING",TRUE);

        //reactivate trigger after 20 seconds
        DelayCommand(20.0f,DeleteLocalInt(OBJECT_SELF,"LORD_TRIGGER_SLEEPING"));


    }
    else if (sTag == "lordo_bones" || sTag == "lordo_corpse3")
    {
       if (GetLocalInt(OBJECT_SELF,"NW_L_DOONCE") == 0)
       {
        if (!GyardCreateRandomTreasure(OBJECT_SELF))
        {
            SendMessageToPC(oUser,"As you touch the remains of a human body, they crumble to dust");
            DestroyObject(OBJECT_SELF);
        }
        SetLocalInt(OBJECT_SELF,"NW_L_DOONCE",1);
       }
       else
       {
            DestroyObject(OBJECT_SELF);
            SendMessageToPC(oUser,"As you touch the remains of a human body, they crumble to dust");
       }


    }
    else if (sTag == "lordo_gmemo")
    {
        string sDeity = GetName(OBJECT_SELF);
        SendMessageToPC(oUser, "You take some time to pray at the " + sDeity );
        AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_MEDITATE,1.0f,6.0f));
        effect eLight =  EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_10);
        DelayCommand(6.0f, SendMessageToPC(oUser,"You feel enlighted!"));
        DelayCommand(6.0f,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLight,oUser,45.0f));
    }




}

