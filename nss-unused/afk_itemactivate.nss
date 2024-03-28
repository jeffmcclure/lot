// Simple onactivate that grabs the tag of the item activated, and executes the script name that matches.
// Its too simple to not work. I didn't create it, and I don't remember who came up with it originally (sorry to that person)

void main()
{
  ExecuteScript(GetTag(GetItemActivated()), OBJECT_SELF);
}
