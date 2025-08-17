global function ChatCommand_God_Init


void function ChatCommand_God_Init()
{
    AddServerChatCommandCallback("/god",  ChatCommand_God)
}

void function ChatCommand_God(entity player, array<string> args)
{
    string userid = player.GetUID()
    if (!Leaf_IsAdmin(userid)) {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    if( args.len() != 1 ){
        if( !player.IsInvulnerable() ){
            player.SetInvulnerable()
            Leaf_ChatServerPrivateMessage(player, "已设置玩家" + player.GetPlayerName() + "为无敌状态！！！")
        }else{
            player.ClearInvulnerable()
            Leaf_ChatServerPrivateMessage(player, "已取消玩家" + player.GetPlayerName() + "的无敌状态！！！")
        }
        return
    }else{
        entity player1 = GetPlayerByName(args[0])
        if( player1 == null || !IsAlive(player1) ){
            Leaf_ChatServerPrivateMessage(player, "玩家不存在或者玩家已死亡！！！")
            return
        }
        if( !player1.IsInvulnerable() ){
            player1.SetInvulnerable()
            Leaf_ChatServerPrivateMessage(player, "已设置玩家" + player1.GetPlayerName() + "为无敌状态！！！")
        }else{
            player1.ClearInvulnerable()
            Leaf_ChatServerPrivateMessage(player, "已取消玩家" + player1.GetPlayerName() + "的无敌状态！！！")
        }
    }
}