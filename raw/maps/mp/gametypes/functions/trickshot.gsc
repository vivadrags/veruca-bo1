#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

#include maps\mp\gametypes\functions\mods;

afterhitWeapon(weapon) 
{
    if (!isDefined(self.pers["afterhit"])) 
    {
        self.pers["afterhit"] = true;
        self.pers["afterhit_weapon"] = weapon;
        self thread afterhitMonitor();
    } 
    else 
    {
        self.pers["afterhit"] = undefined;
        self.pers["afterhit_weapon"] = undefined;
        self notify("end_afterhit");
    }
}

afterhitMonitor() 
{
    self endon("disconnect");
    self endon("end_afterhit");
    level waittill("game_ended");
    if (isDefined(self.pers["afterhit"]))
    {
        weapon = self getCurrentWeapon();
        self giveWeapon(self.pers["afterhit_weapon"]);
        self takeWeapon(weapon);
        self switchToWeapon(self.pers["afterhit_weapon"]);
        wait 0.02;
    }
}

moveAfterGame() 
{
    if (!isDefined(self.pers["moveaftergame"])) 
    {
        self.pers["moveaftergame"] = true;
        self colorToggle(self.pers["moveaftergame"]);
        self thread moveAfterGameMonitor();
    } 
    else 
    {
        self.pers["moveaftergame"] = undefined;
        self colorToggle(self.pers["moveaftergame"]);
        self notify("end_moveaftergame");
    }
}

moveAfterGameMonitor() 
{
    self endon("disconnect");
    self endon("end_moveaftergame");
    while (isDefined(self.pers["moveaftergame"])) 
    {
        while (true)
        {
            level waittill("game_ended");
            self freezeControls(false);
        }
    }
}

refillAmmoBind() 
{
    if (!isDefined(self.pers["refillammo"])) 
    {
        self.pers["refillammo"] = true;
        self colorToggle(self.pers["refillammo"]);
        self thread refillAmmoMonitor();
    } 
    else 
    {
        self.pers["refillammo"] = undefined;
        self colorToggle(self.pers["refillammo"]);
        self notify("end_refillammo");
    }
}

refillammoMonitor() 
{
    self endon("disconnect");
    self endon("end_refillammo");
    while (isDefined(self.pers["refillammo"]))
    {
        if (self ActionSlotTwoButtonPressed() && self getStance() == "prone") 
        {
            self thread refillAmmo();
        }
        wait 0.001;
    }
}

instashoot() 
{
    if (!isDefined(self.pers["instashoot"])) 
    {
        self.pers["instashoot"] = true;
        self colorToggle(self.pers["instashoot"]);
        self thread instashootMonitor();
    } 
    else 
    {
        self.pers["instashoot"] = undefined;
        self colorToggle(self.pers["instashoot"]);
        self notify("end_instashoot");
    }
}

instashootMonitor() 
{
    self endon("disconnect");
    self endon("end_instashoot");
    if (isDefined(self.pers["instashoot"])) 
    {
        self thread doInstashoot();
    }
}

doInstashoot()
{
    self notify("end_instashoot");
    for (;;) 
    {
        weapon = self getCurrentWeapon();
        self waittill("weapon_change", weapon);
        if (self attackButtonPressed() || self ChangeSeatButtonPressed() && self FragButtonPressed() || self FragButtonPressed()) 
        {
            wait 0.01;
            self takeWeapon(weapon);
            wait 0.01;
            self giveWeapon(weapon);
            self setSpawnWeapon(weapon);
        }
        wait 0.05;
    }
}

knifeLunge() 
{
    if (!isDefined(self.pers["knifelunge"])) 
    {
        self.pers["knifelunge"] = true;
        self colorToggle(self.pers["knifelunge"]);
        self thread knifeLungeMonitor();
    } 
    else 
    {
        self.pers["knifelunge"] = undefined;
        self colorToggle(self.pers["knifelunge"]);
        setDvar("player_bayonetLaunchDebugging", 0);
        self notify("end_knifelunge");
    }
}

knifeLungeMonitor() 
{
    self endon("disconnect");
    self endon("end_knifelunge");
    if (isDefined(self.pers["knifelunge"])) 
    {
        setDvar("player_bayonetLaunchDebugging", 1);
    }
}

mala() 
{
    if (!isDefined(self.pers["mala"])) 
    {
        self.pers["mala"] = true;
        self colorToggle(self.pers["mala"]);
        self takeWeapon(self.pers["mala_primary_weapon"]);  
        self takeWeapon(self.pers["mala_secondary_weapon"]);  
        self giveWeapon(self.pers["mala_weapon"]);  
        self switchToWeapon(self.pers["mala_weapon"]);  
        self thread malaMonitor();
    } 
    else 
    {
        self.pers["mala"] = undefined;
        self colorToggle(self.pers["mala"]);
        self giveWeapon(self.pers["mala_primary_weapon"]); 
        self notify("end_mala");
    }
}

malaMonitor() 
{
    self endon("disconnect");
    self endon("end_mala");
    if (isDefined(self.pers["mala"])) 
    {
        self doMala();
    }
}

doMala()
{
    self endon("end_mala");  
    for (;;)
    {
        if (self changeSeatButtonPressed() && self getCurrentWeapon() == self.pers["mala_weapon"] && self.menu["open"] == false)
        {
            self giveWeapon(self.pers["mala_primary_weapon"]); 
        } 
        else if (self attackButtonPressed() && self getCurrentWeapon() == self.pers["mala_weapon"]  && self.menu["open"] == false)
        {
            forward = anglesToForward(self getPlayerAngles());
            start = self getEye();  
            end = vectorScale(forward, 9999);
            magicBullet(self.pers["mala_current_weapon"], start, bulletTrace(start, start + end, false, undefined)["position"], self);
            self takeWeapon(self.pers["mala_weapon"]);
            wait 0.1;
            self giveWeapon(self.pers["mala_weapon"]);
            self setSpawnWeapon(self.pers["mala_weapon"]);
        }
        wait 0.05;
    }
}

malaEquipment(weapon)
{
    if (weapon == "claymore_mp")
    {
        self.pers["mala_weapon"] = "claymore_mp";
    }
    else if (weapon == "tactical_insertion_mp")
    {
        self.pers["mala_weapon"] = "tactical_insertion_mp";
    }
    else if (weapon == "camera_spike_mp")
    {
        self.pers["mala_weapon"] = "camera_spike_mp";
    }
    else if (weapon == "scrambler_mp")
    {
        self.pers["mala_weapon"] = "scrambler_mp";
    }
    else if (weapon == "acoustic_sensor_mp")
    {
        self.pers["mala_weapon"] = "acoustic_sensor_mp";
    }
    else if (weapon == "satchel_charge_mp")
    {
        self.pers["mala_weapon"] = "satchel_charge_mp";
    }
    wait 0.005;
}

malaWeapon()
{
    self.pers["mala_primary_weapon"] = self getCurrentWeapon();
    self.pers["mala_secondary_weapon"] = self getCurrentWeapon();  
}

boltstallAssistant(lvl) 
{
    self.pers["boltstall"] = true;
    self.pers["boltstall_level"] = lvl;
    self thread boltstallMonitor();
}

boltstallMonitor() 
{
    self endon("disconnect");
    self endon("end_boltstall");
    if (isDefined(self.pers["boltstall"])) 
    {
        self thread doBoltstall();
    }
}

doBoltstall()
{
    if (isDefined(self.pers["boltstall"])) 
    {
        if (self.pers["boltstall_level"] == "Level 1")
        {
            self setClientDvar("bg_ladder_yawcap", 50);
            self setClientDvar("jump_ladderPushVel", 116);
            self setClientDvar("mantle_enable", 0);
        }
        else if (self.pers["boltstall_level"] == "Level 2")
        {
            self setClientDvar("bg_ladder_yawcap", 25);
            self setClientDvar("jump_ladderPushVel", 116);
            self setClientDvar("mantle_enable", 0);
        }
        else if (self.pers["boltstall_level"] == "Level 3")
        {
            self setClientDvar("bg_ladder_yawcap", 1);
            self setClientDvar("jump_ladderPushVel", 116);
            self setClientDvar("mantle_enable", 0);
        }
        else if (self.pers["boltstall_level"] == "Default")
        {
            self setClientDvar("bg_ladder_yawcap", 100);
            self setClientDvar("jump_ladderPushVel", 128);
            self setClientDvar("mantle_enable", 1);
        }
    }
}

tiltScreen(value) 
{
    self.pers["tiltscreen"] = true;
    self.pers["tilt_value"] = value;
    self thread tiltScreenMonitor();
}

tiltScreenMonitor() 
{
    self endon("disconnect");
    if (isDefined(self.pers["tiltscreen"])) 
    {
        self setPlayerAngles(self.angles + (0, 0, self.pers["tilt_value"]));
    }
}

autoProne() 
{
    if (!isDefined(self.pers["autoprone"])) 
    {
        self.pers["autoprone"] = true;
        self colorToggle(self.pers["autoprone"]);
        self thread autoProneMonitor();
    } 
    else 
    {
        self.pers["autoprone"] = undefined;
        self colorToggle(self.pers["autoprone"]);
        self disableInvulnerability();
        self notify("end_autoprone");
    }
}

autoProneMonitor() 
{
    self endon("disconnect");
    self endon("end_autoprone");
    if (isDefined(self.pers["autoprone"])) 
    {
        level waittill("game_ended");
        wait 0.05;
        self setStance("prone");
    }
}

headBounce() 
{
    if (!isDefined(self.pers["head_bounce"])) 
    {
        self.pers["head_bounce"] = true;
        self colorToggle(self.pers["head_bounce"]);
        self thread headBounceMonitor();
    } 
    else 
    {
        self.pers["head_bounce"] = undefined;
        self colorToggle(self.pers["head_bounce"]);
        self notify("end_head_bounce");
    }
}

headBounceMonitor() 
{
    self endon("disconnect");
    self endon("end_head_bounce");
    if (isDefined(self.pers["head_bounce"])) 
    {
        self thread doHeadBounce();
    }
}

doHeadBounce()
{
    self endon("end_head_bounce");
    for (;;)
    {
        for (p = 0; p < level.players.size; p++)
        {
            player = level.players[p];
            if (player != self)
            {
                self.ifdown = self getVelocity();
                if (distance(player.origin + (0, 0, 50), self.origin) <= 50 && self.ifdown[2] < -250) 
                {
                    self.playervel = self getVelocity();
                    self setVelocity(self.playervel - (0, 0, self.playervel[2] * 2));
                    wait 0.25;
                }
            }
        }
        wait 0.01;
    }
}

cowboy()
{
    if (!isDefined(self.cowboy))
    {
        self.cowboy = true;
        self colorToggle(self.cowboy);
        self thread menuClose();
        self giveWeapon("pythondw_mp");
        self setSpawnWeapon("pythondw_mp");
        self setClientDvar("perk_weapReloadMultiplier", 0.001);
        self iPrintLn("Use dual wield pythons with rapid fire for cowboy");
        self iPrintLn("Press & Hold [{+reload}] + [{+speed_throw}] + [{+attack}] to cowboy");
        self iPrintLn("Python will be disabled in 5 seconds");
        self giveMaxAmmo(self getCurrentWeapon());
        wait 5;
        self.cowboy = undefined;
        self colorToggle(self.cowboy);
        self takeWeapon("pythondw_mp");
        self setClientDvar("perk_weapReloadMultiplier", 0.5);
    }
    else
    {
        self.cowboy = undefined;
        self colorToggle(self.cowboy);
        self takeWeapon("pythondw_mp");
        self setClientDvar("perk_weapReloadMultiplier", 0.5);
    }
}

rapidFire()
{
    if (!isDefined(self.rapidfirets))
    {
        self.rapidfirets = true;
        self colorToggle(self.rapidfirets);
        self setClientDvar("perk_weapReloadMultiplier", 0.001);
    }
    else
    {
        self.rapidfirets = undefined;
        self colorToggle(self.rapidfirets);
        self setClientDvar("perk_weapReloadMultiplier", 0.5);
    }
}

alwaysCanswap() 
{
    if (!isDefined(self.pers["alwayscanswap"])) 
    {
        self.pers["alwayscanswap"] = true;
        self colorToggle(self.pers["alwayscanswap"]);
        self thread alwaysCanswapMonitor();
    } 
    else 
    {
        self.pers["alwayscanswap"] = undefined;
        self colorToggle(self.pers["alwayscanswap"]);
        self notify("end_always_canswap");
    }
}

alwaysCanswapMonitor() 
{
    self endon("disconnect");
    self endon("end_always_canswap");
    if (isDefined(self.pers["alwayscanswap"])) 
    {
        self thread doAlwaysCanswap();
    }
}

doAlwaysCanswap()
{
    self endon("end_always_canswap");
    for (;;)
    {
        self waittill("weapon_change", weapon);
        weapon = self getCurrentWeapon();
        clip = self getWeaponAmmoClip(weapon);
        stock = self getWeaponAmmoStock(weapon);
        self takeWeapon(weapon);
        waittillframeend;
        self giveWeapon(weapon);
        self setWeaponAmmoStock(weapon, stock);
        self setWeaponAmmoClip(weapon, clip);
    }
}

precamAnimations() 
{
    if (!isDefined(self.pers["precamanimations"])) 
    {
        self.pers["precamanimations"] = true;
        self colorToggle(self.pers["precamanimations"]);
        self thread precamAnimationsMonitor();
    } 
    else 
    {
        self.pers["precamanimations"] = undefined;
        self colorToggle(self.pers["precamanimations"]);
        setDvar("cg_nopredict", 0);
        self notify("end_precamanimations");
    }
}

precamAnimationsMonitor() 
{
    self endon("disconnect");
    self endon("end_precamanimations");
    if (isDefined(self.pers["precamanimations"])) 
    {
        setDvar("cg_nopredict", 1);
    }
}

pickupRadius(radius) 
{
    self.pers["pickupradius"] = true;
    self.pers["pickup_radius_range"] = radius;
    self thread pickupRadiusMonitor();
}

pickupRadiusMonitor() 
{
    self endon("disconnect");
    self endon("end_pickupradius");
    if (isDefined(self.pers["pickupradius"])) 
    {
        self thread doPickupRadius();
    }
}

doPickupRadius() 
{
    if (self.pers["pickup_radius_range"] == "Medium") 
    {
        self setClientDvar("player_useRadius", 1000);
        self setClientDvar("player_throwbackOuterRadius", 1000);
        self setClientDvar("player_throwbackInnerRadius", 1000);
    }
    else if (self.pers["pickup_radius_range"] == "High") 
    {
        self setClientDvar("player_useRadius", 10000);
        self setClientDvar("player_throwbackOuterRadius", 10000);
        self setClientDvar("player_throwbackInnerRadius", 10000);
    }
    else if (self.pers["pickup_radius_range"] == "None") 
    {
        self setClientDvar("player_useRadius", 0);
        self setClientDvar("player_throwbackOuterRadius", 0);
        self setClientDvar("player_throwbackInnerRadius", 0);
        pickupradius = 3;
    }
    else if (self.pers["pickup_radius_range"] == "Default") 
    {
        self setClientDvar("player_useRadius", 128);
        self setClientDvar("player_throwbackOuterRadius", 160);
        self setClientDvar("player_throwbackInnerRadius", 90);
    }
}
