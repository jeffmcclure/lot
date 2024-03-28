////////////////////////////////////////////////////////////////////////////////
// Resting Script
// Module OnPlayerRest Event
////////////////////////////////////////////////////////////////////////////////

//int REST_DELAY = 3; // amount of hours a player must wait between rests

//------------------------------------------------------------------------------
// transform current date and time into hours
//------------------------------------------------------------------------------
int GetCalendarInHours()
{
  int nHour  = GetTimeHour();
  int nDay   = GetCalendarDay();
  int nMonth = GetCalendarMonth();
  int nYear  = GetCalendarYear();

  return ( nHour + nDay*24 + nMonth*28*24 + nYear*12*28*24 );
}

//------------------------------------------------------------------------------
// Module OnPlayerRest Event
//------------------------------------------------------------------------------
void main()
{
  int    REST_DELAY      = GetLocalInt(GetModule(),"OPTION_RestTimer");

  object oPC             = GetLastPCRested();
  int    nTimeLastRested = GetLocalInt(oPC,"ModuleOnRest_nTimeLastRested");

  if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
  {
    if (GetCalendarInHours() < (nTimeLastRested + REST_DELAY))
    {
      AssignCommand(oPC,ClearAllActions()); // cancel resting

      int nRemainingTime = REST_DELAY - (GetCalendarInHours() - nTimeLastRested);
      int bDisplayHours  = TRUE;

      // display remaining real time seconds during the last game hour
      if (nRemainingTime == 1)
      {
        nRemainingTime = FloatToInt(HoursToSeconds(1)) - GetTimeMinute()*60 - GetTimeSecond();
        bDisplayHours = FALSE;
      }
      string s = "You must wait "+IntToString(nRemainingTime);
      if (bDisplayHours) s+= (nRemainingTime > 1) ? " (game) hours "        : " (game) hour ";
      else               s+= (nRemainingTime > 1) ? " (real time) seconds " : " (real time) second ";
      s+= "before resting again.";
      SendMessageToPC(oPC,s);
    }
    else
    {
      SetLocalInt(oPC,"ModuleOnRest_nTimeLastRested",GetCalendarInHours());
    }
  }
}
