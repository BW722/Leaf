global function ChatCommand_SvCheats_Init


void function ChatCommand_SvCheats_Init() {
    AddServerChatCommandCallback("/sv_cheats", ChatCommand_SvCheats)
}

void function ChatCommand_SvCheats(entity player, array<string> args) {
    string userid = player.GetUID()
    if (!Leaf_IsAdmin(userid)) {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    if ( args.len() != 1 )
        return

    string state = args[0]

    if(state == "1") {
        ServerCommand("sv_cheats 1")
    }else if(state == "0"){
        ServerCommand("sv_cheats 0")
    }
}