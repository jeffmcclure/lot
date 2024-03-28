void main()
{
    if (GetLocalInt(OBJECT_SELF,"LORD_EMITTER_ACTIVATED"))
        return;

    SetLocalInt(OBJECT_SELF,"LORD_EMITTER_ACTIVATED",TRUE);

    string sTag = GetTag(OBJECT_SELF);


    if (sTag == "lordo_em_dark")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_DARKNESS);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    } else if (sTag == "lordo_em_web")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_WEB);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
    else if (sTag == "lordo_em_weba")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_WEB_MASS);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
    else if (sTag == "lordo_em_tenta")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_TENTACLE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
    else if (sTag == "lordo_em_antilight")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_ANTI_LIGHT_10);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
    else if (sTag == "lordo_em_entangle")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_ENTANGLE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
        else if (sTag == "lordo_em_bluel20")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_LIGHT_BLUE_20);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
        else if (sTag == "lordo_em_music")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_BARD_SONG);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
        else if (sTag == "lordo_em_premo")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_PROT_PREMONITION);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
            else if (sTag == "lordo_em_globi")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_GLOBE_INVULNERABILITY);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
             else if (sTag == "lordo_em_sturn")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_SPELLTURNING);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
            else if (sTag == "lordo_em_flame")
    {
        effect eEff = EffectVisualEffect(VFX_DUR_AURA_FIRE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEff, OBJECT_SELF);
    }
            else if (sTag == "lordo_em_firew")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_WALLFIRE,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
        else if (sTag == "lordo_em_windw")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_WALLWIND,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
        else if (sTag == "lordo_em_grease")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_GREASE,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
        else if (sTag == "lordo_em_cdoom")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_CREEPING_DOOM,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
        else if (sTag == "lordo_em_tentaa")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_EVARDS_BLACK_TENTACLES,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
        else if (sTag == "lordo_em_bladew")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_WALLBLADE,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
        else if (sTag == "lordo_em_storm")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_STORM,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
        else if (sTag == "lordo_em_fogs")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_FOGSTINK,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
            else if (sTag == "lordo_em_fogk")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_FOGKILL,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
        else if (sTag == "lordo_em_fogm")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_FOGMIND,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
            else if (sTag == "lordo_em_foga")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_FOGACID,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
                else if (sTag == "lordo_em_fogf")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_FOGFIRE,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
                    else if (sTag == "lordo_em_tanglea")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_ENTANGLE,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }
                   else if (sTag == "lordo_em_fogz")
    {
        effect eEff = EffectAreaOfEffect(AOE_PER_FOGGHOUL,"lord_dummy","lord_dummy","lord_dummy");
        ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEff, GetLocation(OBJECT_SELF));
    }



}
