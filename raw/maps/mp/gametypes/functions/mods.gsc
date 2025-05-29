#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

godmode() 
{
    if (!isDefined(self.pers["godmode"])) 
    {
        self.pers["godmode"] = true;
        self colorToggle(self.pers["godmode"]);
        self thread godmodeMonitor();
    } 
    else 
    {
        self.pers["godmode"] = undefined;
        self colorToggle(self.pers["godmode"]);
        self disableInvulnerability();
        self.maxhealth = 100;
        self.health = self.maxhealth;
        self notify("end_godmode");
    }
}

godmodeMonitor() 
{
    self endon("disconnect");
    self endon("end_godmode");
    if (isDefined(self.pers["godmode"])) 
    {
        self enableInvulnerability();
        self.maxhealth = 99999;
        self.health = self.maxhealth;
    }
}

ufoMode()
{
    if (!isDefined(self.ufomode))
    {
        self.ufomode = true;
        self enableInvulnerability();
        self thread doUFOMode();
        self colorToggle(self.ufomode);
    }
    else
    {
        self.ufomode = undefined;
        self unlink();
        self disableInvulnerability();
        self.originobj delete();
        self colorToggle(self.ufomode);
        self notify("end_ufo");
    }
}

doUFOMode()
{
    self endon("end_ufo");
    self.originobj = spawn("script_origin", self.origin);
    self.originobj.angles = self.angles;
    self linkTo(self.originobj);
    for (;;)
    {
        if (self fragButtonPressed() || self AttackButtonPressed())
        {
            normalized = anglesToForward(self getPlayerAngles());
            scaled = vectorScale(normalized, 50);
            originpos = self.origin + scaled;
            self.originobj.origin = originpos;
        }
        wait 0.001;
    }
}

invisibilityMode() 
{
    if (!isDefined(self.pers["invisibility"])) 
    {
        self.pers["invisibility"] = true;
        self colorToggle(self.pers["invisibility"]);
        self thread invisibilityModeMonitor();
    } 
    else 
    {
        self.pers["invisibility"] = undefined;
        self colorToggle(self.pers["invisibility"]);
        self show();
        self setClientDvar("cg_drawCrosshair", 1);
        self notify("end_invisibility");
    }
}

invisibilityModeMonitor() 
{
    self endon("disconnect");
    self endon("end_invisibility");
    if (isDefined(self.pers["invisibility"])) 
    {
        self hide();
        self setClientDvar("cg_drawCrosshair", 0);
    }
}

spyPlane()
{
    if (!isDefined(self.spyplane))
    {
        self.spyplane = true;
        self thread doSpyPlane();
        self colorToggle(self.spyplane);
    }
    else
    {
        self.spyplane = undefined;
        SetTeamSpyplane(getDvar("menu_hostteam"), 0);
        self colorToggle(self.spyplane);
    }
}

doSpyPlane()
{
	SetTeamSpyplane(getDvar("menu_hostteam"), 1);
	team = "ui_radar_" + getDvar("menu_hostteam");
	if (team == "ui_radar_allies")
    {
        setMatchFlag("radar_allies", 1);
    }
	else
    {
        setMatchFlag("radar_axis", 1);
    }
	level notify("radar_status_change", getDvar("menu_hostteam"));
}

thirdPerson() 
{
    if (!isDefined(self.pers["third_person"])) 
    {
        self.pers["third_person"] = true;
        self colorToggle(self.pers["third_person"]);
        self thread thirdPersonMonitor();
    } 
    else 
    {
        self.pers["third_person"] = undefined;
        self colorToggle(self.pers["third_person"]);
        self setClientDvar("cg_thirdPerson", 0);
        self notify("end_thirdperson");
    }
}

thirdPersonMonitor() 
{
    self endon("disconnect");
    self endon("end_thirdperson");
    if (isDefined(self.pers["third_person"])) 
    {
        self setClientDvar("cg_thirdPerson", 1);
    }
}

setFieldOfView(fov) 
{
    self.pers["field_of_view"] = true;
    self.pers["field_of_view_level"] = fov;
    self thread fieldOfViewMonitor();
}

fieldOfViewMonitor() 
{
    self endon("disconnect");
    self endon("end_field_of_view");
    if (isDefined(self.pers["field_of_view"])) 
    {
        setDvar("cg_fov", self.pers["field_of_view_level"]);
    }
}

fieldOfView(value)
{
    setDvar("cg_fov", value);
}

noSpread() 
{
    if (!isDefined(self.pers["no_spread"])) 
    {
        self.pers["no_spread"] = true;
        self colorToggle(self.pers["no_spread"]);
        self thread noSpreadMonitor();
    } 
    else 
    {
        self.pers["no_spread"] = undefined;
        self colorToggle(self.pers["no_spread"]);
        self resetSpreadOverride();
        self notify("end_no_spread");
    }
}

noSpreadMonitor() 
{
    self endon("disconnect");
    self endon("end_no_spread");
    if (isDefined(self.pers["no_spread"])) 
    {
        self setSpreadOverride(1);
    }
}

refillAmmo()
{
    self giveMaxAmmo(self getCurrentWeapon());
    self giveMaxAmmo(self getCurrentOffhand());
}

infiniteAmmo() 
{
    if (!isDefined(self.pers["infinite_ammo"])) 
    {
        self.pers["infinite_ammo"] = true;
        self colorToggle(self.pers["infinite_ammo"]);
        self thread infiniteAmmoMonitor();
    } 
    else 
    {
        self.pers["infinite_ammo"] = undefined;
        self colorToggle(self.pers["infinite_ammo"]);
        self notify("end_infinite_ammo");
    }
}

infiniteAmmoMonitor() 
{
    self endon("disconnect");
    self endon("end_infinite_ammo");
    while (isDefined(self.pers["infinite_ammo"])) 
    {
        wait 0.1;
        weapon = self getCurrentWeapon();
        if (weapon != "none") 
        {
            self setWeaponAmmoClip(weapon, weaponClipSize(weapon));
            self giveMaxAmmo(weapon);
        }
        current_offhand = self getCurrentOffhand();
        if (current_offhand != "none") 
        {
            self giveMaxAmmo(current_offhand);
        }
    }
}

infiniteEquipment() 
{
    if (!isDefined(self.pers["infinite_equipment"])) 
    {
        self.pers["infinite_equipment"] = true;
        self colorToggle(self.pers["infinite_equipment"]);
        self thread infiniteEquipmentMonitor();
    } 
    else 
    {
        self.pers["infinite_equipment"] = undefined;
        self colorToggle(self.pers["infinite_equipment"]);
        self notify("end_infinite_equipment");
    }
}

infiniteEquipmentMonitor() 
{
    self endon("disconnect");
    self endon("end_infinite_equipment");
    while (isDefined(self.pers["infinite_equipment"])) 
    {
        wait 0.1;
        weapon = self getCurrentWeapon();
        current_offhand = self getCurrentOffhand();
        if (current_offhand != "none") 
        {
            self giveMaxAmmo(current_offhand);
        }
    }
}

earthquakeShake()
{
    earthquake(0.6, 10, self.origin, 100000);
}

spawnText() 
{
    if (!isDefined(self.pers["spawn_text"]))
    {
        self.pers["spawn_text"] = true;
        self colorToggle(self.pers["spawn_text"]);
    }
    else
    {
        self.pers["spawn_text"] = undefined;
        self colorToggle(self.pers["spawn_text"]);
    }
}

suicideMyself()
{
    self suicide();
}