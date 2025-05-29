#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;

#include maps\mp\gametypes\main;
#include maps\mp\gametypes\structure;
#include maps\mp\gametypes\utilities;

initializeMenuSetup(player)
{   
    player notify("end_menu");

    if (player isMenuOpen())
    {
        player menuClose();
    }

    player.menu = [];
    player.previousMenu = [];
    player.menu["open"] = false;

    if (!isDefined(player.menu["current"]))
    {
        player.menu["current"] = "Main Menu";
    }
    
    player.custommenu = [];
    player.custommenu["MENU_BACKGROUND"] = (0, 0, 0);
    player.custommenu["TITLE_BAR_COLOR"] = (255/255, 180/255, 230/255);
    player.custommenu["SCROLL_BAR_COLOR"] = (255/255, 180/255, 230/255);

    player freezeControls(false);
    player menuOptions();
    player thread menuMonitor();
}

colorToggle(variable)
{
    if (!isDefined(self.colortoggle))
    {
        self.colortoggle = [];
    }
    if (!isDefined(self.colortoggle[self getCurrentMenu()]))
    {
        self.colortoggle[self getCurrentMenu()] = [];
    }
    
    if (isDefined(variable))
    {
        self.colortoggle[self getCurrentMenu()][self getCursor()] = true;
    }
    else 
    {
        self.colortoggle[self getCurrentMenu()][self getCursor()] = undefined;
    }
    self setMenuText();
}

menuMonitor()
{
    self endon("disconnected");
    self endon("end_menu");

    self thread closeMenuOnDeath();
    self thread closeMenuOnGameEnd();
    
    while (self.pers["menu_access"] == true)
    {
        if (!self.menu["open"])
        {
            if (self AdsButtonPressed() && self ActionSlotTwoButtonPressed())
            {
                self menuOpen();
                wait 0.05;
            }               
        }
        else 
        {
            if (self ActionSlotOneButtonPressed() || self ActionSlotTwoButtonPressed())
            {
                self.menu[self getCurrentMenu() + "_cursor"] -= self ActionSlotOneButtonPressed();
                self.menu[self getCurrentMenu() + "_cursor"] += self ActionSlotTwoButtonPressed();
                self scrollingSystem();
                wait 0.05;
            }
            else if (self ActionSlotThreeButtonPressed() || self ActionSlotFourButtonPressed())
            {
                if (isDefined(self.eMenu[self getCursor()].val) || isDefined(self.eMenu[self getCursor()].ID_list))
                {
                    if (self ActionSlotThreeButtonPressed())
                    {
                        self updateSlider("L2");
                    }
                    if (self ActionSlotFourButtonPressed())
                    {
                        self updateSlider("R2");
                    }
                    wait 0.1;
                }
            }
            else if (self useButtonPressed())
            {
                if (isDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()]))
                {
                    slider = self.sliders[self getCurrentMenu() + "_" + self getCursor()];
                    if (isDefined(self.eMenu[self getCursor()].ID_list))
                    {
                        slider = self.eMenu[self getCursor()].ID_list[slider];
                    }     
                    self thread [[self.eMenu[self getCursor()].func]](slider, self.eMenu[self getCursor()].p1, self.eMenu[self getCursor()].p2, self.eMenu[self getCursor()].p3, self.eMenu[self getCursor()].p4, self.eMenu[self getCursor()].p5);
                }
                else
                {
                    self thread [[self.eMenu[self getCursor()].func]](self.eMenu[self getCursor()].p1, self.eMenu[self getCursor()].p2, self.eMenu[self getCursor()].p3, self.eMenu[self getCursor()].p4, self.eMenu[self getCursor()].p5);
                }
                wait 0.25;
            }
            else if (self meleeButtonPressed())
            {
                if (self getCurrentMenu() == "Main Menu")
                {
                    self menuClose();
                }
                else 
                {
                    self newMenu();
                }
                wait 0.25;
            }
        }  
    wait 0.05;
    }
}

menuOpen()
{
    self.menu["open"] = true;
    self menuOptions();
    self drawMenu();
    self drawText(); 
    self updateScrollbar();

    self.getequipment = self getWeaponsList();
    self.getequipment = array_remove(self.getequipment, "knife_mp");
    for (i = 0; i < self.getequipment.size; i++)
    {
        self.currentequipment = self.getequipment[i];
        switch (self.currentequipment)
        {
            case "claymore_mp":
            case "tactical_insertion_mp":
            case "scrambler_mp":
            case "satchel_charge_mp":
            case "camera_spike_mp":
            case "acoustic_sensor_mp":
                self takeWeapon(self.currentequipment);
                self.myequipment = self.currentequipment;
                break;
            default:
                break;
        }
    }
}

menuClose()
{
    self.menu["OPT"]["TITLE"] destroy();
    self.menu["OPT"]["MENU"] destroy();
    self.menu["UI"]["BACKGROUND"] destroy();
    self.menu["UI"]["TITLE_BAR"] destroy();
    self.menu["UI"]["SCROLL_BAR"] destroy();
    if (isDefined(self.menu["UI"]["SLIDER_TEXT"]))
    {
        self.menu["UI"]["SLIDER_TEXT"] destroy();
    }
    if (isDefined(self.menu["UI"]["SLIDER_SHADER"]))
    {
        self.menu["UI"]["SLIDER_SHADER"] destroy();   
    } 
    self.menu["open"] = false;

    if (isDefined(self.myequipment))
    {
        self giveWeapon(self.myequipment);
        self giveStartAmmo(self.myequipment);
        self setActionSlot(1, "weapon", self.myequipment);
    }
}

closeMenuOnDeath()
{
     for (;;)
     {
        self waittill("death");
        self thread menuClose();
     }
}

closeMenuOnGameEnd()
{
    for (;;)
     {
        level waittill("game_ended");
        self thread menuClose();
     }
}

drawMenu()
{
    if (!isDefined(self.menu["UI"]))
    {
        self.menu["UI"] = [];
    }      

    if (getDvar("xenonGame") == "true" || getDvar("ps3Game") == "true") // Console
    {
        self.menu["UI"]["BACKGROUND"] = self createRectangle("TOP", "RIGHT", -112, -120, 212, 51, self.custommenu["MENU_BACKGROUND"], "white", 2, 0.65);
        self.menu["UI"]["TITLE_BAR"] = self createRectangle("TOP", "RIGHT", -112, -123, 212, 16, self.custommenu["TITLE_BAR_COLOR"], "white", 3, 1);
        self.menu["UI"]["SCROLL_BAR"] = self createRectangle("TOP", "RIGHT", -112, -70, 212, 15, self.custommenu["SCROLL_BAR_COLOR"], "white", 3, 1);
    }
    else // PC
    {
        self.menu["UI"]["BACKGROUND"] = self createRectangle("TOP", "RIGHT", -175, -120, 212, 51, self.custommenu["MENU_BACKGROUND"], "white", 2, 0.65);
        self.menu["UI"]["TITLE_BAR"] = self createRectangle("TOP", "RIGHT", -175, -123, 212, 16, self.custommenu["TITLE_BAR_COLOR"], "white", 3, 1);
        self.menu["UI"]["SCROLL_BAR"] = self createRectangle("TOP", "RIGHT", -175, -70, 212, 15, self.custommenu["SCROLL_BAR_COLOR"], "white", 3, 1);
    }
}

drawText()
{
    if (!isDefined(self.menu["OPT"]))
    {
        self.menu["OPT"] = [];
    }
    self.menu["OPT"]["TITLE"] = self createText("Objective", 1.185, "CENTER", "CENTER", 250, -115, 4, 1, self.menutitle, (1, 1, 1)); 
    self.menu["OPT"]["MENU"] = self createText("Objective", 1.185, "LEFT", "CENTER", 151, -98, 6, 1, "", (1, 1, 1));
    self setMenuText();
}

refreshTitle()
{
    self.menu["OPT"]["TITLE"] setSafeText((self.menutitle));
}
    
scrollingSystem()
{
    if (self getCursor() >= self.eMenu.size || self getCursor() < 0 || self getCursor() == 11)
    {
        if (self getCursor() <= 0)
        {
            self.menu[self getCurrentMenu() + "_cursor"] = self.eMenu.size -1;
        }
        else if (self getCursor() >= self.eMenu.size)
        {
            self.menu[self getCurrentMenu() + "_cursor"] = 0;
        }
        self setMenuText();
        self updateScrollbar();
    }
    if (self getCursor() >= 12)
    {
        self setMenuText();
    }
    self updateScrollbar();
}

updateScrollbar()
{
    curs = self getCursor();
    if (curs >= 12)
    {
        curs = 11;
    }    
        
    opt = self.eMenu.size;
    if ((self.eMenu.size >= 12))
    {
        opt = 12;
    }
    size = (opt * 14.4) + 15.1;
    
    self.menu["UI"]["BACKGROUND"] setShader("white", 212, int(size) + 5);
    
    self.menu["UI"]["SCROLL_BAR"].y = (self.menu["OPT"]["MENU"].y + (curs * 14.4)) - 6;
        
    if (isDefined(self.menu["UI"]["SLIDER_TEXT"]))
    {
        self.menu["UI"]["SLIDER_TEXT"] destroy();
    }
    if (isDefined(self.menu["UI"]["SLIDER_SHADER"]))
    {
        self.menu["UI"]["SLIDER_SHADER"] destroy();
    }
    if (isDefined(self.eMenu[self getCursor()].val) || isDefined(self.eMenu[self getCursor()].ID_list))
    {
        self updateSlider();
    }
}

updateSlider(pressed)
{
    if (isDefined(self.menu["UI"]["SLIDER_TEXT"]))
    {
        self.menu["UI"]["SLIDER_TEXT"] destroy();
    }
    if (isDefined(self.menu["UI"]["SLIDER_SHADER"]))
    {
        self.menu["UI"]["SLIDER_SHADER"] destroy();
    }
        
    // Shader Slider
    if (isDefined(self.eMenu[self getCursor()].shaders))
    {
        if (!isDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()]))
        {
            self.sliders[self getCurrentMenu() + "_" + self getCursor()] = 0;
        }    
        value = self.sliders[self getCurrentMenu() + "_" + self getCursor()];
        if (pressed == "R2") 
        {
            value++;
        }
        if (pressed == "L2")
        {
            value--;
        }   
        if (value > self.eMenu[self getCursor()].shaders.size - 1)
        {
            value = 0;
        }
        if (value < 0)
        {
            value = self.eMenu[self getCursor()].shaders.size - 1;
        }
        self.menu["UI"]["SLIDER_TEXT"] = self createRectangle("RIGHT", "CENTER", 348, self.menu["UI"]["SCROLL_BAR"].y + 7, self.eMenu[self getCursor()].val, self.eMenu[self getCursor()].val1, (1, 1, 1), self.eMenu[self getCursor()].shaders[value], 4, 2); 
        self.menu["UI"]["SLIDER_SHADER"] = self createText("Objective", 1.185, "RIGHT", "CENTER", 345 - (self.eMenu[self getCursor()].val), self.menu["UI"]["SCROLL_BAR"].y + 6, 5, 1, self.eMenu[self getCursor()].RL_list[value], (1, 1, 1));
    
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] = value;
        return;
    }
    
    // String Slider
    if (isDefined(self.eMenu[self getCursor()].ID_list))
    {
        if (!isDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()]))
        {
            self.sliders[self getCurrentMenu() + "_" + self getCursor()] = 0;
        }
        value = self.sliders[self getCurrentMenu() + "_" + self getCursor()];
        if (pressed == "R2")
        {
            value++;
        }
        if (pressed == "L2")
        {
            value--;
        }
            
        if (value > self.eMenu[self getCursor()].ID_list.size-1)
        {
            value = 0;
        }
        if (value < 0)
        {
            value = self.eMenu[self getCursor()].ID_list.size-1;
        }
        
        self.menu["UI"]["SLIDER_TEXT"] = self createText("Objective", 1.185, "RIGHT", "CENTER", 350, self.menu["UI"]["SCROLL_BAR"].y + 6, 5, 1, "[^6" + self.eMenu[self getCursor()].RL_list[value] + "^7]", (1, 1, 1));
    
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] = value;
        return;
    }
    
    if (!isDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()]))
    {
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] = self.eMenu[self getCursor()].val;
    }
    
    if (pressed == "R2")
    {
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] += self.eMenu[self getCursor()].mult;
    }
    if (pressed == "L2")
    {
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] -= self.eMenu[self getCursor()].mult;
    }
    
    if (self.sliders[self getCurrentMenu() + "_" + self getCursor()] > self.eMenu[self getCursor()].max)
    {
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] = self.eMenu[self getCursor()].min;
    }
    if (self.sliders[self getCurrentMenu() + "_" + self getCursor()] < self.eMenu[self getCursor()].min)
    {
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] = self.eMenu[self getCursor()].max;
    }  
        
    // Value Slider
    self.menu["UI"]["SLIDER_TEXT"] = self createText("Objective", 1.185, "RIGHT", "CENTER", 350, self.menu["UI"]["SCROLL_BAR"].y + 6, 5, 1, "[^6" + self.sliders[self getCurrentMenu() + "_" + self getCursor()] + " ^7/^6 " + self.eMenu[self getCursor()].max + "^7]", (1, 1, 1));
}

setMenuText()
{
    ary = 0;
    if (self getCursor() >= 12)
    {
        ary = self getCursor() - 11;
    }

    final = "";
    for (e = 0; e < 12; e++)
    {
        if (isDefined(self.eMenu[ary + e].opt))
        {
            if (isDefined(self.colortoggle[self getCurrentMenu()][ary + e]))
            {
                final +=  "^6" + (self.eMenu[ary + e].opt) + "^7\n";
            }
            else
            {
                final += (self.eMenu[ary + e].opt) + "^7\n";
            }
        }
    }
    self.menu["OPT"]["MENU"] setSafeText(final);
}

newMenu(menu)
{
    if (!isDefined(menu))
    {
        menu = self.previousMenu[self.previousMenu.size - 1];
        self.previousMenu[self.previousMenu.size - 1] = undefined;
    }
    else 
    {
        self.previousMenu[self.previousMenu.size] = self getCurrentMenu();
    }
        
    self setCurrentMenu(menu);
    self menuOptions();
    self setMenuText();
    self refreshTitle();
    self updateScrollbar();
}

addMenu(menu, title)
{
    self.storeMenu = menu;
    if (self getCurrentMenu() != menu)
    {
        return;
    }
        
    self.eMenu = [];
    self.menutitle = title;
    if (!isDefined(self.menu[menu + "_cursor"]))
    {
        self.menu[menu + "_cursor"] = 0;
    }
}

addOpt(opt, func, p1, p2, p3, p4, p5)
{
    if (self.storeMenu != self getCurrentMenu())
    {
        return;
    }
    option = spawnStruct();
    option.opt = opt;
    option.func = func;
    option.p1 = p1;
    option.p2 = p2;
    option.p3 = p3;
    option.p4 = p4;
    option.p5 = p5;
    self.eMenu[self.eMenu.size] = option;
}

addOptDesc(opt, desc, func, p1, p2, p3, p4, p5)
{
    if (self.storeMenu != self getCurrentMenu())
    {
        return;
    }
    option = spawnStruct();
    option.opt = opt;
    option.desc = desc;
    
    option.func = func;
    option.p1 = p1;
    option.p2 = p2;
    option.p3 = p3;
    option.p4 = p4;
    option.p5 = p5;
    self.eMenu[self.eMenu.size] = option;
}

addSlider(opt, val, min, max, mult, func, p1, p2, p3, p4, p5)
{
    if (self.storeMenu != self getCurrentMenu())
    {
        return;
    }
    option = spawnStruct();
    option.opt = opt;
    option.val = val;
    option.min = min;
    option.max = max;
    option.mult = mult;
    option.func = func;
    option.p1 = p1;
    option.p2 = p2;
    option.p3 = p3;
    option.p4 = p4;
    option.p5 = p5;
    self.eMenu[self.eMenu.size] = option;
}

addSliderString(opt, ID_list, RL_list, func, p1, p2, p3, p4, p5)
{
    if (self.storeMenu != self getCurrentMenu())
    {
        return;
    }
    option = spawnStruct();
    
    if (!isDefined(RL_list))
    {
        RL_list = ID_list;
    }
    option.ID_list = strTok(ID_list, ";");
    option.RL_list = strTok(RL_list, ";");
    
    option.opt = opt;
    option.func = func;
    option.p1 = p1;
    option.p2 = p2;
    option.p3 = p3;
    option.p4 = p4;
    option.p5 = p5;
    self.eMenu[self.eMenu.size] = option;
}

addSliderShader(opt, shaders, ID_list, RL_List, val, val1, func, p1, p2, p3, p4, p5)
{
    if (self.storeMenu != self getCurrentMenu())
    {
        return;
    }
    option = spawnStruct();
    
    option.shaders = strTok(shaders, ";");
    if (!isDefined(RL_list))
    {
        RL_list = ID_list;
    }
    option.ID_list = strTok(ID_list, ";");
    option.RL_list = strTok(RL_list, ";");
    option.val = val;
    option.val1 = val1;
    
    option.opt = opt;
    option.func = func;
    option.p1 = p1;
    option.p2 = p2;
    option.p3 = p3;
    option.p4 = p4;
    option.p5 = p5;
    self.eMenu[self.eMenu.size] = option;
}

setCurrentMenu(menu)
{
    self.menu["current"] = menu;
}

getCurrentMenu(menu)
{
    return self.menu["current"];
}

getCursor()
{
    return self.menu[self getCurrentMenu() + "_cursor"];
}

isMenuOpen()
{
    if (!isDefined(self.menu["open"]) || !self.menu["open"])
    {
        return false;
    }
    return true;
}

vectorScale(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}