void main()
{
string sColor = GetName(GetObjectByTag("COLORS"));
string sWhite = GetSubString(sColor, 0, 6);
string sYellow = GetSubString(sColor, 6, 6);
string sMagenta = GetSubString(sColor, 12, 6);
string sCyan = GetSubString(sColor, 18, 6);
string sRed = GetSubString(sColor, 24, 6);
string sGreen = GetSubString(sColor, 30, 6);
string sBlue = GetSubString(sColor, 36, 6);

SendMessageToPC(GetEnteringObject(), "Welcome " +
sMagenta + "to " +
sCyan + "the " +
sRed + "wonderful " +
sGreen + "world " +
sBlue + "of " +
sWhite + "color!");
}
