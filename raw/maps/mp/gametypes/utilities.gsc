#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

#include maps\mp\gametypes\main;

createText(font, fontScale, align, relative, x, y, sort, alpha, text, color, isLevel)
{
    textElem = self createFontString(font, fontScale);   
    textElem setPoint(align, relative, x, y);
    textElem.hideWhenInMenu = false;
    textElem.archived = false;
    textElem.sort = sort;
    textElem.alpha = alpha;
    textElem.color = color;
    self addToStringArray(text);
    textElem thread watchForOverFlow(text);
    return textElem;
}

createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha)
{
	barElemBG = newClientHudElem(self);
	barElemBG.elemType = "bar";
	barElemBG.width = width;
	barElemBG.height = height;
	barElemBG.align = align;
	barElemBG.relative = relative;
	barElemBG.xOffset = 0;
	barElemBG.yOffset = 0;
	barElemBG.children = [];
	barElemBG.sort = sort;
	barElemBG.color = color;
	barElemBG.alpha = alpha;
	barElemBG setParent(level.uiParent);
	barElemBG setShader(shader, width , height);
	barElemBG.hidden = false;
	barElemBG setPoint(align,relative,x,y);
	return barElemBG;
}

setSafeText(text)
{
    self notify("end_text_monitor");
    self addToStringArray(text);
    self thread watchForOverFlow(text);
}

addToStringArray(text)
{
    if (!isInArray(level.strings, text))
    {
        level.strings[level.strings.size] = text;
        level notify("CHECK_OVERFLOW");
    }
}

watchForOverFlow(text)
{
    self endon("end_text_monitor");
    while (isDefined(self))
    {
        if (isDefined(text.size))
        {
            self setText(text);
        }
        else
        {
            self setText(undefined);
            self.label = text;
        }
        level waittill("FIX_OVERFLOW");
    }
}

isInArray(array, text)
{
    for (e = 0; e < array.size; e++) 
    {
        if (array[e] == text) 
        {
            return true;
        }
    }
    return false;
}

getName()
{
    name = self.name;
    if (name[0] != "[")
    {
        return name;
    }
    for (a = name.size - 1; a >= 0; a--)
    {
        if (name[a] == "]")
        {
            break;
        }
    }
    return(getSubStr(name, a + 1));
}