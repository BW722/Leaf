global function ChatCommand_Noclip_Init
global function Noclip


void function ChatCommand_Noclip_Init() {
    AddServerChatCommandCallback("/noclip", ChatCommand_Noclip )
}

void function ChatCommand_Noclip(entity player, array<string> args) {
    string userid = player.GetUID()
    if (!Leaf_IsAdmin(userid))
    {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    array<entity> players = []
    if(args.len() != 1)
    {
        players.append(player)
    }

    if(args.len() == 1)
    {
        if (args[0].tolower() ==  "all")
        {
            players = GetPlayerArray()
        }
        else
        {
            players.append(GetPlayerByName(args[0]))
        }
    }

    foreach (targetPlayer in players)
    {
        if ( targetPlayer == null || !IsAlive(targetPlayer) )
            continue
        thread Noclip(targetPlayer)
    }
}

void function Noclip( entity player )
{
	if( player.GetParent() )
    {
		print( player + " failed noclipping because the entity is parented" )
		return
	}

	print( player + " NOCLIP" )

	if ( player.IsNoclipping() )
    {
        player.SetPhysics( MOVETYPE_WALK )
    }
	else
    {
        player.SetPhysics( MOVETYPE_NOCLIP )
    }
}