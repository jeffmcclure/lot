void main() {
    // Decline loot genie quest
    AddJournalQuestEntry("QST_LOOT_GENIE", 3, GetPCSpeaker(), FALSE, FALSE); // only give to player not party
}
