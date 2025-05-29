#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

giveKillstreak(killstreak) 
{
    self maps\mp\gametypes\_hardpoints::giveKillstreak(killstreak);
}

fillKillstreaks()
{
    for (i = 0; i < 3; i++)
    {
        self thread maps\mp\gametypes\_hardpoints::giveKillstreak(stripKillstreak(self.killstreak[i]) + "_mp");
    }
}

stripKillstreak(streak)
{
    str = "";
    for (i = 11; i < streak.size; i++)
    {
        str += streak[i];
    }
    return str;
}