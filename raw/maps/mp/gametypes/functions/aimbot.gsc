#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

trickshotAimbot() 
{
    if (!isDefined(self.pers["trickshot_aimbot"])) 
    {
        self.pers["trickshot_aimbot"] = true;
        self.pers["aimbot_radius"] = 1000;
        self.pers["aimbot_weapon"] = self getCurrentWeapon();
        self colorToggle(self.pers["trickshot_aimbot"]);
        self thread trickshotAimbotMonitor();
    } 
    else 
    {
        self.pers["trickshot_aimbot"] = undefined;
        self colorToggle(self.pers["trickshot_aimbot"]);
        self notify("end_trickshot_aimbot");
    }
}

trickshotAimbotMonitor() 
{
    self endon("disconnect");
    self endon("end_trickshot_aimbot");
    while (isDefined(self.pers["trickshot_aimbot"])) 
    {
        for (;;)
        {
            wait 0.001;
            self waittill("weapon_fired");
            
            forward = self getTagOrigin("j_head");
            end = self thread vectorScale(anglesToForward(self getPlayerAngles()), 100000);
            bullet_impact = bulletTrace(forward, end, 0, self)["position"];
            
            for (i = 0; i < level.players.size; i++)
            {
                if (isDefined(self.pers["aimbot_weapon"]) && self getCurrentWeapon() == self.pers["aimbot_weapon"])
                {
                    player = level.players[i];
                    player_origin = player getOrigin();
                    
                    // Skip if it's the same player
                    if (player == self)
                        continue;
                    
                    // Skip if team-based and same team
                    if (level.teamBased && self.pers["team"] == player.pers["team"])
                        continue;
                    
                    // Skip if player is not alive
                    if (!isAlive(player))
                        continue;
                    
                    if (distance(bullet_impact, player_origin) < self.pers["aimbot_radius"])
                    {
                        if (isDefined(self.pers["aimbot_delay"]))
                        {
                            wait (self.pers["aimbot_delay"]);
                        } 
                        player thread [[level.callbackPlayerDamage]](self, self, 500, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "body", 0);
                    }
                }
            }
            wait 0.1;
        }
    }
}


aimbotWeapon(weapon)
{
    if (weapon == "Current Weapon")
    {
        self.pers["aimbot_weapon"] = self getCurrentWeapon();
    }
    else if (weapon == "All Weapons")
    {
        self.pers["aimbot_weapon"] = undefined;
    }
}

aimbotRadius(radius)
{
    self.pers["aimbot_radius"] = int(radius);
}

aimbotDelay(delay)
{
    self.pers["aimbot_delay"] = int(delay);
}

tagAimbot() 
{
    if (!isDefined(self.pers["tag_aimbot"])) 
    {
        self.pers["tag_aimbot"] = true;
        self.pers["tagweapon"] = self getCurrentWeapon();
        self colorToggle(self.pers["tag_aimbot"]);
        self thread tagAimbotMonitor();
    } 
    else 
    {
        self.pers["tag_aimbot"] = undefined;
        self colorToggle(self.pers["tag_aimbot"]);
        self notify("end_tag_aimbot");
    }
}

tagAimbotMonitor() 
{
    self endon("disconnect");
    self endon("end_tag_aimbot");
    while (isDefined(self.pers["tag_aimbot"])) 
    {
        for (;;)
        {   
            wait 0.001;
            self waittill("weapon_fired");
            
            forward = self getTagOrigin("j_head");
            end = self thread vectorScale(anglesToForward(self getPlayerAngles()), 100000);
            bullet_impact = bulletTrace(forward, end, 0, self)["position"];

            for (i = 0; i < level.players.size; i++)
            {
                if (isDefined(self.pers["tagweapon"]) && self getCurrentWeapon() == self.pers["tagweapon"])
                {
                    player = level.players[i];
                    player_origin = player getOrigin();

                    // Skip if it's the same player
                    if (player == self)
                        continue;
                    
                    // Skip if team-based and same team
                    if (level.teamBased && self.pers["team"] == player.pers["team"])
                        continue;
                    
                    // Skip if player is not alive
                    if (!isAlive(player))
                        continue;
                    
                    if (distance(bullet_impact, player_origin) < 999999)
                    {
                        player thread [[level.callbackPlayerDamage]](self, self, 1, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "body", 0);
                    }
                }
            }
            wait 0.1;   
        }
    }
}

tagWeapon(weapon)
{           
    if (weapon == "Current Weapon")
    {
        self.pers["tagweapon"] = self getCurrentWeapon();
    }
    else if (weapon == "All Weapons")
    {
        self.pers["tagweapon"] = undefined;
    }
}