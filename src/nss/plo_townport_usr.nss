////////////////////////////////////////////////////////////////////////////////
// Placeable Object Event: OnUserDefined
////////////////////////////////////////////////////////////////////////////////

void main()
{
  int nUserEvent = GetUserDefinedEventNumber();

  //----------------------------------------------------------------------------

  if (nUserEvent == 9000)
  {
    PlaySound("al_mg_portal1");
    DelayCommand(7.7,SignalEvent(OBJECT_SELF,EventUserDefined(9000)));
  }

  //----------------------------------------------------------------------------

}
