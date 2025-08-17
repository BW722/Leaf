global function ChatCommand_Kill_Init


void function ChatCommand_Kill_Init() {
    AddServerChatCommandCallback("/kill", ChatCommand_Kill )
}

void function ChatCommand_Kill(entity player, array<string> args) {
    string userid = player.GetUID()
    if (!Leaf_IsAdmin(userid)) {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    if( args.len() != 1 ){
        player.Die()
        return
    }

    if(args[0] == "all"){
        foreach(player1 in GetPlayerArray()){
            if ( player1 == null || !IsAlive(player1) )
                continue
            player1.Die()
        }
    }else{
        entity player1 = GetPlayerByName(args[0])
        if ( player1 == null || !IsAlive(player1) )
            return
        player1.Die()
    }
}