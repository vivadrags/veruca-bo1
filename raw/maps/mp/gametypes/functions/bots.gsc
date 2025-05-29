#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

spawnEnemyBot()
{
    team = self.pers["team"];
    bot = addTestClient();
    bot.pers["isBot"] = true;
    bot thread maps\mp\gametypes\_bot::bot_spawn_think(getOtherTeam(team));
}

spawnFriendlyBot()
{
    team = self.pers["team"];
    bot = addTestClient();
    bot.pers["isBot"] = true;
    bot thread maps\mp\gametypes\_bot::bot_spawn_think(team);
}

freezeBots() 
{
    if (!isDefined(self.pers["frozen_bots"])) 
    {
        self.pers["frozen_bots"] = true;
        self colorToggle(self.pers["frozen_bots"]);
        self thread freezeBotsMonitor();
    } 
    else 
    {
        self.pers["frozen_bots"] = undefined;
        self colorToggle(self.pers["frozen_bots"]);

        players = level.players;
        for (i = 0; i < players.size; i++)
        {
            player = players[i];
            if (isDefined(player.pers["isBot"]))
            {
                player freezeControls(false);
            }
        }

        self notify("end_frozen_bots");
    }
}

freezeBotsMonitor() 
{
    self endon("disconnect");
    self endon("end_frozen_bots");

    players = level.players;
    for (i = 0; i < players.size; i++)
    {
        player = players[i];
        if (isDefined(player.pers["isBot"]))
        {
            player freezeControls(true);
        }
    }
}


teleportBots() 
{
    players = level.players;
    for (i = 0; i < players.size; i++)
    {
        player = players[i];
        if (isDefined(player.pers["isBot"]))
        {
            player.pers["location"] = player.origin;
            level.players[i] setOrigin(bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, 0, self)["position"]);
            wait 0.1;
            player setPlayerAngles(vectorToAngles((self.origin + (0, 0, 30)) - (player getTagOrigin("j_head"))));
        }
    }
}

teleportBotsDefaultLocation(coords, angles)
{
    players = level.players;
    for (i = 0; i < players.size; i++)
    {
        player = players[i];
        if (isDefined(player.pers["isBot"]) && player.pers["isBot"])
        {
            player.pers["location"] = player.origin;
            player setOrigin(coords);
            player setPlayerAngles(angles);
            wait 0.1;
            player setPlayerAngles(vectorToAngles((self.origin + (0, 0, 30)) - (player getTagOrigin("j_head"))));
        }
    }
}

saveBotLocation()
{
    if (!isDefined(self.savebotlocation))
    {
        self.savebotlocation = true;
        self colorToggle(self.savebotlocation);
        self endon("end_save_bot_location");

        players = level.players;
        for (i = 0; i < players.size; i++)
        {
            player = players[i];
            if (isDefined(player.pers["isBot"]) && player.pers["isBot"])
            {
                player.pers["location"] = player.origin;
            }
        }
    }
    else 
    {
        self.savebotlocation = undefined;
        self colorToggle(self.savebotlocation);
        self notify("end_save_bot_location");

        players = level.players;
        for (i = 0; i < players.size; i++)
        {
            player = players[i];
            if (isDefined(player.pers["isBot"]) && player.pers["isBot"])
            {
                player.pers["location"] = undefined;
            }
        }
        
    }
}

botsLookAtYou()
{
    players = level.players;
    for (i = 0; i < players.size; i++)
    {
        player = players[i];
        if (isDefined(player.pers["isBot"]))
        {
            player setPlayerAngles(VectorToAngles((self.origin + (0, 0, 30)) - (player getTagOrigin("j_head"))));
        }
    }
}

botsStance(stance_position) 
{
    self.pers["stance"] = true;
    self.pers["stance_position"] = stance_position;
    self thread botsStanceMonitor();
}

botsStanceMonitor() 
{
    self endon("disconnect");
    self endon("end_stance");
    if (isDefined(self.pers["stance"])) 
    {
        self thread doBotsStance();
    }
}

doBotsStance() 
{
    players = level.players;
    for (i = 0; i < players.size; i++) 
    {
        player = players[i];
        if (isDefined(player.pers["isBot"]))
        {
            if (self.pers["stance_position"]  == "stand")
            {
                player setStance("stand");
            }
            else if (self.pers["stance_position"]  == "crouch")
            {
                player setStance("crouch");
            }
            else if (self.pers["stance_position"]  == "prone")
            {
                player setStance("prone");
            }
        }
    }
}

kickBots() 
{
    players = level.players;
    for (i = 0; i < players.size; i++) 
    {
        player = players[i];
        if (isDefined(player.pers["isBot"]) && player.pers["isBot"])
        {
            kick(player getEntityNumber());
        }
    }
}