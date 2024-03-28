//include file by Lilac Soul, aka Carsten Hjorthoj

void SetPartyInt(object oPC, string sName, int n)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalInt(oMember, sName, n);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

int GetPartyInt(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

int n=0;
int nn;

while (GetIsObjectValid(oMember))
  {
  nn=GetLocalInt(oMember, sName);
  if (nn>n) n=nn;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return n;
}

void SetPartyFloat(object oPC, string sName, float f)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalFloat(oMember, sName, f);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

float GetPartyFloat(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

float f=0.0f;
float ff;

while (GetIsObjectValid(oMember))
  {
  ff=GetLocalFloat(oMember, sName);
  if (ff>f) f=ff;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return f;
}

void SetPartyString(object oPC, string sName, string s)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalString(oMember, sName, s);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

string GetPartyString(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);
string s="";

while (GetIsObjectValid(oMember))
  {
  s=GetLocalString(oMember, sName);
  if (s != "") return s;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return s;
}

void SetPartyObject(object oPC, string sName, object o)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalObject(oMember, sName, o);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

object GetPartyObject(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);
object o=OBJECT_INVALID;

while (GetIsObjectValid(oMember))
  {
  o=GetLocalObject(oMember, sName);
  if (o != OBJECT_INVALID) return o;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return o;
}

void SetPartyLocation(object oPC, string sName, location l)
{
object oMember=GetFirstFactionMember(oPC, TRUE);

while (GetIsObjectValid(oMember))
  {
  SetLocalLocation(oMember, sName, l);
  oMember=GetNextFactionMember(oPC, TRUE);
  }
}

location GetPartyLocation(object oPC, string sName)
{
object oMember=GetFirstFactionMember(oPC, TRUE);
location l;

while (GetIsObjectValid(oMember))
  {
  //testing: if the area of l isn't valid, it isn't a
  //valid location
  l=GetLocalLocation(oMember, sName);
  if (GetAreaFromLocation(l) != OBJECT_INVALID) return l;
  oMember=GetNextFactionMember(oPC, TRUE);
  }

return l;
}
