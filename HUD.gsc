init_HUDS()
{
	// Inventory Menu
	self.inventory_display_string = "Inventory Menu\nWeapons\nBoosters\nAbilities\nAAT's\nTaunt\nUtility Menu\nExit Menu";
	self.inventory_menu_open = false;
	self.inventory_menu_pos = 0;
	self.inventory_menu_menu = -1;
	self.inventory_menu_HUD = self CreateText("Inventory Menu\nWeapons\nBoosters\nAbilities\nAAT's\nTaunt\nUtility Menu\nExit Menu", 2, 100, 0, (0,.7,0), 0, 10, true, false, true, true);
	self.inventory_menu_BG = self SpawnShader("white", -190, 0, 150, 250, (0,0,0), 0, 5);
	self.inventory_menu_Scroller = self SpawnShader("white", -190, 25, 150, 25, (1,1,1), 0, 5);
	
	self.infobarstr1 = "Press ADS and [{+melee}] to open the menu";
	self.infobarstr2 = "The Survival Games " + level.versionid + " by ^2Nothingbutbread";
	self.infobar = self SpawnShader("white", 0, 360, 1000, 45, (.3, .3, .3), .8, 1);
	self.infobar_text_1 = self CreateText("Press ADS and [{+melee}] to open the menu", 2, 0, 360, (1,1,1), 1, 20, true, false, true, false);
	self.infobar_text_2 = self CreateText(" ", 2, 0, 380, (1,1,1), 1, 20, true, false, true, false);
	
	self.invlimmit = []; // First index is max on each type of good that can be held.
	self.invlimmit[0] = 3; self.invlimmit[1] = 3; self.invlimmit[2] = 3; self.invlimmit[3] = 3;// Default player can hold 3 of everything.
	self.invgun = []; self.invboo = []; self.invabi = []; self.invaat = [];
	for(x=0;x<7;x++){ self.invgun[x] = ""; } // Gunslots
	for(x=0;x<7;x++){ self.invboo[x] = ""; } // Boosters
	for(x=0;x<7;x++){ self.invabi[x] = ""; } // Abilities
	for(x=0;x<7;x++){ self.invaat[x] = ""; } // Alternate Ammo types (AAT)
	
	self thread Menu_Inventory_Open_Bind();
	// Create / Occupation menu
	self.loot_menu_Scroller = self SpawnShader("white", -190, 25, 150, 25, (1,1,1), 0, 5);
	self.loot_menu_pos = 0;
	
	self.SideHUDHealth = self CreateText(self.health, 2, 0, 240, (1, 1, 1), 1, 10, false, false, true, true);
	self.SideHUDHealth.label = &"Health: ";
	self.SideHUDSP = self CreateText(self.sp, 2, 0, 220, (1, 1, 1), 1, 10, false, false, true, true);
	self.SideHUDSP.label = &"Survivor Points: ";
	self thread HUDSConstantUpdate();
}
HUDSConstantUpdate()
{
	self endon("death");
	self endon("disconnect");
	while(true)
	{
		self.SideHUDHealth setValue(self.health);
		self.SideHUDSP setValue(self.sp);
		wait .2;
	}
}
RebuildHUDS()
{
	self.inventory_menu_HUD setSafeText(self.inventory_display_string);
	self.infobar_text_1 setSafeText(self.infobarstr1);
	self.infobar_text_2 setSafeText(self.infobarstr2);
	self.SideHUDHealth destroy();
	self.SideHUDSP destroy();
	self.SideHUDHealth = self CreateText(self.health, 2, 0, 240, (1, 1, 1), 1, 10, false, false, true, true);
	self.SideHUDHealth.label = &"Health: ";
	self.SideHUDSP = self CreateText(self.sp, 2, 0, 220, (1, 1, 1), 1, 10, false, false, true, true);
	self.SideHUDSP.label = &"Survivor Points: ";
	if (self.inventory_menu_open)
		self Menu_Inventory_Update_Menu();
	if (self.loot_menu_open)
		self Menu_Loot_Update_Menu();
}
Menu_Inventory_Update_Menu()
{ // self.inventory_menu_menu controls what menu is displayed. -1 = Occupation menu 0 = main menu, 1 = weapons, 2 = boosters, 3 = abilties, 4 = Alternate Ammo Types
	if (self.inventory_menu_menu == 0) { self.inventory_display_string = "Inventory Menu\nWeapons\nBoosters\nAbilities\nAAT's\nTaunt\nUtility Menu\nShop Menu\nExit Menu"; self.inventory_menu_HUD setSafeText(self.inventory_display_string); }
	else if (self.inventory_menu_menu == -1) { self.inventory_display_string = "Select Class!\nAddict\nBookie\nWarrior\nTank\nScout\nAthlete\nSpeicalist\nSecret Shopper"; self.inventory_menu_HUD setSafeText(self.inventory_display_string); }
	else if (self.inventory_menu_menu == 7) { self.inventory_display_string = "Utility Menu\nUnstuck\nNoclip\nGodmode\nPrint Origin\nCommon LB\nUncommon LB\nRare LB\nBack"; self.inventory_menu_HUD setSafeText(self.inventory_display_string); }
	else if (self.inventory_menu_menu == 8) { self.inventory_display_string = "Shop Menu\n5 - Common LB\n9 - Uncommon LB\n15 - Rare LB\n3 - Gun\n5 - Booster\n7 - AAT\n10 - Ability\nBack"; self.inventory_menu_HUD setSafeText(self.inventory_display_string); }
	else
	{
		str = "";
		if (self.inventory_menu_menu == 1) { str = "Stored Weapons"; array = self.invgun; }
		else if (self.inventory_menu_menu == 2) { str = "Boosters"; array = self.invboo; }
		else if (self.inventory_menu_menu == 3) { str = "Stored Abilties"; array = self.invabi; }
		else if (self.inventory_menu_menu == 4) { str = "AAT's"; array = self.invaat; }
		for(x=0;x<7;x++)
		{
			luck = RandomIntRange(0,2);
			if (array[x] != "") 
			{ 
				str += "\n";
				if (self.eastereggeffect && luck == 0)
				{ str += "<Corrupted data>"; }
				else if (self.inventory_menu_menu == 1) { str += self DisplayStringMod(array[x], 16); }
				else { str += array[x]; } 
			}
			else 
			{ 
				if (self.eastereggeffect && luck == 0)
				{ str += "\n<Corrupted data>"; }
				else { str += "\n>--------<"; }
			}
		}
		str += "\nBack";
		self.inventory_display_string = str; 
		self.inventory_menu_HUD setSafeText(self.inventory_display_string);
	}
	self Menu_Inventory_Info_Bar_Update_Mapping();
}
Menu_Inventory_Controls()
{
	self endon("death");
	self endon("disconnect");
	self Menu_Inventory_Info_Bar_Update_Mapping();
	while(self.inventory_menu_open)
	{
		if (self actionslotonebuttonpressed() && self.inventory_menu_pos > 0)
		{
			self.inventory_menu_Scroller moveOverTime(.05);
			self.inventory_menu_Scroller.y -= 24;
			self.inventory_menu_pos--;
			self Menu_Inventory_Info_Bar_Update_Mapping();
			wait .05;
		}
		else if (self actionslottwobuttonpressed()  && self.inventory_menu_pos < 7)
		{
			self.inventory_menu_Scroller moveOverTime(.05);
			self.inventory_menu_Scroller.y += 24;
			self.inventory_menu_pos++;
			self Menu_Inventory_Info_Bar_Update_Mapping();
			wait .05;
		}
		else if (self usebuttonpressed())
		{
			self thread Menu_Inventory_Run_Cmd();
			self Menu_Inventory_Info_Bar_Update_Mapping();
			wait .5;
		}
		else if (self jumpbuttonpressed())
		{
			// Exception case, too many people keep thinking the X button is select in the class menu!
			// This makes the X button select the class while in the class menu.
			if (self.inventory_menu_menu == -1)
			{ 
				self thread Menu_Inventory_Run_Cmd();
				self Menu_Inventory_Info_Bar_Update_Mapping();
			}
			else
			{
				self.inventory_menu_menu = 0;
				self Menu_Inventory_Close();
				return;
			}
		}
		wait .05;
	}
}
Menu_Inventory_Run_Cmd()
{
	if (self.inventory_menu_pos == 7 && self.inventory_menu_menu == 0) { self Menu_Inventory_Close(); }
	else if (self.inventory_menu_pos == 6 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 8; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 4 && self.inventory_menu_menu == 0) {  self thread Fun_Taunt(); }
	else if (self.inventory_menu_menu == -1) { self.inventory_menu_menu = 0; self Menu_Inventory_Update_Menu(); self init_Occupation(self.inventory_menu_pos); }
	else if (self.inventory_menu_pos == 7 && self.inventory_menu_menu > 0) { self.inventory_menu_menu = 0; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 0 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 1; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 1 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 2; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 2 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 3; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 3 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 4; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_pos == 5 && self.inventory_menu_menu == 0) { self.inventory_menu_menu = 7; self Menu_Inventory_Update_Menu(); }
	else if (self.inventory_menu_menu == 1)
	{ 
		if (self.invgun[self.inventory_menu_pos] != "")
		{
			oldweapon = self thread GiveGun(self.invgun[self.inventory_menu_pos]);
			if (oldweapon != "") { self.invgun[self.inventory_menu_pos] = oldweapon; }
			else { self.invgun[self.inventory_menu_pos] = ""; }
			self Menu_Inventory_Update_Menu();
		}
	}
	else if (self.inventory_menu_menu == 2) 
	{ 
		if (self.invboo[self.inventory_menu_pos] != "")
		{
			self thread Use_Booster(self.invboo[self.inventory_menu_pos]);
			self.invboo[self.inventory_menu_pos] = "";
			self Menu_Inventory_Update_Menu();
		}
		else { return; }
	}
	else if (self.inventory_menu_menu == 3) 
	{ 
		if (self.invabi[self.inventory_menu_pos] != "")
		{
			self thread Use_Ability(self.invabi[self.inventory_menu_pos]);
			self.invabi[self.inventory_menu_pos] = "";
			self Menu_Inventory_Update_Menu();
		}
		else { return; }
	}
	else if (self.inventory_menu_menu == 4) 
	{ 
		if (self.invaat[self.inventory_menu_pos] != "")
		{
			self thread Use_AAT(self.invaat[self.inventory_menu_pos]);
			self.invaat[self.inventory_menu_pos] = "";
			self Menu_Inventory_Update_Menu();
		}
		else { return; }
	}
	else if (self.inventory_menu_menu == 7)
	{
		if (self.inventory_menu_pos == 0) { self UnstuckPlayer(); }
		else if (level.debugger)
		{
			if (self.inventory_menu_pos == 1) { self thread Host_Toggle_Noclip(); }
			else if (self.inventory_menu_pos == 2) { self thread Host_Toggle_GodMode(); }
			else if (self.inventory_menu_pos == 3) { self thread Host_Toggle_OriginPrint(); }
			else if (self.inventory_menu_pos == 4) { self thread GiveCommonLootBox(); }
			else if (self.inventory_menu_pos == 5) { self thread GiveUncommonLootBox(); }
			else if (self.inventory_menu_pos == 6) { self thread GiveRareLootBox(); }
		}
		else { self iprintln("^1Command disabled! The game must be debugger mode inorder to use.^7\nDon't bug the host about it. Debugger mode is for mod development only."); }
	}
	else if (self.inventory_menu_menu == 8)
	{
		if (self.inventory_menu_pos == 0 && self.sp >= 5) { self thread GiveCommonLootBox(); self.sp-= 5; }
		else if (self.inventory_menu_pos == 1 && self.sp >= 9) { self thread GiveUncommonLootBox(); self.sp-= 9; }
		else if (self.inventory_menu_pos == 2 && self.sp >= 20) { self thread GiveRareLootBox(); self.sp-= 20; }
		else if (self.inventory_menu_pos == 3 && self.sp >= 3) { self add_Thing_To_Inventory(1, Loot_Purchased_gun(), true); self.sp-= 3; self iprintln("Added a gun to your inventory"); }
		else if (self.inventory_menu_pos == 4 && self.sp >= 5) { self add_Thing_To_Inventory(2, Loot_Booster(), true); self.sp-= 5; self iprintln("Added a booster to your inventory"); }
		else if (self.inventory_menu_pos == 5 && self.sp >= 7) { self add_Thing_To_Inventory(4, Loot_AAT(), true); self.sp-= 7; self iprintln("Added a AAT to your inventory");}
		else if (self.inventory_menu_pos == 6 && self.sp >= 10) { self add_Thing_To_Inventory(3, Loot_Ability(), true); self.sp-= 10; self iprintln("Added an Ability to your inventory");}
		else { self iprintln("^1Not enough Survior Points [SP] to buy that!"); }
	}
	else { return; }
	wait .5;
	
}
Menu_Inventory_Open_Bind()
{
	self endon("death");
	self endon("disconnect");
	while(!self.inventory_menu_open && self.iscoolfordisgame)
	{
		if (self adsbuttonpressed() && !self.canusemenu) { self iprintln("^1Can't open the menu while under a proxy attack!"); }
		else if (self adsbuttonpressed() && self meleebuttonpressed() && !self.loot_menu_open) { self thread Menu_Inventory_Open(); break; }
		else if (self adsbuttonpressed() && self meleebuttonpressed() && self.loot_menu_open) { self iprintln("^1Another menu is already open!"); }
		wait .1;
	}
}
Menu_Inventory_Open()
{
	self.inventory_menu_open = true;
	self Menu_Inventory_Update_Menu();
	self.inventory_menu_HUD FadeOverTime(.5);
	self.inventory_menu_BG FadeOverTime(.5);
	self.inventory_menu_BG.color = (0,0,0);
	self.inventory_menu_HUD.color = (0,.7,0);
	self.inventory_menu_Scroller FadeOverTime(.5);
	self.inventory_menu_HUD.alpha = 1;
	self.inventory_menu_BG.alpha = 1;
	self.inventory_menu_Scroller.alpha = 1;
	wait .5;
	self thread Menu_Inventory_Controls();
}
Menu_Inventory_Close()
{
	self.inventory_menu_open = false;
	self.inventory_menu_HUD FadeOverTime(.5);
	self.inventory_menu_BG FadeOverTime(.5);
	self.inventory_menu_Scroller FadeOverTime(.5);
	self.inventory_menu_HUD.alpha = 0;
	self.inventory_menu_BG.alpha = 0;
	self.inventory_menu_Scroller.alpha = 0;
	wait .5;
	self.infobarstr1 = "Press ADS and [{+melee}] to open the menu";
	self.infobarstr2 = "The Survival Games " + level.versionid + " by ^2Nothingbutbread";
	self.infobar_text_1 setSafeText(self.infobarstr1);
	self.infobar_text_2 setSafeText(self.infobarstr2);
	self thread Menu_Inventory_Open_Bind();
}
CreateText(item, fontScale, x, y, color, alpha, sort, text, allpeeps, foreground, normal)
{
	if (!allpeeps)
		hud = self createFontString("objective", fontScale);
	else
		hud = level createServerFontString("objective", fontScale);
	if (!text)
    	hud setValue(item);
    else
    	hud setSafeText(item);
    hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
    hud.sort = sort;
	hud.foreground = foreground;
	if (!isDefined(normal) || normal)
	{
		hud.alignX = "left";
		hud.horzAlign = "left";
		hud.vertAlign = "center";
	}
	return hud;
}
SpawnShader(shader, x, y, width, height, color, alpha, sort)
{
	hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    hud.foreground = true;
    return hud;
}
overflowfix()
{
	level endon("game_ended");
	level endon("host_migration_begin");
	
	test = level createServerFontString("default", 1);
	test setText("xTUL");
	test.alpha = 0;
	limit = 50;
	if(GetDvar("g_gametype") == "sd")
    	limit = 35;

	while(1)
	{
		level waittill("textset"); 
		if(level.strings.size >= limit)
		{
			test ClearAllTextAfterHudElem();
			level.strings = [];//re-building the string array
			//iprintln("^1Debug: ^5Overflow prevented!"); //Remove after finishing your menu.
			level.timerHUDMinute setSafeText(level.timestring);
			level.aliveHUD setSafeText(level.alivestring);
			foreach(player in level.players) { if (player.iscoolfordisgame) { player thread RebuildHUDS(); } }
		}
	}
}

setSafeText(text)
{
    if (!isInArray(level.strings, text))
    {
        level.strings[level.strings.size] = text;
        self setText(text);
        level notify("textset");
    }
    else
        self setText(text);
}
// From Cooljayz Zombieland
CreateWaypoint(shader, origin, width, height, alpha, allplayers)
{
	if (allplayers) { createwaypoint = NewHudElem(); }
    else { createwaypoint = NewClientHudElem(self); }
    createwaypoint SetShader(shader, width, height);
	createwaypoint SetWayPoint(true);   
	createwaypoint.x = origin[0];
	createwaypoint.y = origin[1];
	createwaypoint.z = origin[2]; 
	createwaypoint.alpha = alpha;
	createwaypoint.archived = false;
	return createwaypoint;
}


