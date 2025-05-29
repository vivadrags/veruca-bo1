#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;
#include maps\mp\gametypes\main;

takeAllMyWeapons() 
{
    self takeAllWeapons();
}

takeCurrentWeapon() 
{
    weapon = self getCurrentWeapon();
    self takeWeapon(weapon);
}

dropCurrentWeapon() 
{
    weapon = self getCurrentWeapon();
    self dropItem(weapon);
}

dropCanswap() 
{
    canswap_weapon_list = [];
    canswap_weapon_list[0] = "ak47_mk_dualclip_mp";
    canswap_weapon_list[1] = "pythondw_mp";
    canswap_weapon_list[2] = "knife_ballistic_mp";
    canswap_weapon_list[3] = "ithaca_mp";
    canswap_weapon_list[4] = "rpg_mp";
    canswap_weapon_list[5] = "mp5k_mp";
    canswap_weapon = canswap_weapon_list[randomIntRange(0, 5)];
    self giveWeapon(canswap_weapon);
    self dropItem(canswap_weapon);
}

giveGun(weapon) 
{
    self giveWeapon(weapon);
    self switchToWeapon(weapon); 
}

classOptions(class)
{
    self clearPerks();
    self takeAllWeapons();

    wait 0.25;

    // Lightweight Pro
    self setPerk("specialty_movefaster");
    self setPerk("specialty_fallheight");
    
    // Hardened Pro
    self setPerk("specialty_bulletpenetration");
    self setPerk("specialty_armorpiercing");
    self setPerk("specialty_bulletflinch");
    
    // Steady Aim Pro
    self setPerk("specialty_bulletaccuracy");
    self setPerk("specialty_sprintrecovery");
    self setPerk("specialty_fastmeleerecovery");
    
    // Sleight of Hand Pro
    self setPerk("specialty_fastreload");
    self setPerk("specialty_fastads");
    
    // Marathon Pro
    self setPerk("specialty_longersprint");
    self setPerk("specialty_unlimitedsprint");

    weapon_options = self calcWeaponOptions(0, 0, 0, 0, 0);
    self giveWeapon("l96a1_mp", 0, weapon_options);
    self setSpawnWeapon("l96a1_mp");
    self setSpawnWeapon("l96a1_mp");
    self giveWeapon("claymore_mp");
    self giveWeapon("hatchet_mp");
    self giveWeapon("concussion_grenade_mp");

    self giveStartAmmo("claymore_mp");
    self giveStartAmmo("hatchet_mp");
    self giveStartAmmo("concussion_grenade_mp");

    self setActionSlot(1, "weapon", "claymore_mp");

    if (class == "Class1")
    {
       self giveWeapon("dragunov_mp");
    }
    else if (class == "Class2")
    {
        self giveWeapon("ithaca_mp");
    }
    else if (class == "Class3")
    {
        self giveWeapon("commando_mk_dualclip_mp");
    }
    else if (class == "Class4")
    {
       self giveWeapon("famas_ir_mk_dualclip_silencer_mp");
    }

    wait 3;
    for (i = 0; i < 5; i++)
    {
        self maps\mp\gametypes\_hud_util::hidePerk(i, 2);
    }
}

changeCamo(num)
{
    //calcWeaponOptions (<camo> <lens> <reticle> <tag> <emblem>)
    camo = self calcWeaponOptions(int(num), 0, 0, 0, 0); 
    weapon = self getCurrentWeapon();

    self takeWeapon(weapon);
    wait 0.1;
    self giveWeapon(weapon, 0, camo);
    wait 0.1;
    self switchToWeapon(weapon);
}

changeLethal(lethal)
{
    primary_weapons = self getWeaponsListPrimaries();
    offhand_weapons = array_exclude(self getWeaponsList(), primary_weapons);
    offhand_weapons = array_remove(offhand_weapons, "knife_mp");
    for (i = 0; i < offhand_weapons.size; i++)
    {
        weapon = offhand_weapons[i];
        switch (weapon)
        {
            case "frag_grenade_mp":
            case "sticky_grenade_mp":
            case "hatchet_mp":
                self takeWeapon(weapon);
                self giveWeapon(lethal);
                self giveStartAmmo(lethal);
                break;
            default:
                break;
        }
    }
}

changeTactical(tactical)
{
    primary_weapons = self getWeaponsListPrimaries();
    offhand_weapons = array_exclude(self getWeaponsList(), primary_weapons);
    for (i = 0; i < offhand_weapons.size; i++)
    {
        weapon = offhand_weapons[i];
        switch (weapon)
        {
            case "willy_pete_mp":
            case "tabun_gas_mp":
            case "flash_grenade_mp":
            case "concussion_grenade_mp":
            case "nightingale_mp":
                self takeWeapon(weapon);
                self giveWeapon(tactical);
                self giveStartAmmo(tactical);
                break;
            default:
                break;
        }
    }
}
    
changeEquipment(equipment)
{
    self.myEquipment = equipment;
}

changeAttachment(attachment)
{
    weapon = self getCurrentWeapon();

    opticAttach = "";
    underBarrelAttach = "";
    clipAttach = "";
    attachmentAttach = "";

    opticWeap = "";
    underBarrelWeap = "";
    clipWeap = "";
    attachmentWeap = "";

    weaponToArray = strTok(weapon, "_");
    for (i = 0; i < weaponToArray.size; i++)
    {
        if (isAttachmentOptic(weaponToArray[i]))
        {
            opticAttach = weaponToArray[i];
        }

        if (isAttachmentUnderBarrel(weaponToArray[i]))
        {
            underBarrelAttach = weaponToArray[i];
        }

        if (isAttachmentClip(weaponToArray[i]))
        {
            clipAttach = weaponToArray[i];
        }

        if (weaponToArray[i] != "mp" && !isAttachmentClip(weaponToArray[i]) && !isAttachmentUnderBarrel(weaponToArray[i]) && !isAttachmentOptic(weaponToArray[i]) && weaponToArray[i] != weaponToArray[0])
        {
            attachmentWeap = weaponToArray[i];
        }
    }

    baseWeapon = weaponToArray[0];
    number = weaponNameToNumber(baseWeapon);

    itemRow = tableLookupRowNum("mp/statsTable.csv", level.cac_numbering, number);
    compatibleAttachments = tableLookupColumnForRow("mp/statstable.csv", itemRow, level.cac_cstring);
    if (!isSubStr(compatibleAttachments, attachment))
    {
        return;
    }

    if (attachmentWeap == attachment)
    {
        return;
    }

    if (isSubStr(baseWeapon, "dw"))
    {
        baseWeapon = getSubStr(baseWeapon, 0, baseWeapon.size - 2);
    }

    if (isSubStr(attachment, "dw"))
    {
        newWeapon = baseWeapon + "dw_mp";

        if (isDefined(self.camo))
        {
            weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
        }
        else 
        {
            self.camo = 0;
            weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
        }

        self takeWeapon(weapon);
        self GiveWeapon(newWeapon, 0, weaponOptions);
        self setSpawnWeapon(newWeapon);
        return;
    }

    if (isAttachmentOptic(attachment))
    {
        opticWeap = attachment + "_";
    }
    else if (isAttachmentUnderBarrel(attachment))
    {
        underBarrelWeap = attachment + "_";
    }
    else if (isAttachmentClip(attachment))
    {
        clipWeap = attachment + "_";
    }
    else if (!isAttachmentOptic(attachment) && !isAttachmentUnderBarrel(attachment) && !isAttachmentClip(attachment))
    {
        attachmentWeap = attachment + "_";
    }

    if (opticAttach == attachment)
    {
        opticAttach = "";
        opticWeap = "";
    }

    if (underBarrelAttach == attachment)
    {
        underBarrelAttach = "";
        underBarrelWeap = "";
    }

    if (clipAttach == attachment)
    {
        clipAttach = "";
        clipWeap = "";
    }

    if (attachmentWeap != "")
    {
        if (!isAttachmentOptic(attachmentWeap) && !isAttachmentUnderBarrel(attachmentWeap) && !isAttachmentClip(attachmentWeap))
        {
            if (!isAttachmentOptic(attachment) && !isAttachmentUnderBarrel(attachment) && !isAttachmentClip(attachment))
            {
                attachmentWeap = attachment + "_";
            }
        }
    }

    if (opticAttach != "" && opticWeap == "")
    {
        opticWeap = opticAttach + "_";
    }

    if (underBarrelAttach != "" && underBarrelWeap == "")
    {
        underBarrelWeap = underBarrelAttach + "_";
    }

    if (clipAttach != "" && clipWeap == "")
    {
        clipWeap = clipAttach + "_";
    }

    if (attachmentWeap != "")
    {
        if (!isSubStr(attachmentWeap, "_"))
        {
            attachmentWeap = attachmentWeap + "_";
        }
    }
    
    self takeWeapon(weapon);

    newWeapon = baseWeapon + "_" + opticWeap + underBarrelWeap + clipWeap + attachmentWeap + weaponToArray[weaponToArray.size - 1];
    
    if (isDefined(self.camo))
    {
        weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
    }
    else 
    {
        self.camo = 0;
        weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
    }

    self GiveWeapon(newWeapon, 0, weaponOptions);
    self setSpawnWeapon(newWeapon);
}

isAttachmentOptic(attachment)
{
    switch (attachment)
    {
        case "vzoom":
        case "acog":
        case "ir":
        case "reflex":
        case "elbit":
            return true;
        default:
            return false;
    }
}

isAttachmentUnderBarrel(attachment)
{
    if (isSubStr(attachment, "mk") || isSubStr(attachment, "ft") || isSubStr(attachment, "gl"))
    {
        return true;
    }

    return false;
}

isAttachmentClip(attachment)
{
    if (isSubStr(attachment, "extclip") || isSubStr(attachment, "dualclip"))
    {
        return true;
    }

    return false;
}

weaponNameToNumber(weapon)
{
    weaponNameLower = toLower(weapon);
    switch (weaponNameLower)
    {
        //Submachine Guns
        case "mp5k":
            return 15;
        case "skorpion":
            return 18;
        case "mac11":
            return 14;
        case "ak74u":
            return 12;
        case "uzi":
            return 20;
        case "pm63":
            return 17;
        case "mpl":
            return 16;
        case "spectre":
            return 19;
        case "kiparis":
            return 13;
        //Assault Rifles
        case "m16":
            return 35;
        case "enfield":
            return 29;
        case "m14":
            return 34;
        case "famas":
            return 30;
        case "galil":
            return 33;
        case "aug":
            return 27;
        case "fnfal":
            return 31;
        case "ak47":
            return 26;
        case "commando":
            return 28;
        case "g11":
            return 32;
        //Shotguns
        case "rottweil72":
            return 49;
        case "ithaca":
            return 48;
        case "spas":
            return 50;
        case "hs10":
            return 47;
        //Light Machine Guns
        case "hk21":
            return 37;
        case "rpk":
            return 39;
        case "m60":
            return 38;
        case "stoner63":
            return 40;
        //Snipers
        case "dragunov":
            return 42;
        case "wa2000":
            return 45;
        case "l96a1":
            return 43;
        case "psg1":
            return 44;
        //Pistols
        case "asp":
            return 1;
        case "m1911":
            return 3;
        case "makarov":
            return 4;
        case "python":
            return 5;
        case "cz75":
            return 2;
        //Launchers
        case "m72_law":
            return 53;
        case "rpg":
            return 54;
        case "strela":
            return 55;
        case "china_lake":
            return 57;
        //Specials
        case "crossbow_explosive":
            return 56;
        default:
            return 0;
    }
}
    
removeAllAttachments()
{
    weapon = self getCurrentWeapon();

    weaponToArray = strTok(weapon, "_");
    baseWeapon = weaponToArray[0];
    newWeapon = baseWeapon + "_mp";

    if (isSubStr(baseWeapon, "dw"))
    {
        baseWeaponOnly = getSubStr(baseWeapon, 0, baseWeapon.size - 2);
        newWeapon = baseWeaponOnly + "_mp";

        if (isDefined(self.camo))
        {
            weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
        }
        else 
        {
            self.camo = 0;
            weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
        }
        
        self TakeWeapon(weapon);
        self GiveWeapon(newWeapon, 0, weaponOptions);
        self setSpawnWeapon(newWeapon);
        return;
    }

    self TakeWeapon(weapon);

    if (isDefined(self.camo))
    {
        weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
    }
    else 
    {
        self.camo = 0;
        weaponOptions = self calcWeaponOptions(self.camo, 0, 0, 0, 0);
    }

    self GiveWeapon(newWeapon, 0, weaponOptions);
    self setSpawnWeapon(newWeapon);
}