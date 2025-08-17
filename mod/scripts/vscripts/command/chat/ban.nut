global function ChatCommand_Ban_Init
global function BanPlayer


void function ChatCommand_Ban_Init()
{
    AddServerChatCommandCallback( "/ban",  ChatCommand_Ban )
}

void function ChatCommand_Ban(entity player, array<string> args)
{
    string userid = player.GetUID()
    if (!Leaf_IsAdmin(userid)) {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    if( args.len() != 1 )
        return
    
    entity targetPlayer = GetPlayerByName(args[0])
    
    if( targetPlayer == null || !IsAlive(targetPlayer) )
        return
     
    string targetPlayerName = targetPlayer.GetPlayerName()
    //string targetPlayerReason = args[1]

    BanPlayer(targetPlayer)
    Leaf_ChatServerBroadcast( "[31m|==================[BAN]==================|" )
    Leaf_ChatServerBroadcast( "[33m 玩家：" + targetPlayerName )
    //Chat_ServerBroadcast( "[33m 理由：" + targetPlayerReason, false )
    Leaf_ChatServerBroadcast( "[31m|========================================|" )
}

void function BanPlayer( entity player )
{
    ServerCommand( "ban " + player.GetPlayerName() )
}