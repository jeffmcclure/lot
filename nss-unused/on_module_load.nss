void main()
{
string sColor = GetName(GetObjectByTag("COLORS"));

SetCustomToken(1001, GetSubString(sColor, 0, 6)); //white
SetCustomToken(1002, GetSubString(sColor, 6, 6)); //yellow
SetCustomToken(1003, GetSubString(sColor, 12, 6)); //magenta
SetCustomToken(1004, GetSubString(sColor, 18, 6)); //cyan
SetCustomToken(1005, GetSubString(sColor, 24, 6)); //red
SetCustomToken(1006, GetSubString(sColor, 30, 6)); //green
SetCustomToken(1007, GetSubString(sColor, 36, 6)); //blue
}
