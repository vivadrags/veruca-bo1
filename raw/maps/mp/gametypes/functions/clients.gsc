#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

#include maps\mp\gametypes\functions\admin; // Include for client change team

verifyClient(player)
{
    player_name = player getName();
    if (player isHost())
    {
        self iPrintLn("Host is already verified!");
    }
    else
    {
        if (player.pers["menu_access"] == true)
        {
            self iPrintLn(player_name + " is already verified!");
        }
        else if (player.pers["menu_access"] == false)
        {
            player.pers["menu_access"] = true;
            self iPrintLn(player_name + " verified");
            player initializeMenuSetup(player);
        }
    }
}

unverifyClient(player)
{
    player_name = player getName();
    if (player isHost())
    {
        self iPrintLn("Can't unverify the host!");
    }
    else
    {
        player.pers["menu_access"] = false;
        player.menu["open"] = false;
        player thread menuClose();
        self iPrintLn(player_name + " unverified");
    }
}

teleportClient(player) 
{
    player_name = player getName();
    if (player isHost()) 
    {
        self iPrintLn("Can't teleport the host!");
    }
    else 
    {
        player setOrigin(bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, false, self)["position"]);
    }
}

teleportToClient(player) 
{
    player_name = player getName();
    if (isAlive(player))
    {
        self setOrigin(player.origin);
    }
    else if (!isAlive(player))
    {
        self iPrintLn(player_name + " is not alive!");
    }
}

freezeClient(player) 
{
    player_name = player getName();
    if (player isHost())
    {
        self iPrintLn("Can't freeze the host!");
    }
    else 
    {
         if (!isDefined(self.freezeplayer))
        {
            self.freezeplayer = true;
            self colorToggle(self.freezeplayer);
            self iPrintLn(player_name + " frozen");
            player freezeControls(true);
        }
        else
        {
            self.freezeplayer = undefined;
            self colorToggle(self.freezeplayer);
            self iPrintLn(player_name + " unfrozen");
            player freezeControls(false);
        }
    }
}

reviveClient(player)
{
    player_name = player getName();
    self_name = self getName();
    if (!isAlive(player))
    {
        if (!maps\mp\gametypes\_globallogic_utils::isValidClass(self.pers["class"]))
        {
            self.pers["class"] = "CLASS_CUSTOM1";
            self.class = self.pers["class"];
        }
        
        if (player.hasSpawned)
        {
            player.pers["lives"]++;
        }
        else 
        {
            player.hasSpawned = true;
        }

        if (player.sessionstate != "playing")
        {
            player.sessionstate = "playing";
        }
        
        player thread [[level.spawnClient]]();

        player iPrintLn("Revived by " + self_name);
        self iPrintLn("You revived " + player_name);
    }
    else 
    {
        self iPrintLn(player_name + " is already alive");
    }
}

secondChanceClient(player)
{
    player_name = player getName();
    if (player isHost()) 
    {
        self iPrintLn("Can't set host to second chance!");
    }
    else 
    {
        player setPerk("specialty_pistoldeath");
        player setPerk("specialty_finalstand");
        wait 0.1;
        player thread[[level.callbackPlayerDamage]](player, player, 100, 8, "MOD_RIFLE_BULLET", player getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "body", 0);
        self iPrintLn(player_name + " set to second chance"); 
    }
}

changeTeamClient(player)
{
    player_name = player getName();
    if (player isHost()) 
    {
        self iPrintLn("Can't change the host's team!");
    }
    else 
    {
        player thread changeMyTeam(getOtherTeam(player.pers["team"]));
        self iPrintLn(player_name + " team changed");
    }
}

godmodeClient(player) 
{
    player_name = player getName();
    if (player isHost())
    {
        self iPrintLn("Can't give god mode to the host!");
    }
    else 
    {
         if (!isDefined(self.godmodeplayer))
        {
            self.godmodeplayer = true;
            self colorToggle(self.godmodeplayer);
            self iPrintLn("Godmode enabled for" + player_name);
            player enableInvulnerability();
        }
        else
        {
            self.godmodeplayer = undefined;
            self colorToggle(self.godmodeplayer);
            self iPrintLn("Godmode disabled for" + player_name);
            player disableInvulnerability();
        }
    }
}

aimbotClient(player) 
{
    player_name = player getName();
    if (player isHost()) 
    {
        self iPrintLn("Can't give aimbot to the host!");
    }
    else 
    {
        if (!isDefined(self.aimbotplayer))
        {
            self iPrintLn("Sniper aimbot enabled for " + player_name);
            self.aimbotplayer = true;
            self colorToggle(self.aimbotplayer);
            player sniperTrickshotAimbot();
        }
        else
        {
            self iPrintLn("Sniper aimbot disabled for " + player_name);
            self notify("end_player_sniper_trickshot_aimbot");
            self.aimbotplayer = undefined;
            self colorToggle(self.aimbotplayer);
        }
    }
}

sniperTrickshotAimbot()
{   
    for (;;)
    {
        wait 0.01;
        self waittill("weapon_fired");
        self endon("end_player_sniper_trickshot_aimbot");
        start = self getTagOrigin("j_head");
        end = anglesToForward(self getPlayerAngles()) * 8000000;
        destination = bulletTrace(start, end, true, self)["position"];
        for (i = 0; i < level.players.size;i++)
        {
            if (level.teamBased && level.players[i].pers["team"] != self.pers["team"])
            {
                if (isSubStr(self getCurrentWeapon(), "l96a1") || isSubStr(self getCurrentWeapon(), "psg1") || isSubStr(self getCurrentWeapon(), "wa2000") || isSubStr(self getCurrentWeapon(), "dragunov"))
                {
                    if (distance(level.players[i].origin, destination) < 600)
                    {
                        level.players[i] thread [[level.callbackPlayerDamage]](self, self, 2147483600, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "pelvis", 0);
                    }
                }
            }
        }
    }
}

instantLastClient(player)
{
    player_name = player getName();
    if (player isHost()) 
    {
        self iPrintLn("Can't fast last the host!");
    }
    else 
    {
        if (getDvar("g_gametype") == "dm") 
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
            self iPrintLn("Fast Last set for " + player_name);
        }
        else
        {
            self iPrintLn("Fast Last only works in FFA");
        }
    }
}

resetClientScore(player)
{
    player_name = player getName();
    if (player isHost()) 
    {
        self iPrintLn("Can't reset the host's score!");
    }
    else 
    {
        player.kills = 0;
        player.deaths = 0;
        player.headshots = 0;
        player.pers["kills"] = 0;
        player.pers["deaths"] = 0;
        player.pers["headshots"] = 0;
        player thread maps\mp\gametypes\_globallogic_score::_setPlayerScore(player, 0);
        self iPrintLn(player_name + " score reset");
    }
}

recoveryClient(player)
{
    player_name = player getName();
    if (player isHost()) 
    {
        self iPrintLn("Can't give the host a recovery!");
    }
    else 
    {
        // Ranked Match
        level.rankedMatch = true;
        level.contractsEnabled = true;
        setDvar("onlinegame", 1);
        setDvar("xblive_rankedmatch", 1);
        setDvar("xblive_privatematch", 0);
        
        // Level 50
        player maps\mp\gametypes\_persistence::statSet("rankxp", 1262500, false);
        player maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "rankxp", 1262500);
        player.pers["rank"] = 49;
        player setRank(49);
        
        // Prestige 15
        prestige_level = 15;
        player.pers["plevel"] = prestige_level;
        player.pers["prestige"] = prestige_level;
        player setdstat("playerstatslist", "plevel", "StatValue", prestige_level);
        player maps\mp\gametypes\_persistence::statSet("plevel", prestige_level, true);
        player maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "plevel", prestige_level);
        player setRank(player.pers["rank"], prestige_level);
        
        // Pro Perks
        perks = [];
        perks[1] = "PERKS_SLEIGHT_OF_HAND";
        perks[2] = "PERKS_GHOST";
        perks[3] = "PERKS_NINJA";
        perks[4] = "PERKS_HACKER";
        perks[5] = "PERKS_LIGHTWEIGHT";
        perks[6] = "PERKS_SCOUT";
        perks[7] = "PERKS_STEADY_AIM";
        perks[8] = "PERKS_DEEP_IMPACT";
        perks[9] = "PERKS_MARATHON";
        perks[10] = "PERKS_SECOND_CHANCE";
        perks[11] = "PERKS_TACTICAL_MASK";
        perks[12] = "PERKS_PROFESSIONAL";
        perks[13] = "PERKS_SCAVENGER";
        perks[14] = "PERKS_FLAK_JACKET";
        perks[15] = "PERKS_HARDLINE";
        for (i = 1; i < 16; i++)
        {
            perk = perks[i];
            for (j = 0; j < 3; j++)
            {
                player maps\mp\gametypes\_persistence::unlockItemFromChallenge("perkpro " + perk + " " + j);
            }
        }

        // Cod Points
        player maps\mp\gametypes\_persistence::statSet("codpoints", 100000000, false);
        player maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "codpoints", 100000000);
        player maps\mp\gametypes\_persistence::setPlayerStat("PlayerStatsList", "codpoints", 100000000);
        player.pers["codpoints"] = 100000000;
        
        //Items
        player setClientDvar("allItemsPurchased", 1);
        player setClientDvar("allItemsUnlocked", 1);
        
        //Emblems
        player setClientDvar("allEmblemsPurchased", 1);
        player setClientDvar("allEmblemsUnlocked", 1);
        player setClientDvar("ui_items_no_cost", 1);
        player setClientDvar("lb_prestige", 1);
        player maps\mp\gametypes\_rank::updateRankAnnounceHUD();

        //Colored Classes
        player setClientDvar("customclass1", "^0" + player.name);
        player setClientDvar("customclass2", "^1" + player.name);
        player setClientDvar("customclass3", "^6" + player.name);
        player setClientDvar("customclass4", "^3" + player.name);
        player setClientDvar("customclass5", "^4" + player.name);
        player setClientDvar("prestigeclass1", "^6" + player.name);
        player setClientDvar("prestigeclass2", "^6" + player.name);
        player setClientDvar("prestigeclass3", "^7" + player.name);
        player setClientDvar("prestigeclass4", "^8" + player.name);
        player setClientDvar("prestigeclass5", "^9" + player.name);
        
        player iPrintLn("Unlock All: ^6Set");
        self iPrintLn("Unlock All set for " + player_name); 
    }
}

derankClient(player)
{
    player_name = player getName();
    if (player isHost()) 
    {
        self iPrintLn("Can't derank the host!");
    }
    else 
    {
        player maps\mp\gametypes\_persistence::statSet("plevel", 0, true);
        player maps\mp\gametypes\_persistence::statSet("rankxp", 0, true);
        self iPrintLn(player_name + " deranked");
    }
}

killClient(player) 
{
    if (player isHost()) 
    {
        self iPrintLn("Can't kill the host!");
    }
    else 
    {
        player suicide();
    }
}

kickClient(player)
{
    if (player isHost()) 
    {
        self iPrintLn("Can't kick the host!");
    }
    else 
    {
        kick(player getEntityNumber());
    }
}

banClient(player)
{
    if (player isHost()) 
    {
        self iPrintLn("Can't ban the host!");
    }
    else 
    {
        ban(player getEntityNumber());
    }
}