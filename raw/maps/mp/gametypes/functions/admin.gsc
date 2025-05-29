#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

#include maps\mp\gametypes\functions\bots; // Include for change map, change gamemode, and fast restart

exitGame()
{
    exitLevel(false);
}

screenOverlay(overlay)
{
    if (overlay == "green")
    {
        self.screenoverlayshader destroy();
        self.screenoverlayshader = createRectangle("CENTER", "CENTER", 0, 0, 1000, 1000, (0, 0.694, 0.250), "white" , 1, 1);
    }
    else if (overlay == "blue")
    {
        self.screenoverlayshader destroy();
        self.screenoverlayshader = createRectangle("CENTER", "CENTER", 0, 0, 1000, 1000, (0, 0.278, 0.733), "white" , 1, 1);
    }
    else if (overlay == "disabled")
    {
        self.screenoverlayshader destroy();
    }
}

weaponName()
{
    weapon = self getCurrentWeapon();
    self iPrintLn("Weapon: ^6" + weapon);
}

gameVersion()
{
    if (!isDefined(self.gameversion))
    {
        self.gameversion = true;
        self colorToggle(self.gameversion);
        self setClientDvar("cg_drawVersion", 1);
    }
    else
    {
        self.gameversion = undefined;
        self colorToggle(self.gameversion);
        self setClientDvar("cg_drawVersion", 0);
    }
}

grabXUID()
{
    XUID = self GetXUID();
    self iPrintln("XUID: ^6" + XUID);
}

showOrigin() 
{
    if (!isDefined(self.showorigin))
    {
        self.showorigin = true;
        self colorToggle(self.showorigin);
        self.origintext = [];
        self.origintext[0] = self createText("Objective", 1.5, "CENTER", "CENTER", -70, 120, 1,  1, self.origin[0], (1, 1, 1));
        self.origintext[1] = self createText("Objective", 1.5, "CENTER", "CENTER", 0, 120, 1, 1, self.origin[1], (1, 1, 1));
        self.origintext[2] = self createText("Objective", 1.5, "CENTER", "CENTER", 70, 120, 1, 1, self.origin[2], (1, 1, 1));
        self.origintext[3] = self createText("Objective", 1.5, "CENTER", "CENTER", -40, 150, 1, 1, self.angles[0], (1, 1, 1));
        self.origintext[4] = self createText("Objective", 1.5, "CENTER", "CENTER", 40, 150, 1, 1, self.angles[1], (1, 1, 1));
        
        while (isDefined(self.origintext[0])) 
        {
            self.origintext[0] setValue(self.origin[0]);
            self.origintext[1] setValue(self.origin[1]);
            self.origintext[2] setValue(self.origin[2]);
            self.origintext[3] setValue(self.angles[0]);
            self.origintext[4] setValue(self.angles[1]);
            wait 0.05;
        }
    }
    else
    {
        self.showorigin = undefined;
        self colorToggle(self.showorigin);
        self.origintext[0] destroy();
        self.origintext[1] destroy();
        self.origintext[2] destroy();
        self.origintext[3] destroy();
        self.origintext[4] destroy();
    }
}

toggleTimer() 
{
    if (!isDefined(self.pers["toggle_timer"])) 
    {
        self.pers["toggle_timer"] = true;
        self colorToggle(self.pers["toggle_timer"]);
        self thread toggleTimerMonitor();
    } 
    else 
    {
        self.pers["toggle_timer"] = undefined;
        self colorToggle(self.pers["toggle_timer"]);
        self maps\mp\gametypes\_globallogic_utils::resumeTimer();
        self notify("end_toggle_timer");
    }
}

toggleTimerMonitor() 
{
    self endon("disconnect");
    self endon("end_toggle_timer");
    if (isDefined(self.pers["toggle_timer"])) 
    {
        self maps\mp\gametypes\_globallogic_utils::pauseTimer();
    }
}

add1Minute()
{
    if (getDvar("g_gametype") == "tdm" || "sd" || "dm")
    {
        time = getDvarInt("scr_tdm_timelimit");
        time = getDvarInt("scr_sd_timelimit");
        time = getDvarInt("scr_dm_timelimit");
        time = time + 1;
        setDvar("scr_tdm_timelimit", time);
        setDvar("scr_sd_timelimit", time);
        setDvar("scr_dm_timelimit", time);
    }
    else 
    {
        self iPrintLn("Adding time doesn't work in the gamemode!");
    }
}

remove1Minute()
{
    if (getDvar("g_gametype") == "tdm" || "sd" || "dm")
    {
        time = getDvarInt("scr_tdm_timelimit");
        time = getDvarInt("scr_sd_timelimit");
        time = getDvarInt("scr_dm_timelimit");
        time = time - 1;
        setDvar("scr_tdm_timelimit", time);
        setDvar("scr_sd_timelimit", time);
        setDvar("scr_dm_timelimit", time);
    }
    else 
    {
        self iPrintLn("Removing time doesn't work in the gamemode!");
    }
}

changeMap(map)
{
    thread kickBots();
    setDvar("ls_map", map);
    setDvar("map", map);
    setDvar("party_map", map);
    setDvar("ui_map", map);
    setDvar("ui_currentMap", map);
    setDvar("ui_map", map);
    setDvar("ui_preview_map", map);
    setDvar("ui_showmap", map);
    map(map, false);
}

changeGamemode(gamemode)
{
    thread kickBots();
    map = getDvar("mapname");
    setDvar("g_gametype", gamemode);
    setDvar("ls_map", map);
    setDvar("map", map);
    setDvar("party_map", map);
    setDvar("ui_map", map);
    setDvar("ui_currentMap", map);
    setDvar("ui_map", map);
    setDvar("ui_preview_map", map);
    setDvar("ui_showmap", map);
    map(map, false);
}

changeTeam()
{
    self thread changeMyTeam(getOtherTeam(self.pers["team"]));
}

changeMyTeam(team)
{
    assignment = team;

    self.pers["team"] = assignment;
    self.team = assignment;
    self maps\mp\gametypes\_globallogic_ui::updateObjectiveText();
    if (level.teamBased)
    {
        self.sessionteam = assignment;
    }
    else
    {
        self.sessionteam = "none";
        self.ffateam = assignment;
    }
    
    if (!isAlive(self))
    {
        self.statusicon = "hud_status_dead";
    }

    self notify("joined_team");
    level notify("joined_team");
    
    self setClientDvar("g_scriptMainMenu", game["menu_class_" + self.pers["team"]]);
}

resetScore()
{
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];

        // Reset individual score
        player.score = 0;
    	player.pointstowin = 0;
    	player.kills = 0;
    	player.deaths = 0;
    	player.headshots = 0;
    	player.assists = 0;
    	player.pers["pointstowin"] = 0;
    	player.pers["kills"] = 0; 
    	player.pers["deaths"] = 0;
    	player.pers["headshots"] = 0;
    	player.pers["assists"] = 0;
        player thread maps\mp\gametypes\_globallogic_score::_setPlayerScore(self, 0);
    }
    //Reset search and destroy and team score
    game["roundsWon"]["axis"] = 0;
    game["roundsWon"]["allies"] = 0;
    game["roundsPlayed"] = 0;
    game["teamScores"]["allies"] = 0;
    game["teamScores"]["axis"] = 0;
    maps\mp\gametypes\_globallogic_score::updateTeamScores("axis", "allies");
}

hardcoreHud() 
{
    if (!isDefined(self.pers["hardcore_hud"])) 
    {
        self.pers["hardcore_hud"] = true;
        self colorToggle(self.pers["hardcore_hud"]);
        self thread hardcoreHudMonitor();
    } 
    else 
    {
        self.pers["hardcore_hud"] = undefined;
        self colorToggle(self.pers["hardcore_hud"]);
        self setClientUIVisibilityFlag("hud_visible", 1);
        self setClientDvar("cg_drawCrosshair", 1);
        self notify("end_hardcore_hud");
    }
}

hardcoreHudMonitor() 
{
    self endon("disconnect");
    self endon("end_hardcore_hud");
    if (isDefined(self.pers["hardcore_hud"])) 
    {
        self setClientUIVisibilityFlag("hud_visible", 0);
        self setClientDvar("cg_drawCrosshair", 0);
    }
}


instantLast()
{
    if (getDvar("g_gametype") == "tdm")
    {
        self thread maps\mp\gametypes\_globallogic_score::_setTeamScore(self.team, level.scorelimit - 100);
    }
    else if (getDvar("g_gametype") == "dm") 
    {
        random_death_int = randomIntRange(6, 19);
        random_headshot_int = randomIntRange(4, 12);
        self.kills = 29;
        self.deaths = random_death_int;
        self.headshots = random_headshot_int;
        self.pers["kills"] = 29;
        self.pers["deaths"] = random_death_int;
        self.pers["headshots"] = random_headshot_int;
        self thread maps\mp\gametypes\_globallogic_score::_setPlayerScore(self, 1450);
    }
    else
    {
        self iPrintLn("Fast Last only works in TDM & FFA");
    }
}

unlimitedLives() 
{
    if (!isDefined(self.pers["unlimited_lives"])) 
    {
        self.pers["unlimited_lives"] = true;
        self colorToggle(self.pers["unlimited_lives"]);
        self thread unlimitedLivesMonitor();
    } 
    else 
    {
        self.pers["unlimited_lives"] = undefined;
        self colorToggle(self.pers["unlimited_lives"]);
        self.pers["lives"] = 1;
        self notify("end_unlimited_lives");
    }
}

unlimitedLivesMonitor() 
{
    self endon("disconnect");
    self endon("end_unlimited_lives");
    if (isDefined(self.pers["unlimited_lives"])) 
    {
        self.pers["lives"] = 999;
    }
}

onlineGame() 
{
    if (!isDefined(self.pers["online_game"])) 
    {
        self.pers["online_game"] = true;
        self colorToggle(self.pers["online_game"]);
        self thread onlineGameMonitor();
    } 
    else 
    {
        self.pers["online_game"] = undefined;
        self colorToggle(self.pers["online_game"]);
        setDvar("onlinegame", 0);
        setDvar("onlinegameandhost", 0);
        setDvar("xblive_privatematch", 1);
        setDvar("xblive_rankedmatch", 0);
        level.rankedMatch = false;
        level.onlineGame = false;
        self notify("end_online_game");
    }
}

onlineGameMonitor() 
{
    self endon("disconnect");
    self endon("end_online_game");
    if (isDefined(self.pers["online_game"])) 
    {
        setDvar("onlinegame", 1);
        setDvar("onlinegameandhost", 1);
        setDvar("xblive_privatematch", 0);
        setDvar("xblive_rankedmatch", 1);
        level.rankedMatch = true;
        level.onlineGame = true;
    }
}

fastRestart()
{
    thread kickBots();
    map = getDvar("mapname");
    setDvar("ls_map", map);
    setDvar("map", map);
    setDvar("party_map", map);
    setDvar("ui_map", map);
    setDvar("ui_currentMap", map);
    setDvar("ui_map", map);
    setDvar("ui_preview_map", map);
    setDvar("ui_showmap", map);
    map(map, false);
}