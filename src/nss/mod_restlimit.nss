int iCurSec=GetTimeSecond();
int iCurMinute=GetTimeMinute();


void main()
{
    object oPC=GetLastPCRested();
    int iCharLvl=GetHitDice(oPC);
    int iLastRestMinute=GetLocalInt(oPC, "LastRestMinute");
    int iLastRestSec=GetLocalInt(oPC,"LastRestSec");
    int iRestDelayMinute=0;

        int iRestDelaySec=((iCharLvl-10)*15)+120;

        if(iRestDelaySec<10)
        {
            iRestDelaySec=0;
        }

        while(iRestDelaySec>=60)
    {
        iRestDelayMinute=iRestDelayMinute+1;
        iRestDelaySec=iRestDelaySec-60;
    }

    int iNewRestMinute=iLastRestMinute+iRestDelayMinute;
    int iNewRestSec=iLastRestSec+iRestDelaySec;
    while(iNewRestSec>=60)
    {
    iNewRestMinute=iNewRestMinute+1;
    iNewRestSec=iNewRestSec-60;
    }

    int iHostileDistance=30;

    int nLastRestType=GetLastRestEventType();
    switch(nLastRestType)
    {
        case REST_EVENTTYPE_REST_STARTED:
            if(iCurMinute<iNewRestMinute || (iCurMinute==iNewRestMinute && iCurSec<iNewRestSec))
            {
                AssignCommand(oPC, ClearAllActions());
                int iMinutesToWait=(iLastRestMinute+iRestDelayMinute)-iCurMinute;
                int iSecToWait=(iLastRestSec+iRestDelaySec)-iCurSec;

                if(iMinutesToWait>=2)
                {
                    SendMessageToPC(oPC, "You must wait "+IntToString(iMinutesToWait) +" minutes and " + IntToString(iSecToWait)+" seconds before resting again.");
                }
                if(iMinutesToWait==1)
                {
                    SendMessageToPC(oPC, "You must wait "+IntToString(iMinutesToWait) +" minute and " + IntToString(iSecToWait)+" seconds before resting again.");
                }
                if(iMinutesToWait==0)
                {
                    SendMessageToPC(oPC, "You must wait " + IntToString(iSecToWait)+" seconds before resting again.");
                }
            }
            else
            {
                object oCreature=GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
                if(GetDistanceToObject(oCreature) <= IntToFloat(iHostileDistance))
                {
                    ActionDoCommand(ActionRest());
                }
                else
                {
                    AssignCommand(oPC, ClearAllActions());
                    SendMessageToPC(oPC, "You cannot rest with enemy creatures nearby.");
                }
            }
        break;

        case REST_EVENTTYPE_REST_FINISHED:
            SetLocalInt(oPC, "LastRestMinute",  iCurMinute);
            SetLocalInt(oPC, "LastRestSec", iCurSec);
        break;

        case REST_EVENTTYPE_REST_CANCELLED:
        break;

        case REST_EVENTTYPE_REST_INVALID:
        break;

        default:
            SendMessageToPC(oPC, "REST_ERROR_NO_EVENTTYPE");
            string nErrorMessage="REST_ERROR_NO_EVENTTYPE on player " + GetPCPlayerName(oPC);
            SendMessageToAllDMs(nErrorMessage);
    }
}

