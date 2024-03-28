void CreateMark(string sTag, location lLoc)
{
        CreateObject(OBJECT_TYPE_PLACEABLE,sTag,lLoc);

}


void main()
{
       AssignCommand(GetPCSpeaker(),ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,1.0f,5.0f));
       AdjustAlignment(GetPCSpeaker(),ALIGNMENT_CHAOTIC,1);
       AdjustAlignment(GetPCSpeaker(),ALIGNMENT_EVIL,1);
       DelayCommand(1.0f, PlaySound("as_cv_mineshovl2"));

       location lLoc = GetLocation(OBJECT_SELF);
       DestroyObject(OBJECT_SELF,5.1f);

       if (d20()<5)
       {
            DelayCommand(5.0f,CreateMark("lordo_bones",lLoc));
            AssignCommand(GetPCSpeaker(),ActionSpeakString("I found bones!"));
       }
        else       if (d20()<5)
        {
            DelayCommand(5.0f,CreateMark("lordo_dcorpse",lLoc));
            AssignCommand(GetPCSpeaker(),ActionSpeakString("A rotten corpse!"));
        }
        else     if (d20()<5)
        {
            DelayCommand(5.0f,CreateMark("lordo_corpse3",lLoc));
            AssignCommand(GetPCSpeaker(),ActionSpeakString("A rotten corpse!"));
        }

        else if (d20()<5)
        {


            effect eLightning = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
            effect eShake = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);
            effect eDmg = EffectDamage(d3()*GetHitDice(GetPCSpeaker()));
            object oDmg = GetPCSpeaker();
            DelayCommand(1.8f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oDmg));
            DelayCommand(3.0f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eLightning, oDmg));
            DelayCommand(3.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eShake, oDmg));
            DelayCommand(3.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oDmg));
            AssignCommand(GetPCSpeaker(),ActionDoCommand(PlayVoiceChat(VOICE_CHAT_PAIN2)));
            AssignCommand(GetPCSpeaker(),ActionSpeakString("Seems like I have angered a higher being!"));

        }
        else
      {
            DelayCommand(5.0f,CreateMark("plc_weathmark",lLoc));
            AssignCommand(GetPCSpeaker(),ActionSpeakString("There is nothing valuable in this grave"));
      }

}
