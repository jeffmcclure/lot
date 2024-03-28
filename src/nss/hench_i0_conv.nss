/*

    Henchman Inventory And Battle AI

    This file contains scripts used settings in conversations
*/

// void main() {    }


const string sHenchAutoRecoverTraps = "AutoRecoverTraps";
const string sHenchAutoOpenLocks = "AutoOpenLocks";
const string sHenchAutoPickup = "AutoPickup";
const string sHenchAutoOpenChest = "AutoOpenChest";
const string sHenchNoDisarmTraps = "NoDisarmTraps";


const string sHenchFamiliarChallenge = "NewFamiliarChallenge";
const string sHenchFamiliarToDeath = "FamiliarToTheDeath";

const string sHenchAniCompChallenge = "NewAniCompChallenge";
const string sHenchAniCompToDeath = "AniCompToTheDeath";



void HenchSetAssociateInt(string sName, int iValue)
{    
    SetLocalInt(OBJECT_SELF, sName, iValue);
/*
    int iAssocType = GetAssociateType(OBJECT_SELF);    
    if (iAssocType == ASSOCIATE_TYPE_FAMILIAR)
    {
        SetLocalInt(GetMaster(), "Fam" + sName, iValue);
    }
    else if (iAssocType == ASSOCIATE_TYPE_ANIMALCOMPANION)
    {
        SetLocalInt(GetMaster(), "Ani" + sName, iValue);
    } */
}


void HenchSetAssociateFlee(float fChallenge, int bFightToDeath)
{
    object oPC = GetPCSpeaker();    
    int iAssocType = GetAssociateType(OBJECT_SELF);    
    // Set the variables
    if (iAssocType == ASSOCIATE_TYPE_FAMILIAR)
    {
        SetLocalFloat(oPC, sHenchFamiliarChallenge, fChallenge);
        SetLocalInt(oPC, sHenchFamiliarToDeath, bFightToDeath);
    }
    else if (iAssocType == ASSOCIATE_TYPE_ANIMALCOMPANION)
    {
        SetLocalFloat(oPC, sHenchAniCompChallenge, fChallenge);
        SetLocalInt(oPC, sHenchAniCompToDeath, bFightToDeath);
    }
}

