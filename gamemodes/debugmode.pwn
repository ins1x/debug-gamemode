/*
    Gamemode: Debugmode
    Description: Simple gamemode created for debugging
    Git: https://github.com/ins1x/useful-samp-stuff
*/

// ----------------------------------------------------------------------------

// NOTE: compile your script with debug info enabled.
// https://github.com/Zeex/samp-plugin-crashdetect/wiki/Compiling-scripts-with-debug-info   
// Below is a list of callbacks available in SA-MP and its call sequence:
// https://open.mp/docs/scripting/resources/callbacks-sequence

// ----------------------------------------------------------------------------

#include <a_samp>

// Binary archives come with an include file (profiler.inc or crashdetect.inc)
// that contains some helper functions that you may find useful. 
// But you don't need to include it to be able to use the plugin, it's not required.

// CrashDetect does not work in conjunction with Profiler and JIT plugins, only one of them can be used!

// #include <profiler>
// https://github.com/Zeex/samp-plugin-profiler#configuration

// #include <crashdetect>
// https://github.com/Zeex/samp-plugin-crashdetect

// #include <sscanf2> 
// https://github.com/Y-Less/sscanf

// ----------------------------------------------------------------------------

#if defined JIT_INC
    #warning Don't include JIT with CrashDetect or Profiler plugin
#endif

// ignore literal array/string passed to a non-const parameter
// #pragma warning disable 239

main()
{
    print("Debug Gamemode\n");
}

public OnPlayerConnect(playerid)
{
    GameTextForPlayer(playerid, "~w~SA-MP: ~r~Debug ~y~Gamemode ", 5000, 5);
    SendClientMessage(playerid, -1, "Available commands:");
    SendClientMessage(playerid, -1, "/spawn /jetpack /time /weather");
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new idx;
    new cmd[256];
    
    cmd = strtok(cmdtext, idx);
    
    if(!strcmp(cmdtext, "/respawn", true) || !strcmp(cmdtext, "/spawn", true))
    {
        if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return 1;
    
        new
            vehicleid = GetPlayerVehicleID(playerid);
        if (vehicleid)
        {
            new Float:x, Float:y, Float:z;
            GetVehiclePos(vehicleid, x, y, z),
            SetPlayerPos(playerid, x, y, z);
        }
        SpawnPlayer(playerid);
        return 1;
    }
    
    if (!strcmp(cmdtext, "/jetpack", true))
    {
        if(GetPlayerState(playerid) != SPECIAL_ACTION_USEJETPACK 
        && GetPlayerState(playerid) != PLAYER_STATE_SPECTATING)
        {
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
        }
        return true;
    }
    
    if (!strcmp("/weather", cmd, true))
    {
        cmd = strtok(cmdtext, idx);
        if (!strlen(cmd) || strval(cmd) > 255)
        {
            SendClientMessage(playerid, -1, "Use: /weather [weather ID]");
            return true;
        }
        
        SetPlayerWeather(playerid, strval(cmd)); 
        return true;
    }
    
    if (!strcmp("/time", cmd, true))
    {
        cmd = strtok(cmdtext, idx);
        if (!strlen(cmd) || strval(cmd) > 23 )
        {
            SendClientMessage(playerid, -1, "Use: /time [hour]");
            return true;
        }
        
        SetPlayerTime(playerid, strval(cmd), 0); 
        return true;
    }
    
    // sscanf cmd example
    // if (sscanf(params, "ui", giveplayerid, amount))
    // {
           // return SendClientMessage(playerid, 0xFF0000AA, "Usage: /givecash <playerid/name> <amount>");
    // }
    
    return 0;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerInterior(playerid, 0);
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    //GameTextForPlayer(playerid, "~w~Wasted", 5000, 3);
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    // Spawn place from bare gamemode
    SetPlayerInterior(playerid,14);
    SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
    SetPlayerFacingAngle(playerid, 270.0);
    SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
    SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
    return 1;
}

public OnGameModeInit()
{
    SetGameModeText("Debug Gamemode");
    
    new heap_free = heapspace(); 
    printf("Stack/heap free %d bytes", heap_free);
    if (heap_free > 16384) printf("Used \"#pragma dynamic\" bytes");
    
    UsePlayerPedAnims();
    AllowInteriorWeapons(true);
    ShowPlayerMarkers(true);
    // ShowNameTags(true); Enabled by default
    // LimitPlayerMarkerRadius(250.0);
    EnableStuntBonusForAll(false);
    DisableInteriorEnterExits();
    
    // Exclude invalid 74 skin
    for (new i = 0; i < 299; i++)
    {
        if(i != 74) AddPlayerClass(i, 1407.6, 2208.9, 19.8, 135.0, 0, 0, 0, 0, 0, 0); 
    }
    
    // Profiler plugin dump call
    // Profiler_Dump();
    
    print("Gamemode init complete \t[OK]\n");
    return 1;
}

// ----------------------------------------------------------------------------
strtok(const string[], &index)
{
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' '))
    {
        index++;
    }

    new offset = index;
    new result[20];
    while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
    {
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}