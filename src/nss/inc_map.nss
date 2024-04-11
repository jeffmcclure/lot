#include "69_i0_henchman"

/* Declarations */
// Return iPinID of the first deleted map pin within the personal map pin array
int GetFirstDeletedMapPin(object oPC);

// Set a personal map pin on oPC. Returns iPinID.
// Defaults: GetArea(oPC) and fX/fY from GetPosition(oPC)
int SetMapPin(object oPC, string sPinText, float fX=-1.0, float fY=-1.0, object oArea=OBJECT_INVALID);

// Mark a map pin as deleted. Not a real delete to maintain the array
void DeleteMapPin(object oPC, int iPinID);

// Returns oArea from iPinID
object GetAreaOfMapPin(object oPC, int iPinID);

/* Implementation */
int GetFirstDeletedMapPin(object oPC)
{
   int i;
   int iPinID = 0;
   int iTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
   if(iTotal > 0) {
       for(i=1; i<=iTotal; i++) {
           if(GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + IntToString(i)) == "DELETED") {
               iPinID = i;
               break;
           }
       }
   }
   return iPinID;
}

int SetMapPin(object oPC, string sPinText, float fX=-1.0, float fY=-1.0, object oArea=OBJECT_INVALID)
{
   // If oArea is not valid, we use the current area.
   if(oArea == OBJECT_INVALID) { oArea = GetArea(oPC); }
   // if fX and fY are both -1.0, we use the position of oPC
   if(fX == -1.0 && fY == -1.0) {
       vector vPos=GetPosition(oPC);
       fX = vPos.x;
       fY = vPos.y;
   }
   // Find out if we can reuse a deleted map pin
   int iUpdateDeleted = TRUE;
   int iPinID = 0;
   int iTotal = GetLocalInt(oPC, "NW_TOTAL_MAP_PINS");
   if(iTotal > 0) { iPinID = GetFirstDeletedMapPin(oPC); }
   // Otherwise use a new one
   if(iPinID == 0) { iPinID = iTotal + 1; iUpdateDeleted = FALSE; }
   // Set the pin
   string sPinID = IntToString(iPinID);
   SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, sPinText);
   SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, fX);
   SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, fY);
   SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, oArea);
   if(!iUpdateDeleted) { SetLocalInt(oPC, "NW_TOTAL_MAP_PINS", iPinID); }
   return iPinID;
}

void DeleteMapPin(object oPC, int iPinID) {
   //SendMessageToPC(GetFirstPC(), "DeleteMapPin() enter");

   string sPinID = IntToString(iPinID);
   // Only mark as deleted if set
   if(GetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID) != "") {
       //SendMessageToPC(GetFirstPC(), "DeleteMapPin() 2");
       SetLocalString(oPC, "NW_MAP_PIN_NTRY_" + sPinID, "DELETED");
       SetLocalFloat(oPC, "NW_MAP_PIN_XPOS_" + sPinID, 0.0);
       SetLocalFloat(oPC, "NW_MAP_PIN_YPOS_" + sPinID, 0.0);
       SetLocalObject(oPC, "NW_MAP_PIN_AREA_" + sPinID, OBJECT_INVALID);
   }
}

object GetAreaOfMapPin(object oPC, int iPinID)
{
   return GetLocalObject(oPC, "NW_MAP_PIN_AREA_"+IntToString(iPinID));
}

void RecordHenchmanDeath(object oHench) {
    int tokenId = GetLocalInt(OBJECT_SELF, "DEATH_TOKEN");
    string henchJournal = "QST_" + GetTag(oHench) + "_DEAD";
    //SendMessageToPC(GetFirstPC(), "RecordHenchmanDeath()");
    // Journal entry for death
    object myMaster = GetMaster(oHench);
    if (FALSE == GetIsObjectValid(myMaster)) {
        myMaster = GetFormerMaster(oHench);
    }
    object deathArea = GetArea(oHench);
    string areaName = GetName(deathArea);
    string henchName = GetName(oHench);
    SetCustomToken(tokenId, areaName);
    // need to remove and re-add so the custom token is re-generated into journal log entry
    RemoveJournalQuestEntry(henchJournal, myMaster, TRUE); // give to party
    AddJournalQuestEntry(henchJournal, 1, myMaster, TRUE); // give to party

    // Map point for death
    vector vPos=GetPosition(oHench);

    object oMember=GetFirstFactionMember(myMaster, TRUE);
    while (GetIsObjectValid(oMember)) {
        int pinId = SetMapPin(oMember, "RIP " + henchName, vPos.x, vPos.y, deathArea);
        //SendMessageToPC(GetFirstPC(), "1-Creating pin " + IntToString(pinId));
        //SendMessageToPC(oMember, "Creating pin " + IntToString(pinId));
        SetLocalInt(oMember, henchJournal + "DEATH_PIN", pinId);
        oMember=GetNextFactionMember(myMaster, TRUE);
    }
}

void DeleteHenchmanDeath(object oHench) {
    string henchJournal = "QST_" + GetTag(oHench) + "_DEAD";
    object myMaster = GetMaster(oHench);
    if (FALSE == GetIsObjectValid(myMaster)) {
        myMaster = GetFormerMaster(oHench);
    }
    RemoveJournalQuestEntry(henchJournal, myMaster, TRUE); // give to party

    object oMember=GetFirstFactionMember(myMaster, TRUE);
    while (GetIsObjectValid(oMember)) {
        int pinId = GetLocalInt(oMember, henchJournal + "DEATH_PIN");
        //SendMessageToPC(oMember, "pinId = " + IntToString(pinId));
        if (pinId > 0)
            DeleteMapPin(oMember, pinId);
        oMember=GetNextFactionMember(myMaster, TRUE);
    }
}
