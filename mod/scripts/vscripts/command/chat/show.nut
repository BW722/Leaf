global function ChatCommand_Show_Init


void function ChatCommand_Show_Init() {
    AddServerChatCommandCallback( "/show", ChatCommand_Show )
}

void function ChatCommand_Show(entity player, array<string> args)
{
    string userId = player.GetUID()
    if (!Leaf_IsAdmin(userId))
    {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    array<entity> players = []

    if (args.len() != 1)
    {
        players.append(player)
    }
    else if(args.len() == 1)
    {
        if (args[0].tolower() == "all")
        {
            players = GetPlayerArray()
        }
        else
        {
            players.append(GetPlayerByName(args[0]))
        }
    }

    foreach(targetPlayer in players)
    {
        if (targetPlayer == null || !IsAlive(targetPlayer))
        {
            continue
        }
        targetPlayer.Show()
    }
}