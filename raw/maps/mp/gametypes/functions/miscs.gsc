#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

/* Spawning Menu */
createBounce()
{
    level.bL[level.bounce] = self.origin;
    level.bounce++;
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        player notify("bounce_created");
    }

    self.bounces_deleted = "^1Not Cleared";
    self iPrintln("Bounce Spawned: " + self.origin);
}

deleteBounces()
{
    for (i = 0; i < level.bounce; i++)
    {
        level.BL[i] destroy();
    }
    level.bounce = 0;
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        self.bounces_deleted = "^6Cleared";
    }
}

monitorBounce()
{
    self waittill("bounce_created");
    for (;;)
    {
        for (i = 0; i < level.bounce; i++) 
        {
            if (distance(self.origin, level.bL[i]) < 70)
            {
                self thread forcePlayerBounce();
                if (self.vel[2] < 0 && self.can_bounce == true) 
                {
                    self setVelocity(self.new_vel);
                    self.can_bounce = false;
                    wait 0.1;
                    self.can_bounce = true;
                }
            }
            wait 0.01;
        }
        wait 0.01;
    }
}

forcePlayerBounce()
{
    self thread doVariables();
    self thread detectVelocity();        
}

doVariables()
{
    self.vel = 0;
    self.new_vel = 0;
    self.top_vel = 0;
    self.can_bounce = true;
}

detectVelocity()
{
    for (;;) 
    {
        self.vel = self getVelocity();
        if (!self isOnGround()) 
        {
            self.new_vel = (self.vel[0], self.vel[1], self negateBounce(self.vel[2]));
        }
        wait 0.001;
    }
}

negateBounce(vector) // Credits: CodJumper
{
    self endon("death");
    negative = vector - (vector * 2);
    return(negative);
}

spawnCarePackage()
{
    origin = bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, 0, self)["position"];
    level.carepackage = spawn("script_model", origin + (0, 0, 0));  
    self thread maps\mp\gametypes\supplydrop::dropCrate(origin + (0, 0, 0), self.angles, "supplydrop_mp", self, self.team, level.carepackage); 
}

spawnModel(type)
{
    origin = bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, 0, self)["position"];
    level.models = createModel(origin + (0, 0, 0), type);
}

spawnPlatform()
{
    level.models = createModel(self.origin + (0, 0, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (40, 0, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (80, 0, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (120, 0, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (160, 0, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-40, 0, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-80, 0, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-120, 0, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-160, 0, 0), "mp_supplydrop_ally");

    level.models = createModel(self.origin + (0, 70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (40, 70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (80, 70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (120, 70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (1660, 70, 0), "mp_suuppldrrop_ally");
    level.models = createModel(self.origin + (-40, 70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-80, 70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-120, 70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-160, 70, 0), "mp_supplydrop_ally");

    level.models = createModel(self.origin + (0, 10,  0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (40, 140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (80, 140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (120, 140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (160, 140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-40, 140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-80, 140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-120, 140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-160, 140, 0), "mp_supplydrop_ally");

    level.models = createModel(self.origin + (0, -70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (40, -70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (80, -70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (120, -70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (160, -70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-40, -70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-80, -70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-120, -70, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-160, -70, 0), "mp_supplydrop_ally");

    level.models = createModel(self.origin + (0, -140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (40, -140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (80, -140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (120, -140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (160, -140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-40, -140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-80, -140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-120, -140, 0), "mp_supplydrop_ally");
    level.models = createModel(self.origin + (-160, -140, 0), "mp_supplydrop_ally");
}

createModel(origin, model) 
{
    models = spawn("script_model", origin); 
    models setModel(model); 
    return models; 
}

forgeMode() 
{
    if (!isDefined(self.forgemode))
    {
        self.forgemode = true;
        self thread doForgeMode();
        self colorToggle(self.forgemode);
    } 
    else
    {
        self notify("end_forge");
        self.forgemode = undefined;
        self colorToggle(self.forgemode);
    }
}

doForgeMode() 
{
    self endon("end_forge");
    for (;;) 
    {
        while (self FragButtonPressed()) 
        {
            trace = bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, true, self);
            while (self FragButtonPressed()) 
            {
                trace["entity"] setOrigin(self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200);
                trace["entity"].origin = self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 200;
                wait 0.05;
            }
        }
        wait 0.05;
    }
}

/* Account Menu */
unlockAll()
{
    // Ranked Match
    level.rankedMatch = true;
    level.contractsEnabled = true;
    setDvar("onlinegame", 1);
    setDvar("xblive_rankedmatch", 1);
    setDvar("xblive_privatematch", 0);
    
    // Level 50
    self maps\mp\gametypes\_persistence::statSet("rankxp", 1262500, false);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "rankxp", 1262500);
    self.pers["rank"] = 49;
    self setRank(49);
    
    // Prestige 15
    prestige_level = 15;
    self.pers["plevel"] = prestige_level;
    self.pers["prestige"] = prestige_level;
    self setdstat("playerstatslist", "plevel", "StatValue", prestige_level);
    self maps\mp\gametypes\_persistence::statSet("plevel", prestige_level, true);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "plevel", prestige_level);
    self setRank(self.pers["rank"], prestige_level);
    
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
            self maps\mp\gametypes\_persistence::unlockItemFromChallenge("perkpro " + perk + " " + j);
        }
    }

    // Cod Points
    self maps\mp\gametypes\_persistence::statSet("codpoints", 100000000, false);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "codpoints", 100000000);
    self maps\mp\gametypes\_persistence::setPlayerStat("PlayerStatsList", "codpoints", 100000000);
    self.pers["codpoints"] = 100000000;
    
    // Items
    self setClientDvar("allItemsPurchased", 1);
    self setClientDvar("allItemsUnlocked", 1);
    
    // Emblems
    self setClientDvar("allEmblemsPurchased", 1);
    self setClientDvar("allEmblemsUnlocked", 1);
    self setClientDvar("ui_items_no_cost", 1);
    self setClientDvar("lb_prestige", 1);
    self maps\mp\gametypes\_rank::updateRankAnnounceHUD();

    // Colored Classes
    self setClientDvar("customclass1", "^6#veruca");
    self setClientDvar("customclass2", "^6#veruca");
    self setClientDvar("customclass3", "^6#veruca");
    self setClientDvar("customclass4", "^6#veruca");
    self setClientDvar("customclass5", "^6#veruca");
    self setClientDvar("prestigeclass1", "^6#veruca");
    self setClientDvar("prestigeclass2", "^6#veruca");
    self setClientDvar("prestigeclass3", "^6#veruca");
    self setClientDvar("prestigeclass4", "^6#veruca");
    self setClientDvar("prestigeclass5", "^6#veruca");
    
    self iPrintLn("Unlock All: ^6Set");
}

level50()
{
    level.rankedMatch = true;
    level.contractsEnabled = true;
    setDvar("onlinegame", 1);
    setDvar("xblive_rankedmatch", 1);
    setDvar("xblive_privatematch", 0);
    self maps\mp\gametypes\_persistence::statSet("rankxp", 1262500, true);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "rankxp", 1262500);
    self.pers["rank"] = 49;
    self setRank(49);
    self maps\mp\gametypes\_rank::updateRankAnnounceHUD();
    self iPrintLn("Level 50: ^6Set");
}

level50XPKill() 
{
    if (!isDefined(self.pers["level_50_xp_kill"])) 
    {
        self.pers["level_50_xp_kill"] = true;
        self colorToggle(self.pers["level_50_xp_kill"]);
        self thread level50XPKillMonitor();
    } 
    else 
    {
        self.pers["level_50_xp_kill"] = undefined;
        self colorToggle(self.pers["level_50_xp_kill"]);
        self setClientDvar("scr_tdm_score_kill", 100);
        self notify("end_level_50_xp_kill");
    }
}

level50XPKillMonitor() 
{
    self endon("disconnect");
    self endon("end_level_50_xp_kill");
    if (isDefined(self.pers["level_50_xp_kill"])) 
    {
        if (getDvar("g_gametype") == "tdm")
        {
            setDvar("onlinegame", 1);
            setDvar("onlinegameandhost", 1);
            setDvar("xblive_privatematch", 0);
            setDvar("xblive_rankedmatch", 1);
            level.rankedMatch = true;
            level.onlineGame = true;
            self setClientDvar("scr_tdm_score_kill", 1262500);
        }
        else
        {
            self iPrintLn("Level 50 XP Kill only works in TDM");
        }
    }
}

setPrestige(value)
{
    self maps\mp\gametypes\_persistence::statSet("plevel", int(value), true);
    self.pers["plevel"] = int(value);
    self.pers["prestige"] = int(value);
    self setdstat("playerstatslist", "plevel", "StatValue", int(value));
    self maps\mp\gametypes\_persistence::statSet("plevel", int(value), true);
    self maps\mp\gametypes\_persistence::statSetInternal("PlayerStatsList", "plevel", int(value));
    self setRank(self.pers["rank"], int(value));
    self maps\mp\gametypes\_rank::updateRankAnnounceHUD();
    self iPrintLn("Prestige " + value + " ^6Set");
}

proPerks()
{
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
            self maps\mp\gametypes\_persistence::unlockItemFromChallenge("perkpro " + perk + " " + j);
        }
    }
    self iPrintLn("Pro Perks: ^6Set");
}

codPoints(value)
{
    self maps\mp\gametypes\_persistence::statAdd("codpoints", value);
    self iPrintln("COD Points: ^6" + value);
}

coloredClass()
{
    level.rankedMatch = true;
    level.contractsEnabled = true;
    self setClientDvar("customclass1", "^6#veruca");
    self setClientDvar("customclass2", "^6#veruca");
    self setClientDvar("customclass3", "^6#veruca");
    self setClientDvar("customclass4", "^6#veruca");
    self setClientDvar("customclass5", "^6#veruca");
    self setClientDvar("prestigeclass1", "^6#veruca");
    self setClientDvar("prestigeclass2", "^6#veruca");
    self setClientDvar("prestigeclass3", "^6#veruca");
    self setClientDvar("prestigeclass4", "^6#veruca");
    self setClientDvar("prestigeclass5", "^6#veruca");
    self iPrintLn("Colored Classes: ^6Set");
}

unlockAchievements()
{
    level.rankedMatch = true;
    level.contractsEnabled = true;
    self iPrintLn("Unlocking Achievements...");
    self iPrintLn("Your game may freeze up for a little!");
    wait 1;
    Achievement[1] = "SP_WIN_CUBA";
    Achievement[2] = "SP_WIN_VORKUTA";
    Achievement[3] = "SP_WIN_PENTAGON";
    Achievement[4] = "SP_WIN_FLASHPOINT";
    Achievement[5] = "SP_WIN_KHE_SANH";
    Achievement[6] = "SP_WIN_HUE_CITY";
    Achievement[7] = "SP_WIN_KOWLOON";
    Achievement[8] = "SP_WIN_RIVER";
    Achievement[9] = "SP_WIN_FULLAHEAD";
    Achievement[10] = "SP_WIN_INTERROGATION_ESCAPE";
    Achievement[11] = "SP_WIN_UNDERWATERBASE";
    Achievement[12] = "SP_VWIN_FLASHPOINT";
    Achievement[13] = "SP_VWIN_HUE_CITY";
    Achievement[14] = "SP_VWIN_RIVER";
    Achievement[15] = "SP_VWIN_FULLAHEAD";
    Achievement[16] = "SP_VWIN_UNDERWATERBASE";
    Achievement[17] = "SP_LVL_CUBA_CASTRO_ONESHOT";
    Achievement[18] = "SP_LVL_VORKUTA_VEHICULAR";
    Achievement[19] = "SP_LVL_VORKUTA_SLINGSHOT";
    Achievement[20] = "SP_LVL_KHESANH_MISSILES";
    Achievement[21] = "SP_LVL_HUECITY_AIRSUPPORT";
    Achievement[22] = "SP_LVL_HUECITY_DRAGON";
    Achievement[23] = "SP_LVL_CREEK1_DESTROY_MG";
    Achievement[24] = "SP_LVL_CREEK1_KNIFING";
    Achievement[25] = "SP_LVL_KOWLOON_DUAL";
    Achievement[26] = "SP_LVL_RIVER_TARGETS";
    Achievement[27] = "SP_LVL_WMD_RSO";
    Achievement[28] = "SP_LVL_WMD_RELAY";
    Achievement[29] = "SP_LVL_POW_HIND";
    Achievement[30] = "SP_LVL_POW_FLAMETHROWER";
    Achievement[31] = "SP_LVL_FULLAHEAD_2MIN";
    Achievement[32] = "SP_LVL_REBIRTH_MONKEYS";
    Achievement[33] = "SP_LVL_REBIRTH_NOLEAKS";
    Achievement[34] = "SP_LVL_UNDERWATERBASE_MINI";
    Achievement[35] = "SP_LVL_FRONTEND_CHAIR";
    Achievement[36] = "SP_LVL_FRONTEND_ZORK";
    Achievement[37] = "SP_GEN_MASTER";
    Achievement[38] = "SP_GEN_FRAGMASTER";
    Achievement[39] = "SP_GEN_ROUGH_ECO";
    Achievement[40] = "SP_GEN_CROSSBOW";
    Achievement[41] = "SP_GEN_FOUNDFILMS";
    Achievement[42] = "SP_ZOM_COLLECTOR";
    Achievement[43] = "SP_ZOM_NODAMAGE";
    Achievement[44] = "SP_ZOM_TRAPS";
    Achievement[45] = "SP_ZOM_SILVERBACK";
    Achievement[46] = "SP_ZOM_CHICKENS";
    Achievement[47] = "SP_ZOM_FLAMINGBULL";
    Achievement[48] = "MP_FILM_CREATED";
    Achievement[49] = "MP_WAGER_MATCH";
    Achievement[50] = "MP_PLAY";
    Achievement[51] = "DLC1_ZOM_OLDTIMER";
    Achievement[52] = "DLC1_ZOM_HARDWAY";
    Achievement[53] = "DLC1_ZOM_PISTOLERO";
    Achievement[54] = "DLC1_ZOM_BIGBADDABOOM";
    Achievement[55] = "DLC1_ZOM_NOLEGS";
    Achievement[56] = "DLC2_ZOM_PROTECTEQUIP";
    Achievement[57] = "DLC2_ZOM_LUNARLANDERS";
    Achievement[58] = "DLC2_ZOM_FIREMONKEY";
    Achievement[59] = "DLC2_ZOM_BLACKHOLE";
    Achievement[60] = "DLC2_ZOM_PACKAPUNCH";
    Achievement[61] = "DLC3_ZOM_STUNTMAN";
    Achievement[62] = "DLC3_ZOM_SHOOTING_ON_LOCATION";
    Achievement[63] = "DLC3_ZOM_QUIET_ON_THE_SET";
    Achievement[64] = "DLC4_ZOM_TEMPLE_SIDEQUEST";
    Achievement[65] = "DLC5_ZOM_CRYOGENIC_PARTY";
    Achievement[66] = "DLC5_ZOM_BIG_BANG_THEORY";
    Achievement[67] = "DLC5_ZOM_GROUND_CONTROL";
    Achievement[68] = "DLC5_ZOM_ONE_SMALL_HACK";
    Achievement[69] = "DLC5_ZOM_ONE_GIANT_LEAP";
    Achievement[70] = "DLC5_ZOM_PERKS_IN_SPACE";
    Achievement[71] = "DLC5_ZOM_FULLY_ARMED";
    Achievement[72] = "DLC4_ZOM_ZOMB_DISPOSAL";
    Achievement[73] = "DLC4_ZOM_MONKEY_SEE_MONKEY_DONT";
    Achievement[74] = "DLC4_ZOM_BLINDED_BY_THE_FRIGHT";
    Achievement[75] = "DLC4_ZOM_SMALL_CONSOLATION";
    for (i = 1; i < 76; i++) 
    {
        self GiveAchievement(Achievement[i]);
        wait 0.2;
    }
    self iPrintLn("Achievments: ^6Unlocked");
}

derankSelf()
{
    self maps\mp\gametypes\_persistence::statSet("plevel", 0, true);
    self maps\mp\gametypes\_persistence::statSet("rankxp", 0, true);
    self iPrintLn("Derank: ^6Set");
}

/* Perks Menu */
setPerk(perk)
{
    // Perk 1
    if (perk == "Lightweight")
    {
        self setPerk("specialty_fallheight");
        self setPerk("specialty_movefaster");
    }
    else if (perk == "Scavenger")
    {
        self setPerk("specialty_extraammo");
        self setPerk("specialty_scavenger");
    }
    else if (perk == "Ghost")
    {
        self setPerk("specialty_gpsjammer");
        self setPerk("specialty_movefaster");
        self setPerk("specialty_noname");
    }
    else if (perk == "Flak Jacket")
    {
        self setPerk("specialty_flakjacket");
        self setPerk("specialty_fireproof");
        self setPerk("specialty_flashprotection");
    }
    else if (perk == "Hardline")
    {
        self setPerk("specialty_killstreak");
        self setPerk("specialty_gambler");
    }

    // Perk 2
    else if (perk == "Hardened")
    {
        self setPerk("specialty_bulletpenetration");
        // self setPerk("specialty_???");
    }
    else if (perk == "Scout")
    {
        self setPerk("specialty_holdbreath");
        self setPerk("specialty_fastweaponswitch");
    }
    else if (perk == "Steady Aim")
    {
        self setPerk("specialty_fallheight");
        self setPerk("specialty_sprintrecovery");
        self setPerk("specialty_fastmeleerecovery");
    }
    else if (perk == "Sleight Of Hand")
    {
        self setPerk("specialty_fastreload");
        self setPerk("specialty_fastads");
    }
    else if (perk == "Warlord")
    {
        self setPerk("specialty_twoattach");
        self setPerk("specialty_twogrenades");
    }

    // Perk 3
    else if (perk == "Tactical Mask")
    {
        self setPerk("specialty_shades");
        self setPerk("specialty_stunprotection");
    }
    else if (perk == "Marathon")
    {
        self setPerk("specialty_longersprint");
        self setPerk("specialty_unlimitedsprint");
    }
    else if (perk == "Ninja")
    {
        self setPerk("specialty_quieter");
        self setPerk("specialty_loudenemies");
    }
    else if (perk == "Second Chance")
    {
        self setPerk("specialty_pistoldeath");
        self setPerk("specialty_finalstand");
    }
    else if (perk == "Hacker")
    {
        self setPerk("specialty_showenemyequipment");
        self setPerk("specialty_detectexplosive");
        self setPerk("specialty_disarmexplosive");
        self setPerk("specialty_nomotionsensor");
    }
}

giveAllPerks()
{
    self setPerk("specialty_fallheight");
    self setPerk("specialty_movefaster");
    self setPerk("specialty_extraammo");
    self setPerk("specialty_scavenger");
    self setPerk("specialty_gpsjammer");
    self setPerk("specialty_movefaster");
    self setPerk("specialty_noname");
    self setPerk("specialty_flakjacket");
    self setPerk("specialty_fireproof");
    self setPerk("specialty_flashprotection");
    self setPerk("specialty_killstreak");
    self setPerk("specialty_gambler");
    self setPerk("specialty_holdbreath");
    self setPerk("specialty_fastweaponswitch");
    self setPerk("specialty_fallheight");
    self setPerk("specialty_sprintrecovery");
    self setPerk("specialty_fastmeleerecovery");
    self setPerk("specialty_fastreload");
    self setPerk("specialty_fastads");
    self setPerk("specialty_twoattach");
    self setPerk("specialty_twogrenades");
    self setPerk("specialty_shades");
    self setPerk("specialty_stunprotection");
    self setPerk("specialty_longersprint");
    self setPerk("specialty_unlimitedsprint");
    self setPerk("specialty_quieter");
    self setPerk("specialty_loudenemies");
    self setPerk("specialty_pistoldeath");
    self setPerk("specialty_finalstand");
    self setPerk("specialty_showenemyequipment");
    self setPerk("specialty_detectexplosive");
    self setPerk("specialty_disarmexplosive");
    self setPerk("specialty_nomotionsensor");
}

removeAllPerks()
{
    self unsetPerk("specialty_fallheight");
    self unsetPerk("specialty_movefaster");
    self unsetPerk("specialty_extraammo");
    self unsetPerk("specialty_scavenger");
    self unsetPerk("specialty_gpsjammer");
    self unsetPerk("specialty_movefaster");
    self unsetPerk("specialty_noname");
    self unsetPerk("specialty_flakjacket");
    self unsetPerk("specialty_fireproof");
    self unsetPerk("specialty_flashprotection");
    self unsetPerk("specialty_killsereak");
    self unsetPerk("specialty_gambler");
    self unsetPerk("specialty_holdbreath");
    self unsetPerk("specialty_fastweaponswitch");
    self unsetPerk("specialty_fallheight");
    self unsetPerk("specialty_sprintrecovery");
    self unsetPerk("specialty_fastmeleerecovery");
    self unsetPerk("specialty_fastreload");
    self unsetPerk("specialty_fastads");
    self unsetPerk("specialty_twoattach");
    self unsetPerk("specialty_twogrenades");
    self unsetPerk("specialty_shades");
    self unsetPerk("specialty_stunprotection");
    self unsetPerk("specialty_longersprint");
    self unsetPerk("specialty_unlimitedsprint");
    self unsetPerk("specialty_quieter");
    self unsetPerk("specialty_loudenemies");
    self unsetPerk("specialty_pistoldeath");
    self unsetPerk("specialty_finalstand");
    self unsetPerk("specialty_showenemyequipment");
    self unsetPerk("specialty_detectexplosive");
    self unsetPerk("specialty_disarmexplosive");
    self unsetPerk("specialty_nomotionsensor");
}

/* Fun Menu */
changeProjectile(projectile)
{
    self notify("end_projectile");
    self endon("end_projectile");
    for (;;)
    {
        self waittill("weapon_fired");
        firing = getCursorPosition();
        magicBullet(projectile, self.origin + anglesToForward(self getPlayerAngles()) * 50, firing, self);
    } 
}

changeModel(model)
{
    self.spawnedplayermodel delete();
    self.spawnedplayermodel = spawn("script_model", self.origin);
    self.spawnedplayermodel setModel(model);
    self hide();
    self.current_origin = self.origin;
    self.current_angle = self.angle;
    self.model = 1;
    for (;;)
    {
        if (self.origin != self.current_origin)
        {
            self.spawnedplayermodel moveTo(self.origin, 0.01);
            self.current_origin = self.origin;
        }
        if (self.currentangles != self.angles)
        {
            self.spawnedplayermodel rotateTo(self.angles, 0.01);
            self.currentangles = self.angles;
        }
        wait 0.01;
     }
}

changeVision(vision)
{
    visionSetNaked(vision, 1);
}

jetPack()
{
	if (!isDefined(self.jetpack))
	{
		self.jetpack = true;
		self colorToggle(self.jetpack);
		self thread doJetPack();
	}
	else
	{
		self.jetpack = undefined;
		self colorToggle(self.jetpack);
		self notify("end_jetpack");
	}
}

doJetPack()
{
    self endon("death");
	self endon("end_jetpack");
	self.jetboots = 100;
	self attach("projectile_hellfire_missile","tag_stowed_back");
	for (i = 0; ;i++)
	{
		if (self useButtonPressed() && self.jetboots > 0)
		{
		    //self playSound("veh_huey_chaff_explo_npc");
			//playFX(level._effect["flak20_fire_fx"], self getTagOrigin("J_Ankle_RI"));
			//playFx(level._effect["flak20_fire_fx"], self getTagOrigin("J_Ankle_LE"));
			//earthquake(0.15, 0.2, self gettagorigin("j_spine4"), 50);
			self.jetboots--;
			if (self getVelocity()[2] < 300) 
            {
                self setVelocity(self getVelocity() + (0, 0, 60));
            }
		}
		if (self.jetboots < 100 && !self useButtonPressed())
        {
            self.jetboots++;
        }
		wait 0.05;
	}
}

flyableJet()
{
    if (!isDefined(self.pers["flyable_jet"]))
    {
        self.pers["flyable_jet"] = true;
        self.pers["change_speed"] = 100;
        self thread doMonojet();
        self colorToggle(self.pers["flyable_jet"]);
    }
    else
    {
        self.pers["flyable_jet"] = undefined;
        self notify("end_flyable_jet");
        self thread doExitJet();
        self colorToggle(self.pers["flyable_jet"]);
    }
}

doMonojet()
{
    self endon("end_flyable_jet");
    for (;;)
    {
        if (self.pers["jet_mode"] == false)
        {
            if (self MeleeButtonPressed())
            {
                wait 0.2;
                if (self MeleeButtonPressed())
                {
                    self.pers["jet_mode"] = true;
                    self thread doFlyJet();

                    if (self.pers["hide_controls"] != true)
                    {
                        self.controls["fly_jet"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -230, 6, 1, "Fly Jet: [{+attack}]", (1, 1, 1));
                        self.controls["fire_rockets"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -215, 6, 1, "Fire Rockets: [{+speed_throw}]", (1, 1, 1));
                        self.controls["change_rocket"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -200, 6, 1, "Change Rocket: [{+actionslot 1}]", (1, 1, 1));
                        self.controls["change_speed"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -185, 6, 1, "Change Speed: [{+actionslot 3}]/[{+actionslot 4}]", (1, 1, 1));
                        self.controls["hide_controls"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -170, 6, 1, "Hide Controls: [{+actionslot 2}]", (1, 1, 1));
                    }
                    wait 0.2;
                }
            }
            
        }
        else if (self.pers["jet_mode"] == true)
        {
            if (self MeleeButtonPressed())
            {
                wait 0.2;
                if (self MeleeButtonPressed())
                {
                    self.pers["jet_mode"] = false;
                    self thread doExitJet();

                    self.controls["fly_jet"] destroy();
                    self.controls["fire_rockets"] destroy();
                    self.controls["change_rocket"] destroy();
                    self.controls["change_speed"] destroy();
                    self.controls["hide_controls"] destroy();
                    wait 0.2;
                }
            }
            if (self ActionSlotTwoButtonPressed())
            {
                if (!isDefined(self.pers["hide_controls"])) 
                {
                    self.pers["hide_controls"] = true;
                    if (isDefined(self.controls["fly_jet"])) self.controls["fly_jet"] destroy();
                    if (isDefined(self.controls["fire_rockets"])) self.controls["fire_rockets"] destroy();
                    if (isDefined(self.controls["change_rocket"])) self.controls["change_rocket"] destroy();
                    if (isDefined(self.controls["change_speed"])) self.controls["change_speed"] destroy();
                    if (isDefined(self.controls["hide_controls"])) self.controls["hide_controls"] destroy();
                }
                else 
                {
                    self.pers["hide_controls"] = undefined;
                    self.controls["fly_jet"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -230, 6, 1, "Fly Jet: [{+attack}]", (1, 1, 1));
                    self.controls["fire_rockets"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -215, 6, 1, "Fire Rockets: [{+speed_throw}]", (1, 1, 1));
                    self.controls["change_rocket"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -200, 6, 1, "Change Rocket: [{+actionslot 1}]", (1, 1, 1));
                    self.controls["change_speed"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -185, 6, 1, "Change Speed: [{+actionslot 3}]/[{+actionslot 4}]", (1, 1, 1));
                    self.controls["hide_controls"] = self createText("Objective", 1.185, "LEFT", "LEFT", -60, -170, 6, 1, "Hide Controls: [{+actionslot 2}]", (1, 1, 1));
                }
            }
            if (self ActionSlotThreeButtonPressed())
            {
                self.pers["change_speed"] -= 10;
            }
            if (self ActionSlotFourButtonPressed())
            {
                self.pers["change_speed"] += 10;
            }
        }
        wait 0.01;
    }
}

doFlyJet()
{
    self endon("jetout");
    self endon("death");
    self.weapon = self getWeaponsList();
    self.location = self.origin;
    self thread doShoot();
    self takeAllWeapons();
    self.myjet = spawn("script_model", self.origin);
    self.myjet.angles = self.angles;
    self.myjet setModel("t5_veh_jet_f4_gearup");
    self enableInvulnerability();
    self linkTo(self.myjet,"tag_origin", (-900, 0, 175), (0, 0, 0));
    self hide();
    self setClientUIVisibilityFlag("hud_visible", 0);
    self.crosshair = self createFontString("default", 2.1);
    self.crosshair setPoint("CENTER", "CENTER", 0, 0);
    self.crosshair setText("^7*");
    for (;;)
    {
        self.myjet.angles = self getPlayerAngles();
        if (self AttackButtonPressed()) // Moves jet
        {
            self.myjet moveTo(self.myjet.origin + anglesToForward(self getPlayerAngles()) * self.pers["change_speed"], 0.030);
        }
        wait 0.01;
    }
}

doExitJet()
{
    self notify("jetout");
    self unlink();
    self.myjet delete();
    self.crosshair destroy();
    self show();
    self setClientUIVisibilityFlag("hud_visible", 1);
    self setOrigin(self.location);
    self disableInvulnerability();
    for (i = 0; i <= self.weapon.size; i++)
    {
        self giveWeapon(self.weapon[i]);
    }
}

doShoot()
{
    self.gunselection = 0;
    self.jetgun = [];
    self.jetgun[0] = "strela_mp";
    self.jetgun[1] = "rpg_mp";
    self.jetgun[2] = "m72_law_mp";
    self.jetgun[3] = "m202_flash_mp";
    self endon("death");
    self endon("jetout");
    for (;;)
    {
        if (self ADSButtonPressed()) // Shoots jet gun
        {
            firing = getCursorPosition();
            MagicBullet(self.jetgun[self.gunselection], self.myjet.origin + anglesToForward(self getPlayerAngles()) * 50, firing, self);
        }
        if (self ActionSlotOneButtonPressed()) // Cycles jet gun
        {   
            if (self.gunselection == self.jetgun.size - 1)
            {
                self.gunselection = 0;
            }
            else 
            {
                self.gunselection++;
            }
            //self iPrintLnBold("Gun: ^6" + self.jetgun[self.gunselection]);
            wait 1;
        }
        wait 0.1;
    }
}

getCursorPosition()
{
    forward = self getTagOrigin("tag_eye");
    end = self thread vectorScale(anglesToForward(self getPlayerAngles()), 1000000);
    location = bulletTrace(forward, end, 0, self)["position"];
    return location;
}