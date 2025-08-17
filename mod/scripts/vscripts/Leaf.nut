#if SERVER
global function Leaf_IsDeveloper
global function Leaf_IsAdmin
global function Leaf_ChatServerPrivateMessage
global function Leaf_ChatServerBroadcast
#endif //SERVER

#if SERVER
global function GetPlayerByUID
global function IsValidUID
#endif //SERVER

global function GetPlayerByName
global function IsValidPlayerName

global function GetPlayerBotArray

//global function GetPlayerPing


#if SERVER
bool function Leaf_IsDeveloper(string userId)
{ 
    return userId == "1013199872353"
}
#endif //SERVER

#if SERVER
bool function Leaf_IsAdmin(string userId)
{ 
    if(Leaf_IsDeveloper(userId))
        return true
    return split(GetConVarString("AdminIDs"),",").contains(userId)
}
#endif //SERVER

#if SERVER
void function Leaf_ChatServerPrivateMessage(entity player, string message)
{
    Chat_ServerPrivateMessage( player, "[32m[Leaf][33m" + message, false, false )
}
#endif //SERVER

#if SERVER
void function Leaf_ChatServerBroadcast(string message)
{
    Chat_ServerBroadcast( "[32m[Leaf][33m" + message, false )
}
#endif //SERVER

#if SERVER
entity function GetPlayerByUID(string userId)
{
    foreach (player in GetPlayerArray())
    {
        if ( player.GetUID() == userId )
        {
            return player
        }
    }
    return null
}
#endif //SERVER

#if SERVER
bool function IsValidUID(string userId)
{
    foreach (player in GetPlayerArray())
    {
        if ( player.GetUID() == userId )
        {
            return true
        }
    }
    return false
}
#endif //SERVER

entity function GetPlayerByName(string playerName)
{
    foreach (player in GetPlayerArray())
    {
        if ( player.GetPlayerName().tolower() == playerName.tolower() )
        {
            return player
        }
    }
    return null
}

bool function IsValidPlayerName(string playerName)
{
    foreach (player in GetPlayerArray())
    {
        if ( player.GetPlayerName() == playerName )
        {
            return true
        }
    }
    return false
}

array<entity> function GetPlayerBotArray()
{
    array<entity> bots = []
    foreach (player in GetPlayerArray())
    {
        if (player.IsBot()) {
            bots.append(player)
        }
    }
    return bots
}

/*
int function GetPlayerPing(entity player)
{
    #if CLIENT
    if (player == GetLocalClientPlayer())
    {
        return MyPing()
    }
    #endif //CLIENT
    return player.GetPlayerGameStat(PGS_PING)
}
*/