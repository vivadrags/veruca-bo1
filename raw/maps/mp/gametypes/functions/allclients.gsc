#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\main;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\structure;

selectAllClientsTeam(team)
{
    self.all_client_teams = team;
}

verifyAllClients()
{
    self iPrintLn("All clients verified");
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        if (self.all_client_teams == "Both Teams" || (self.all_client_teams == "Friendly Team" && self.pers["team"] == player.pers["team"]) || (self.all_client_teams == "Enemy Team" && self.pers["team"] != player.pers["team"]))
        {
            if (!player isHost())
            {
                player.pers["menu_access"] = true;
                player initializeMenuSetup(player);
            }
        }
   }
}

unverifyAllClients()
{
    self iPrintLn("All clients unverified"); 
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        if (self.all_client_teams == "Both Teams" || (self.all_client_teams == "Friendly Team" && self.pers["team"] == player.pers["team"]) || (self.all_client_teams == "Enemy Team" && self.pers["team"] != player.pers["team"]))
        {
            if (!player isHost())
            {
                player.pers["menu_access"] = false;
                player.menu["open"] = false;
                player thread menuClose(); 
            }
        }
    }
}

teleportAllClients()
{
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        if (self.all_client_teams == "Both Teams" || (self.all_client_teams == "Friendly Team" && self.pers["team"] == player.pers["team"]) || (self.all_client_teams == "Enemy Team" && self.pers["team"] != player.pers["team"]))
        {
            if (!player isHost())
            {
                player setOrigin(bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, false, self)["position"]);
            }
        }
   }
}

freezeAllClients() 
{
    if (self.freezeallplayer == 0) 
    {
        self.freezeallplayer = 1;
    } 
    else 
    {
        self.freezeallplayer = 0;
    }
    
    for (p = 0; p < level.players.size; p++) 
    {
        player = level.players[p];
        if (self.all_client_teams == "Both Teams" || (self.all_client_teams == "Friendly Team" && self.pers["team"] == player.pers["team"]) ||  (self.all_client_teams == "Enemy Team" && self.pers["team"] != player.pers["team"])) {
            
            if (!player isHost()) 
            {
                player freezeControls(self.freezeallplayer == 1);
            }
        }
    }
}

instantLastAllClients()
{
    if (getDvar("g_gametype") == "dm")
    {
        
        for (p = 0; p < level.players.size; p++)
        {
            player = level.players[p];
            if (self.all_client_teams == "Both Teams" || (self.all_client_teams == "Friendly Team" && self.pers["team"] == player.pers["team"]) || (self.all_client_teams == "Enemy Team" && self.pers["team"] != player.pers["team"]))
            {
                if (!player isHost())
                {
                    random_death_int = randomIntRange(6, 19);
                    random_headshot_int = randomIntRange(4, 12);
                    self.kills = 29;
                    self.deaths = random_death_int;
                    self.headshots = random_headshot_int;
                    self.pers["kills"] = 29;
                    self.pers["deaths"] = random_death_int;
                    self.pers["headshots"] = random_headshot_int;
                    player thread maps\mp\gametypes\_globallogic_score::_setPlayerScore(player, 1450);
                }
            }
        }
    }
    else
    {
        self iPrintLn("Instant last only works in FFA");
    }
}

killAllClients()
{
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        if (self.all_client_teams == "Both Teams" || (self.all_client_teams == "Friendly Team" && self.pers["team"] == player.pers["team"]) || (self.all_client_teams == "Enemy Team" && self.pers["team"] != player.pers["team"]))
        {
            if (!player isHost())
            {
                player suicide();
            }
        }
    }
}

kickAllClients()
{
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        if (self.all_client_teams == "Both Teams" || (self.all_client_teams == "Friendly Team" && self.pers["team"] == player.pers["team"]) || (self.all_client_teams == "Enemy Team" && self.pers["team"] != player.pers["team"]))
        {
            if (!player isHost())
            {
                kick(player getEntityNumber());
            }
        }
    }
}

banAllClients()
{
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        if (self.all_client_teams == "Both Teams" || (self.all_client_teams == "Friendly Team" && self.pers["team"] == player.pers["team"]) || (self.all_client_teams == "Enemy Team" && self.pers["team"] != player.pers["team"]))
        {
            if (!player isHost())
            {
                ban(player getEntityNumber());
            }
        }
    }
}