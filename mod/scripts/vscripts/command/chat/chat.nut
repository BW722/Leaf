global function ChatCommand_Chat_Init

bool ChatEnable = false

void function ChatCommand_Chat_Init()
{
    AddCallback_OnReceivedSayTextMessage(OnReceivedSayTextMessage)
    AddServerChatCommandCallback( "/chat",  ChatCommand_Chat )
}

void function ChatCommand_Chat(entity player, array<string> args)
{
    string userid = player.GetUID()
    if (!Leaf_IsAdmin(userid)) {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    if(args.len() == 1)
    {
        if(args[0] == "on")
        {
            SetChatEnable(false)
            Leaf_ChatServerBroadcast("聊天已开启！！！")
        }
        else if(args[0] == "off")
        {
            SetChatEnable(true)
            Leaf_ChatServerBroadcast("聊天已关闭！！！")
        }
    }
    else
    {
        Leaf_ChatServerPrivateMessage(player, "用法: /chat <on|off>")
        Leaf_ChatServerPrivateMessage(player, "当前状态: " + (ChatEnable ? "已关闭" : "已开启"))
        return
    }
}

void function SetChatEnable(bool enable)
{
    ChatEnable = enable
}

ClServer_MessageStruct function OnReceivedSayTextMessage(ClServer_MessageStruct message)
{
    entity sender = message.player
    string userId = sender.GetUID()
    if (Leaf_IsAdmin(userId))
    {
        return message
    }
    if (ChatEnable)
    {
        message.shouldBlock = true
        Leaf_ChatServerPrivateMessage(message.player, "聊天功能已禁用(仅管理员可发言)")
    }
    return message
}