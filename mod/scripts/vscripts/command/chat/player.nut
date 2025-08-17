global function ChatCommand_Player_Init


void function ChatCommand_Player_Init() {
    AddServerChatCommandCallback("/player", ChatCommand_Player )
}

void function ChatCommand_Player(entity player, array<string> args) {
    if (args[0] == "list")
    {
        foreach ( targetPlayer in GetPlayerArray() )
        {
            string name = "[Name: " + targetPlayer.GetPlayerName() + "]"
            string uid = "[UID: " + targetPlayer.GetUID() + "]"
            string team = "[Team: " + targetPlayer.GetTeam() + "]"
            Leaf_ChatServerPrivateMessage( player , team + uid + name )
        }
        return
    }
}