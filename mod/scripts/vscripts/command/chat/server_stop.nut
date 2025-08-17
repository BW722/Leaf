global function ChatCommand_ServerStop_Init


void function ChatCommand_ServerStop_Init()
{
    AddServerChatCommandCallback("/server_stop",  ChatCommand_ServerStop)
}

void function ChatCommand_ServerStop(entity player, array<string> args)
{
    string userId = player.GetUID()
    if (!Leaf_IsAdmin(userId)) {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    foreach(player in GetPlayerArray())
    {
        NSDisconnectPlayer(player,"懒得写")
    }

    ServerCommand("quit")
}