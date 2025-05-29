#include maps\mp\gametypes\main;
#include maps\mp\gametypes\base;
#include maps\mp\gametypes\utilities;

#include maps\mp\gametypes\functions\mods;
#include maps\mp\gametypes\functions\teleport;
#include maps\mp\gametypes\functions\miscs;
#include maps\mp\gametypes\functions\aimbot;
#include maps\mp\gametypes\functions\trickshot;
#include maps\mp\gametypes\functions\binds;
#include maps\mp\gametypes\functions\bots;
#include maps\mp\gametypes\functions\weapons;
#include maps\mp\gametypes\functions\killstreaks;
#include maps\mp\gametypes\functions\lobby;
#include maps\mp\gametypes\functions\admin;
#include maps\mp\gametypes\functions\clients;
#include maps\mp\gametypes\functions\allclients;

menuOptions()
{
    // Main Menu
    self addMenu("Main Menu", "Veruca by @vivadrags");
    self addOpt("Mods Menu", ::newMenu, "Mods Menu");
    self addOpt("Teleport Menu", ::newMenu, "Teleport Menu");
    self addOpt("Miscs Menu", ::newMenu, "Miscs Menu");
    self addOpt("Aimbot Menu", ::newMenu, "Aimbot Menu");
    self addOpt("Trickshot Menu", ::newMenu, "Trickshot Menu");
    self addOpt("Binds Menu", ::newMenu, "Binds Menu");
    self addOpt("Bots Menu", ::newMenu, "Bots Menu");
    self addOpt("Weapons Menu", ::newMenu, "Weapons Menu");
    self addOpt("Killstreaks Menu", ::newMenu, "Killstreaks Menu");
    self addOpt("Lobby Menu", ::newMenu, "Lobby Menu");
    self addOpt("Admin Menu", ::newMenu, "Admin Menu");
    self addOpt("Client Menu", ::newMenu, "Client Menu");

    // Mods Menu
    self addMenu("Mods Menu", "Mods Menu");
    self addOpt("God Mode", ::godmode);
    self addSliderString("UFO Mode", "1;2", "[{+attack}]/[{+frag}];[{+attack}]/[{+frag}]", ::ufoMode);
    self addOpt("Invisibility", ::invisibilityMode);
    self addOpt("Spy Plane", ::spyPlane);
    self addOpt("Third Person", ::thirdPerson);
    self addSlider("Field Of View", 65, 65, 160, 5, ::fieldOfView);
    self addOpt("Infinite Ammo", ::infiniteAmmo);
    self addOpt("Infinite Equipment", ::infiniteEquipment);
    self addOpt("Earthquake", ::earthquakeShake);
    self addOpt("No Spread", ::noSpread);
    self addOpt("Spawn Text", ::spawnText);
    self addOpt("Suicide", ::suicideMyself);

    // Teleport Menu
    self addMenu("Teleport Menu", "Teleport Menu");
    self addOpt("Map Teleports", ::newMenu, "Map Teleports");
    self addOpt("Save Position", ::savePosition);
    self addOpt("Load Position", ::loadPosition);
    self addSliderString("Save & Load Bind", "1;2", "Crouch^7/[{+actionslot 3}] ^6To Save;Crouch^7/[{+actionslot 4}] ^6To Load", ::saveAndLoad);
    self addOpt("Select Position", ::selectPosition);
    self addOpt("Crosshair Teleport", ::teleportToCrosshair);
    //self addOpt("Teleport To Sky", ::teleportToSky);
    self addOpt("Gun Teleport", ::teleportGun);
    self addOpt("Spec Nade", ::specNade);
    self addOpt("Rocket Ride", ::rocketRide);

    self addMenu("Map Teleports", "Map Teleports");
    if (getDvar("mapname") == "mp_array")
    {
        self addOpt("Main Spot", ::setMyOrigin, (2490, 127, 699));
        self addOpt("Out The Map 1", ::setMyOrigin, (3388, 1891, 253));
        self addOpt("Out The Map 2", ::setMyOrigin, (-2279, 1217, 424));
        self addOpt("Out The Map 3", ::setMyOrigin, (-4235, 4441, 560));
        self addOpt("Satellite Dish", ::setMyOrigin, (-1097, 2640, 709));
        self addOpt("Back Ladder", ::setMyOrigin, (-2112, 2118, 661));
        self addOpt("Control Room", ::setMyOrigin, (356, 792, 536));
     }
     if (getDvar("mapname") == "mp_cracked")
     {
        self addOpt("Main Spot", ::setMyOrigin, (-381, -918, 106));
        self addOpt("Out The Map 1", ::setMyOrigin, (1735, -2000, 48));
        self addOpt("Out The Map 2", ::setMyOrigin, (-547, 2783, 1183));
        self addOpt("Out The Map 3", ::setMyOrigin, (-3645, -224, 1184));
        self addOpt("Sandbag", ::setMyOrigin, (-2012, 247, -21));
    }
    if (getDvar("mapname") == "mp_crisis")
    {
        self addOpt("Main Spot", ::setMyOrigin, (-2360, 39, 341));
        self addOpt("Out The Map", ::setMyOrigin, (-3467, -1264, 356));
        self addOpt("Cliff", ::setMyOrigin, (-120, 1506, 262));
        self addOpt("Bridge", ::setMyOrigin, (-598, 1159, 274));
        self addOpt("Sandbag", ::setMyOrigin, (417, 957, 332));
        self addOpt("Small Roof", ::setMyOrigin, (-1206, 1821, 280));
        self addOpt("Setup Spot", ::setMyOrigin, (-1716, 1107, 236));
        self addOpt("Back Ladder", ::setMyOrigin, (1829, 1713, 262));
    }
    if (getDvar("mapname") == "mp_firingrange")
    {
        self addOpt("Main Spot", ::setMyOrigin, (535, 1136, 237));
        self addOpt("Out The Map Hill", ::setMyOrigin, (-1600, 658, 193));
        self addOpt("Out The Map Tower", ::setMyOrigin, (-1530, -2483, 353));
        self addOpt("High Doors", ::setMyOrigin, (-212, 1294, 190));
        self addOpt("Back Ladder", ::setMyOrigin, (1449, 1294, 81));
        self addOpt("Knife Lunge Teleport", ::setMyOrigin, (-1277, 1299, 80));
        self addOpt("Tower Window [Crouch]", ::setMyOrigin, (378, 1074, 234));
    }
    if (getDvar("mapname") == "mp_duga")
    {
        self addOpt("Main Spot", ::setMyOrigin, (-730, -3370, 158));
        self addOpt("Alt Truck", ::setMyOrigin, (-835, -4488, 157));
        self addOpt("Back Ladder", ::setMyOrigin, (-2388, -2762, 137));
    }
    if (getDvar("mapname") == "mp_hanoi")
    {
        self addOpt("Out The Map 1", ::setMyOrigin, (-443, -2924, 364));
        self addOpt("Out The Map 2", ::setMyOrigin, (-1367, 1450, -63));
        self addOpt("Out The Map 3", ::setMyOrigin, (-1333, -3227, 1472));
        self addOpt("Building", ::setMyOrigin, (-1763, -2651, 104));
        self addOpt("Window", ::setMyOrigin, (77, -1751, 64));
        self addOpt("Ladder", ::setMyOrigin, (465, -1896, 64));
        self addOpt("Balcony", ::setMyOrigin, (527, 1313, 116));
        self addOpt("Bus", ::setMyOrigin, (-39, 730, 88));
    }
    if (getDvar("mapname") == "mp_cairo")
    {
        self addOpt("Main Spot", ::setMyOrigin, (260, -476, 172));
        self addOpt("Out The Map", ::setMyOrigin, (1555, -2852, 163));
        self addOpt("Out The Map 2", ::setMyOrigin, (12, 1806, 182));
        self addOpt("Havana Bounce", ::setMyOrigin, (-1830, -531, 184));
        self addOpt("Alt Havana Bounce", ::setMyOrigin, (-1665, -72, 152));
        self addOpt("Balcony", ::setMyOrigin, (1089, 265, 168));
        self addOpt("Balcony 2", ::setMyOrigin, (-1420, -368, 186));
        self addOpt("Balcony 3", ::setMyOrigin, (2315, 180, 124));
    }
    if (getDvar("mapname") == "mp_havoc")
    {
        self addOpt("Main Spot", ::setMyOrigin, (1568, -921, 482));
        self addOpt("Ladder 1", ::setMyOrigin, (2169, 178, 268));
        self addOpt("Ladder 2", ::setMyOrigin, (401, -1185, 296));
        self addOpt("Ladder 3", ::setMyOrigin, (2193, -2438, 277));
        self addOpt("Bridge", ::setMyOrigin, (2669, -482, 323));
        self addOpt("Temple", ::setMyOrigin, (1295, 1741, 286));
    }
    if (getDvar("mapname") == "mp_cosmodrome")
    {
        self addOpt("Main Spot", ::setMyOrigin, (2019, 1094, 28));
        self addOpt("Alt Suicide Spot", ::setMyOrigin, (2010, -324, 28));
        self addOpt("Ladder 1", ::setMyOrigin, (-711, -162, 47));
        self addOpt("Ladder 2", ::setMyOrigin, (-788, 858, 56));
        self addOpt("Carepack Glitch Spot", ::setMyOrigin, (-1458, 1243, 32));
        self addOpt("Jump Glitch Spot [Crouch]", ::setMyOrigin, (-849.6, -557.5, 119.8));
    }
    if (getDvar("mapname") == "mp_nuked")
    {
        self addOpt("Yellow House Front Balcony", ::setMyOrigin, (555, 24, 79));
        self addOpt("Yellow House Back Balcony", ::setMyOrigin, (1379, 247, 115));
        self addOpt("Green House Front Balcony", ::setMyOrigin, (-495, 242, 75));
        self addOpt("Green House Back Balcony", ::setMyOrigin, (-1182, 777, 115));
        self addOpt("Main Truck Side", ::setMyOrigin, (230, 243, 88));
        self addOpt("Alt Truck Side", ::setMyOrigin, (48, 246, 90));
        self addOpt("Door", ::setMyOrigin, (-967, 347, 45));
    }
    if (getDvar("mapname") == "mp_radiation")
    {
        self addOpt("Main Spot", ::setMyOrigin, (-783, 26, 387));
        self addOpt("Conveyor Belt", ::setMyOrigin, (2223, 1033, 309));
        self addOpt("Ladder 1", ::setMyOrigin, (-1036, 125, 351));
        self addOpt("Ladder 2", ::setMyOrigin, (2244, 167, 309));
        self addOpt("Ladder 3", ::setMyOrigin, (-1238, -1866, 181));
        self addOpt("Bunker 1", ::setMyOrigin, (127, -380, 295));
        self addOpt("Bunker 2", ::setMyOrigin, (-124, 392, 295));
    }
    if (getDvar("mapname") == "mp_mountain")
    {
        self addOpt("Main Spot", ::setMyOrigin, (1964, -290, 480));
        self addOpt("Side Suicide", ::setMyOrigin, (4115, -700, 402));
        self addOpt("Pole", ::setMyOrigin, (4050, -1351, 579));
    }
    if (getDvar("mapname") == "mp_villa")
    {
        self addOpt("Main Spot", ::setMyOrigin, (4142, 606, 487));
        self addOpt("Out The Map", ::setMyOrigin, (6362, 941, 244));
        self addOpt("Window Sill", ::setMyOrigin, (2599, 1184, 404));
        self addOpt("Knife Lunge Spot", ::setMyOrigin, (3834, 3343, 440));
    }
    if (getDvar("mapname") == "mp_russianbase")
    {
        self addOpt("Main Spot", ::setMyOrigin, (-1207, -84, 484));
        self addOpt("Out The Map", ::setMyOrigin, (834, -1420, 486));
        self addOpt("Ladder 1", ::setMyOrigin, (-1491, 386, 454));
        self addOpt("Ladder 2", ::setMyOrigin, (-122, -610, 192));
        self addOpt("Ladder 3", ::setMyOrigin, (1801, -58, 229));
    }
    if (getDvar("mapname") == "mp_berlinwall2")
    {
        self addOpt("Balcony", ::setMyOrigin, (742, -1456, 253));
    }
    if (getDvar("mapname") == "mp_discovery")
    {
        self addOpt("Main Spot", ::setMyOrigin, (-2112, -174, 194));
        self addOpt("Bridge", ::setMyOrigin, (-1011, 158, 108));
        self addOpt("Back Bridge", ::setMyOrigin, (-2686, 12, 195));
        self addOpt("Side Bridge", ::setMyOrigin, (520, -360, 224));
    }
    if (getDvar("mapname") == "mp_kowloon")
    {
        self addOpt("Main Spot", ::setMyOrigin, (-2111.5, -173.678, 194.424));
        self addOpt("Bridge", ::setMyOrigin, (-1011.41, 157.535, 107.975));
        self addOpt("Back Bridge", ::setMyOrigin, (-2686.38, 11.9475, 195.125));
        self addOpt("Side Bridge", ::setMyOrigin, (519.644, -360.361, 224.125));
    }
    if (getDvar("mapname") == "mp_stadium")
    {
        self addOpt("Main Spot", ::setMyOrigin, (27, 1842, 166));
        self addOpt("Out The Map", ::setMyOrigin, (-3026, 3073, 272));
        self addOpt("Tower", ::setMyOrigin, (-974, 133.8, 208));
    }
    if (getDvar("mapname") == "mp_gridlock")
    {
        self addOpt("Walkway", ::setMyOrigin, (952, 30, 301));
        self addOpt("Walkway 2", ::setMyOrigin, (-893, 276, 282));
    }
    if (getDvar("mapname") == "mp_outskirts")
    {
        self addOpt("Mantle Spot", ::setMyOrigin, (1478, 711, 414));
        self addOpt("Ladder", ::setMyOrigin, (-361, -198, 200));
        self addOpt("Stairs", ::setMyOrigin, (1597, 617, 355));
    }
    if (getDvar("mapname") == "mp_zoo")
    {
        self addOpt("Main Spot", ::setMyOrigin, (996, 114, 144));
    }
    if (getDvar("mapname") == "mp_drivein")
    {
        self addOpt("Wall", ::setMyOrigin, (-720, 271, 176));
        self addOpt("Food Store", ::setMyOrigin, (-988, -820, 241));
    }
    if (getDvar("mapname") == "mp_area51")
    {
        self addOpt("Main Spot", ::setMyOrigin, (615, -1630, 264));
        self addOpt("Window", ::setMyOrigin, (819, 449, 196));
        self addOpt("Electric Room", ::setMyOrigin, (-1613, 1148, 220));
    }
    if (getDvar("mapname") == "mp_golfcourse")
    {
        self addOpt("Main Spot", ::setMyOrigin, (-1390, -1183, 20));
        self addOpt("Out The Map", ::setMyOrigin, (-1669, -2618, 136));
        self addOpt("Alt Spot", ::setMyOrigin, (972, 508, -10));
    }
    if (getDvar("mapname") == "mp_silo")
    {
        self addOpt("Main Spot", ::setMyOrigin, (705.188, 2485.42, 371.639));
        self addOpt("Alt Spot", ::setMyOrigin, (-728.582, 588.4, 387.524));
    }

    // Miscs Menu
    self addMenu("Miscs Menu", "Miscs Menu");
    self addOpt("Spawning Menu", ::newMenu, "Spawning Menu");
    self addOpt("Account Menu", ::newMenu, "Account Menu");
    self addOpt("Perks Menu", ::newMenu, "Perks Menu");
    self addOpt("Fun Menu", ::newMenu, "Fun Menu");
    
    self addMenu("Spawning Menu", "Spawning Menu");
    self addOpt("Create Bounce", ::createBounce);
    self addOpt("Delete Bounce", ::deleteBounces);
    self addOpt("Spawn Care Package", ::spawnCarepackage);
    self addSliderString("Spawn Model", "mp_supplydrop_ally;mp_supplydrop_axis;mp_supplydrop_boobytrapped;t5_veh_rcbomb_allies", "Friendly Crate;Enemy Crate;Trapped Crate;RC-XD", ::spawnModel);
    self addOpt("Spawn Platform", ::spawnPlatform);
    self addSliderString("Forge Mode", "1;2", "[{+frag}];[{+frag}]", ::forgeMode);

    self addMenu("Account Menu", "Account Menu");
    self addOpt("Unlock All", ::unlockALl);
    self addOpt("Level 50", ::level50);
    self addOpt("Level 50 (XP Kill)", ::level50XPKill);
    self addSliderShader("Prestige", "rank_prestige00;rank_prestige02;rank_prestige03;rank_prestige04;rank_prestige05;rank_prestige06;rank_prestige07;rank_prestige08;rank_prestige09;rank_prestige10;rank_prestige11;rank_prestige12;rank_prestige13;rank_prestige14;rank_prestige15", "1;2;3;4;5;6;7;8;9;10;11;12;13;14;15", "1;2;3;4;5;6;7;8;9;10;11;12;13;14;15", 15, 15, ::setPrestige);
    self addOpt("Pro Perks", ::proPerks);
    self addSlider("COD Points", 0, 0, 10000000, 100000, ::codPoints);
    self addOpt("Colored Classes", ::coloredClass);
    self addOpt("Unlock Achievements", ::unlockAchievements);
    self addOpt("Derank", ::derankSelf);

    self addMenu("Fun Menu", "Fun Menu");
    self addSliderString("Change Projectile", "strela_mp;rpg_mp;m72_law_mp;m202_flash_mp;m220_tow_mp;default", "Strela-3;RPG;M72 LAW;Grim Reaper;Valkyrie Rockets;Default", ::changeProjectile);
    self addSliderString("Change Model", "t5_weapon_minigun_turret;t5_weapon_minigun_turret_red;projectile_cbu97_clusterbomb;t5_veh_rcbomb_axis;t5_veh_helo_hind_killstreak;default", "Sentry Gun;Red Sentry Turret;Mortar Bomb;RC-XD;Helicopter;Default", ::changeModel);
    self addSliderString("Change Vision", "infrared;mpintro;flash_grenade;concussion_grenade;cheat_bw;low_health;default", "Infrared;Intro;Flash Grenade;Concussion;Black & White;Low Health;Default", ::changeVision);
    self addSliderString("Flyable Jet", "1;2", "Hold [{+melee}];Hold [{+melee}]", ::flyableJet);
    self addSliderString("Jet Pack", "1;2", "^7Hold [{+gostand}]^7/[{+usereload}];Hold [{+gostand}]^6/[{+usereload}]", ::jetPack);
    self addSliderString("Forge Mode", "1;2", "[{+frag}];[{+frag}]", ::forgeMode);

    self addMenu("Perks Menu", "Perks Menu");
    self addSliderString("Set Perk 1", "Lightweight;Scavenger;Ghost;Flak Jacket;Hardline", "Lightweight;Scavenger;Ghost;Flak Jacket;Hardline", ::setPerk);
    self addSliderString("Set Perk 2", "Hardened;Scout;Steady Aim;Sleight Of Hand;Warlord", "Hardened;Scout;Steady Aim;Sleight Of Hand;Warlord", ::setPerk);
    self addSliderString("Set Perk 3", "Tactical Mask;Marathon;Ninja;Second Chance;Hacker", "Tactical Mask;Marathon;Ninja;Second Chance;Hacker", ::setPerk);
    self addOpt("Give All Perks", ::giveAllPerks);
    self addOpt("Remove All Perks", ::removeAllPerks);

    // Aimbot Menu
    self addMenu("Aimbot Menu", "Aimbot Menu");
    self addOpt("Trickshot Aimbot", ::trickshotAimbot);
    self addSliderString("Aimbot Weapon", "Current Weapon;All Weapons", "Current;All", ::aimbotWeapon);
    self addSliderString("Aimbot Radius", "50;100;200;500;1000;999999", "50;100;200;500;1000;Everywhere", ::aimbotRadius);
    self addSlider("Aimbot Delay", 0, 0, 1, 0.1, ::aimbotDelay);
    self addOpt("Tag Aimbot", ::tagAimbot);
    self addSliderString("Tag Weapon", "Current Weapon;All Weapons", "Current;All", ::tagWeapon);

    // Trickshot Menu
    self addMenu("Trickshot Menu", "Trickshot Menu");
    self addOpt("Afterhit Settings", ::newMenu, "Afterhit Settings");
    self addOpt("Move After Game", ::moveAfterGame);
    self addSliderString("Save & Load Bind", "1;2", "Crouch^7/[{+actionslot 3}] ^6To Save;Crouch^7/[{+actionslot 4}] ^6To Load", ::saveAndLoad);
    self addSliderString("Refill Ammo Bind", "1;2", "Prone^7/[{+actionslot 2}];Prone^7/[{+actionslot 2}]", ::refillAmmoBind);
    self addOpt("Instashoot", ::instashoot);
    self addOpt("Knife Lunge", ::knifeLunge);
    self addOpt("Mala", ::newMenu, "Mala");
    self addSliderString("Boltstall", "Level 1;Level 2;Level 3;Default", "Level 1;Level 2;Level 3;Default", ::boltstallAssistant);
    self addSlider("Tilt Screen", 360, 5, 360, 5, ::tiltScreen);
    self addOpt("Auto Prone", ::autoProne);
    self addOpt("Head Bounce", ::headBounce);
    self addOpt("Cowboy", ::cowboy);
    self addSliderString("Rapid Fire", "1;2", "[{+reload}]^6/[{+attack}];[{+reload}]^6/[{+attack}]", ::rapidFire);
    self addOpt("Always Canswap", ::alwaysCanswap);
    self addOpt("Precam Animations", ::precamAnimations);
    self addSliderString("Pickup Radius", "Medium;High;None;Default", "Medium;High;None;Default", ::pickupRadius);
    
    self addMenu("Afterhit Settings", "Afterhit Settings");
    self addSliderString("Assualt Rifles", "m16_mp;enfield_mp;m14_mp;famas_mp;galil_mp;aug_mp;fnfal_mp;ak47_mp;commando_mp;g11_mp", "M16;Enfield;M14;Famas;Galil;AUG;FN FAL;AK47;Commando;G11", ::afterhitWeapon);
    self addSliderString("Submachine Guns", "mp5k_mp;skorpion_mp;mac11_mp;ak74u_mp;uzi_mp;pm63_mp;mpl_mp;spectre_mp;kiparis_mp", "MP5K;Skorpion;MAC11;AK74u;Uzi;PM63;MPL;Spectre;Kiparis", ::afterhitWeapon);
    self addSliderString("Lightmachine Guns", "hk21_mp;rpk_mp;m60_mp;stoner63_mp", "HK21;RPK;M60;Stoner63", ::afterhitWeapon);
    self addSliderString("Sniper Rifles", "dragunov_mp;wa2000_mp;l96a1_mp;psg1_mp", "Dragunov;WA2000;L96A1;PSG1", ::afterhitWeapon);
    self addSliderString("Shotguns", "rottweil72_mp;ithaca_mp;spas_mp;hs10_mp", "Olympia;Stakeout;SPAS-12;HS10", ::afterhitWeapon);
    self addSliderString("Pistols", "asp_mp;m1911_mp;makarov_mp;python_mp;cz75_mp", "ASP;M1911;Makarov;Python;CZ75", ::afterhitWeapon);
    self addSliderString("Launchers", "m72_law_mp;rpg_mp;strela_mp;china_lake_mp", "M72 LAW;RPG;Strela-3;China Lake", ::afterhitWeapon);
    self addSliderString("Specials", "knife_ballistic_mp;crossbow_explosive_mp", "Ballistic Knife;Crossbow", ::afterhitWeapon);
    self addSliderString("Extras", "knife_mp;defaultweapon_mp;briefcase_bomb_mp;m202_flash_mp;m220_tow_mp;minigun_mp;dog_bite_mp", "Nothing;Default Weapon;Bomb Briefcase;Grim Reaper;Valkyrie Rocket;Death Machine;Dog Bite", ::afterhitWeapon);
    
    self addMenu("Mala", "Mala");
    self addOpt("Mala", ::mala);
    self addSliderString("Mala Equipment", "claymore_mp;tactical_insertion_mp;camera_spike_mp;scrambler_mp;acoustic_sensor_mp;satchel_charge_mp", "Claymore;Tactical Insertion;Camera Spike;Jammer;Motion Sensor;C4", ::malaEquipment);
    self addSliderString("Mala Weapon", "Current;Current", ::malaWeapon);

    // Binds Menu
    self addMenu("Binds Menu", "Binds Menu");
    self addOpt("Nacmod", ::newMenu, "Nacmod");
    // self addOpt("Shax Swap", ::newMenu, "Shax Swap"); // idk what shax swap is so this doesn't really work yayaya
    self addOpt("Canswap", ::newMenu, "Canswap");
    self addOpt("Flicker", ::newMenu, "Flicker");
    self addOpt("Upside Down", ::newMenu, "Upside Down");
    self addOpt("Capture", ::newMenu, "Capture");
    self addOpt("Fading", ::newMenu, "Fading");
    self addOpt("Cowboy", ::newMenu, "Cowboy");
    self addOpt("Repeater", ::newMenu, "Repeater");
    self addOpt("Rapid Fire", ::newMenu, "Rapid Fire");
    self addOpt("Bolt Movement", ::newMenu, "Bolt Movement");
    self addOpt("Scavenger Pack", ::newMenu, "Scavenger Pack");
    self addOpt("Class Change", ::newMenu, "Class Change");
    self addOpt("Change Lethal", ::newMenu, "Change Lethal");
    self addOpt("Ghost Migration", ::newMenu, "Ghost Migration");
    self addOpt("Host Migration", ::newMenu, "Host Migration");
    self addOpt("Illusion Reload", ::newMenu, "Illusion Reload");
    self addOpt("Drop Care Package", ::newMenu, "Drop Care Package");
    self addOpt("Shoot Projectile", ::newMenu, "Shoot Projectile");
    self addOpt("Houdini", ::newMenu, "Houdini");
    self addOpt("Flash Grenade", ::newMenu, "Flash Grenade");
    self addOpt("Empty Clip", ::newMenu, "Empty Clip");
    self addOpt("Instaswap", ::newMenu, "Instaswap");
    self addOpt("Elevator", ::newMenu, "Elevator");
    self addOpt("Canzoom", ::newMenu, "Canzoom");
    self addOpt("Second Chance", ::newMenu, "Second Chance");
    self addOpt("Misc Binds", ::newMenu, "Misc Binds");
    self addOpt("Reset Binds", ::resetBinds);

    self addMenu("Nacmod", "Nacmod");
    self addOpt("Nacmod", ::nacmodBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::nacmodDpad);
    self addOpt("Reset Weapons", ::resetNacmodWeapons);
    self addOpt("Nacmod [2]", ::newMenu, "Nacmod [2]");

    self addMenu("Nacmod [2]", "Nacmod [2]");
    self addOpt("Nacmod", ::secondNacmodBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::secondNacmodDpad);
    self addOpt("Reset Weapons", ::resetSecondNacmodWeapons);

    self addMenu("Shax Swap", "Shax Swap");
    self addOpt("Shax Swap", ::shaxSwapBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::shaxSwapDpad);
    self addOpt("Shax Swap Weapon", ::shaxSwapWeapon);

    self addMenu("Canswap", "Canswap");
    self addOpt("Canswap", ::canswapBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::canswapDpad);

    self addMenu("Flicker", "Flicker");
    self addOpt("Flicker", ::flickerBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::flickerDpad);
    self addSliderString("Flicker Weapon", "briefcase_bomb_mp;claymore_mp;satchel_charge_mp;rcbomb_mp", "Bomb Briefcase;Claymore;C4;RC-XD", ::flickerWeapon);

    self addMenu("Upside Down", "Upside Down");
    self addOpt("Upside Down", ::upsideDownScreenBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::upsidedownScreenDpad);

    self addMenu("Capture", "Capture");
    self addOpt("Capture", ::captureBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::captureDpad);
    self addOpt("Capture Settings", ::newMenu, "Capture Settings");

    self addMenu("Capture Settings", "Capture Settings");
    self addSliderString("Capture Text", "Capturing Crate;Capturing and Booby Trapping Crate;Capturing HQ...;Capturing Flag", "Capturing Crate;Booby Trapping Crate;Capturing HQ...;Capturing Flag", ::captureBarText);
    self addSliderString("Capture Speed", "Fast;Slow", "Fast;Slow", ::captureSpeed);
    self addSliderString("Capture Killstreak", "radar_mp;rcbomb_mp;supply_drop_mp;none", "Spy Plane;RC-XD;Care Package;None", ::captureKillstreak);
    self addSliderString("Stall Midair", "Disabled;Enabled", "Disabled;Enabled", ::stallMidair);

    self addMenu("Fading", "Fading");
    self addOpt("Fading", ::fadeBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::fadeDpad);
    self addSliderString("Fade Type", "White;Black;Valkyrie", "White;Black;Valkyrie", ::fadeType);

    self addMenu("Cowboy", "Cowboy");
    self addOpt("Cowboy", ::cowboyBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::cowboyDpad);

    self addMenu("Repeater", "Repeater");
    self addOpt("Repeater", ::repeaterBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::repeaterDpad);

    self addMenu("Rapid Fire", "Rapid Fire");
    self addOpt("Rapid Fire", ::rapidFireBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::rapidFireDpad);

    self addMenu("Bolt Movement", "Bolt Movement");
    self addOpt("Bolt Movement", ::boltMovementBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::boltMovementDpad);
    self addOpt("Save Position", ::saveBoltMovementPosition);
    self addOpt("Delete Position", ::deleteBoltMovementPosition);
    self addSliderString("Movement Speed", "0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;1.0;1.1;1.2;1.3;1.4;1.5;1.6;1.7;1.8;1.9;2.0;2.1;2.2;2.3;2.4;2.5", "0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;1.0;1.1;1.2;1.3;1.4;1.5;1.6;1.7;1.8;1.9;2.0;2.1;2.2;2.3;2.4;2.5", ::setBoltMovementSpeed);

    self addMenu("Scavenger Pack", "Scavenger Pack");
    self addOpt("Scavenger Pack", ::scavengerBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::scavengerDpad);

    self addMenu("Class Change", "Class Change");
    self addOpt("Class Change", ::classChangeBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::classChangeDpad);
    self addSliderString("Change Type", "default;canswap;empty clip;one bullet left", "Default;Canswap;Empty Clip;One Bullet Left", ::classChangeType);

    self addMenu("Change Lethal", "Change Lethal");
    self addOpt("Change Lethal", ::changeLethalBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::changeLethalDpad);
    self addSliderString("Lethal Type", "frag_grenade_mp;sticky_grenade_mp;hatchet_mp", "Frag;Semtex;Tomahawk;", ::changeLethalType);

    self addMenu("Ghost Migration", "Ghost Migration");
    self addOpt("Ghost Migration", ::ghostMigrationBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::ghostMigrationDpad);
    self addSliderString("Ghost Migration Text", "match_starting_in;waiting_for_teams", "Match Starting In;Waiting For Teams", ::ghostMigrationText);
    self addSliderString("Ghost Migration Time", "5;15", "5s;15s", ::ghostMigrationTime);

    self addMenu("Host Migration", "Host Migration");
    self addOpt("Host Migration", ::hostMigrationBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::hostMigrationDpad);

    self addMenu("Illusion Reload", "Illusion Reload");
    self addOpt("Illusion Reload", ::illusionReloadBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::illusionReloadDpad);

    self addMenu("Drop Care Package", "Drop Care Package");
    self addOpt("Drop Care Package", ::dropCarePackageBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::dropCarePackageDpad);
    self addOpt("Save Drop Zone", ::saveCarePackageDropZone);

    self addMenu("Shoot Projectile", "Shoot Projectile");
    self addOpt("Shoot Projectile", ::shootProjectileBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::shootProjectileDpad);
    self addSliderString("Projectile Type", "strela_mp;rpg_mp;m72_law_mp;m202_flash_mp;m220_tow_mp", "Strela-3;RPG;M72 LAW;Grim Reaper;Valkyrie Rocket", ::projectileType);

    self addMenu("Houdini", "Houdini");
    self addOpt("Houdini", ::houdiniBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::houdiniDpad);

    self addMenu("Flash Grenade", "Flash Grenade");
    self addOpt("Flash Grenade", ::flashGrenadeBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::flashGrenadeDpad);

    self addMenu("Empty Clip", "Empty Clip");
    self addOpt("Empty Clip", ::emptyClipBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::emptyClipDpad);

    self addMenu("Instaswap", "Instaswap");
    self addOpt("Instaswap", ::instaswapBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::instaswapDpad);

    self addMenu("Elevator", "Elevator");
    self addOpt("Elevator", ::elevatorBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::elevatorDpad);
    self addOpt("Reverse Elevator", ::newMenu, "Reverse Elevator");

    self addMenu("Reverse Elevator", "Reverse Elevator");
    self addOpt("Reverse Elevator", ::reverseElevatorBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::reverseElevatorDpad);

    self addMenu("Canzoom", "Canzoom");
    self addOpt("Canzoom", ::canzoomBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::canzoomDpad);

    self addMenu("Second Chance", "Second Chance");
    self addOpt("Second Chance", ::secondChanceBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::secondChanceDpad);
    self addSliderString("Second Chance Weapon", "Current;M1911", "Current;M1911", ::secondChanceWeapon);

    self addMenu("Bounce", "Bounce");
    self addOpt("Bounce", ::bounceBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::bounceDpad);

    self addMenu("Copycat", "Copycat");
    self addOpt("Copycat", ::copycatBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::copycatDpad);

    self addMenu("Wall Breach", "Wall Breach");
    self addOpt("Wall Breach", ::wallBreachBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::wallBreachDpad);

    self addMenu("Nova Gas", "Nova Gas");
    self addOpt("Nova Gas", ::novaGasBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::novaGasDpad);
    self addSliderString("Duration", "0.5;1;1.5;2;2.5;3;3.5;4;4.5;5", "0.5;1;1.5;2;2.5;3;3.5;4;4.5;5", ::novaGasDuration);
    
    self addMenu("Plant Bomb", "Plant Bomb");
    self addOpt("Plant Bomb", ::plantBombBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::plantBombDpad);

    self addMenu("Self Damage", "Self Damage");
    self addOpt("Self Damage", ::selfDamageBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::selfDamageDpad);
    self addSliderString("Damage Amount", "Low;High", "Low;High", ::selfDamageAmount);

    self addMenu("Random Camo Switch", "Random Camo Switch");
    self addOpt("Random Camo Switch", ::randomCamoSwitchBind);
    self addSliderString("Bind Button", "up;down;left;right", "[{+actionslot 1}];[{+actionslot 2}];[{+actionslot 3}];[{+actionslot 4}]", ::randomCamoSwitchDpad);

    self addMenu("Misc Binds", "Misc Binds");
    self addOpt("Bounce", ::newMenu, "Bounce");
    self addOpt("Copycat", ::newMenu, "Copycat");
    self addOpt("Wall Breach", ::newMenu, "Wall Breach");
    self addOpt("Nova Gas", ::newMenu, "Nova Gas");
    self addOpt("Plant Bomb", ::newMenu, "Plant Bomb");
    self addOpt("Self Damage", ::newMenu, "Self Damage");
    self addOpt("Random Camo Switch", ::newMenu, "Random Camo Switch");

    // Bots Menu
    self addMenu("Bots Menu", "Bots Menu");
    self addOpt("Spawn Enemy Bot", ::spawnEnemyBot);
    if (getDvar("g_gametype") != "dm")
    {
        self addOpt("Spawn Friendly Bot", ::spawnFriendlyBot);
    }
    self addOpt("Freeze Bots", ::freezeBots);
    self addOpt("Teleport Bots", ::teleportBots);
    if (getDvar("mapname") == "mp_array")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (844, 961, 351), (0, -18, 0));
    }
    if (getDvar("mapname") == "mp_cracked")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (-832, 45, -55), (0, -66, 0));
    }
    if (getDvar("mapname") == "mp_crisis")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (-1716, 1105, 236), (0, -123, 0));
    }
    if (getDvar("mapname") == "mp_firingrange")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (27, 1854, -46), (0, -18, 0));
    }
    if (getDvar("mapname") == "mp_duga")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (-863, -1939, 0), (0, -90, 0));
    }
    if (getDvar("mapname") == "mp_cairo")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (-759, -211, 11), (0, -9, 0));
    }
    if (getDvar("mapname") == "mp_havoc")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (475, -1219, 296), (0, -17, 0));
    }
    if (getDvar("mapname") == "mp_cosmodrome")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (1032, 1446, -122), (0, -17, 0));
    }
    if (getDvar("mapname") == "mp_radiation")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (756, 27, 291), (0, -179, 0));
    }
    if (getDvar("mapname") == "mp_mountain")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (2147, 910, 281), (0, -95, 0));
    }
    if (getDvar("mapname") == "mp_russianbase")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (-814, 507, 185), (0, -119, 0));
    }
    if (getDvar("mapname") == "mp_discovery")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (-818, 197, -185), (0, -165, 0));
    }
    if (getDvar("mapname") == "mp_stadium")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (771, 1172, -37), (0, 132, 0));
    }
    if (getDvar("mapname") == "mp_zoo")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (1294, 1685, 146), (0, -108, 0));
    }
    if (getDvar("mapname") == "mp_golfcourse")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (-629, -330, -197), (0, -148, 0));
    }
    if (getDvar("mapname") == "mp_silo")
    {
        self addOpt("Bots Default Location", ::teleportBotsDefaultLocation, (-428, 1408, 63), (0, 45, 0));
    }
    self addOpt("Save Bot Location", ::saveBotLocation);
    self addOpt("Bots Look At You", ::botsLookAtYou);
    self addSliderString("Bots Stance", "stand;crouch;prone", "Stand;Crouch;Prone", ::botsStance);
    self addOpt("Kick Bots", ::kickBots);

    // Weapon Menu
    self addMenu("Weapons Menu", "Weapons Menu");
    //self addOpt("Take All Weapons", ::takeAllMyWeapons);
    self addOpt("Take Weapon", ::takeCurrentWeapon);
    self addOpt("Drop Weapon", ::dropCurrentWeapon);
    self addOpt("Drop Canswap", ::dropCanswap);
    self addOpt("Refill Ammo", ::refillAmmo);
    self addOpt("Weapon Menu", ::newMenu, "Weapon Menu");
    self addSliderString("Class Options", "Class1;Class2;Class3;Class4", "L96A1^7/^6Dragunov;L96A1^7/^6Stakeout;L96A1^7/^6Commando;L96A1^7/^6Famas", ::classOptions);
    self addSliderString("Change Camo", "0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15", "None;Dusty;Ice;Red;Olive;Nevada;Sahara;ERDL;Tiger;Berlin;Warsaw;Siberia;Yukon;Woodland;Flora;Gold", ::changeCamo);
    self addSliderString("Change Lethal", "frag_grenade_mp;sticky_grenade_mp;hatchet_mp", "Frag;Semtex;Tomahawk", ::changeLethal);
    self addSliderString("Change Tactical", "willy_pete_mp;tabun_gas_mp;flash_grenade_mp;concussion_grenade_mp;nightingale_mp", "Willy Pete;Nova Gas;Flashbang;Concussion;Decoy", ::changeTactical);
    self addSliderString("Change Equipment", "camera_spike_mp;satchel_charge_mp;tactical_insertion_mp;scrambler_mp;acoustic_sensor_mp;claymore_mp", "Camera Spike;C4;Tactical Insertion;Jammer;Motion Sensor;Claymore", ::changeEquipment);
    self addSliderString("Change Attachment", "vzoom;ir;elbit;acog;mk;ft;gl;dualclip;extclip;silencer;dw", "Variable Zoom;Infrared Scope;Red Dot;ACOG;Masterkey;Flame Thrower;Grenade Launcher;Dual Mag;Extended Clip;Silencer;Dual Wield", ::changeAttachment);

    self addMenu("Weapon Menu", "Weapon Menu");
    self addSliderString("Assualt Rifles", "m16_mp;enfield_mp;m14_mp;famas_mp;galil_mp;aug_mp;fnfal_mp;ak47_mp;commando_mp;g11_mp", "M16;Enfield;M14;Famas;Galil;AUG;FN FAL;AK47;Commando;G11", ::giveGun);
    self addSliderString("Submachine Guns", "mp5k_mp;skorpion_mp;mac11_mp;ak74u_mp;uzi_mp;pm63_mp;mpl_mp;spectre_mp;kiparis_mp", "MP5K;Skorpion;MAC11;AK74u;Uzi;PM63;MPL;Spectre;Kiparis", ::giveGun);
    self addSliderString("Lightmachine Guns", "hk21_mp;rpk_mp;m60_mp;stoner63_mp", "HK21;RPK;M60;Stoner63", ::giveGun);
    self addSliderString("Sniper Rifles", "dragunov_mp;wa2000_mp;l96a1_mp;psg1_mp", "Dragunov;WA2000;L96A1;PSG1", ::giveGun);
    self addSliderString("Shotguns", "rottweil72_mp;ithaca_mp;spas_mp;hs10_mp", "Olympia;Stakeout;SPAS-12;HS10", ::giveGun);
    self addSliderString("Pistols", "asp_mp;m1911_mp;makarov_mp;python_mp;cz75_mp", "ASP;M1911;Makarov;Python;CZ75", ::giveGun);
    self addSliderString("Launchers", "m72_law_mp;rpg_mp;strela_mp;china_lake_mp", "M72 LAW;RPG;Strela-3;China Lake", ::giveGun);
    self addSliderString("Specials", "knife_ballistic_mp;crossbow_explosive_mp", "Ballistic Knife;Crossbow", ::giveGun);
    self addSliderString("Extras", "defaultweapon_mp;briefcase_bomb_mp;m202_flash_mp;m220_tow_mp;minigun_mp;dog_bite_mp", "Default Weapon;Bomb Briefcase;Grim Reaper;Valkyrie Rocket;Death Machine;Dog Bite", ::giveGun);
    
    self addMenu("Killstreaks Menu", "Killstreaks Menu");
    self addSliderString("Killstreaks", "radar_mp;rcbomb_mp;counteruav_mp;tow_turret_drop_mp;supply_drop_mp;napalm_mp;turret_drop_mp;mortar_mp;helicopter_comlink_mp;m220_tow_drop_mp;radardirection_mp;airstrike_mp;helicopter_gunner_mp;dogs_mp;helicopter_player_firstperson_mp", "Spyplane;RC-XD;Counter-Spyplane;Sam Turret;Care Package;Napalm Strike;Sentry Gun;Mortar Team;Attack Helicopter;Valkyrie Rockets;Blackbird;Rolling Thunder;Chopper Gunner;Attack Dogs;Gunship", ::giveKillstreak);
    self addOpt("Spawn Care Package", ::spawnCarePackage);
    self addOpt("Fill Killstreaks", ::fillKillstreaks);

    self addMenu("Lobby Menu", "Lobby Menu");
    self addSlider("Gravity", 800, 400, 800, 50, ::setGravity);
    self addSlider("Timescale", 1, 0.25, 1, 0.25, ::setTimescale);
    self addSlider("Speed", 190, 0, 1000, 10, ::setSpeed);
    self addSlider("Back Speed", 1, 0, 10, 0.5, ::setBackSpeed);
    self addSlider("Stop Speed", 100, 0, 1000, 100, ::setStopSpeed);
    self addOpt("Ladder Mod", ::laddermod);
    self addOpt("Ladder Spin", ::ladderspin);
    self addOpt("Knockback", ::knockback);
    self addOpt("Killcam Settings", ::newMenu, "Killcam Settings");

    self addMenu("Killcam Settings", "Killcam Settings");
    self addOpt("Killcam Playercard", ::killcamPlayercard);
    self addOpt("Killcam Slowmotion", ::killcamSlowMotion);
    self addOpt("Long Killcam", ::longKillcam);

    self addMenu("Admin Menu", "Admin Menu");
    self addOpt("Dev Menu", ::newMenu, "Dev Menu");
    self addOpt("Toggle Timer", ::toggleTimer);
    self addSliderString("Change Map", "mp_array;mp_cracked;mp_crisis;mp_firingrange;mp_duga;mp_hanoi;mp_cairo;mp_havoc;mp_cosmodrome;mp_nuked;mp_radiation;mp_mountain;mp_villa;mp_russianbase;mp_berlinwall2;mp_discovery;mp_kowloon;mp_stadium;mp_gridlock;mp_hotel;mp_outskirts;mp_zoo;mp_drivein;mp_area51;mp_golfcourse;mp_silo", "Array;Cracked;Crisis;Firing Range;Grid;Hanoi;Havana;Jungle;Launch;Nuketown;Radiation;Summit;Villa;WMD;Berlinwall;Discovery;Kowloon;Stadium;Convoy;Hotel;Stockpile;Zoo;Drive-In;Hangar 18;Hazard;Silo", ::changeMap);
    self addSliderString("Change Game", "tdm;dm;sd;dom;koth;dem;ctf;sab;oic;gun;hlnd;shrp", "Team Deathmatch;Free-For-All;Search & Destroy;Domination;Headquarters;Demolition;Capture The Flag;Sabotage;One In The Chamber;Gun Game;Sticks And Stones;Sharp Shooter", ::changeGamemode);
    self addOpt("Change Team", ::changeTeam);
    self addOpt("Reset Score", ::resetScore);
    self addOpt("Hardcore HUD", ::hardcoreHUD);
    self addOpt("Instant Last", ::instantLast);
    if (getDvar("g_gametype") == "sd")
    {
        self addOpt("Unlimited Lives", ::unlimitedLives);
    }
    self addOpt("Online Game", ::onlineGame);
    self addOpt("Fast Restart", ::fastRestart);

    self addMenu("Dev Menu", "Dev Menu");
    self addOpt("Exit Game", ::exitGame);
    self addSliderString("Screen Overlay", "green;blue;disabled", "Green Screen;Blue Screen;Disable", ::screenOverlay);
    self addOpt("Weapon Name", ::weaponName);
    self addOpt("Game Version", ::gameVersion);
    self addOpt("Grab XUID", ::grabXUID);
    self addOpt("Show Position", ::showOrigin);

    self addMenu("Time Menu", "Time Menu");
    self addOpt("Toggle Timer", ::toggleTimer);
    self addOpt("Add 1 Minute", ::add1Minute);
    self addOpt("Remove 1 Minute", ::remove1Minute);

    // Client Menu
    self clientOptions();
}

clientOptions()
{
    self addMenu("Client Menu", "Client Menu");
    self addOpt("All Clients", ::newMenu, "All Clients");
    
    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        self addOpt(level.players[p] getName(), ::newMenu, "client_" + level.players[p] getEntityNumber());
    }

    for (p = 0; p < level.players.size; p++)
    {
        player = level.players[p];
        self addMenu("client_" + level.players[p] getEntityNumber(), level.players[p] getName());
        self addOpt("Verify Client", ::verifyClient, level.players[p]);
        self addOpt("Unverify Client", ::unverifyClient, level.players[p]);
        self addOpt("Teleport Client", ::teleportClient, level.players[p]);
        //self addOpt("Teleport To Client", ::teleportToClient, level.players[p]);
        self addOpt("Freeze Client", ::freezeClient, level.players[p]);
        self addOpt("Revive Client", ::reviveClient, level.players[p]);
        self addOpt("Godmode Client", ::godmodeClient, level.players[p]);
        self addOpt("Second Chance", ::secondChanceClient, level.players[p]);
        self addOpt("Change Team", ::changeTeamClient, level.players[p]);
        //self addOpt("Reset Score", ::resetClientScore, level.players[p]);
        self addOpt("Sniper Aimbot", ::aimbotClient, level.players[p]);
        //self addOpt("Instant Last", ::instantLastClient, level.players[p]);
        self addOpt("Quick Recovery", ::recoveryClient, level.players[p]);
        self addOpt("Kill Client", ::killClient, level.players[p]);
        self addOpt("Kick Client", ::kickClient, level.players[p]);
        self addOpt("Ban Client", ::banClient, level.players[p]);
    }

    self addMenu("All Clients", "All Clients");
    self addSliderString("Select Team", "Both Teams;Friendly Team;Enemy Team", "Both Teams;Friendly Team;Enemy Team", ::selectAllClientsTeam);
    self addOpt("Verify All Clients", ::verifyAllClients);
    self addOpt("Unverify All Clients", ::unverifyAllClients);
    self addOpt("Teleport All Clients", ::teleportAllClients);
    self addOpt("Freeze All Clients", ::freezeAllClients);
    self addOpt("Instant Last All Clients", ::instantLastAllClients);
    self addOpt("Kill All Clients", ::killAllClients);
    self addOpt("Kick All Clients", ::kickAllClients);
    self addOpt("Ban All Clients", ::banAllClients);
}