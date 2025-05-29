#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

#include maps\mp\gametypes\functions\miscs; // Include for getCursorPosition

// Nacmod
nacmodBind() 
{
    if (!isDefined(self.pers["nacmod"])) 
    {
        self.pers["nacmod"] = true;
        self.pers["do_nac"] = false;
        self.pers["nacmod_weapon"] = 0;
        self.pers["nacmod_dpad"] = undefined;
        self colorToggle(self.pers["nacmod"]);
        self thread nacmodMonitor();
    } 
    else 
    {
        self.pers["nacmod"] = undefined;
        self colorToggle(self.pers["nacmod"]);
        self notify("end_nacmod");
    }
}

nacmodMonitor()
{
    self endon("disconnect");
    self endon("end_nacmod");
    primary_weapon = self getCurrentWeapon();
    secondary_weapon = self getCurrentWeapon();
    while (isDefined(self.pers["nacmod"]))
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["nacmod_dpad"] == "up")
            {
                if (self.pers["do_nac"] == false)
                {
                    if (self.pers["nacmod_weapon"] == 0) 
                    {
                        self.pers["nacmod_weapon"] = 1;
                        primary_weapon = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + primary_weapon);
                    } 
                    else if (self.pers["nacmod_weapon"] == 1) 
                    {
                        self.pers["nacmod_weapon"] = 2;
                        secondary_weapon = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + secondary_weapon);
                        self.pers["do_nac"] = true;
                    }
                }
                else
                {     
                    weapon = self getCurrentWeapon();
                    if (weapon == primary_weapon) 
                    {
                        self nacFunction(primary_weapon, secondary_weapon);
                    } 
                    else if (weapon == secondary_weapon) 
                    {
                        self nacFunction(secondary_weapon, primary_weapon);
                    }
                }
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["nacmod_dpad"] == "down")
            {
                if (self.pers["do_nac"] == false)
                {
                    if (self.pers["nacmod_weapon"] == 0) 
                    {
                        self.pers["nacmod_weapon"] = 1;
                        primary_weapon = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + primary_weapon);
                    } 
                    else if (self.pers["nacmod_weapon"] == 1) 
                    {
                        self.pers["nacmod_weapon"] = 2;
                        secondary_weapon = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + secondary_weapon);
                        self.pers["do_nac"] = true;
                    }
                }
                else
                {     
                    weapon = self getCurrentWeapon();
                    if (weapon == primary_weapon) 
                    {
                        self nacFunction(primary_weapon, secondary_weapon);
                    } 
                    else if (weapon == secondary_weapon) 
                    {
                        self nacFunction(secondary_weapon, primary_weapon);
                    }
                }
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["nacmod_dpad"] == "left")
            {
                if (self.pers["do_nac"] == false)
                {
                    if (self.pers["nacmod_weapon"] == 0) 
                    {
                        self.pers["nacmod_weapon"] = 1;
                        primary_weapon = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + primary_weapon);
                    } 
                    else if (self.pers["nacmod_weapon"] == 1) 
                    {
                        self.pers["nacmod_weapon"] = 2;
                        secondary_weapon = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + secondary_weapon);
                        self.pers["do_nac"] = true;
                    }
                }
                else
                {     
                    weapon = self getCurrentWeapon();
                    if (weapon == primary_weapon) 
                    {
                        self nacFunction(primary_weapon, secondary_weapon);
                    } 
                    else if (weapon == secondary_weapon) 
                    {
                        self nacFunction(secondary_weapon, primary_weapon);
                    }
                }
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["nacmod_dpad"] == "right")
            {
                if (self.pers["do_nac"] == false)
                {
                    if (self.pers["nacmod_weapon"] == 0) 
                    {
                        self.pers["nacmod_weapon"] = 1;
                        primary_weapon = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + primary_weapon);
                    } 
                    else if (self.pers["nacmod_weapon"] == 1) 
                    {
                        self.pers["nacmod_weapon"] = 2;
                        secondary_weapon = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + secondary_weapon);
                        self.pers["do_nac"] = true;
                    }
                }
                else
                {     
                    weapon = self getCurrentWeapon();
                    if (weapon == primary_weapon) 
                    {
                        self nacFunction(primary_weapon, secondary_weapon);
                    } 
                    else if (weapon == secondary_weapon) 
                    {
                        self nacFunction(secondary_weapon, primary_weapon);
                    }
                }
            }
        }
        wait 0.001;
    }
}

nacmodDpad(dpad)
{
    self.pers["nacmod_dpad"] = dpad;
}

nacFunction(weapona, weaponb) 
{
    clip = self getWeaponAmmoClip(weapona);
    stock = self getWeaponAmmoStock(weapona);
    self takeWeapon(weapona);
    self switchToWeapon(weaponb);
    wait 0.015;
    self giveWeapon(weapona);
    self setWeaponAmmoClip(weapona, clip);
    self setWeaponAmmoStock(weapona, stock);
}

resetNacmodWeapons()
{
    self.pers["do_nac"] = false;
    self.pers["nacmod_weapon"] = 0;
}

// Second Nacmod
secondNacmodBind() 
{
    if (!isDefined(self.pers["second_nacmod"])) 
    {
        self.pers["second_nacmod"] = true;
        self.pers["do_second_nac"] = false;
        self.pers["second_nacmod_weapon"] = 0;
        self.pers["second_nacmod_dpad"] = undefined;
        self colorToggle(self.pers["second_nacmod"]);
        self thread secondNacmodMonitor();
    } 
    else 
    {
        self.pers["second_nacmod"] = undefined;
        self colorToggle(self.pers["second_nacmod"]);
        self notify("end_secondnacmod");
    }
}

secondNacmodMonitor()
{
    self endon("disconnect");
    self endon("end_secondnacmod");
    primary_weapon = self getCurrentWeapon();
    secondary_weapon = self getCurrentWeapon();
    while (isDefined(self.pers["second_nacmod"]))
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["second_nacmod_dpad"] == "up")
            {
                if (self.pers["do_second_nac"] == false)
                {
                    if (self.pers["second_nacmod_weapon"] == 0) 
                    {
                        self.pers["second_nacmod_weapon"] = 1;
                        primary_weapon = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + primary_weapon);
                    } 
                    else if (self.pers["second_nacmod_weapon"] == 1) 
                    {
                        self.pers["second_nacmod_weapon"] = 2;
                        secondary_weapon = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + secondary_weapon);
                        self.pers["do_second_nac"] = true;
                    }
                }
                else
                {     
                    weapon = self getCurrentWeapon();
                    if (weapon == primary_weapon) 
                    {
                        self secondNacFunction(primary_weapon, secondary_weapon);
                    } 
                    else if (weapon == secondary_weapon) 
                    {
                        self secondNacFunction(secondary_weapon, primary_weapon);
                    }
                }
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["second_nacmod_dpad"] == "down")
            {
                if (self.pers["do_second_nac"] == false)
                {
                    if (self.pers["second_nacmod_weapon"] == 0) 
                    {
                        self.pers["second_nacmod_weapon"] = 1;
                        primary_weapon = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + primary_weapon);
                    } 
                    else if (self.pers["second_nacmod_weapon"] == 1) 
                    {
                        self.pers["second_nacmod_weapon"] = 2;
                        secondary_weapon = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + secondary_weapon);
                        self.pers["do_second_nac"] = true;
                    }
                }
                else
                {     
                    weapon = self getCurrentWeapon();
                    if (weapon == primary_weapon) 
                    {
                        self secondNacFunction(primary_weapon, secondary_weapon);
                    } 
                    else if (weapon == secondary_weapon) 
                    {
                        self secondNacFunction(secondary_weapon, primary_weapon);
                    }
                }
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["second_nacmod_dpad"] == "left")
            {
                if (self.pers["do_second_nac"] == false)
                {
                    if (self.pers["second_nacmod_weapon"] == 0) 
                    {
                        self.pers["second_nacmod_weapon"] = 1;
                        primary_weapon = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + primary_weapon);
                    } 
                    else if (self.pers["second_nacmod_weapon"] == 1) 
                    {
                        self.pers["second_nacmod_weapon"] = 2;
                        secondary_weapon = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + secondary_weapon);
                        self.pers["do_second_nac"] = true;
                    }
                }
                else
                {     
                    weapon = self getCurrentWeapon();
                    if (weapon == primary_weapon) 
                    {
                        self secondNacFunction(primary_weapon, secondary_weapon);
                    } 
                    else if (weapon == secondary_weapon) 
                    {
                        self secondNacFunction(secondary_weapon, primary_weapon);
                    }
                }
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["second_nacmod_dpad"] == "right")
            {
                if (self.pers["do_second_nac"] == false)
                {
                    if (self.pers["second_nacmod_weapon"] == 0) 
                    {
                        self.pers["second_nacmod_weapon"] = 1;
                        primary_weapon = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + primary_weapon);
                    } 
                    else if (self.pers["second_nacmod_weapon"] == 1) 
                    {
                        self.pers["second_nacmod_weapon"] = 2;
                        secondary_weapon = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + secondary_weapon);
                        self.pers["do_second_nac"] = true;
                    }
                }
                else
                {     
                    weapon = self getCurrentWeapon();
                    if (weapon == primary_weapon) 
                    {
                        self secondNacFunction(primary_weapon, secondary_weapon);
                    } 
                    else if (weapon == secondary_weapon) 
                    {
                        self secondNacFunction(secondary_weapon, primary_weapon);
                    }
                }
            }
        }
        wait 0.001;
    }
}

secondNacmodDpad(dpad)
{
    self.pers["second_nacmod_dpad"] = dpad;
}

secondNacFunction(weaponc, weapond) 
{
    clip = self getWeaponAmmoClip(weaponc);
    stock = self getWeaponAmmoStock(weaponc);
    self takeWeapon(weaponc);
    self switchToWeapon(weapond);
    wait 0.015;
    self giveWeapon(weaponc);
    self setWeaponAmmoClip(weaponc, clip);
    self setWeaponAmmoStock(weapond, stock);
}

resetSecondNacmodWeapons()
{
    self.pers["do_second_nac"] = false;
    self.pers["second_nacmod_weapon"] = 0;
}

// ShaxSwap
shaxSwapBind() 
{
    if (!isDefined(self.pers["shax_swap"])) 
    {
        self.pers["shax_swap_dpad"] = undefined;
        self.pers["shax_swap"] = true;
        self colorToggle(self.pers["shax_swap"]);
        self thread shaxSwapMonitor();
    } 
    else 
    {
        self.pers["shax_swap"] = undefined;
        self colorToggle(self.pers["shax_swap"]);
        self notify("end_shax_swap");
    }
}

shaxSwapMonitor()
{
    self endon("disconnect");
    self endon("end_shax_swap");
    while (isDefined(self.pers["shax_swap"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["shax_swap_dpad"] == "up") 
            {
                self thread doShaxSwap();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["shax_swap_dpad"] == "down") 
            {
                self thread doShaxSwap();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["shax_swap_dpad"] == "left") 
            {
                self thread doShaxSwap();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["shax_swap_dpad"] == "right") 
            {
                self thread doShaxSwap();
            }
        }
        wait 0.001;
    }
}

shaxSwapDpad(dpad)
{
    self.pers["shax_swap_dpad"] = dpad;
}

shaxSwapWeapon()
{
    self.pers["shax_swap_weapon_chosen"] = true;
    self.pers["shax_gun"] = self getCurrentWeapon();
    self iPrintLn("Shax Weapon: ^6" + self.pers["shax_gun"]);
}

shaxSwapKillcam()
{
    if (isSubStr(self.pers["shax_gun"], "skorpion"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.4;
    }
    else if (isSubStr(self.pers["shax_gun"], "mp5k"))
    {
        self.pers["shax_gun_check"] = 0.9;
        self.pers["shax_take_away"] = 0.46; 
    }
    else if (isSubStr(self.pers["shax_gun"], "ak74u"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.37;
    }
    else if (isSubStr(self.pers["shax_gun"], "pm63"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.26;
    }
    else if (isSubStr(self.pers["shax_gun"], "spectre"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.34;
    }
    else if (isSubStr(self.pers["shax_gun"], "mac11"))
    {
        self.pers["shax_gun_check"] = 0.9;
        self.pers["shax_take_away"] = 0.41;
    }
    else if (isSubStr(self.pers["shax_gun"], "kiparis"))
    {
        self.pers["shax_gun_check"] = 0.78;
        self.pers["shax_take_away"] = 0.4;
    }
    else if (isSubStr(self.pers["shax_gun"], "mpl"))
    {
        self.pers["shax_gun_check"] = 0.9;
        self.pers["shax_take_away"] = 0.4;
    }
    else if (isSubStr(self.pers["shax_gun"], "uzi"))
    {
        self.pers["shax_gun_check"] = 0.85;
        self.pers["shax_take_away"] = 0.58;
    }
    else if (isSubStr(self.pers["shax_gun"], "fnfal"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.45;
    }
    else if (isSubStr(self.pers["shax_gun"], "m16"))
    {
        self.pers["shax_gun_check"] = 0.8;
        self.pers["shax_take_away"] = 0.32;
    }
    else if (isSubStr(self.pers["shax_gun"], "enfield"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.45;
    }
    else if (isSubStr(self.pers["shax_gun"], "m14"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.523;
    }
    else if (isSubStr(self.pers["shax_gun"], "famas"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.395;
    }
    else if (isSubStr(self.pers["shax_gun"], "galil"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.59;
    }
    else if (isSubStr(self.pers["shax_gun"], "aug"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.364;
    }
    else if (isSubStr(self.pers["shax_gun"], "ak47"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.43;
    }
    else if (isSubStr(self.pers["shax_gun"], "commando"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.22;
    }
    else if (isSubStr(self.pers["shax_gun"], "g11"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.43;
    }
    else if (isSubStr(self.pers["shax_gun"], "rottweil72"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.8;
    }
    else if (isSubStr(self.pers["shax_gun"], "ithaca"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.71;
    }
    else if (isSubStr(self.pers["shax_gun"], "spas"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 2.13;
    }
    else if (isSubStr(self.pers["shax_gun"], "hs10"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 1.04;
    }
    else if (isSubStr(self.pers["shax_gun"], "hk21"))
    {
        self.pers["shax_gun_check"] = 1.2;
        self.pers["shax_take_away"] = 0.71;
    }
    else if (isSubStr(self.pers["shax_gun"], "rpk"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 1.5;
    }
    else if (isSubStr(self.pers["shax_gun"], "m60"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 3.2;
    }
    else if (isSubStr(self.pers["shax_gun"], "stoner63"))
    {
        self.pers["shax_gun_check"] = 1.2;
        self.pers["shax_take_away"] = 0.55;
    }
    else if (isSubStr(self.pers["shax_gun"], "dragunov"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.53;
    }
    else if (isSubStr(self.pers["shax_gun"], "wa2000"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.57;
    }
    else if (isSubStr(self.pers["shax_gun"], "l96a1"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.55;
    }
    else if (isSubStr(self.pers["shax_gun"], "psg1"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 0.53;
    }
    else if (isSubStr(self.pers["shax_gun"], "asp"))
    {
        self.pers["shax_gun_check"] = 0.2;
        self.pers["shax_take_away"] = 0.4;
    }
    else if (isSubStr(self.pers["shax_gun"], "m1911"))
    {
        self.pers["shax_gun_check"] = 0.2;
        self.pers["shax_take_away"] = 0.7;
    }
    else if (isSubStr(self.pers["shax_gun"], "makarov"))
    {
        self.pers["shax_gun_check"] = 0.2;
        self.pers["shax_take_away"] = 0.7;
    }
    else if (isSubStr(self.pers["shax_gun"], "python"))
    {
        self.pers["shax_gun_check"] = 1;
        self.pers["shax_take_away"] = 1.83;
    }
    else if (isSubStr(self.pers["shax_gun"], "cz75"))
    {
        self.pers["shax_gun_check"] = 0.2;
        self.pers["shax_take_away"] = 0.7;
    }
    else
    {
        self.pers["shax_gun_check"] = 0;
        self.pers["shax_take_away"] = 0;
        self iPrintLn("Shax swap does not work with this weapon");
    }
}

doShaxSwap()
{
    if (self.pers["shax_swap_weapon_chosen"] == false)
    {
        self iPrintLn("Must select shax swap weapon");
        return;
    }
    weapon = self getCurrentWeapon();
    stock = self getWeaponAmmoStock(self.pers["shax_gun"]);
    self thread shaxSwapKillcam();
    self giveWeapon(self.pers["shax_gun"]);
    self switchToWeapon(self.pers["shax_gun"]);
    self setWeaponAmmoClip(self.pers["shax_gun"], 0);
    wait 0.05;
    self setSpawnWeapon(self.pers["shax_gun"]);
    wait self.pers["shax_gun_check"];
    self setWeaponAmmoStock(self.pers["shax_gun"], stock);
    wait self.pers["shax_take_away"];
    self takeWeapon(self.pers["shax_gun"]);
    wait 0.05;
    self switchToWeapon(weapon);
}

// Canswap
canswapBind() 
{
    if (!isDefined(self.pers["canswap"])) 
    {
        self.pers["canswap_dpad"] = undefined;
        self.pers["canswap"] = true;
        self colorToggle(self.pers["canswap"]);
        self thread canswapMonitor();
    } 
    else 
    {
        self.pers["canswap"] = undefined;
        self colorToggle(self.pers["canswap"]);
        self notify("end_canswap");
    }
}

canswapMonitor()
{
    self endon("disconnect");
    self endon("end_canswap");
    while (isDefined(self.pers["canswap"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["canswap_dpad"] == "up") 
            {
                self thread doCanswap();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["canswap_dpad"] == "down") 
            {
                self thread doCanswap();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["canswap_dpad"] == "left") 
            {
                self thread doCanswap();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["canswap_dpad"] == "right") 
            {
                self thread doCanswap();
            }
        }
        wait 0.001;
    }
}

canswapDpad(dpad)
{
    self.pers["canswap_dpad"] = dpad;
}

doCanswap()
{
    weapon = self getCurrentWeapon();
    self takeWeapon(weapon);
    self giveWeapon(weapon);
}

// Flicker
flickerBind() 
{
    if (!isDefined(self.pers["flicker"])) 
    {
        self.pers["flicker_dpad"] = undefined;
        self.pers["flicker"] = true;
        self colorToggle(self.pers["flicker"]);
        self thread flickerMonitor();
    } 
    else 
    {
        self.pers["flicker"] = undefined;
        self colorToggle(self.pers["flicker"]);
        self notify("end_flicker");
    }
}


flickerMonitor()
{
    self endon("disconnect");
    self endon("end_flicker");
    while (isDefined(self.pers["flicker"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["flicker_dpad"] == "up") 
            {
                self thread doFlicker();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["flicker_dpad"] == "down") 
            {
                self thread doFlicker();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["flicker_dpad"] == "left") 
            {
                self thread doFlicker();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["flicker_dpad"] == "right") 
            {
                self thread doFlicker();
            }
        }
        wait 0.001;
    }
}

flickerDpad(dpad)
{
    self.pers["flicker_dpad"] = dpad;
}

doFlicker()
{
    if (self.pers["flicker_weapon_chosen"] == false)
    {
        self iPrintLn("Must select flicker weapon");
        return;
    }
    self giveWeapon(self.pers["flicker_weapon"]);
    self setSpawnWeapon(self.pers["flicker_weapon"]);
    wait 0.4;
    self takeWeapon(self.pers["flicker_weapon"]);
}

flickerWeapon(weapon)
{
    self.pers["flicker_weapon_chosen"] = true;
    self.pers["flicker_weapon"] = weapon;
}

// Upsidedown Screen 
upsideDownScreenBind() 
{
    if (!isDefined(self.pers["upside_down_screen"])) 
    {
        self.pers["upside_down_screen_dpad"] = undefined;
        self.pers["upside_down_screen"] = true;
        self colorToggle(self.pers["upside_down_screen"]);
        self thread upsideDownScreenMonitor();
    } 
    else 
    {
        self.pers["upside_down_screen"] = undefined;
        self colorToggle(self.pers["upside_down_screen"]);
        self notify("end_upside_down_screen");
    }
}
upsideDownScreenMonitor()
{
    self endon("disconnect");
    self endon("end_upside_down_screen");
    while (isDefined(self.pers["upside_down_screen"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["upside_down_screen_dpad"] == "up") 
            {
                self thread doUpsidedownScreen();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["upside_down_screen_dpad"] == "down") 
            {
                self thread doUpsidedownScreen();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["upside_down_screen_dpad"] == "left") 
            {
                self thread doUpsidedownScreen();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["upside_down_screen_dpad"] == "right") 
            {
                self thread doUpsidedownScreen();
            }
        }
        wait 0.001;
    }
}

upsidedownScreenDpad(dpad)
{
    self.pers["upside_down_screen_dpad"] = dpad;
}

doUpsidedownScreen()
{
    self setPlayerAngles((self getPlayerAngles()[0], self getPlayerAngles()[1], self getPlayerAngles()[2] + 180));
}

// Capture
captureBind() 
{
    if (!isDefined(self.pers["capture"])) 
    {
        self.pers["capture_dpad"] = undefined;
        self.pers["capture"] = true;
        self.pers["capturing"] = false; 
        self.pers["capture_speed"] = 0.50;
        self.pers["capture_killstreak"] = "radar_mp";
        self.pers["capture_text"] = "Capturing Crate";
        self.pers["stall_mid_air"] = false;
        self colorToggle(self.pers["capture"]);
        self thread captureMonitor();
    } 
    else 
    {
        self.pers["capture"] = undefined;
        self colorToggle(self.pers["capture"]);
        self notify("end_capture");
    }
}


captureMonitor()
{
    while (isDefined(self.pers["capture"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["capture_dpad"] == "up" && self.pers["capturing"] == false) 
            {
                self thread doCapture();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["capture_dpad"] == "down" && self.pers["capturing"] == false) 
            {
                self thread doCapture();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["capture_dpad"] == "left" && self.pers["capturing"] == false) 
            {
                self thread doCapture();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["capture_dpad"] == "right" && self.pers["capturing"] == false) 
            {
                self thread doCapture();
            }   
        }
        wait 0.001;
    } 
}

captureDpad(dpad)
{
    self.pers["capture_dpad"] = dpad;
}

doCapture() 
{
    self.pers["capturing"] = true; 
    duration = self.pers["capture_speed"];
    bar = createPrimaryProgressBar();
    progress_bar_text = createPrimaryProgressBarText();
    bar setPoint("CENTER", "CENTER", 0, -85);
    progress_bar_text setPoint("CENTER", "CENTER", 0, -100);
    
    progress_bar_text setText(self.pers["capture_text"]);
    bar updateBar(0, 1 / duration);
    bar.color = (0, 0, 0);
    bar.bar.color = (1, 1, 1);
    
    self setClientDvar("cg_drawCrosshair", 0);
    
    if (self.pers["stall_mid_air"] == true)
    {
        self.originobj = spawn("script_origin", self.origin);
        self.originobj.angles = self.angles;
        self linkTo(self.originobj);
    }
    
    for (wait_time = 0; wait_time < duration && isAlive(self) && !level.gameEnded; wait_time += 0.05)
    wait (0.05);
    self maps\mp\gametypes\_hardpoints::giveKillstreak(self.pers["capture_killstreak"]);
    bar destroyElem();
    progress_bar_text destroyElem();
    
    self setClientDvar("cg_drawCrosshair", 1);
    
    self.originobj delete();
    
    self.pers["capturing"] = false;
}

captureBarText(text) 
{
    self.pers["capture_text"] = text;
}

captureSpeed(speed)
{
    if (speed == "Fast")
    {
        self.pers["capture_speed"] = 0.50;
    }
    else if (speed == "Slow")
    {
        self.pers["capture_speed"] = 3.0;
    }
}

captureKillstreak(killstreak)
{
    self.pers["capture_killstreak"] = killstreak;
}

stallMidair(status)
{
    if (status == "Enabled")
    {
        self.pers["stall_mid_air"] = true;
        self.originobj delete();
    }
    else if (status == "Disabled")
    {
        self.pers["stall_mid_air"] = false;
        self.originobj delete();
    }
}

// Fade
fadeBind() 
{
    if (!isDefined(self.pers["fade"])) 
    {
        self.pers["fade_dpad"] = undefined;
        self.pers["fade"] = true;
        self colorToggle(self.pers["fade"]);
        self thread fadeMonitor();
    } 
    else 
    {
        self.pers["fade"] = undefined;
        self colorToggle(self.pers["fade"]);
        self notify("end_fade");
    }
}


fadeMonitor()
{
    self endon("disconnect");
    self endon("end_fade");
    while (isDefined(self.pers["fade"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["fade"] == "up")
            {
                self thread doFade(0.0, 0.8, 0.01, 0.5);
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["fade"] == "down")
            {
                self thread doFade(0.0, 0.8, 0.01, 0.5);
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["fade"] == "left")
            {
                self thread doFade(0.0, 0.8, 0.01, 0.5);
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["fade"] == "right")
            {
                self thread doFade(0.0, 0.8, 0.01, 0.5);
            }
        }
        wait 0.001;
    }
}

fadeDpad(dpad)
{
    self.pers["fade"] = dpad;
}

fadeType(type)
{
    self.pers["fade_type"] = type;
}

doFade(start_wait, fade_screen_wait, fade_in_time, fade_out_time)
{
    wait (start_wait);
    if (!isdefined(self.fade_screen)) 
    {
        self.fade_screen = newClientHudElem(self);
    }
    self.fade_screen.x = 0;
    self.fade_screen.y = 0;
    self.fade_screen.horzalign = "fullscreen";
    self.fade_screen.vertalign = "fullscreen";
    self.fade_screen.foreground = false;
    self.fade_screen.hidewhendead = false;
    self.fade_screen.hidewheninmenu = true;
    self.fade_screen.sort = 50;
    if (self.pers["fade_type"] == "White")
    {
        self.fade_screen setShader("white", 640, 480);
    }
    else if (self.pers["fade_type"] == "Black")
    {
       self.fade_screen setShader("black", 640, 480);
    }
    else if (self.pers["fade_type"] == "Valkyrie")
    {
        self.fade_screen setShader("tow_filter_overlay_no_signal", 640, 480);
    }
    self.fade_screen.alpha = 0;
    if (fade_in_time > 0) 
    {
        self.fade_screen fadeOverTime(fade_in_time);
        self.fade_screen.alpha = 1;
        wait (fade_in_time);
    }
    if (!isdefined(self.fade_screen)) 
    {
        return;
    }
    wait (fade_screen_wait);
    if (!isdefined(self.fade_screen)) 
    {
        return;
    }
    if (fade_out_time > 0) 
    {
        self.fade_screen fadeOverTime(fade_out_time);
        self.fade_screen.alpha = 0;
        wait (fade_out_time);
    }
    if (isdefined(self.fade_screen)) 
    {
        self.fade_screen destroy();
        self.fade_screen = undefined;
    }
}

// Cowboy
cowboyBind() 
{
    if (!isDefined(self.pers["cowboy_bind"])) 
    {
        self iPrintLn("Use bind for dual wield pythons with rapid fire for cowboy");
        self iPrintLn("Press & Hold [{+reload}] + [{+speed_throw}] + [{+attack}] to cowboy");
        self iPrintLn("Python disables in 5 seconds");
        self.pers["cowboy_dpad"] = undefined;
        self.pers["cowboy_bind"] = true;
        self colorToggle(self.pers["cowboy_bind"]);
        self thread cowboyMonitor();
    } 
    else 
    {
        self.pers["cowboy_bind"] = undefined;
        self colorToggle(self.pers["cowboy_bind"]);
        self takeWeapon("pythondw_mp");
        self setClientDvar("perk_weapReloadMultiplier", 0.5);
        self notify("end_cowboy");
    }
}
cowboyMonitor()
{
    self endon("disconnect");
    self endon("end_cowboy");
    while (isDefined(self.pers["cowboy_bind"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["cowboy_dpad"] == "up") 
            {
                self thread doCowboy();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["cowboy_dpad"] == "down") 
            {
                self thread doCowboy();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["cowboy_dpad"] == "left") 
            {
                self thread doCowboy();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["cowboy_dpad"] == "right") 
            {
                self thread doCowboy();
            }
        }
        wait 0.001;
    }
}

cowboyDpad(dpad)
{
    self.pers["cowboy_dpad"] = dpad;
}

doCowboy()
{
    self giveWeapon("pythondw_mp");
    self setSpawnWeapon("pythondw_mp");
    self setClientDvar("perk_weapReloadMultiplier", 0.001);
    self giveMaxAmmo(self getCurrentWeapon());
    wait 5;
    self takeWeapon("pythondw_mp");
    self setClientDvar("perk_weapReloadMultiplier", 0.5);
}

// Repeater
repeaterBind() 
{
    if (!isDefined(self.pers["repeater"])) 
    {
        self.pers["repeater_dpad"] = undefined;
        self.pers["repeater"] = true;
        self colorToggle(self.pers["repeater"]);
        self thread repeaterMonitor();
    } 
    else 
    {
        self.pers["repeater"] = undefined;
        self colorToggle(self.pers["repeater"]);
        self notify("end_repeater");
    }
}

repeaterMonitor()
{
    self endon("disconnect");
    self endon("end_repeater");
    while (isDefined(self.pers["repeater"])) 
    {
        if (self ActionSlotOneButtonPressed() && self.pers["repeater_dpad"] == "up") 
        {
            self thread doRepeater();
        }
        if (self ActionSlotTwoButtonPressed() && self.pers["repeater_dpad"] == "down") 
        {
            self thread doRepeater();
        }
        if (self ActionSlotThreeButtonPressed() && self.pers["repeater_dpad"] == "left") 
        {
            self thread doRepeater();
        }
        if (self ActionSlotFourButtonPressed() && self.pers["repeater_dpad"] == "right") 
        {
            self thread doRepeater();
        }
        wait 0.001;
    }
}

repeaterDpad(dpad)
{
    self.pers["repeater_dpad"] = dpad;
}

doRepeater()
{
    weapon = self getCurrentWeapon();
    clip = self getWeaponAmmoClip(weapon);
    stock = self getWeaponAmmoStock(weapon);
    random_int = randomIntRange(0, 1);
    self takeWeapon(weapon);
    self giveWeapon(weapon, random_int);
    self switchToWeapon(weapon);
    self setSpawnWeapon(weapon);
    self setWeaponammoClip(weapon, clip);
    self setWeaponammoStock(weapon, stock);
}

// Rapid Fire
rapidFireBind() 
{
    if (!isDefined(self.pers["rapid_fire"])) 
    {
        self.pers["rapid_fire_dpad"] = undefined;
        self.pers["rapid_fire"] = true;
        self colorToggle(self.pers["rapid_fire"]);
        self thread rapidFireMonitor();
    } 
    else 
    {
        self.pers["rapid_fire"] = undefined;
        self colorToggle(self.pers["rapid_fire"]);
        self setClientDvar("perk_weapReloadMultiplier", 0.5);
        self notify("end_rapid_fire");
    }
}

rapidFireMonitor()
{
    self endon("disconnect");
    self endon("end_rapid_fire");
    while (isDefined(self.pers["rapid_fire"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["rapid_fire_dpad"] == "up") 
            {
                self thread doRapidFire();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["rapid_fire_dpad"] == "down") 
            {
                self thread doRapidFire();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["rapid_fire_dpad"] == "left") 
            {
                self thread doRapidFire();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["rapid_fire_dpad"] == "right") 
            {
                self thread doRapidFire();
            }
        }
        wait 0.001;
    }
}

rapidFireDpad(dpad)
{
    self.pers["rapid_fire_dpad"] = dpad;
}

doRapidFire()
{
    if (!isDefined(self.pers["rapid_firing"]))
    {
        self setPerk("specialty_fastreload");
        self setClientDvar("perk_weapReloadMultiplier", 0.001);
        self thread rapidFireInfiniteAmmo();
        self.pers["rapid_firing"] = true;
    }
    else if (isDefined(self.pers["rapid_firing"])) 
    {
        self setClientDvar("perk_weapReloadMultiplier", 0.5);
        self notify("end_infinite_ammo");
        self.pers["rapid_firing"] = undefined;
    }
}

rapidFireInfiniteAmmo()
{
    self endon("disconnect");
    self endon("end_infinite_ammo");
    for (;;)
    {
        wait 0.1;
        weapon = self getCurrentWeapon();
        if (weapon != "none") 
        {
            self setWeaponAmmoClip(weapon, weaponClipSize(weapon));
            self giveMaxAmmo(weapon);
        }
    }
}

// Bolt Movement
boltMovementBind() 
{
    if (!isDefined(self.pers["bolt_movement"])) 
    {
        self.pers["bolt_movement_dpad"] = undefined;
        self.pers["bolt_movement"] = true;
        self colorToggle(self.pers["bolt_movement"]);
        self thread boltMovementMonitor();
    } 
    else 
    {
        self.pers["bolt_movement"] = undefined;
        self colorToggle(self.pers["bolt_movement"]);
        self.pers["bolt_speed_chosen"] = false;
        self notify("end_boltmovement");
    }
}

boltMovementMonitor()
{
    self endon("disconnect");
    self endon("end_boltmovement");
    while (isDefined(self.pers["bolt_movement"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["bolt_movement_dpad"] == "up") 
            {
                self thread doBoltMovement();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["bolt_movement_dpad"] == "down") 
            {
                self thread doBoltMovement();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["bolt_movement_dpad"] == "left") 
            {
                self thread doBoltMovement();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["bolt_movement_dpad"] == "right") 
            {
                self thread doBoltMovement();
            }
        }
        wait 0.005;
    }
}

boltMovementDpad(dpad)
{
    self.pers["bolt_movement_dpad"] = dpad;
}

doBoltMovement()
{
    self endon("detach_bolt");
    if (!self.pers["bolt_stalling"])
    {
        if (self.pers["pos_count"] == 0)
        {
            self iPrintLn("Must select position(s)");
            return;
        }
        if (self.pers["bolt_speed_chosen"] == false)
        {
            self iPrintLn("Must select speed");
            return;
        }
        bolt_model = spawn("script_model", self.origin);
        bolt_model setModel("tag_origin");
        self.pers["bolt_stalling"] = true;
        setDvar("cg_nopredict", 1);
        wait 0.05;
        self linkTo(bolt_model);
        self thread boltDetach(bolt_model);
        for (i = 1; i < self.pers["pos_count"] + 1 ; i++)
        {
            bolt_model moveTo(self.pers["bolt_origin"][i],(self.pers["bolt_speed"])/self.pers["pos_count"], 0, 0);
            wait ((self.pers["bolt_speed"]) / self.pers["pos_count"]);
        }
        self unlink();
        bolt_model delete();
        self.pers["bolt_stalling"] = false;
        setDvar("cg_nopredict", 0);
    }
}

boltDetach(model)
{
    if (self jumpButtonPressed() || self changeSeatButtonPressed())
    {
        self unlink();
        model delete();
        self.pers["bolt_stalling"] = false;
        self notify("detach_bolt");
        setDvar("cg_nopredict", 0);
    }
}

saveBoltMovementPosition()
{
    self.pers["pos_count"] += 1;
    self.pers["bolt_origin"][self.pers["pos_count"]] = self getOrigin();
    self iPrintLn("Position ^6" + self.pers["pos_count"] + "^7 Saved");
}

deleteBoltMovementPosition()
{
    if (self.pers["pos_count"] == 0)
    {
        self iPrintLn("No positions to delete");
    }
    else
    {
        self.pers["bolt_origin"][self.pers["pos_count"]] = undefined;
        self iPrintLn("Position ^6" + self.pers["pos_count"] + "^7Deleted");
        self.pers["pos_count"] -= 1;
    }
}

setBoltMovementSpeed(speed)
{
    self.pers["bolt_speed_chosen"] = true;
    self.pers["bolt_speed"] = float(speed);
}

// Scavenger
scavengerBind() 
{
    if (!isDefined(self.pers["scavenger"])) 
    {
        self.pers["scavenger_dpad"] = undefined;
        self.pers["scavenger"] = true;
        self colorToggle(self.pers["scavenger"]);
        self thread scavengerMonitor();
    } 
    else 
    {
        self.pers["scavenger"] = undefined;
        self colorToggle(self.pers["scavenger"]);
        self notify("end_scavenger");
    }
}

scavengerMonitor()
{
    self endon("disconnect");
    self endon("end_scavenger");
    while (isDefined(self.pers["scavenger"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["scavenger_dpad"] == "up") 
            {
                self thread doScavengerPack();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["scavenger_dpad"] == "down") 
            {
                self thread doScavengerPack();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["scavenger_dpad"] == "left") 
            {
                self thread doScavengerPack();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["scavenger_dpad"] == "right") 
            {
                self thread doScavengerPack();
            }
        }
        wait 0.001;
    }
}

scavengerDpad(dpad)
{
    self.pers["scavenger_dpad"] = dpad;
}

doScavengerPack()
{
    if (isSubStr(self getCurrentWeapon(), "l96a1")) 
    {
        self thread scavengerPackThink();
        self.pers["stock"] = 5;
    }
    if (isSubStr(self getCurrentWeapon(), "ithaca")) 
    {
        self thread scavengerPackThink();
        self.pers["stock"] = 4;
    }
    if (isSubStr(self getCurrentWeapon(), "knife_ballistic")) 
    {
        self thread scavengerPackThink();
        self.pers["stock"] = 1;
    }
    if (isSubStr(self getCurrentWeapon(), "rpg")) 
    {
        self thread scavengerPackThink();
        self.pers["stock"] = 1;
    }
}

scavengerPackThink() 
{
    // Play scavenger pickup spound
    self playSound("fly_equipment_pickup_npc");
    self playLocalSound("fly_equipment_pickup_plr");

    // Show scavenger icon
    self.scavenger_icon.alpha = 1;
    self.scavenger_icon fadeOverTime(2.5);
    self.scavenger_icon.alpha = 0;

    // Get current weapon and set ammo stock
    weapon = self getCurrentWeapon();
    self setWeaponAmmoStock(weapon, self.pers["stock"]);
}

// Class Change
classChangeBind() 
{
    if (!isDefined(self.pers["class_change"])) 
    {
        self.pers["class_change_dpad"] = undefined;
        self.pers["class_change"] = true;
        self colorToggle(self.pers["class_change"]);
        self thread classChangeMonitor();
    } 
    else 
    {
        self.pers["class_change"] = undefined;
        self colorToggle(self.pers["class_change"]);
        self notify("end_class_change");
    }
}

classChangeMonitor()
{
    self endon("disconnect");
    self endon("end_class_change");
    while (isDefined(self.pers["class_change"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["class_change_dpad"] == "up") 
            {
                self thread doClassChange();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["class_change_dpad"] == "down") 
            {
                self thread doClassChange();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["class_change_dpad"] == "left") 
            {
                self thread doClassChange();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["class_change_dpad"] == "right") 
            {
                self thread doClassChange();
            }
        }
        wait 0.001;
    }
}

classChangeDpad(dpad)
{
    self.pers["class_change_dpad"] = dpad;
}

doClassChange() 
{
    if (self.pers["class_change"] == 0) 
    {
        self.pers["class_change"] = 1;
        self notify("menuresponse", "changeclass", "custom1");
    }
    else if (self.pers["class_change"] == 1)
    {
        self.pers["class_change"] = 2;
        self notify("menuresponse", "changeclass", "custom2");
    }
    else if (self.pers["class_change"] == 2) 
    {
        self.pers["class_change"] = 3;
        self notify("menuresponse", "changeclass", "custom3");
    }
    else if (self.pers["class_change"] == 3)
    {
        self.pers["class_change"] = 4;
        self notify("menuresponse", "changeclass", "custom4");
    }
    else if (self.pers["class_change"] == 4) 
    {
        self.pers["class_change"] = 5;
        self notify("menuresponse", "changeclass", "custom5");
    }
    else if (self.pers["class_change"] == 5) 
    {
        self.pers["class_change"] = 0;
    }

    wait 0.05;    

    weapon = self getCurrentWeapon();
    stock = self getWeaponAmmoStock(weapon);
    clip = self getWeaponAmmoClip(weapon);
    if (self.pers["class_change_type"] == "default")
    {
        // No Change
    }
    if (self.pers["class_change_type"] == "canswap")
    {
        self takeWeapon(weapon);
        self giveWeapon(weapon);
    }
    if (self.pers["class_change_type"] == "empty clip")
    {
        self setWeaponAmmoStock(weapon, stock);
        self setWeaponAmmoClip(weapon, 0);
    }
    if (self.pers["class_change_type"] == "one bullet left")
    {
        self setWeaponAmmoStock(weapon, stock);
        self setWeaponAmmoClip(weapon, 1);
    }
}

classChangeType(type)
{
    self.pers["class_change_type"] = type;
}

// Change Lethal
changeLethalBind() 
{
    if (!isDefined(self.pers["change_lethal"])) 
    {
        self.pers["change_lethal_dpad"] = undefined;
        self.pers["change_lethal"] = true;
        self colorToggle(self.pers["change_lethal"]);
        self thread changeLethalMonitor();
    } 
    else 
    {
        self.pers["change_lethal"] = undefined;
        self colorToggle(self.pers["change_lethal"]);
        self notify("end_change_lethal");
    }
}

changeLethalMonitor()
{
    self endon("disconnect");
    self endon("end_change_lethal");
    while (isDefined(self.pers["change_lethal"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["change_lethal_dpad"] == "up") 
            {
                self thread doChangeLethal();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["change_lethal_dpad"] == "down") 
            {
                self thread doChangeLethal();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["change_lethal_dpad"] == "left") 
            {
                self thread doChangeLethal();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["change_lethal_dpad"] == "right") 
            {
                self thread doChangeLethal();
            }
        }
        wait 0.001;
    }
}

changeLethalDpad(dpad)
{
    self.pers["change_lethal_dpad"] = dpad;
}

doChangeLethal()
{
    if (self.pers["lethal_type_chosen"] == false)
    {
        self iPrintLn("Must select lethal");
        return;
    }
    
    primary_weapons = self getWeaponsListPrimaries();
    offhand_weapons = array_exclude(self getWeaponsList(), primary_weapons);
    offhand_weapons = array_remove(offhand_weapons, "knife_mp");

    if (!isDefined(self.pers["changing_lethal"]))
    {
        self.pers["current_offhand"] = self getCurrentOffhand();
        for (i = 0; i < offhand_weapons.size; i++)
        {
            weapon = offhand_weapons[i];
            switch (weapon)
            {
                case "frag_grenade_mp":
                case "sticky_grenade_mp":
                case "hatchet_mp":
                    self takeWeapon(weapon);
                    self giveWeapon(self.pers["lethal"]);
                    self giveStartAmmo(self.pers["lethal"]);
                    break;
                default:
                    break;
            }
        }
        self.pers["changing_lethal"] = true;
    }
    else if (isDefined(self.pers["changing_lethal"]))
    {
        for (i = 0; i < offhand_weapons.size; i++)
        {
            weapon = offhand_weapons[i];
            switch (weapon)
            {
                case "frag_grenade_mp":
                case "sticky_grenade_mp":
                case "hatchet_mp":
                    self takeWeapon(weapon);
                    self giveWeapon(self.pers["current_offhand"]);
                    self giveStartAmmo(self.pers["current_offhand"]);
                    break;
                default:
                    break;
            }
        }
        self.pers["changing_lethal"] = undefined;
    }
}

changeLethalType(lethal)
{
    self.pers["lethal_type_chosen"] = true;
    self.pers["lethal"] = lethal;
}

// Ghost Migration
ghostMigrationBind() 
{
    if (!isDefined(self.pers["ghost_migration"])) 
    {
        self.pers["ghost_migration_dpad"] = undefined;
        self.pers["ghost_migration"] = true;
        self.pers["ghost_migration_text"] = "match_starting_in";
        self.pers["ghost_migration_time"] = 5;
        self colorToggle(self.pers["ghost_migration"]);
        self thread ghostMigrationMonitor();
    } 
    else 
    {
        self.pers["ghost_migration"] = undefined;
        self colorToggle(self.pers["ghost_migration"]);
        self notify("end_ghost_migration");
    }
}

ghostMigrationMonitor()
{
    self endon("disconnect");
    self endon("end_ghost_migration");
    while (isDefined(self.pers["ghost_migration"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["ghost_migration_dpad"] == "up") 
            {
                self thread doGhostMigration();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["ghost_migration_dpad"] == "down") 
            {
                self thread doGhostMigration();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["ghost_migration_dpad"] == "left") 
            {
                self thread doGhostMigration();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["ghost_migration_dpad"] == "right") 
            {
                self thread doGhostMigration();
            }
        }
        wait 0.001;
    }
}

ghostMigrationDpad(dpad)
{
    self.pers["ghost_migration_dpad"] = dpad;
}

doGhostMigration()
{
    self maps\mp\gametypes\_hostmigration::matchStartTimerConsole(self.pers["ghost_migration_text"], self.pers["ghost_migration_time"]);
}

ghostMigrationText(text)
{
    self.pers["ghost_migration_text"] = text;
}

ghostMigrationTime(time)
{
    self.pers["ghost_migration_time"] = int(time);
}

// Host Migration
hostMigrationBind() 
{
    if (!isDefined(self.pers["host_migration"])) 
    {
        self.pers["host_migration_dpad"] = undefined;
        self.pers["host_migration"] = true;
        self colorToggle(self.pers["host_migration"]);
        self thread hostMigrationMonitor();
    } 
    else 
    {
        self.pers["host_migration"] = undefined;
        self colorToggle(self.pers["host_migration"]);
        self notify("end_host_migration");
    }
}

hostMigrationMonitor()
{
    self endon("disconnect");
    self endon("end_host_migration");
    while (isDefined(self.pers["host_migration"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["host_migration_dpad"] == "up") 
            {
                self thread doHostMigration();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["host_migration_dpad"] == "down") 
            {
                self thread doHostMigration();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["host_migration_dpad"] == "left") 
            {
                self thread doHostMigration();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["host_migration_dpad"] == "right") 
            {
                self thread doHostMigration();
            }
        }
        wait 0.001;
    }
}

hostMigrationDpad(dpad)
{
    self.pers["host_migration_dpad"] = dpad;
}

doHostMigration()
{
    if (!isDefined(self.pers["host_migrating"]))
    {
        //1. Stalls player midair, pauses timer, removes HUD (Add overlays in post)
        self setClientUIVisibilityFlag("hud_visible", 0);
        maps\mp\gametypes\_globallogic_utils::pauseTimer();
        self.originobj = spawn("script_origin", self.origin);
        self.originobj.angles = self.angles;
        self linkTo(self.originobj);

        self.pers["host_migrating"] = true;
    }
    else if (isDefined(self.pers["host_migrating"])) 
    {
        //1. Unlink player from midair stall, freezes player to put them in floater, add HUD
        self setClientUIVisibilityFlag("hud_visible", 1);
        self freezeControls(true);
        self.originobj delete();

        //2. Match starting in text
        self maps\mp\gametypes\_hostmigration::matchStartTimerConsole("match_starting_in", 5);

        //3. Unfreezes player and resumes timer
        self freezeControls(false);
        maps\mp\gametypes\_globallogic_utils::resumeTimer();
        
        self.pers["host_migrating"] = undefined;
    }
}

// Illusion Reload
illusionReloadBind() 
{
    if (!isDefined(self.pers["illusion_reload"])) 
    {
        self.pers["illusion_reload_dpad"] = undefined;
        self.pers["illusion_reload"] = true;
        self colorToggle(self.pers["illusion_reload"]);
        self thread illusionReloadMonitor();
    } 
    else 
    {
        self.pers["illusion_reload"] = undefined;
        self colorToggle(self.pers["illusion_reload"]);
        self notify("end_illusion_reload");
    }
}

illusionReloadMonitor()
{
    self endon("disconnect");
    self endon("end_illusion_reload");
    while (isDefined(self.pers["illusion_reload"])) 
    {   
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["illusion_reload_dpad"] == "up") 
            {
            self thread doIllusionReload();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["illusion_reload_dpad"] == "down") 
            {
            self thread doIllusionReload();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["illusion_reload_dpad"] == "left") 
            {
                self thread doIllusionReload();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["illusion_reload_dpad"] == "right") 
            {
                self thread doIllusionReload();
            }
        }
        wait 0.001;
    }
}

illusionReloadDpad(dpad)
{
    self.pers["illusion_reload_dpad"] = dpad;
}

doIllusionReload()
{
    weapon = self getCurrentWeapon();
    clip = self getWeaponAmmoClip(weapon);
    stock = self getWeaponAmmoStock(weapon);
    self setweaponammostock(weapon, stock);
    self setweaponammoclip(weapon, clip - clip);
    wait 0.01;
    self setweaponammoclip(weapon, clip);
    self setspawnweapon(weapon);
}

// Drop Care Package
dropCarePackageBind() 
{
    if (!isDefined(self.pers["drop_care_package"])) 
    {
        self.pers["drop_care_package_dpad"] = undefined;
        self.pers["drop_care_package"] = true;
        self colorToggle(self.pers["drop_care_package"]);
        self thread dropCarePackageMonitor();
    } 
    else 
    {
        self.pers["drop_care_package"] = undefined;
        self.pers["care_package_dropzone_chosen"] = false;
        self colorToggle(self.pers["drop_care_package"]);
        self notify("end_drop_carepackage");
    }
}

dropCarePackageMonitor()
{
    self endon("disconnect");
    self endon("end_drop_carepackage");
    while (isDefined(self.pers["drop_care_package"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["drop_care_package_dpad"] == "up") 
            {
                self thread doDropCarePackage();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["drop_care_package_dpad"] == "down") 
            {
                self thread doDropCarePackage();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["drop_care_package_dpad"] == "left") 
            {
                self thread doDropCarePackage();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["drop_care_package_dpad"] == "right") 
            {
                self thread doDropCarePackage();
            }
        }
        wait 0.001;
    }
}

dropCarePackageDpad(dpad)
{
    self.pers["drop_care_package_dpad"] = dpad;
}

doDropCarePackage()
{
    if (self.pers["care_package_dropzone_chosen"] == false)
    {
        self iPrintLn("Must select carepackage drop zone");
        return;
    }
    level.dropCarePackage = spawn("script_model", self.pers["dropzone_origin"]);  
    self thread maps\mp\gametypes\supplydrop::dropCrate(self.pers["dropzone_origin"], self.pers["dropzone_angle"], "supplydrop_mp", self, self.team, level.dropCarePackage);
}

saveCarePackageDropZone()
{
    self.pers["care_package_dropzone_chosen"] = true;
    self.pers["dropzone_origin"] = self.origin + (0, 0, 1150);
    self.pers["dropzone_angle"] = self.angle;
    self thread maps\mp\gametypes\supplydrop::newHeli(self.pers["dropzone_origin"], "none", self, self.team);
}

// Shoot Projectile
shootProjectileBind() 
{
    if (!isDefined(self.pers["shoot_projectile"])) 
    {
        self.pers["shoot_projectile_dpad"] = undefined;
        self.pers["shoot_projectile"] = true;
        self colorToggle(self.pers["shoot_projectile"]);
        self thread shootProjectileMonitor();
    } 
    else 
    {
        self.pers["shoot_projectile"] = undefined;
        self.pers["projectile_type_chosen"] = false;
        self disableInvulnerability();
        self colorToggle(self.pers["shoot_projectile"]);
        self notify("end_shoot_projectile");
        self notify("end_shooting_projectile");
    }
}

shootProjectileMonitor()
{
    self endon("disconnect");
    self endon("end_shoot_projectile");
    while (isDefined(self.pers["shoot_projectile"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["shoot_projectile_dpad"] == "up") 
            {
                self thread doShootProjectile();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["shoot_projectile_dpad"] == "down") 
            {
                self thread doShootProjectile();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["shoot_projectile_dpad"] == "left") 
            {
                self thread doShootProjectile();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["shoot_projectile_dpad"] == "right") 
            {
                self thread doShootProjectile();
            }
        }
        wait 0.001;
    }
}

shootProjectileDpad(dpad)
{
    self.pers["shoot_projectile_dpad"] = dpad;
}

doShootProjectile()
{
    if (self.pers["projectile_type_chosen"] == false)
    {
        self iPrintLn("Must select projectile type");
        return;
    }
    
    if (!isDefined(self.pers["shooting_projectile"]))
    {
        self endon("end_shooting_projectile");
        self.pers["shooting_projectile"] = true;
        self enableInvulnerability();
        for (;;)
        {
            self waittill("weapon_fired");
            firing = self thread getCursorPosition();
            magicBullet(self.pers["projectile_type"], self.origin + anglesToForward(self getPlayerAngles()) * 50, firing, self);
        }
    }
    else if (isDefined(self.pers["shooting_projectile"])) 
    {
        self disableInvulnerability();
        self notify("end_shooting_projectile");
        self.pers["shooting_projectile"] = undefined;
    }
}

projectileType(projectile)
{
    self.pers["projectile_type_chosen"] = true;
    self.pers["projectile_type"] = projectile;
}

// Houdini
houdiniBind() 
{
    if (!isDefined(self.pers["houdini"])) 
    {
        self.pers["houdini_dpad"] = undefined;
        self.pers["houdini"] = true;
        self colorToggle(self.pers["houdini"]);
        self thread houdiniMonitor();
    } 
    else 
    {
        self.pers["houdini"] = undefined;
        self colorToggle(self.pers["houdini"]);
        self notify("end_houdini");
    }
}

houdiniMonitor()
{
    self endon("disconnect");
    self endon("end_houdini");
    while (isDefined(self.pers["houdini"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["houdini_dpad"] == "up") 
            {
                self thread doHoudini();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["houdini_dpad"] == "down") 
            {
                self thread doHoudini();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["houdini_dpad"] == "left") 
            {
                self thread doHoudini();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["houdini_dpad"] == "right") 
            {
                self thread doHoudini();
            }
        }
        wait 0.001;
    }
}

houdiniDpad(dpad)
{
    self.pers["houdini_dpad"] = dpad;
}

doHoudini()
{
    self disableWeapons();
    wait 0.1;
    self enableWeapons();
    self setSpawnWeapon(self getCurrentWeapon());
}

// Flash Grenade
flashGrenadeBind() 
{
    if (!isDefined(self.pers["flash_grenade"])) 
    {
        self.pers["flash_grenade_dpad"] = undefined;
        self.pers["flash_grenade"] = true;
        self colorToggle(self.pers["flash_grenade"]);
        self thread flashGrenadeMonitor();
    } 
    else 
    {
        self.pers["flash_grenade"] = undefined;
        self colorToggle(self.pers["flash_grenade"]);
        self notify("end_flash_grenade");
    }
}

flashGrenadeMonitor()
{
    self endon("disconnect");
    self endon("end_flash_grenade");
    while (isDefined(self.pers["flash_grenade"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["flash_grenade_dpad"] == "up") 
            {
                self thread doFlashGrenade();
            }
            if (self ActionSlotTwoButtonPressed() && self.pers["flash_grenade_dpad"] == "down") 
            {
                self thread doFlashGrenade();
            }
            if (self ActionSlotThreeButtonPressed() && self.pers["flash_grenade_dpad"] == "left") 
            {
                self thread doFlashGrenade();
            }
            if (self ActionSlotFourButtonPressed() && self.pers["flash_grenade_dpad"] == "right") 
            {
                self thread doFlashGrenade();
            }
        }
        wait 0.001;
    }
}

flashGrenadeDpad(dpad)
{
    self.pers["flash_grenade_dpad"] = dpad;
}

doFlashGrenade()
{
    self thread maps\mp\_flashgrenades::applyFlash(1, 1);
}

// Empty Clip
emptyClipBind() 
{
    if (!isDefined(self.pers["empty_clip"])) 
    {
        self.pers["empty_clip_dpad"] = undefined;
        self.pers["empty_clip"] = true;
        self colorToggle(self.pers["empty_clip"]);
        self thread emptyClipMonitor();
    } 
    else 
    {
        self.pers["empty_clip"] = undefined;
        self colorToggle(self.pers["empty_clip"]);
        self notify("end_emptyclip");
    }
}

emptyClipMonitor()
{
    self endon("disconnect");
    self endon("end_emptyclip");
    while (isDefined(self.pers["empty_clip"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["empty_clip_dpad"] == "up") 
            {
                self thread doEmptyClip();
            }
            if (self ActionSlotTwoButtonPressed() && self.pers["empty_clip_dpad"] == "down") 
            {
                self thread doEmptyClip();
            }
            if (self ActionSlotThreeButtonPressed() && self.pers["empty_clip_dpad"] == "left") 
            {
                self thread doEmptyClip();
            }
            if (self ActionSlotFourButtonPressed() && self.pers["empty_clip_dpad"] == "right") 
            {
                self thread doEmptyClip();
            }
        }
        wait 0.001;
    }
}

emptyClipDpad(dpad)
{
    self.pers["empty_clip_dpad"] = dpad;
}

doEmptyClip()
{
    weapon = self getCurrentWeapon();
    clip = self getWeaponAmmoClip(weapon);
    stock = self getWeaponAmmoStock(weapon);
    self setWeaponAmmoStock(weapon, stock);
    self setWeaponAmmoClip(weapon, clip - clip);
}

// Instaswap
instaswapBind() 
{
    if (!isDefined(self.pers["instaswap"])) 
    {
        self.pers["instaswap_dpad"] = undefined; 
        self.pers["instaswap"] = true;
        self.pers["do_instaswap"] = false;
        self.pers["instaswap_weapon"] = 0;
        self colorToggle(self.pers["instaswap"]);
        self thread instaswapMonitor();
    } 
    else 
    {
        self.pers["instaswap"] = undefined;
        self colorToggle(self.pers["instaswap"]);
        self notify("end_instaswap");
    }
}

instaswapMonitor()
{
    self endon("disconnect");
    self endon("end_instaswap");
    while (isDefined(self.pers["instaswap"]))
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["instaswap_dpad"] == "up")
            {
                if (self.pers["do_instaswap"] == false)
                {
                    if (self.pers["instaswap_weapon"] == 0)
                    {
                        self.pers["instaswap_weapon"] = 1;
                        self.pers["primary_weapon"] = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + self.pers["primary_weapon"]);
                    }
                    else if (self.pers["instaswap_weapon"] == 1)
                    {
                        self.pers["instaswap_weapon"] = 2;
                        self.pers["secondary_weapon"] = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + self.pers["secondary_weapon"]);
                        self.pers["do_instaswap"] = true;
                    }
                }
                else 
                {
                    self doInstaswap();
                }
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["instaswap_dpad"] == "down")
            {
                if (self.pers["do_instaswap"] == false)
                {
                    if (self.pers["instaswap_weapon"] == 0)
                    {
                        self.pers["instaswap_weapon"] = 1;
                        self.pers["primary_weapon"] = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + self.pers["primary_weapon"]);
                    }
                    else if (self.pers["instaswap_weapon"] == 1)
                    {
                        self.pers["instaswap_weapon"] = 2;
                        self.pers["secondary_weapon"] = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + self.pers["secondary_weapon"]);
                        self.pers["do_instaswap"] = true;
                    }
                }
                else 
                {
                    self doInstaswap();
                }
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["instaswap_dpad"] == "left")
            {
                if (self.pers["do_instaswap"] == false)
                {
                    if (self.pers["instaswap_weapon"] == 0)
                    {
                        self.pers["instaswap_weapon"] = 1;
                        self.pers["primary_weapon"] = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + self.pers["primary_weapon"]);
                    }
                    else if (self.pers["instaswap_weapon"] == 1)
                    {
                        self.pers["instaswap_weapon"] = 2;
                        self.pers["secondary_weapon"] = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + self.pers["secondary_weapon"]);
                        self.pers["do_instaswap"] = true;
                    }
                }
                else 
                {
                    self doInstaswap();
                }
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["instaswap_dpad"] == "right")
            {
                if (self.pers["do_instaswap"] == false)
                {
                    if (self.pers["instaswap_weapon"] == 0)
                    {
                        self.pers["instaswap_weapon"] = 1;
                        self.pers["primary_weapon"] = self getCurrentWeapon();
                        self iPrintLn("Primary Weapon: ^6" + self.pers["primary_weapon"]);
                    }
                    else if (self.pers["instaswap_weapon"] == 1)
                    {
                        self.pers["instaswap_weapon"] = 2;
                        self.pers["secondary_weapon"] = self getCurrentWeapon();
                        self iPrintLn("Secondary Weapon: ^6" + self.pers["secondary_weapon"]);
                        self.pers["do_instaswap"] = true;
                    }
                }
                else 
                {
                    self doInstaswap();
                }
            }
        }
        wait 0.001;
    }
}

instaswapDpad(dpad)
{
    self.pers["instaswap_dpad"] = dpad;
}

doInstaswap() 
{   
    if (self getCurrentWeapon() == self.pers["primary_weapon"]) 
    {
        self giveWeapon(self.pers["secondary_weapon"]);
        self setSpawnWeapon(self.pers["secondary_weapon"]);

    }
    else if (self getCurrentWeapon() == self.pers["secondary_weapon"]) 
    {
        self giveWeapon(self.pers["primary_weapon"]);
        self setSpawnWeapon(self.pers["primary_weapon"]);
    }
}

resetInstaswapWeapons()
{
    self.pers["do_instaswap"] = false;
    self.pers["instaswap_weapon"] = 0;
}

// Elevator
elevatorBind() 
{
    if (!isDefined(self.pers["elevator"])) 
    {
        self.pers["elevator_dpad"] = undefined;
        self.pers["elevator"] = true;
        self colorToggle(self.pers["elevator"]);
        self thread elevatorMonitor();
    } 
    else 
    {
        self.pers["elevator"] = undefined;
        self colorToggle(self.pers["elevator"]);
        self notify("end_elevator");
    }
}

elevatorMonitor() 
{
    self endon("disconnect");
    self endon("end_elevator");
    
    while (isDefined(self.pers["elevator"])) 
    {
        if (self.menu["open"] == false) 
        {
            if (self ActionSlotOneButtonPressed() && self.pers["elevator_dpad"] == "up") 
            {
                self thread doElevator();
            } 
            else if (self ActionSlotTwoButtonPressed() && self.pers["elevator_dpad"] == "down") 
            {
                self thread doElevator();
            } 
            else if (self ActionSlotThreeButtonPressed() && self.pers["elevator_dpad"] == "left") 
            {
                self thread doElevator();
            } 
            else if (self ActionSlotFourButtonPressed() && self.pers["elevator_dpad"] == "right") 
            {
                self thread doElevator();
            }
        }
        wait 0.001;
    }
}

elevatorDpad(dpad)
{
    self.pers["elevator_dpad"] = dpad;
}

doElevator()
{
    if (!isDefined(self.pers["elevator_change_angle"]))
    {
        self endon("doing_elevator");
        self.elevate = spawn("script_origin", self.origin, 1);
        self playerLinkToDelta(self.elevate, undefined);
        self.pers["elevator_change_angle"] = true;
        for (;;)
        {
            self.o = self.elevate.origin;
            wait 0.005;
            self.elevate.origin = self.o + (0, 0, 4);
        }
        wait 0.005;
    }
    else if (isDefined(self.pers["elevator_change_angle"])) 
    {
        wait 0.01;
        self unlink();
        self.pers["elevator_change_angle"] = undefined;
        self.elevate delete();
        self notify("doing_elevator");
    }
}

// Reverse Elevator
reversEelevatorBind() 
{
    if (!isDefined(self.pers["reverse_elevator"])) 
    {
        self.pers["reverse_elevator_dpad"] = undefined;
        self.pers["reverse_elevator"] = true;
        self colorToggle(self.pers["reverse_elevator"]);
        self thread reverseElevatorMonitor();
    } 
    else 
    {
        self.pers["reverse_elevator"] = undefined;
        self colorToggle(self.pers["reverse_elevator"]);
        self notify("end_reverse_elevator");
    }
}

reverseElevatorMonitor()
{
    self endon("disconnect");
    self endon("end_reverse_elevator");
    while (isDefined(self.pers["reverse_elevator"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["reverse_elevator_dpad"] == "up") 
            {
                self thread doReverseElevator();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["reverse_elevator_dpad"] == "down") 
            {
                self thread doReverseElevator();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["reverse_elevator_dpad"] == "left") 
            {
                self thread doReverseElevator();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["reverse_elevator_dpad"] == "right") 
            {
                self thread doReverseElevator();
            }
        }
        wait 0.001;
    }
}

reverseElevatorDpad(dpad)
{
    self.pers["reverse_elevator_dpad"] = dpad;
}

doReverseElevator()
{
    if (!isDefined(self.pers["reverse_elevator_change_angle"]))
    {
        self endon("doing_reverse_elevator");
        self.elevate = spawn("script_origin", self.origin, 1);
        self playerLinkToDelta(self.elevate, undefined);
        self.pers["reverse_elevator_change_angle"] = true;
        for (;;)
        {
            self.o = self.elevate.origin;
            wait 0.005;
            self.elevate.origin = self.o + (0, 0, -4);
        }
        wait 0.005;
    }
    else if (isDefined(self.pers["reverse_elevator_change_angle"])) 
    {
        wait 0.01;
        self unlink();
        self.pers["reverse_elevator_change_angle"] = undefined;
        self.elevate delete();
        self notify("doing_reverse_elevator");
    }
}

// Canzoom
canzoomBind() 
{
    if (!isDefined(self.pers["canzoom"])) 
    {
        self.pers["canzoom_dpad"] = undefined;
        self.pers["canzoom"] = true;
        self colorToggle(self.pers["canzoom"]);
        self thread canzoomMonitor();
    } 
    else 
    {
        self.pers["canzoom"] = undefined;
        self colorToggle(self.pers["canzoom"]);
        self notify("end_canzoom");
    }
}

canzoomMonitor()
{
    self endon("disconnect");
    self endon("end_canzoom");
    while (isDefined(self.pers["canzoom"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["canzoom_dpad"] == "up") 
            {
                self thread doCanzoom();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["canzoom_dpad"] == "down") 
            {
                self thread doCanzoom();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["canzoom_dpad"] == "left") 
            {
                self thread doCanzoom();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["canzoom_dpad"] == "right") 
            {
                self thread doCanzoom();
            }
        }
        wait 0.001;
    }
}

canzoomDpad(dpad)
{
    self.pers["canzoom_dpad"] = dpad;
}

doCanzoom()
{
    weapon = self getCurrentWeapon();
    self takeWeapon(weapon);
    self giveWeapon(weapon);
    wait 0.05;
    self setSpawnWeapon(weapon);
}

// Second Chance
secondChanceBind() 
{
    if (!isDefined(self.pers["second_chance"])) 
    {
        self.pers["second_chance_dpad"] = undefined;
        self.pers["second_chance"] = true;
        level.laststandpistol = "m1911_mp";
        self colorToggle(self.pers["second_chance"]);
        self thread secondChanceMonitor();
    } 
    else 
    {
        self.pers["second_chance"] = undefined;
        self colorToggle(self.pers["second_chance"]);
        self notify("end_secondchance");
    }
}

secondChanceMonitor()
{
    self endon("disconnect");
    self endon("end_secondchance");
    while (isDefined(self.pers["second_chance"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["second_chance_dpad"] == "up") 
            {
                self thread doSecondChance();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["second_chance_dpad"] == "down") 
            {
                self thread doSecondChance();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["second_chance_dpad"] == "left") 
            {
                self thread doSecondChance();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["second_chance_dpad"] == "right") 
            {
                self thread doSecondChance();
            }
        }
        wait 0.001;
    }
}

secondChanceDpad(dpad)
{
    self.pers["second_chance_dpad"] = dpad;
}

doSecondChance()
{
    self setPerk("specialty_pistoldeath");
    self setPerk("specialty_finalstand");
    wait 0.1;
    self thread [[level.callbackPlayerDamage]](self, self, self.health, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "body", 0);
    if (!self isOnGround())
    {
        self freezeControlsAllowLook(true);
        wait 0.3;
        self freezeControlsAllowLook(false);
    }
    wait 0.5;
}

secondChanceWeapon(selected)
{
    self.pers["second_chance_weapon"] = selected;

    if (self.pers["second_chance_weapon"] == "M1911")
    {
        level.laststandpistol = "m1911_mp";
    }
    else if (self.pers["second_chance_weapon"] == "Current")
    {
        level.laststandpistol = self getCurrentWeapon();
    }
}

// Bounce
bounceBind() 
{
    if (!isDefined(self.pers["bounce"])) 
    {
        self.pers["bounce_dpad"] = undefined;
        self.pers["bounce"] = true;
        self colorToggle(self.pers["bounce"]);
        self thread bounceMonitor();
    } 
    else 
    {
        self.pers["bounce"] = undefined;
        self colorToggle(self.pers["bounce"]);
        self notify("end_bounce");
    }
}

bounceMonitor()
{
    self endon("disconnect");
    self endon("end_bounce");
    while (isDefined(self.pers["bounce"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["bounce_dpad"] == "up") 
            {
                self thread doBounceBind();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["bounce_dpad"] == "down") 
            {
                self thread doBounceBind();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["bounce_dpad"] == "left") 
            {
                self thread doBounceBind();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["bounce_dpad"] == "right") 
            {
                self thread doBounceBind();
            }
        }
        wait 0.001;
    }
}

bounceDpad(dpad)
{
    self.pers["bounce_dpad"] = dpad;
}

doBounceBind()
{
    self setVelocity(self getVelocity() + (0, 0, 999));
}

// Copycat
copycatBind() 
{
    if (!isDefined(self.pers["copycat"])) 
    {
        self.pers["copycat_dpad"] = undefined;
        self.pers["copycat"] = true;
        self colorToggle(self.pers["copycat"]);
        self thread copycatMonitor();
    } 
    else 
    {
        self.pers["copycat"] = undefined;
        self colorToggle(self.pers["copycat"]);
        self notify("end_copycat");
    }
}

copycatMonitor()
{
    self endon("disconnect");
    self endon("end_copycat");
    while (isDefined(self.pers["copycat"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["copycat_dpad"] == "up") 
            {
                self thread doCopycat();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["copycat_dpad"] == "down") 
            {
                self thread doCopycat();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["copycat_dpad"] == "left") 
            {
                self thread doCopycat();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["copycat_dpad"] == "right") 
            {
                self thread doCopycat();
            }
        }
        wait 0.001;
    }
}

copycatDpad(dpad)
{
    self.pers["copycat_dpad"] = dpad;
}

doCopycat()
{
    self thread copycatButtonThink();
}

copycatButtonThink() 
{
    icon = copycatButtonCreate();
    text = copycatTextCreate();
    self thread copycatButtonPress();
    event = self waittill_any_return("copycat_used");
    if (event == "copycat_used") 
    {
        icon Destroy();
        text Destroy();
    }
}

copycatButtonPress()
{
    while (!self changeSeatButtonPressed())
    {
        wait 0.05;
    }
    self notify("copycat_used");
    self notify("menuresponse", "changeclass", "custom1");
}

copycatButtonCreate()
{
    icon = newClientHudElem(self);
    icon.archived = false;
    icon.x = 16;
    icon.y = 16;
    icon.alignX = "left";
    icon.alignY = "top";
    icon.horzalign = "center";
    icon.vertalign = "middle";
    icon.sort = 1; 
    icon.foreground = true;
    icon.hideWhenInMenu = true;     
    icon setShader("rank_prestige02", 48, 48); 
    icon.alpha = 1;
    return icon;
}

copycatTextCreate()
{
    text = newClientHudElem(self);
    text.archived = false;
    text.y = 48;
    text.alignX = "left";
    text.alignY = "top";
    text.horzalign = "center";
    text.vertalign = "middle";
    text.sort = 10;
    text.font = "small";
    text.foreground = true;
    text.hideWhenInMenu = true;
    if (level.splitscreen)
    {
        text.x = 16;
        text.fontscale = 1.2;
    }
    else
    {
        text.x = 32;
        text.fontscale = 1.6;
    }
    text setText(&"PLATFORM_PRESS_TO_COPYCAT");
    text.alpha = 1;
    return text;
}

// Wall Breach
wallBreachBind() 
{
    if (!isDefined(self.pers["wall_breach"])) 
    {
        self.pers["wall_breach_dpad"] = undefined;
        self.pers["wall_breach"] = true;
        self colorToggle(self.pers["wall_breach"]);
        self thread wallBreachMonitor();
    } 
    else 
    {
        self.pers["wall_breach"] = undefined;
        self colorToggle(self.pers["wall_breach"]);
        self notify("end_wall_breach");
    }
}

wallBreachMonitor()
{
    self endon("disconnect");
    self endon("end_wall_breach");
    while (isDefined(self.pers["wall_breach"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["wall_breach_dpad"] == "up") 
            {
                self thread doWallBreach();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["wall_breach_dpad"] == "down") 
            {
                self thread doWallBreach();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["wall_breach_dpad"] == "left") 
            {
                self thread doWallBreach();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["wall_breach_dpad"] == "right") 
            {
                self thread doWallBreach();
            }
        }
        wait 0.001;
    }
}

wallBreachDpad(dpad)
{
    self.pers["wall_breach_dpad"] = dpad;
}

doWallBreach()
{
    if (!isDefined(self.pers["wall_breaching"]))
    {
        self setClientDvar("r_singleCell", 1);
        self.pers["wall_breaching"] = true;
    }
    else if (isDefined(self.pers["wall_breaching"])) 
    {
        self setClientDvar("r_singleCell", 0);
        self.pers["wall_breaching"] = undefined;
    }
}

// Nova Gas
novaGasBind() 
{
    if (!isDefined(self.pers["nova_gas"])) 
    {
        self.pers["nova_gas_dpad"] = undefined;
        self.pers["nova_gas"] = true;
        self colorToggle(self.pers["nova_gas"]);
        self thread novaGasMonitor();
    } 
    else 
    {
        self.pers["nova_gas"] = undefined;
        self colorToggle(self.pers["nova_gas"]);
        self notify("end_nova_gas");
    }
}


novaGasMonitor()
{
    self endon("disconnect");
    self endon("end_nova_gas");
    while (isDefined(self.pers["nova_gas"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["nova_gas_dpad"] == "up") 
            {
                self thread doNovaGas();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["nova_gas_dpad"] == "down") 
            {
                self thread doNovaGas();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["nova_gas_dpad"] == "left") 
            {
                self thread doNovaGas();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["nova_gas_dpad"] == "right") 
            {
                self thread doNovaGas();
            }
        }
        wait 0.001;
    }
}

novaGasDpad(dpad)
{
    self.pers["nova_gas_dpad"] = dpad;
}

doNovaGas()
{
    if (self.pers["nova_gas_duration_chosen"] == false)
    {
        self iPrintLn("Must select nova_gas weapon");
        return;
    }
    self setClientDvar("r_poisonFX_debug_enable", 1);
    self thread[[level.callbackPlayerDamage]](self, self, 26, 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "body", 0);
    wait (self.pers["nova_gas_duration"]);
    self setClientDvar("r_poisonFX_debug_enable", 0);
}

novaGasDuration(duration)
{
    self.pers["nova_gas_duration_chosen"] = true;
    self.pers["nova_gas_duration"] = float(duration);
}

// Plant Bomb
plantBombBind() 
{
    if (!isDefined(self.pers["plant_bomb"])) 
    {
        self.pers["plant_bomb_dpad"] = undefined;
        self.pers["plant_bomb"] = true;
        self colorToggle(self.pers["plant_bomb"]);
        self thread plantBombMonitor();
    } 
    else 
    {
        self.pers["plant_bomb"] = undefined;
        self colorToggle(self.pers["plant_bomb"]);
        self notify("end_plant_bomb");
    }
}

plantBombMonitor()
{
    self endon("disconnect");
    self endon("end_plant_bomb");
    while (isDefined(self.pers["plant_bomb"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["plant_bomb_dpad"] == "up") 
            {
                self thread doPlantBomb();
            }
            if (self ActionSlotTwoButtonPressed() && self.pers["plant_bomb_dpad"] == "down") 
            {
                self thread doPlantBomb();
            }
            if (self ActionSlotThreeButtonPressed() && self.pers["plant_bomb_dpad"] == "left") 
            {
                self thread doPlantBomb();
            }
            if (self ActionSlotFourButtonPressed() && self.pers["plant_bomb_dpad"] == "right") 
            {
                self thread doPlantBomb();
            }
        }
        wait 0.001;
    }
}

plantBombDpad(dpad)
{
    self.pers["plant_bomb_dpad"] = dpad;
}

doPlantBomb() 
{
    weapon = self getCurrentWeapon();
    current_clip = self getWeaponAmmoClip(weapon);
    current_stock = self getWeaponAmmoStock(weapon);
    self takeWeapon(weapon);
    self giveWeapon("briefcase_bomb_mp");
    self switchToWeapon("briefcase_bomb_mp");
    
    duration = 5.00;
    bar = createPrimaryProgressBar();
    progress_bar_text = createPrimaryProgressBarText();
    
    progress_bar_text setText("Planting...");
    bar updateBar(0, 1 / duration);
    bar.color = (0, 0, 0);
    bar.bar.color = (255, 255, 255);
    
    self setClientDvar("cg_drawCrosshair", 0);

    for (wait_time = 0; wait_time < duration && isAlive(self) && !level.gameEnded; wait_time += 0.05)
    wait (0.05);
    bar destroyElem();
    progress_bar_text destroyElem();
    self setClientDvar("cg_drawCrosshair", 1);
    
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    wait 0.8;
    self takeWeapon("briefcase_bomb_mp");
}

// Self Damage
selfDamageBind() 
{
    if (!isDefined(self.pers["self_damage"])) 
    {
        self.pers["self_damage_dpad"] = undefined;
        self.pers["self_damage"] = true;
        self.pers["self_damage_amount"] = 24;
        self colorToggle(self.pers["self_damage"]);
        self thread selfDamageMonitor();
    } 
    else 
    {
        self.pers["self_damage"] = undefined;
        self colorToggle(self.pers["self_damage"]);
        self notify("end_self_damage");
    }
}

selfDamageMonitor()
{
    self endon("disconnect");
    self endon("end_self_damage");
    while (isDefined(self.pers["self_damage"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["self_damage_dpad"] == "up") 
            {
                self thread doSelfDamage();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["self_damage_dpad"] == "down") 
            {
                self thread doSelfDamage();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["self_damage_dpad"] == "left") 
            {
                self thread doSelfDamage();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["self_damage_dpad"] == "right") 
            {
                self thread doSelfDamage();
            }
        }
        wait 0.001;
    }
}

selfDamageDpad(dpad)
{
    self.pers["self_damage_dpad"] = dpad;
}

doSelfDamage() 
{
    self thread[[level.callbackPlayerDamage]](self, self, self.pers["self_damage_amount"], 8, "MOD_RIFLE_BULLET", self getCurrentWeapon(), (0, 0, 0), (0, 0, 0), "body", 0);
}

selfDamageAmount(amount)
{
    if (amount == "Low")
    {
        self.pers["self_damage_amount"] = 24;
    }
    else if (amount == "High")
    {
        self.pers["self_damage_amount"] = 49;
    }
}

// Random Camo Switch
randomCamoSwitchBind() 
{
    if (!isDefined(self.pers["random_camo_switch"])) 
    {
        self.pers["random_camo_switch_dpad"] = undefined;
        self.pers["random_camo_switch"] = true;
        self colorToggle(self.pers["random_camo_switch"]);
        self thread randomCamoSwitchMonitor();
    } 
    else 
    {
        self.pers["random_camo_switch"] = undefined;
        self colorToggle(self.pers["random_camo_switch"]);
        self notify("end_random_camo_switch");
    }
}

randomCamoSwitchMonitor()
{
    self endon("disconnect");
    self endon("end_random_camo_switch");
    while (isDefined(self.pers["random_camo_switch"])) 
    {
        if (self.menu["open"] == false)
        {
            if (self ActionSlotOneButtonPressed() && self.pers["random_camo_switch_dpad"] == "up") 
            {
                self thread doRandomCamoSwitch();
            }
            else if (self ActionSlotTwoButtonPressed() && self.pers["random_camo_switch_dpad"] == "down") 
            {
                self thread doRandomCamoSwitch();
            }
            else if (self ActionSlotThreeButtonPressed() && self.pers["random_camo_switch_dpad"] == "left") 
            {
                self thread doRandomCamoSwitch();
            }
            else if (self ActionSlotFourButtonPressed() && self.pers["random_camo_switch_dpad"] == "right") 
            {
                self thread doRandomCamoSwitch();
            }
        }
        wait 0.001;
    }
}

randomCamoSwitchDpad(dpad)
{
    self.pers["random_camo_switch_dpad"] = dpad;
}

doRandomCamoSwitch() 
{
    random_int = randomIntRange(1, 16);
    weapon = self getCurrentWeapon();
    clip = self getWeaponAmmoClip(weapon);
    stock = self getWeaponAmmoStock(weapon);
    self takeWeapon(weapon);
    weapon_options = self calcWeaponOptions(random_int, 0, 0, 0, 0);
    self giveWeapon(weapon, 0, weapon_options);
    self switchToWeapon(weapon);
    self setSpawnWeapon(weapon);
    self setWeaponAmmoClip(weapon, clip);
    self setWeaponAmmoStock(weapon, stock);
    self.camo = random_int;
}

resetBinds()
{
    self.pers["elevator"] = undefined;
    self.pers["nacmod"] = undefined;
    self.pers["second_nacmod"] = undefined;
    self.pers["shax_swap"] = undefined;
    self.pers["canswap"] = undefined;
    self.pers["flicker"] = undefined;
    self.pers["upside_down_screen"] = undefined;
    self.pers["capture"] = undefined;
    self.pers["fade"] = undefined;
    self.pers["cowboy_bind"] = undefined;
    self.pers["repeater"] = undefined;
    self.pers["rapid_fire"] = undefined;
    self.pers["bolt_movement"] = undefined;
    self.pers["scavenger"] = undefined;
    self.pers["class_change"] = undefined;
    self.pers["change_lethal"] = undefined;
    self.pers["ghost_migration"] = undefined;
    self.pers["host_migration"] = undefined;
    self.pers["illusion_reload"] = undefined;
    self.pers["drop_care_package"] = undefined;
    self.pers["shoot_projectile"] = undefined;
    self.pers["houdini"] = undefined;
    self.pers["flash_grenade"] = undefined;
    self.pers["empty_clip"] = undefined;
    self.pers["instaswap"] = undefined;
    self.pers["reverse_elevator"] = undefined;
    self.pers["canzoom"] = undefined;
    self.pers["second_chance"] = undefined;
    self.pers["bounce"] = undefined;
    self.pers["copycat"] = undefined;
    self.pers["plant_bomb"] = undefined;
    self.pers["self_damage"] = undefined;
    self.pers["random_camo_switch"] = undefined;
}