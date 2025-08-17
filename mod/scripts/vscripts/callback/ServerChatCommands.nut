global function ServerChatCommands_Init
global function IsServerChatCommandRegistered
global function AddServerChatCommandCallback
global function RemoveServerChatCommandCallback


table< string, void functionref(entity, array<string>) > ChatCommandCallbacks = {}

void function ServerChatCommands_Init() {
    AddCallback_OnReceivedSayTextMessage(OnReceivedSayTextMessage)
}

ClServer_MessageStruct function OnReceivedSayTextMessage(ClServer_MessageStruct message)
{
    entity player = message.player
    string chatText = message.message

    array<string> words = split(chatText, " ")
    string commandKey = words[0]

    if( commandKey in ChatCommandCallbacks ) {
        array<string> args = words.slice(1)
        thread ChatCommandCallbacks[commandKey](player, args)
        message.shouldBlock = true
    }

    return message
}

bool function IsServerChatCommandRegistered(string command) {
    return (command in ChatCommandCallbacks)
}

void function AddServerChatCommandCallback(string command, void functionref(entity player, array<string> args) func) {
    if( command in ChatCommandCallbacks )
        return
    if ( func == null )
        return
    ChatCommandCallbacks[command] <- func
}

void function RemoveServerChatCommandCallback(string command) {
    if( command in ChatCommandCallbacks ) {
        delete ChatCommandCallbacks[command]
    }
}