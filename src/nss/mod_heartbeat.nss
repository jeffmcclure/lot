//::///////////////////////////////////////////////
//:: FileName:modonheartbeat
//:://////////////////////////////////////////////
//::Exports all characters.
//::
//:://////////////////////////////////////////////
//:: Created By: Devin Loiacano
//:: Created On: February 27, 2004
//:://////////////////////////////////////////////
//Event: OnHeartbeat, trigger: every six seconds after module load, the module's
//heartbeat will fire. There is nothing that triggers this event... whatever
//script is in this area will run on every heartbeat. For that reason, be
//careful that you do not add large scripts into this area that will be running
//constantly, as the overhead on processing power that they can take up can be
//large.

int ExportTimer();
void MessagePlayers();

void main()
{
ExportTimer();
}

int ExportTimer()
{
int nWait = 10; //Hours of game time. 1 hour = ~2 minutes
int nLastFired = GetLocalInt(OBJECT_SELF, "LastFired");

int nHour = GetTimeHour();
int nDay = GetCalendarDay() * 24;
int nMonth = GetCalendarMonth() * 30 * 24;
int nYear = GetCalendarYear() * 12 * 30 * 24;
int nCurrent = nHour + nDay + nMonth + nYear;

if (nCurrent - nLastFired >= nWait)
{
SetLocalInt(OBJECT_SELF, "LastFired", nCurrent);

ExportAllCharacters();
MessagePlayers();

return 1;
}
else
{
return 0;
}
}

void MessagePlayers()
{
object oPC=GetFirstPC();

while (oPC != OBJECT_INVALID)
{
SendMessageToPC(oPC,"Game status saved.");
oPC=GetNextPC();
}
}
