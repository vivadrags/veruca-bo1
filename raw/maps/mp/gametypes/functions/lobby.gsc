#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

setGravity(gravity_level) 
{
    self.pers["gravity"] = true;
    self.pers["gravity_level"] = gravity_level;
    self thread gravityMonitor();
}

gravityMonitor() 
{
    self endon("disconnect");
    self endon("end_gravity");
    if (isDefined(self.pers["gravity"])) 
    {
        setDvar("bg_gravity", self.pers["gravity_level"]);
    }
}

setTimescale(timescale_level) 
{
    self.pers["timescale"] = true;
    self.pers["timescale_level"] = timescale_level;
    self thread timescaleMonitor();
}

timescaleMonitor() 
{
    self endon("disconnect");
    self endon("end_timescale");
    if (isDefined(self.pers["timescale"])) 
    {
        setDvar("timescale", self.pers["timescale_level"]);

        // (Untested) I think this is only needed for PC Killcams. Console killcams are fine.
        if (getDvar("xenonGame") != "true" && getDvar("ps3Game") != "true")
        {
            level waittill("game_ended");
            setDvar("com_maxfps", 144);
        }
    }
}

setSpeed(speed_level) 
{
    self.pers["speed"] = true;
    self.pers["speed_level"] = speed_level;
    self thread speedMonitor();
}

speedMonitor() 
{
    self endon("disconnect");
    self endon("end_speed");
    if (isDefined(self.pers["speed"])) 
    {
        setDvar("g_speed", self.pers["speed_level"]);
    }
}

setbackSpeed(backspeed_level) 
{
    self.pers["backspeed"] = true;
    self.pers["back_speed_level"] = backspeed_level;
    self thread backSpeedMonitor();
}

backSpeedMonitor() 
{
    self endon("disconnect");
    self endon("end_backspeed");
    if (isDefined(self.pers["backspeed"])) 
    {
        setDvar("player_backSpeedScale", self.pers["back_speed_level"]);
    }
}

setStopSpeed(stopspeed_level) 
{
    self.pers["stop_speed"] = true;
    self.pers["stop_speed_level"] = stopspeed_level;
    self thread stopSpeedMonitor();
}

stopSpeedMonitor() 
{
    self endon("disconnect");
    self endon("end_stopspeed");
    if (isDefined(self.pers["stop_speed"])) 
    {
        setDvar("stop_speed", self.pers["stop_speed_level"]);
    }
}

laddermod() 
{
    if (!isDefined(self.pers["laddermod"])) 
    {
        self.pers["laddermod"] = true;
        self colorToggle(self.pers["laddermod"]);
        self thread laddermodMonitor();
    } 
    else 
    {
        self.pers["laddermod"] = undefined;
        self colorToggle(self.pers["laddermod"]);
        setDvar("jump_ladderPushVel", 128);
        self notify("end_laddermod");
    }
}

laddermodMonitor() 
{
    self endon("disconnect");
    self endon("end_laddermod");
    if (isDefined(self.pers["laddermod"])) 
    {
        setDvar("jump_ladderPushVel", 800);
    }
}

ladderspin() 
{
    if (!isDefined(self.pers["ladder_spin"])) 
    {
        self.pers["ladder_spin"] = true;
        self colorToggle(self.pers["ladder_spin"]);
        self thread ladderspinMonitor();
    } 
    else 
    {
        self.pers["ladder_spin"] = undefined;
        self colorToggle(self.pers["ladder_spin"]);
        setDvar("bg_ladder_yawcap", 100);
        self notify("end_ladder_spin");
    }
}

ladderspinMonitor() 
{
    self endon("disconnect");
    self endon("end_ladder_spin");
    if (isDefined(self.pers["ladder_spin"])) 
    {
        setDvar("bg_ladder_yawcap", 360);
    }
}

knockback() 
{
    if (!isDefined(self.pers["knockback"])) 
    {
        self.pers["knockback"] = true;
        self colorToggle(self.pers["knockback"]);
        self thread knockbackMonitor();
    } 
    else 
    {
        self.pers["knockback"] = undefined;
        self colorToggle(self.pers["knockback"]);
        setDvar("g_knockback", 1);
        self notify("end_knockback");
    }
}

knockbackMonitor() 
{
    self endon("disconnect");
    self endon("end_knockback");
    if (isDefined(self.pers["knockback"])) 
    {
        setDvar("g_knockback", 999999);
    }
}

killcamPlayercard() 
{
    if (!isDefined(self.pers["killcam_playercard"])) 
    {
        self.pers["killcam_playercard"] = true;
        self colorToggle(self.pers["killcam_playercard"]);
        self thread killcamPlayercardMonitor();
    } 
    else 
    {
        self.pers["killcam_playercard"] = undefined;
        self colorToggle(self.pers["killcam_playercard"]);
        setDvar("killcam_final", 0);
        self notify("end_killcam_playercard");
    }
}

killcamPlayercardMonitor() 
{
    self endon("disconnect");
    self endon("end_killcam_playercard");
    if (isDefined(self.pers["killcam_playercard"])) 
    {
        setDvar("killcam_final", 1);
    }
}

killcamSlowMotion() 
{
    if (!isDefined(self.pers["killcam_slow_motion"])) 
    {
        self.pers["killcam_slow_motion"] = true;
        self colorToggle(self.pers["killcam_slow_motion"]);
        self thread killcamSlowMotionMonitor();
    } 
    else 
    {
        self.pers["killcam_slow_motion"] = undefined;
        self colorToggle(self.pers["killcam_slow_motion"]);
        level waittill("game_ended");
        if (isDefined(self.pers["killcam_slow_motion"])) 
        {
            level waittill("game_ended");
            
            // I think this is only needed for PC Killcams. Console killcams are fine.
            if (getDvar("xenonGame") != "true" || getDvar("ps3Game") != "true")
            {
                setDvar("com_maxfps", 144);
            }
            setDvar("timescale", 1);
            self notify("end_killcam_slow_motion");
        }
    }
}

killcamSlowMotionMonitor() 
{
    self endon("disconnect");
    self endon("end_killcam_slow_motion");
    if (isDefined(self.pers["killcam_slow_motion"])) 
    {
        level waittill("game_ended");
        setDvar("com_maxfps", 65);
        setDvar("timescale", self.pers["timescale_level"]);
    }
}

longKillcam() 
{
    if (!isDefined(self.pers["long_killcam"])) 
    {
        self.pers["long_killcam"] = true;
        self colorToggle(self.pers["long_killcam"]);
        self thread longKillcamMonitor();
    } 
    else 
    {
        self.pers["long_killcam"] = undefined;
        self colorToggle(self.pers["long_killcam"]);
        setDvar("scr_killcam_time", 5);
        makeDvarServerInfo("scr_killcam_time", 5);
        self notify("end_long_killcam");
    }
}

longKillcamMonitor() 
{
    self endon("disconnect");
    self endon("end_long_killcam");
    if (isDefined(self.pers["long_killcam"])) 
    {
        setDvar("scr_killcam_time", 15);
        makeDvarServerInfo("scr_killcam_time", 15);
    }
}