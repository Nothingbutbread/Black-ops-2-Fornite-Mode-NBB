CreatePlayerHUDS()
{
	self.selectorpos = 0;
	self.menuselectorpos = 0;
	self.curmenu = 0;
	self.menuopen = false;
	//self.menutext = "Utility Menu:\nBuild Wall\nBuild Ramp\nGet Unstuck\nAdjust Menu Controls\nDelete All Ramps/Walls\nDelete Last Placed Item";
	self.menutext = "Utility Menu:\nBuild Wall\nBuild Ramp\nBuild Platform\nGet Unstuck\nDelete All Ramps/Walls\nDelete Last Placed Item";
	self.controlsText = "";
	self.healthHUDText = "^1Health: " + self.forthealth + "\n^5Sheild: " + self.fortshield;
	self.ItemUseText = "";
	self.fortHUDS = [];
	// Inventory
	self.fortHUDS[0] = self SpawnShader("white", 120, 320, 40, 40, teirIDToColor(0), .7, 5);
	self.fortHUDS[1] = self SpawnShader("white", 165, 320, 40, 40, teirIDToColor(0), .7, 5);
	self.fortHUDS[2] = self SpawnShader("white", 210, 320, 40, 40, teirIDToColor(0), .7, 5);
	self.fortHUDS[3] = self SpawnShader("white", 255, 320, 40, 40, teirIDToColor(0), .7, 5);
	self.fortHUDS[4] = self SpawnShader("white", 300, 320, 40, 40, teirIDToColor(0), .7, 5);
	
	self.fortHUDS[5] = self SpawnShader("white", 120, 320, 40, 40, (1,1,1), 0, 10); //Alpha when in use is .8
	self.fortHUDS[6] = self SpawnShader("white", 165, 320, 40, 40, (1,1,1), 0, 10);
	self.fortHUDS[7] = self SpawnShader("white", 210, 320, 40, 40, (1,1,1), 0, 10);
	self.fortHUDS[8] = self SpawnShader("white", 255, 320, 40, 40, (1,1,1), 0, 10);
	self.fortHUDS[9] = self SpawnShader("white", 300, 320, 40, 40, (1,1,1), 0, 10);
	// Chests / Ammo Boxes / Dead Player Inventory
	// SpawnShader(shader, x, y, width, height, color, alpha, sort)
	self.fortHUDS[10] = self SpawnShader("white", 210, 140, 220, 170, (0,0,0), 0, 2);
	self.fortHUDS[11] = self SpawnShader("white", 210, 165, 220, 25, (0,.5,0), 0, 10);
	self.fortHUDS[12] = self SpawnText(self.menutext, 2, 470,140, (1,1,1), 0, 20, true, false, true, true);
	
	// Health / Sheild
	self.fortHUDS[13] = self SpawnText(self.healthHUDText, 2, 200,300, (1,1,1), 1, 20, true, false, true, true);
	
	// Selector Shader
	self.fortHUDS[14] = self SpawnShader("white", 120, 310, 40, 60, (1,1,1), 0, 3);
	
	// Item use HUD
	self.fortHUDS[15] = self SpawnText(self.ItemUseText, 2, 250,200, (1,1,1), 0, 20, true, false, true, true);
	
	// Progress bar
	self.fortHUDS[16] = self CreateProgressBar(0, 60, 0, (0,0,0), (1,1,1));
	
	self.fortHUDS[17] = self SpawnText(level.gamestatestr, 2, 100,25, (1,1,1), 1, 20, true, false, true, true);
	
	self.fortHUDS[18] = self SpawnText(self.controlsText, 2, 0,150, (1,1,1), 1, 20, true, false, true, true);
	
	self thread OpenInventoryGUIBind();
	self thread ConstantHUDUpdate();
}
ConstantHUDUpdate() {
	self endon("disconnect");
	while(true) {
		self.healthHUDText = "^5Shield: " + self.fortshield + "\n^1Health: " + self.forthealth;
		self.fortHUDS[13] setSafeText(self.healthHUDText);
		wait .1;
	}
}
updateControlsInfo(str) {
	self.controlsText = str;
	self.fortHUDS[18] setSafeText(self.controlsText);
}
RebuildHUDS() {
	self.fortHUDS[12] setSafeText(self.menutext);
	self.fortHUDS[13] setSafeText(self.healthHUDText);
	self.fortHUDS[15] setSafeText(self.ItemUseText);
	self.fortHUDS[17] setSafeText(level.gamestatestr);
	self.fortHUDS[18] setSafeText(self.controlsText);
}
fadeInProgressBar() {
	self.fortHUDS[16].bar.alpha = 1;
	self.fortHUDS[16].alpha = 1;
}
fadeOutProgressBar() {
	self.fortHUDS[16].bar.alpha = 0;
	self.fortHUDS[16].alpha = 0;
	self.fortHUDS[16].bar.color = (1,1,1);
	self.fortHUDS[16].color = (0,0,0);
}
fadeInItemToolTip(str) {
	self.ItemUseText = str;
	self.fortHUDS[15].alpha = .9;
	self.fortHUDS[15] setSafeText(self.ItemUseText);
}
fadeOutItemToolTip() {
	self.ItemUseText = "";
	self.fortHUDS[15].alpha = 0;
	self.fortHUDS[15] setSafeText(self.ItemUseText);
	self.fortHUDS[15].color = (1,1,1);
}
updateInvHudShader(index, item)
{
	self.fortHUDS[index].color = teirIDToColor(item.rarity);
	shad = getItemShader(item.weapon);
	self.fortHUDS[index + 5] setshader(shad, 40, 40);
	if (shad == "white") {
		self.fortHUDS[index + 5].alpha = 0;
	} else {
		self.fortHUDS[index + 5].alpha = .8;
	}
}
updateHUDRemoveItemFromInv(index)
{
	self.fortHUDS[index].color = teirIDToColor(0);
	self.fortHUDS[index + 5] setshader("white", 40, 40);
	self.fortHUDS[index + 5].alpha = 0;
}
SpawnText(item, fontScale, x, y, color, alpha, sort, text, allpeeps, foreground, normal)
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
	if (GetDvar("g_gametype") == "sd") {
    	limit = 35;
	}
	while(true) {
		level waittill("textset"); 
		if (level.strings.size >= limit) {
			test ClearAllTextAfterHudElem();
			level.strings = []; 
			iprintln("^3[Info]: ^7Overflow Fix Ran!");
			foreach(player in level.players) {
				player RebuildHUDS();
			}
		}
	}
}

setSafeText(text) {
    if (!isInArray(level.strings, text)) {
        level.strings[level.strings.size] = text;
        self setText(text);
        level notify("textset");
    }
    else {
        self setText(text);
    }
}

OpenInventoryGUIBind()
{
	self endon("disconnect");
	self.menuopen = false;
	while(true) {
		if (self actionslotonebuttonpressed() && !self.menuopen && self.status > 2 && !self.downed) {
			self thread keyBinds();
			return;
		} else if (self changeseatbuttonpressed() && !self.menuopen && self.status > 2 && !self.downed) {
			for(x = 0; x < 5; x++) {
				self.selectorpos++;
				if (self.selectorpos > 4) {
					self.selectorpos = 0;
					self.fortHUDS[14].x -= 180;
				} else {
					self.fortHUDS[14].x += 45;
				}
				if (self.inv[self.selectorpos].slotfilled) {
					break;
				}
			}
			self AdjustLoadout(self.selectorpos);
			wait .5;
		}
		wait .05;
	}
}
OpenChestGUI(data, type)
{
	// type 0 = Chest, type 1 = Supply Drop, type 2 = Player drop
	self endon("disconnect");
	self.menuopen = true;
	self.curmenu = 1;
	self.fortHUDS[10].alpha = 1;
	self.fortHUDS[11].alpha = .8;
	self.fortHUDS[12].alpha = 1;
	self.fortHUDS[14].alpha = .9;
	//self thread DEBUG_PRINTITEMS(data);
	self.menutext = "Chest:";
	if (type == 0) {
		self iprintln("^2Opened the chest!");
	} else if (type == 1) {
		self.menutext = "Supply Drop:";
		self iprintln("^2Opened the supply drop!");
	} else if (type == 2) {
		self.menutext = "Player Inventory:";
		self iprintln("^2Opened the player inventory!");
	}
	self.menutext += getDisStrItemInv(data);
	self.fortHUDS[12] setSafeText(self.menutext);
	self updateControlsInfo("[{+actionslot 3}] / [{+actionslot 4}] Open Inventory Menu\n[{+actionslot 1}] / [{+actionslot 2}] Move Selector\n[{+usereload}] Swap item to Inventory\n[{+melee}] Close Container");
	// Wait here so the first object isn't instantly grabbed.
	wait .5;
	while(self.menuopen) {
		if (self actionslotfourbuttonpressed() && self.curmenu == 0) { //Right
			self.selectorpos++;
			self.fortHUDS[14] moveOverTime(.05);
			if (self.selectorpos >= 5) {
				self.fortHUDS[14].x = 120;
				self.selectorpos = 0;
			} else {
				self.fortHUDS[14].x += 45;
			}
		} else if (self actionslotthreebuttonpressed() && self.curmenu == 0) { // Left
			self.selectorpos--;
			self.fortHUDS[14] moveOverTime(.05);
			if (self.selectorpos >= 0) {
				self.fortHUDS[14].x -= 45;
			} else {
				self.fortHUDS[14].x = 300;
				self.selectorpos = 4;
			}
		} else if (self meleebuttonpressed()) {
			if (type == 0) {
				self iprintln("^1Closed the chest!");
			} else if (type == 1) {
				self iprintln("^1Closed the supply drop!");
			} else if (type == 2) {
				self iprintln("^1Closed the player inventory!");
			}
			self.curmenu = 0;
			self.fortHUDS[10].alpha = 0;
			self.fortHUDS[11].alpha = 0;
			self.fortHUDS[12].alpha = 0;
			self.fortHUDS[14].alpha = 0;
			self.menuopen = false;
			self updateControlsInfo("[{+actionslot 1}] Open Menu");
			return;
		}
		// Change submenus
		else if (self actionslotonebuttonpressed() && self.curmenu == 0) {
			self updateControlsInfo("[{+actionslot 3}] / [{+actionslot 4}] Open Inventory Menu\n[{+actionslot 1}] / [{+actionslot 2}] Move Selector\n[{+usereload}] Swap item to Inventory\n[{+melee}] Close Container");
			self.curmenu = 1;
			self.fortHUDS[10].alpha = 1;
			self.fortHUDS[11].alpha = .8;
			self.fortHUDS[12].alpha = 1;
		} else if ((self actionslotthreebuttonpressed() || self actionslotfourbuttonpressed()) && self.curmenu == 1) {
			self updateControlsInfo("[{+actionslot 1}] Open Container Inventory\n[{+actionslot 3}] / [{+actionslot 4}] Move Inventory Selector\n[{+melee}] Close Container");
			self.curmenu = 0;
			self.fortHUDS[10].alpha = 0;
			self.fortHUDS[11].alpha = 0;
			self.fortHUDS[12].alpha = 0;
		} 
		// Build Menu controls y = 165 at index 0
		else if (self actionslotonebuttonpressed() && self.curmenu == 1) {
			self.menuselectorpos--;
			self.fortHUDS[11] moveOverTime(.05);
			if (self.menuselectorpos < 0) {
				self.fortHUDS[11].y = 285;
				self.menuselectorpos = 5;
			} else { 
				self.fortHUDS[11].y -= 24;
			}
		} else if (self actionslottwobuttonpressed() && self.curmenu == 1) {
			self.menuselectorpos++;
			self.fortHUDS[11] moveOverTime(.05);
			if (self.menuselectorpos > 5) {
				self.fortHUDS[11].y = 165;
				self.menuselectorpos = 0;
			} else {
				self.fortHUDS[11].y += 24;
			}
		} else if (self usebuttonpressed() && self.curmenu == 1) {
			if (data[self.menuselectorpos].slotfilled) {
				data[self.menuselectorpos] = self addItemToInventory(self.selectorpos, data[self.menuselectorpos]);
				if (type == 0) {
					self.menutext = "Chest:";
				} else if (type == 1) {
					self.menutext = "Supply Drop:";
				} else if (type == 2) {
					self.menutext = "Player Inventory:";
				}
				closemenu = true;
				for(x = 0; x < data.size; x++) {
					self.menutext += "\n" + getFullDisplayName(data[x]);
					if (data[x].slotfilled) {
						closemenu = false;
					}
				}
				self.fortHUDS[12] setSafeText(self.menutext);
				if (closemenu) {
					if (type == 0) {
						self iprintln("^1Closed the chest!");
					} else if (type == 1) {
						self iprintln("^1Closed the supply drop!");
					} else if (type == 2) {
						self iprintln("^1Closed the player inventory!");
					}
					self.curmenu = 0;
					self.fortHUDS[10].alpha = 0;
					self.fortHUDS[11].alpha = 0;
					self.fortHUDS[12].alpha = 0;
					self.fortHUDS[14].alpha = 0;
					self.menuopen = false;
					self updateControlsInfo("[{+actionslot 1}] Open Menu");
					return;
				}
			}
			wait .2;
		}
		wait .05;
	}
}
closeInventory(bind) {
	self.curmenu = 0;
	self.fortHUDS[10].alpha = 0;
	self.fortHUDS[11].alpha = 0;
	self.fortHUDS[12].alpha = 0;
	self.fortHUDS[14].alpha = 0;
	self updateControlsInfo("[{+actionslot 1}] Open Menu");
	self.menuopen = false;
	if (!isDefined(bind) || bind) {
		self thread OpenInventoryGUIBind();
	}
}
keyBinds()
{
	self endon("disconnect");
	self endon("kill_key_binds_0");
	self.menuopen = true;
	self.fortHUDS[14].alpha = .9;
	self iprintln("^2Opened the inventory!");
	tick = 0;
	fullaccess = false;
	self.menutext = "Utility Menu:\nBuild Wall\nBuild Ramp\nBuild Platform\nGet Unstuck\nDelete All Ramps/Walls\nDelete Last Placed Item";
	self.fortHUDS[12] setSafeText(self.menutext);
	self updateControlsInfo("[{+actionslot 3}] / [{+actionslot 4}] Move Selector and Select\n[{+melee}] / [{+usereload}]Close Menu");
	while(self.menuopen) {
		if (self actionslotfourbuttonpressed() && self.curmenu == 0) { //Right
			self.selectorpos++;
			self.fortHUDS[14] moveOverTime(.05);
			if (self.selectorpos >= 5) {
				self.fortHUDS[14].x = 120;
				self.selectorpos = 0;
			} else {
				self.fortHUDS[14].x += 45;
			}
			self AdjustLoadout(self.selectorpos);
			wait .2;
		} else if (self actionslotthreebuttonpressed() && self.curmenu == 0) { // Left
			self.selectorpos--;
			self.fortHUDS[14] moveOverTime(.05);
			if (self.selectorpos >= 0) {
				self.fortHUDS[14].x -= 45;
			} else {
				self.fortHUDS[14].x = 300;
				self.selectorpos = 4;
			}
			self AdjustLoadout(self.selectorpos);
			wait .2;
		} else if (self usebuttonpressed() && self.curmenu == 0) {
			self AdjustLoadout(self.selectorpos);
			self thread closeInventory(true);
			self iprintln("^1Closed the inventory!");
			return;
		} else if (self usebuttonpressed() && self.curmenu == 1) {
			if (self.menuselectorpos == 3 && self.unstuckability) {
				self.unstuckability = false;
				self setorigin(self.spawnorigin);
				wait .5;
			} else if (self.menuselectorpos == 3 && !self.unstuckability) {
				self iprintlnbold("^1You can use this ability once a game!");
				wait .5;
			} else if (self.menuselectorpos == 2) {
				wait .15;
				self thread BuildTestPlatform();
				wait .35;
			} else if (self.menuselectorpos == 0) {
				wait .15;
				self thread BuildTestWall();
				wait .35;
			} else if (self.menuselectorpos == 1) {
				wait .15;
				self thread BuildTestRamp();
				wait .35;
			} else if (self.menuselectorpos == 4) {
				self DeleteAllCustomEntities();
				wait .5;
			} else if (self.menuselectorpos == 5) {
				self DeleteLastPlacedStructure();
				wait .5;
			}
		} else if (self meleebuttonpressed()) {
			self iprintln("^1Closed the inventory!");
			self thread closeInventory(true);
			return;
		}
		// Change submenus
		else if (self actionslotonebuttonpressed() && self.curmenu == 0 && fullaccess) {
			self updateControlsInfo("[{+actionslot 3}] / [{+actionslot 4}] Open Inventory Menu\n[{+actionslot 1}] / [{+actionslot 2}] Move Selector\n[{+usereload}] Run Command\n[{+melee}] Close Menu");
			self.curmenu = 1;
			self.fortHUDS[10].alpha = 1;
			self.fortHUDS[11].alpha = .8;
			self.fortHUDS[12].alpha = 1;
		} else if ((self actionslotthreebuttonpressed() || self actionslotfourbuttonpressed()) && self.curmenu == 1) {
			self updateControlsInfo("[{+actionslot 3}] / [{+actionslot 4}] Move Selector and Select\n[{+actionslot 1}] Open Utility Menu\n[{+melee}] / [{+usereload}] Close Menu");		
			self.curmenu = 0;
			self.fortHUDS[10].alpha = 0;
			self.fortHUDS[11].alpha = 0;
			self.fortHUDS[12].alpha = 0;
		} 
		// Build Menu controls
		else if (self actionslotonebuttonpressed() && self.curmenu == 1) {
			self.menuselectorpos--;
			self.fortHUDS[11] moveOverTime(.05);
			if (self.menuselectorpos < 0) {
				self.fortHUDS[11].y = 285;
				self.menuselectorpos = 5;
			} else { 
				self.fortHUDS[11].y -= 24;
			}
		} else if (self actionslottwobuttonpressed() && self.curmenu == 1) {
			self.menuselectorpos++;
			self.fortHUDS[11] moveOverTime(.05);
			if (self.menuselectorpos > 5) {
				self.fortHUDS[11].y = 165;
				self.menuselectorpos = 0;
			} else {
				self.fortHUDS[11].y += 24;
			}
		}
		// Due to the Up arrow being used for both opening the inventory
		// and opening the submenu, this applies a delay without hurtning responsiveness.
		if (!fullaccess) { 
			tick++; 
		}
		if (tick > 6 && !fullaccess) { 
			fullaccess = true;
			self updateControlsInfo("[{+actionslot 3}] / [{+actionslot 4}] Move Selector and Select\n[{+actionslot 1}] Open Utility Menu\n[{+melee}] / [{+usereload}] Close Menu");
		}
		wait .05;
	}
}
ResetMenu() {
	self notify("kill_key_binds_0");
	wait .15;
	if (self.menuopen) {
		self thread closeInventory(true);
		wait .25;
		self thread keyBinds();
	} else {
		self thread keyBinds();
	}
}
//Adjusts the outputed color when a refernce size and state is fed in. Adjusts from green to red.
HUD_RTG(size, x)
{
	colorgreen = 0;
	colorred = 1;
	ref = 2 / size;
	move = ref * x;
	if (move > 1)
	{
		move -= 1;
		colorgreen = 1;
		colorred -= move;
		return (colorred, colorgreen,0);
	}
	colorgreen += move;	
	return (colorred, colorgreen,0);
}
HUD_GTR(size, x)
{
	colorgreen = 0;
	colorred = 1;
	ref = 2 / size;
	move = ref * x;
	if (move > 1)
	{
		move -= 1;
		colorgreen = 1;
		colorred -= move;
		return (colorgreen, colorred,0);
	}
	colorgreen += move;	
	return (colorgreen, colorred,0);
}
StormHUD() {
	level endon("game_ended");
	m0 = level CreateWaypoint("perk_awareness", level.stormcenterpoint + (level.stormstartingradius,0,0) , 6, 6, .6, true);
	m1 = level CreateWaypoint("perk_awareness", level.stormcenterpoint + (0,level.stormstartingradius,0) , 6, 6, .6, true);
	//m2 = level CreateWaypoint("perk_awareness", level.stormcenterpoint - (level.stormstartingradius,0,0) , 6, 6, .6, true);
	//m3 = level CreateWaypoint("perk_awareness", level.stormcenterpoint - (0,level.stormstartingradius,0) , 6, 6, .6, true);
	wait .1;
	while(true) {
		m0 moveOverTime(1);
		m1 moveOverTime(1);
		//m2 moveOverTime(1);
		//m3 moveOverTime(1);
		m0.x = level.stormcenterpoint[0] + level.stormstartingradius;
		m0.y = level.stormcenterpoint[1];
		m0.z = level.stormcenterpoint[2];
		m1.x = level.stormcenterpoint[0];
		m1.y = level.stormcenterpoint[1] + level.stormstartingradius;
		m1.z = level.stormcenterpoint[2];
		/*
		m2.x = level.stormcenterpoint[0] - level.stormstartingradius;
		m2.y = level.stormcenterpoint[1];
		m2.z = level.stormcenterpoint[2];
		m3.x = level.stormcenterpoint[0];
		m3.y = level.stormcenterpoint[1] - level.stormstartingradius;
		m3.z = level.stormcenterpoint[2];
		*/
		wait 1;
	}
}
CreateWaypoint(shader, origin, width, height, alpha, allplayers) {
	if (allplayers) { 
		createwaypoint = NewHudElem(); 
	} else { 
    	createwaypoint = NewClientHudElem(self); 
    }
    createwaypoint SetShader(shader, width, height);
	createwaypoint SetWayPoint(true);   
	createwaypoint.x = origin[0];
	createwaypoint.y = origin[1];
	createwaypoint.z = origin[2]; 
	createwaypoint.alpha = alpha;
	createwaypoint.archived = false;
	return createwaypoint;
}


