#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;

#include maps\mp\gametypes\functions\mods; // Include for auto ufo mode / persistant settings
#include maps\mp\gametypes\functions\teleport; // Include for save and load / persistant settings
#include maps\mp\gametypes\functions\miscs; // Include for monitor bounce
#include maps\mp\gametypes\functions\binds; // Include for persistant settings
#include maps\mp\gametypes\functions\bots; // Include for persistant settings
#include maps\mp\gametypes\functions\aimbot; // Include for persistant settings
#include maps\mp\gametypes\functions\trickshot; // Include for persistant settings
#include maps\mp\gametypes\functions\lobby; // Include for persistant settings
#include maps\mp\gametypes\functions\admin; // Include for persistant settings

init()
{
    level thread onPlayerConnect();
    
    thread initDvars();
    level.strings = []; // For overflow fix
    level.prematchperiod = false;
    level.rankedMatch = true;
    level.onlineGame = true;
    level.onForfeit = false;
    level.gameForfeited = false;
    level.numKills = 1; // Disables first blood
    level.onDeadEvent = ::onDeadEvent; // Bomb plant killcam

    // Authentication List
    level.names[0] = "vivadrags";
    level.names[1] = "boof";
}

onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();

        player thread changeClass();
        player thread monitorSettings();
        level thread removeSkyBarrier();
        level thread removeDeathBarrier();

        // For bolt movement bind
        if (!isDefined(player.pers["pos_count"]))
        {
            player.pers["pos_count"] = 0;
        }

        if (player isHost() || player isAuthed())
        {
            player.pers["menu_access"] = true;
        }
        else
        {
            player.pers["menu_access"] = false;
        }
    }
}

onPlayerSpawned()
{
    level endon("game_ended");
    for (;;) 
    {
        self waittill("spawned_player");

        // Bounce monitoring settings
        self thread monitorBounce();
        level.bounce = 0;

        thread onBotSpawned();

        self thread persistentSettings();
        
        if (self.pers["menu_access"] == true)
        {
            self thread overflowFix();
            self thread saveAndLoad();
            self thread autoUFO();
            self thread initializeMenuSetup(self);
            if (!isDefined(self.pers["spawn_text"]))
            {
                self iPrintLn("^6Veruca ^7by @vivadrags");
                self iPrintLn("Press [{+speed_throw}] & [{+actionslot 2}] to open");
            }
        }
        if (self.pers["menu_access"] == false)
        {

        }
    }
}

// Function to save settings between SND rounds
persistentSettings() 
{
    // Mods monitoring settings
    if (isDefined(self.pers["godmode"]))
    {
        self thread godmodeMonitor();
    }
    if (isDefined(self.pers["invisibility"]))
    {
        self thread invisibilityModeMonitor();
    }
    if (isDefined(self.pers["third_person"]))
    {
        self thread thirdPersonMonitor();
    }
    if (isDefined(self.pers["field_of_view"]))
    {
        self thread fieldOfViewMonitor();
    }
    if (isDefined(self.pers["infinite_ammo"]))
    {
        self thread infiniteAmmoMonitor();
    }
    if (isDefined(self.pers["infinite_equipment"]))
    {
        self thread infiniteEquipmentMonitor();
    }
    if (isDefined(self.pers["no_spread"]))
    {
        self thread noSpreadMonitor();
    }

    // Teleport monitoring settings (save and load, save bot teleport)
    if (isDefined(self.pers["location"]))
    {
        self setOrigin(self.pers["location"]);
    }
    if (isDefined(self.pers["angles"]))
    {
        self setPlayerAngles(self.pers["angles"]);
    }
    if (isDefined(self.pers["teleport_gun"]))
    {
        self thread teleportGunMonitor();
    }
    if (isDefined(self.pers["spec_nade"]))
    {
        self thread specNadeMonitor();
    }
    if (isDefined(self.pers["rocket_ride"]))
    {
        self thread rocketRideMonitor();
    }

    // Aimbot monitoring settings
    if (isDefined(self.pers["trickshot_aimbot"]))
    {
        self thread trickshotAimbotMonitor();
    }
    if (isDefined(self.pers["tag_aimbot"]))
    {
        self thread tagAimbotMonitor();
    }

    // Trickshot monitoring settings
    if (isDefined(self.pers["afterhit"]))
    {
        self thread afterhitMonitor();
    }
    if (isDefined(self.pers["moveaftergame"]))
    {
        self thread moveAfterGameMonitor();
    }
    if (isDefined(self.pers["refillammo"]))
    {
        self thread refillammoMonitor();
    }
    if (isDefined(self.pers["instashoot"]))
    {
        self thread instashootMonitor();
    }
    if (isDefined(self.pers["knifelunge"]))
    {
        self thread knifeLungeMonitor();
    }
    if (isDefined(self.pers["mala"]))
    {
        self thread malaMonitor();
    }
    if (isDefined(self.pers["boltstall"]))
    {
        self thread boltstallMonitor();
    }
    if (isDefined(self.pers["tiltscreen"]))
    {
        self thread tiltScreenMonitor();
    }
    if (isDefined(self.pers["autoprone"]))
    {
        self thread autoProneMonitor();
    }
    if (isDefined(self.pers["head_bounce"]))
    {
        self thread headBounceMonitor();
    }
    if (isDefined(self.pers["alwayscanswap"]))
    {
        self thread alwaysCanswapMonitor();
    }
    if (isDefined(self.pers["precamanimations"]))
    {
        self thread precamAnimationsMonitor();
    }
    if (isDefined(self.pers["pickupradius"]))
    {
        self thread pickupRadiusMonitor();
    }

    // Bind monitoring settings
    if (isDefined(self.pers["nacmod"]))
    {
        self thread resetNacmodWeapons();
        self thread nacmodMonitor();
    }
    if (isDefined(self.pers["second_nacmod"]))
    {
        self thread resetSecondNacmodWeapons();
        self thread secondNacmodMonitor();
    }
    if (isDefined(self.pers["shax_swap"]))
    {
        self thread shaxSwapMonitor();
    }
    if (isDefined(self.pers["canswap"]))
    {
        self thread canswapMonitor();
    }
    if (isDefined(self.pers["flicker"]))
    {
        self thread flickerMonitor();
    }
    if (isDefined(self.pers["upside_down_screen"]))
    {
        self thread upsideDownScreenMonitor();
    }
    if (isDefined(self.pers["capture"]))
    {
        self thread captureMonitor();
    }
    if (isDefined(self.pers["fade"]))
    {
        self thread fadeMonitor();
    }
    if (isDefined(self.pers["cowboy_bind"]))
    {
        self thread cowboyMonitor();
    }
    if (isDefined(self.pers["repeater"]))
    {
        self thread repeaterMonitor();
    }
    if (isDefined(self.pers["rapid_fire"]))
    {
        self thread rapidFireMonitor();
    }
    if (isDefined(self.pers["bolt_movement"]))
    {
        self thread boltMovementMonitor();
    }
    if (isDefined(self.pers["scavenger"]))
    {
        self thread scavengerMonitor();
    }
    if (isDefined(self.pers["class_change"]))
    {
        self thread classChangeMonitor();
    }
    if (isDefined(self.pers["change_lethal"]))
    {
        self thread changeLethalMonitor();
    }
    if (isDefined(self.pers["ghost_migration"]))
    {
        self thread ghostMigrationMonitor();
    }
    if (isDefined(self.pers["host_migration"]))
    {
        self thread hostMigrationMonitor();
    }
    if (isDefined(self.pers["illusion_reload"]))
    {
        self thread illusionReloadMonitor();
    }
    if (isDefined(self.pers["drop_care_package"]))
    {
        self thread dropCarePackageMonitor();
        self thread maps\mp\gametypes\supplydrop::newHeli(self.pers["dropzone_origin"], "none", self, self.team);
    }
    if (isDefined(self.pers["shoot_projectile"]))
    {
        self thread shootProjectileMonitor();
    }
    if (isDefined(self.pers["houdini"]))
    {
        self thread houdiniMonitor();
    }
    if (isDefined(self.pers["flash_grenade"]))
    {
        self thread flashGrenadeMonitor();
    }
    if (isDefined(self.pers["empty_clip"]))
    {
        self thread emptyClipMonitor();
    }
    if (isDefined(self.pers["instaswap"]))
    {
        self thread instaswapMonitor();
        self thread resetInstaswapWeapons();
    }
    if (isDefined(self.pers["elevator"]))
    {
        self thread elevatorMonitor();
    }
    if (isDefined(self.pers["reverse_elevator"]))
    {
        self thread reverseElevatorMonitor();
    }
    if (isDefined(self.pers["canzoom"]))
    {
        self thread canzoomMonitor();
    }
    if (isDefined(self.pers["second_chance"]))
    {
        self thread secondChanceMonitor();
    }
    if (isDefined(self.pers["bounce"]))
    {
        self thread bounceMonitor();
    }
    if (isDefined(self.pers["copycat"]))
    {
        self thread copycatMonitor();
    }
    if (isDefined(self.pers["wall_breach"]))
    {
        self thread wallBreachMonitor();
    }
    if (isDefined(self.pers["nova_gas"]))
    {
        self thread novaGasMonitor();
    }
    if (isDefined(self.pers["plant_bomb"]))
    {
        self thread plantBombMonitor();
    }
    if (isDefined(self.pers["self_damage"]))
    {
        self thread selfDamageMonitor();
    }
    if (isDefined(self.pers["random_camo_switch"]))
    {
        self thread randomCamoSwitchMonitor();
    }

    // Bots monitoring settings
    if (isDefined(self.pers["frozen_bots"]))
    {
        self thread freezeBotsMonitor();
    }
    if (isDefined(self.pers["stance"]))
    {
        self thread botsStanceMonitor();
    }

    // Lobby monitoring settings
    if (isDefined(self.pers["gravity"]))
    {
        self thread gravityMonitor();
    }
    if (isDefined(self.pers["timescale"]))
    {
        self thread timescaleMonitor();
    }
    if (isDefined(self.pers["speed"]))
    {
        self thread speedMonitor();
    }
    if (isDefined(self.pers["backspeed"]))
    {
        self thread backSpeedMonitor();
    }
    if (isDefined(self.pers["stop_speed"]))
    {
        self thread stopSpeedMonitor();
    }
    if (isDefined(self.pers["laddermod"]))
    {
        self thread laddermodMonitor();
    }
    if (isDefined(self.pers["ladder_spin"]))
    {
        self thread ladderspinMonitor();
    }
    if (isDefined(self.pers["knockback"]))
    {
        self thread knockbackMonitor();
    }

    // Admin monitoring settings
    if (isDefined(self.pers["toggle_timer"]))
    {
        self thread toggleTimerMonitor();
    }
    if (isDefined(self.pers["hardcore_hud"]))
    {
        self thread hardcoreHudMonitor();
    }
    if (isDefined(self.pers["killcam_playercard"]))
    {
        self thread killcamPlayercardMonitor();
    }
    if (isDefined(self.pers["killcam_slow_motion"]))
    {
        self thread killcamSlowMotionMonitor();
    }
    if (isDefined(self.pers["long_killcam"]))
    {
        self thread longKillcamMonitor();
    }
    if (isDefined(self.pers["unlimited_lives"]))
    {
        self thread unlimitedLivesMonitor();
    }
    if (isDefined(self.pers["online_game"]))
    {
        self thread onlineGameMonitor();
    }
}

initDvars()
{
    // Set initial dvars
    setDvar("sv_cheats", 1);
    setDvar("killcam_final", 1); // Killcam playercard
    setDvar("didyouknow", "^6Veruca ^7by @vivadrags"); // Loading tips
    setDvar("sv_botUseFriendNames", 0); // Default bot names only
    setDvar("player_bayonetLaunchProof", 0); // Bounce uncap (?)
    setDvar("scr_disable_tacinsert", 0); // Enable tac inserts for FFA
    //setDvar("cg_scoreboardPingText", 1); // Enable ping
    setDvar("jump_slowdownEnable", 0); // No jump fatigue

    // All bullet penetration
    setDvar("perk_bulletDamage", 9999);    
    setDvar("bg_surfacePenetration", 9999);
    setDvar("bg_bulletRange", 99999);
    setDvar("bullet_penetrationEnabled", 1);

    // Reset dvars to default
    setDvar("cg_nopredict", 0);
    setDvar("timescale", 1);
    setDvar("perk_weapReloadMultiplier", 0.5);
    setDvar("player_bayonetLaunchDebugging", 0);
    setDvar("bg_ladder_yawcap", 100);
    setDvar("bg_prone_yawcap", 100);
    setDvar("jump_ladderPushVel", 128);
    setDvar("mantle_enable", 1);
    setDvar("player_meleeRange", 64);
    setDvar("stop_speed", 100);
    setDvar("g_speed", 190);
    setDvar("player_backSpeedScale", 0.7);
    setDvar("scr_killcam_time", 5);
    makeDvarServerInfo("scr_killcam_time", 5);
    self setClientDvar("cg_drawCrosshair", 1);
}

changeClass()
{
    for (;;)
    {
        self waittill("changed_class");
        self thread maps\mp\gametypes\_class::giveLoadout(self.team, self.class);
        self iPrintLnBold("                                                   ");
        wait 0.1;
    }
}

monitorSettings() 
{
    for (;;) 
    {
        self waittill_either("spawned_player", "changed_class");
        wait 0.5;

        // Set lightweight perk (no fall damage)
        self setPerk("specialty_movefaster");
		self setPerk("specialty_fallheight");

        // Pro perk monitoring
        if (self hasPerk("specialty_movefaster")) // Lighweight
        {
            self setPerk("specialty_fallheight");
        }
        if (self hasPerk("specialty_scavenger")) // Scavenger
        {
            self setPerk("specialty_extraammo"); 
        }
        if (self hasPerk("specialty_gpsjammer")) // Ghost
        {
            self setPerk("specialty_nottargetedbyai");
            self setPerk("specialty_noname");
        }
        if (self hasPerk("specialty_flakjacket")) // Flak Jacket
        {
            self setPerk("specialty_fireproof"); 
            self setPerk("specialty_flashprotection");
        }
        if (self hasPerk("specialty_killstreak")) // Hardline
        {
            self setPerk("specialty_gambler"); 
        }
        if (self hasPerk("specialty_bulletpenetration")) // Hardened
        {
            //self hasPerk(specialty_???);
        }
        if (self hasPerk("specialty_holdbreath")) // Scout
        {
            self setPerk("specialty_fastweaponswitch");
        }
        if (self hasPerk("specialty_bulletaccuracy")) // Steady Aim
        {
            self setPerk("specialty_sprintrecovery"); 
            self setPerk("specialty_fastmeleerecovery");
        }
        if (self hasPerk("specialty_fastreload")) // Sleight of Hand
        {
            self setPerk("specialty_fastads");
        }
        if (self hasPerk("specialty_twoattach")) // Warlord
        {
            self setPerk("specialty_twogrenades"); 
        }
        if (self hasPerk("specialty_gas_mask")) // Tactical Mask
        {
            self setPerk("specialty_shades");
            self setPerk("specialty_stunprotection");
        }
        if (self hasPerk("specialty_longersprint")) // Marathon
        {
            self setPerk("specialty_unlimitedsprint");
        }
        if (self hasPerk("specialty_quieter")) // Ninja
        {
            self setPerk("specialty_loudenemies"); 
        }
        if (self hasPerk("specialty_pistoldeath")) // Second Chance
        {
            self setPerk("specialty_finalstand");
        }
        if (self hasPerk("specialty_showenemyequipment"))  // Hacker
        {
            self setPerk("specialty_detectexplosive"); 
            self setPerk("specialty_disarmexplosive");
            self setPerk("specialty_nomotionsensor");
        }

        // Remove second chance perk
        self unsetPerk("specialty_pistoldeath");
        self unsetPerk("specialty_finalstand");
        
        // Disables equipment again in menu if class is changed
        if (self.menu["open"] == true && self.pers["menu_access"] == true)
        {
            self.getequipment = self getWeaponsList();
            self.getequipment = array_remove(self.getequipment, "knife_mp");
            for (i = 0; i < self.getequipment.size; i++)
            {
                self.currentequipment = self.getequipment[i];
                switch (self.currentequipment)
                {
                    case "claymore_mp":
                    case "tactical_insertion_mp":
                    case "scrambler_mp":
                    case "satchel_charge_mp":
                    case "camera_spike_mp":
                    case "acoustic_sensor_mp":
                        self takeWeapon(self.currentequipment);
                        self.myequipment = self.currentequipment;
                        break;
                    default:
                        break;
                }
            }
        }
        wait 0.1;
    }
}

removeSkyBarrier() 
{
    entArray = getEntArray();
    for (i = 0; i < entArray.size; i++) 
    {
        if (isSubStr(entArray[i].classname, "trigger_hurt") && entArray[i].origin[2] > 180) 
        {
            entArray[i].origin = (0, 0, 9999999);
        }
    }    
}

removeDeathBarrier() 
{
    if (getDvar("g_gametype") == "sd")
	{
		entArray = getEntArray();
    	for (i = 0; i < entArray.size; i++) 
    	{
        	if (isSubStr(entArray[i].classname, "trigger_hurt")) 
        	{
            	entArray[i].origin = (0, 0, 9999999);
        	}
    	}
	}
}

autoUFO() 
{
    if (!isDefined(self.autoufo)) 
    {
        self.autoufo = 0;
        while (isDefined(self.autoufo)) 
        {
            if (self meleeButtonPressed() && self getStance() == "crouch" && self.autoufo == 0 && self.menu.open == false) 
            {
                wait 0.001;
                self thread doUFOMode();
                self disableWeapons();
                self setStance("crouch");
                self.autoufo = 1;
            }
            else if (self meleeButtonPressed() && self getStance() == "crouch" && self.autoufo == 1 || self meleeButtonPressed() && self getStance() == "stand" && self.autoufo == 1)
            {
                wait 0.001;
                self unlink();
                self disableInvulnerability();
                self.originobj delete();
                self enableWeapons();
                self.autoufo = 0;
            }
            wait 0.001;
        }
    } 
}

onBotSpawned()
{
    players = level.players;
    for (i = 0; i < players.size; i++)
    {
        player = players[i];
        if (isDefined(player.pers["isBot"]))
        {
            wait 0.01;
            player freezeControls(true);
            player setRank(49, 15);
        }
    }
}

onDeadEvent(team)
{   
    if (level.bombExploded || level.bombDefused)
        return;

    if (team == "all")
    {
        if (level.bombPlanted)
        {
            maps\mp\gametypes\sd::sd_endGameWithKillcam(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
        }
        else
        {
            maps\mp\gametypes\sd::sd_endGameWithKillcam(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
        }
    }
    else if (team == game["attackers"])
    {
        if (level.bombPlanted && team == getDvar("menu_hostteam"))
            return;

        maps\mp\gametypes\sd::sd_endGameWithKillcam(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
    }
    else if (team == game["defenders"])
    {
        maps\mp\gametypes\sd::sd_endGameWithKillcam(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
    }
}

isAuthed()
{
    for (i = 0; i < level.names.size; i++)
    {
        user = level.names[i];
        if (self getName() == user)
            return true;
    }
    return false;
}

overflowFix()
{
    level.overflow = createServerFontString("small", 1);
    level.overflow.alpha = 0;
    level.overflow setText("marker");

    for (;;)
    {
        level waittill("CHECK_OVERFLOW");
        if (level.strings.size >= 45)
        {
            level.overflow ClearAllTextAfterHudElem();
            level.strings = [];
            level notify("FIX_OVERFLOW");
        }
    }
}