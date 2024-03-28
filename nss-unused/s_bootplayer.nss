void main()
{
// remove the player from the server
object oPlayer = GetPCSpeaker();
RemoveFromParty(oPlayer);
BootPC(oPlayer);
}
