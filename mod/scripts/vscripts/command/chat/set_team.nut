global function ChatCommand_SetTeam_Init


void function ChatCommand_SetTeam_Init() {
    AddServerChatCommandCallback("/set_team", ChatCommand_SetTeam )
}

void function ChatCommand_SetTeam(entity player, array<string> args) {
    string userid = player.GetUID()
    if (!Leaf_IsAdmin(userid))
    {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    if (args.len() != 2) {
        return
    }

    int team = int(args[1])
    array<entity> players = []

    if (args[0].tolower() == "all")
    {
        players = GetPlayerArray()
    }
    else
    {
        players.append(GetPlayerByName(args[0]))
    }

    foreach(targetPlayer in players)
    {
        if (targetPlayer == null || !IsAlive(targetPlayer))
        {
            Leaf_ChatServerPrivateMessage( player, "设置玩家" + targetPlayer.GetPlayerName() + "队伍失败" )
            continue
        }
        try {
            SetTeam(targetPlayer, team)
            Leaf_ChatServerPrivateMessage( player, "已设置玩家" + targetPlayer.GetPlayerName() + "队伍为" + team )
        }
        catch(error)
        {
            Leaf_ChatServerPrivateMessage( player, "设置玩家" + targetPlayer.GetPlayerName() + "队伍时发生错误: " + error )
            print(error)
        }
    }
}