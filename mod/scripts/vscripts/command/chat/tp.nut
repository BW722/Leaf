global function ChatCommand_Tp_Init

void function ChatCommand_Tp_Init() {
    AddServerChatCommandCallback("/tp", ChatCommand_Tp)
}

void function ChatCommand_Tp(entity player, array<string> args) {
    string userId = player.GetUID()
    if (!Leaf_IsAdmin(userId)) {
        Leaf_ChatServerPrivateMessage(player, "你没有管理员权限！！！")
        return
    }

    if( args.len() != 2 )
        return

    array<entity> subjects = []

    if ( args[0].tolower() == "all" )
    {
        subjects = GetPlayerArray()
    } 
    else
    {
        subjects.append( GetPlayerByName(args[0]) )
    }
    entity target = GetPlayerByName(args[1])

    foreach(subject in subjects)
    {
        if (subject == null || !IsAlive(subject))
            continue
        thread TeleportPlayerToPlayer(subject, target)
    }
}

void function TeleportPlayerToPlayer(entity subject, entity target)
{
    vector targetOrigin = target.GetOrigin()
    subject.SetInvulnerable()
    target.SetInvulnerable()
    WaitEndFrame()
    EmitSoundOnEntity( subject, "Timeshift_Scr_DeviceShift2Present" )
    wait 0.25
    subject.SetOrigin(targetOrigin)
    subject.ClearInvulnerable()
    target.ClearInvulnerable()
}