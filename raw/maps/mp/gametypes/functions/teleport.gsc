#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

setMyOrigin(coords) 
{
    self setOrigin(coords);
}

setMyOriginCrouch(coords)
{
    self setStance("crouch");
    wait 0.1;
    self setOrigin(coords);
    self setStance("stand");
}

savePosition() 
{
    self.pers["location"] = self.origin;
    wait 0.05;
}

loadPosition() 
{
    self setOrigin(self.pers["location"]);
    wait 0.05;
}

saveAndLoad()
{
    if (!isDefined(self.snl))
    {
        self thread doSaveAndLoad();
        self.snl = true;
        self colorToggle(self.snl);
    }
    else
    {
        self.snl = undefined;
        self colorToggle(self.snl);
        self notify("end_save_and_load");
    }
}

doSaveAndLoad()
{
    self endon("end_save_and_load");
    for (;;)
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotThreeButtonPressed() && self getStance() == "crouch" && self.snl == 1)
            {
                self.pers["location"] = self.origin;
                self.pers["angles"] = self.angles;
            }
            else if (self ActionSlotFourButtonPressed() && self getStance() == "crouch" && self.snl == 1)
            {
                self setOrigin(self.pers["location"]); 
                self setPlayerAngles(self.pers["angles"]);
            }
        }
        wait 0.05;
    }
}

selectPosition() 
{
    self beginLocationSelection("map_mortar_selector");
    self.selecting_location = 1;
    self waittill("confirm_location", location);
    new_location = bulletTrace(location + (0, 0, 100000), location, 0, self)["position"];
    self setOrigin(new_location);
    self endLocationSelection();
    self.selecting_location = undefined;
}

teleportToCrosshair() 
{
    self setOrigin(bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, 0, self)["position"]);
}

teleportToSky()
{
    self setOrigin(self.origin + (0, 0, 25000));
}

teleportGun() 
{
    if (!isDefined(self.pers["teleport_gun"])) 
    {
        self.pers["teleport_gun"] = true;
        self colorToggle(self.pers["teleport_gun"]);
        self thread teleportGunMonitor();
    } 
    else 
    {
        self.pers["teleport_gun"] = undefined;
        self colorToggle(self.pers["teleport_gun"]);
        self notify("end_teleport_gun");
    }
}

teleportGunMonitor() 
{
    self endon("disconnect");
    self endon("end_teleport_gun");
    while (isDefined(self.pers["teleport_gun"])) 
    {
        self waittill("weapon_fired");
        self setOrigin(bulletTrace(self getTagOrigin("j_head"), self getTagOrigin("j_head") + anglesToForward(self getPlayerAngles()) * 1000000, 0, self)["position"]);
    }
}

specNade() 
{
    if (!isDefined(self.pers["spec_nade"])) 
    {
        self.pers["spec_nade"] = true;
        self colorToggle(self.pers["spec_nade"]);
        self thread specNadeMonitor();
    } 
    else 
    {
        self.pers["spec_nade"] = undefined;
        self colorToggle(self.pers["spec_nade"]);
        self.maxhealth = 100;
        self.health = self.maxhealth;
        self notify("end_spec_nade");
    }
}

specNadeMonitor() 
{
    self endon("disconnect");
    self endon("end_spec_nade");
    self setClientDvar("player_sustainammo", 1);
    self setClientDvar("bg_falldamageminheight", 9998);
    self setClientDvar("cg_drawshellshock", 0);
    while (isDefined(self.pers["spec_nade"])) 
    {
        self thread detach();
        self.maxhealth = 99999;
        self.health = self.maxhealth;
        self waittill("grenade_fire", grenade);
        self linkTo(grenade, "", (0, 0, 0), (0, 0, 40));
    }
}

rocketRide() 
{
    if (!isDefined(self.pers["rocket_ride"])) 
    {
        self.pers["rocket_ride"] = true;
        self colorToggle(self.pers["rocket_ride"]);
        self thread rocketRideMonitor();
    } 
    else 
    {
        self.pers["rocket_ride"] = undefined;
        self colorToggle(self.pers["rocket_ride"]);
        self notify("end_rocket_ride");
    }
}

rocketRideMonitor() 
{
    self endon("disconnect");
    self endon("end_rocket_ride");
    while (isDefined(self.pers["rocket_ride"])) 
    {
        self waittill("missile_fire", missile, weapon);
        weapon = self getCurrentWeapon();
        if (weapon == "m220_tow_mp" || "rpg_mp" || "m202_flash_mp")
        {
            self enableInvulnerability();
            self thread detach();
            self linkTo(missile);
            self hide();
            wait 0.1;
            self waittill("jump");
            self unlink();
            self show();
            self disableInvulnerability();
            wait 0.05;
        }
    }
}

detach()
{
    for (;;)
    {
        if (self jumpButtonPressed())
        {
            self notify("jump");
            self unlink();
        }
        wait 0.1;
    }
}