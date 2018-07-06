ACL(origin) {
	level.chestspawnlocations[level.chestspawnlocations.size] = origin;
}
AAL(origin) {
	level.ammospawnlocations[level.ammospawnlocations.size] = origin;
}
ASIL(origin) {
	level.spinningweaponlocations[level.spinningweaponlocations.size] = origin;
}
ASDL(origin) {
	level.supplydroplocations[level.supplydroplocations.size] = origin;
}
SpawnLamma(origin) {
	level endon("game_ended");
	level.activespeicallootdrops++;
	m = spawnEntity("t6_wpn_supply_drop_trap", origin, (0,0,90));
	f = spawnEntity("mp_flag_red", origin + (0,0,30) , (0,0,0));
	trig = spawn("trigger_radius", origin, 1, 60, 60);
	trig setCursorHint("HINT_NOICON", trig);
	trig setHintString("Hold [{+usereload}] to open the ^6Lamma");
	if (level.debugger) {
		level.debuggerhost setorigin(origin + (0,0,100));
	}
	while(true) {
		trig waittill("trigger", player);
		if (player useButtonPressed() && isAlive(player) && !player.menuopen) {
			for(x = 0; x < 5; x++) {
				player addAmmo(x, 1000);
			}
			player.forthealth = 100;
			player.fortshield = 100;
			trig triggerOff();
			m delete();
			f delete();
			break;
		} else if (player useButtonPressed() && isAlive(player) && player.menuopen) {
			player iprintlnbold("^1Your inventory must be closed to use this!");
		}
		wait .05;
	}
	level.activespeicallootdrops--;
	trig delete();
}
SpawnSupplyDrop(sorigin, eorigin, dur) {
	level endon("game_ended");
	level.activespeicallootdrops++;
	ammo0 = GetRandomAmmoAmmout(0);
	ammo1 = GetRandomAmmoAmmout(1);
	ammo2 = GetRandomAmmoAmmout(2);
	ammo3 = GetRandomAmmoAmmout(3);
	ammo4 = GetRandomAmmoAmmout(4);
	ammoobj0 = []; 
	ammoobj0[0] = "knife_mp"; 
	ammoobj0[1] = ammoTypeToString(0, ammo0); 
	ammoobj0[2] = 0 + ""; 
	ammoobj0[3] = 0 + ""; 
	ammoobj0[4] = "f";
	ammoobj1 = []; 
	ammoobj1[0] = "knife_mp"; 
	ammoobj1[1] = ammoTypeToString(1, ammo1); 
	ammoobj1[2] = 0 + ""; 
	ammoobj1[3] = 1 + ""; 
	ammoobj1[4] = "f";
	ammoobj2 = []; 
	ammoobj2[0] = "knife_mp"; 
	ammoobj2[1] = ammoTypeToString(2, ammo2); 
	ammoobj2[2] = 0 + ""; 
	ammoobj2[3] = 2 + ""; 
	ammoobj2[4] = "f";
	ammoobj3 = []; 
	ammoobj3[0] = "knife_mp"; 
	ammoobj3[1] = ammoTypeToString(3, ammo3); 
	ammoobj3[2] = 0 + ""; 
	ammoobj3[3] = 3 + ""; 
	ammoobj3[4] = "f";
	ammoobj4 = []; 
	ammoobj4[0] = "knife_mp"; 
	ammoobj4[1] = ammoTypeToString(4, ammo4); 
	ammoobj4[2] = 0 + ""; 
	ammoobj4[3] = 4 + ""; 
	ammoobj4[4] = "f";
	
	item = [];
	item[0] = ammoobj0;
	item[1] = ammoobj1;
	item[2] = ammoobj2;
	item[3] = ammoobj3;
	item[4] = ammoobj4;
	item[5] = GenerateChestLoot(true);
	
	refpoint = spawn("script_origin", sorigin);
	
	m = spawnEntity("t6_wpn_supply_drop_trap", sorigin, (0,0,90));
	f = spawnEntity("mp_flag_green", sorigin + (0,0,30) , (0,0,0));
	m EnableLinkTo();
	f EnableLinkTo();
	m LinkTo(refpoint);
	f LinkTo(refpoint);
	iprintln("^2A Supply Drop is falling into the map!");
	refpoint moveTo(eorigin, dur);
	wait dur;
	trig = spawn("trigger_radius", eorigin, 1, 60, 60);
	trig setCursorHint("HINT_NOICON", trig);
	trig setHintString("Hold [{+usereload}] to open the Supply Drop");
	if (level.debugger) {
		level.debuggerhost setorigin(eorigin + (0,0,100));
	}
	while(true) {
		trig waittill("trigger", player);
		if (player useButtonPressed() && isAlive(player) && !player.menuopen) {
			player thread OpenChestGUI(item, false);
			trig triggerOff();
			refpoint delete();
			m delete();
			f delete();
			break;
		} else if (player useButtonPressed() && isAlive(player) && player.menuopen) {
			player iprintlnbold("^1Your inventory must be closed to use this!");
		}
		wait .05;
	}
	level.activespeicallootdrops--;
	trig delete();
}
SpawnChest(origin, angle)
{
	level endon("game_ended");
	level.activechests++;
	if (!isDefined(angle)) { angle = (0,0,0); }
	totalitems = RandomIntRange(1, 4);
	ammotype1 = RandomIntRange(0, 5);
	ammotype2 = RandomIntRange(0, 5);
	ammo1 = GetRandomAmmoAmmout(ammotype1);
	ammo2 = GetRandomAmmoAmmout(ammotype2);
	ammoobj1 = []; 
	ammoobj1[0] = "knife_mp"; 
	ammoobj1[1] = ammoTypeToString(ammotype1, ammo1); 
	ammoobj1[2] = 0 + ""; 
	ammoobj1[3] = ammotype1 + ""; 
	ammoobj1[4] = "f";
	ammoobj2 = []; 
	ammoobj2[0] = "knife_mp"; 
	ammoobj2[1] = ammoTypeToString(ammotype2, ammo2); 
	ammoobj2[2] = 0 + ""; 
	ammoobj2[3] = ammotype2 + ""; 
	ammoobj2[4] = "f";
	item = [];
	item[0] = ammoobj1;
	item[1] = ammoobj2;
	
	for(x = 0; x < totalitems; x++) {
		item[x + 2] = level GenerateChestLoot();
	}
	m = spawnEntity("t6_wpn_supply_drop_trap", origin, angle);
	trig = spawn("trigger_radius", m.origin, 1, 60, 60);
	trig setCursorHint("HINT_NOICON", trig);
	trig setHintString("Hold [{+usereload}] to open chest");
	while(true) {
		trig waittill("trigger", player);
		if (player useButtonPressed() && isAlive(player) && !player.menuopen) {
			player thread OpenChestGUI(item, false);
			trig triggerOff();
			m delete();
			break;
		} else if (player useButtonPressed() && isAlive(player) && player.menuopen) {
			player iprintlnbold("^1Your inventory must be closed to use this!");
		}
		wait .05;
	}
	level.activechests--;
	trig delete();
}
SpawnAmmoCrate(origin, angle)
{
	level endon("game_ended");
	level.activeammodrops++;
	if (!isDefined(angle)) { angle = (0,0,0); }
	ammotype1 = RandomIntRange(0, 5);
	ammotype2 = RandomIntRange(0, 5);
	ammotype3 = RandomIntRange(0, 5);
	ammo1 = GetRandomAmmoAmmout(ammotype1);
	ammo2 = GetRandomAmmoAmmout(ammotype2);
	ammo3 = GetRandomAmmoAmmout(ammotype3);
	
	m = spawnEntity("t6_wpn_supply_drop_trap", origin, angle);
	trig = spawn("trigger_radius", m.origin, 1, 60, 60);
	trig setCursorHint("HINT_NOICON", trig);
	trig setHintString("Hold [{+usereload}] to loot ammo drop");
	while(true) {
		trig waittill("trigger", player);
		if (player useButtonPressed() && isAlive(player) && !player.menuopen) {
			player addAmmo(ammotype1, ammo1);
			player addAmmo(ammotype2, ammo2);
			player addAmmo(ammotype3, ammo3);
			trig triggerOff();
			m delete();
			break;
		}
		wait .05;
	}
	level.activeammodrops--;
	trig delete();
}
SpawnItemDrop(origin)
{
	level endon("game_ended");
	weap = GenerateLoot();
	e = spawnEntity(getWeaponModel("an94_mp"), origin + (0,0,40), (0,0,0));
	disname = getDisplayName(weap[0]);
	isweapon = isAWeapon(weap[0]);
	ammotype = getAmmoType(weap[0]);
	e thread spinWeaponDrop();
	if (isweapon) {
		if (weap[0] == "frag_grenade_mp" || weap[0] == "sticky_grenade_mp" || weap[0] == "satchel_charge_mp") {
			level thread DeploySpiningItemDrop(weap[0], disname, e, getDefaultItemSpawnCount(weap[0]), int(weap[1]), -1, true);
		} else {
			level thread DeploySpiningItemDrop(weap[0], disname, e, 999, int(weap[1]), ammotype, true);
		}
	}
	else {
		level thread DeploySpiningItemDrop(weap[0], weap[0], e, getDefaultItemSpawnCount(weap[0]), int(weap[1]), 0, false);
	}
}
SpawnPlayerDeathDrop() 
{
	self endon("disconnect");
	newdata = [];
	i = 0;
	for(x = 0; x < 4; x++) {
		if (!IsEmpty(x)) {
			temp = self.inv[x];
		}
		if (temp.size != 0) {
			newdata[i] = temp;
			i++;
			//level.debuggerhost iprintln("Item index: " + x + " added to dumpable inventory");
		}
	}
	if (newdata.size > 0) {
		retval = [];
		// Up to this point this is stable!
		for(x = 0; x < newdata.size; x++) {
			retval[x][0] = newdata[x][0];
			retval[x][1] = "" + teirIDToStringColor(int(newdata[x][2])) + "" + getDisplayName(newdata[x][0]);
			retval[x][2] = newdata[x][2];
			retval[x][3] = newdata[x][1];
			retval[x][4] = newdata[x][4];
		}
		level thread SpawnPlayerDeathDropLevelThread(self.name, self.ammotypes, retval, self.origin);
	}
}
SpawnPlayerDeathDropLevelThread(name, ammo, data, origin) 
{
	level endon("game_ended");
	m = spawnEntity("t6_wpn_supply_drop_trap", origin, (0,0,0));
	trig = spawn("trigger_radius", m.origin, 1, 60, 60);
	trig setCursorHint("HINT_NOICON", trig);
	trig setHintString("Hold [{+usereload}] to loot " + name + "'s inventory");
	tick = 0;
	while(1800 > tick) {
		trig waittill("trigger", player);
		if (player useButtonPressed() && isAlive(player) && !player.menuopen) {
			for(x = 0; x < ammo.size; x++) {
				player addAmmo(x, ammo[x]);
			}
			if (data.size != 0) {
				player thread OpenChestGUI(data, true);
			}
			trig triggerOff();
			m delete();
			break;
		} else if (player useButtonPressed() && isAlive(player) && player.menuopen) {
			player iprintlnbold("^1Your inventory must be closed to use this!");
		}
		wait .05;
		tick++;
	}
	trig delete();
}
// 
spawnObject(model, origin, angle)
{
	obj = spawnEntity(model, origin, angle);
}
spawnEntity(model, origin, angle)
{
	if (!isdefined(angle)) { angle = (0,0,0); }
    entity = spawn("script_model", origin);
    entity.angles = angle;
    entity setModel(model);
    return entity;
}
spawnSafeEntity(model, origin, angle)
{
    entity = spawn("script_model", origin);
    entity.angles = angle;
    entity setModel(model);
    if(getentarray().size >= level.mapcustomentitylimit)
    {
        self iprintln("^1Error: Max Entity spawn limmit reached, some objects did not spawn to prevent overflow!");
        entity delete();
    }
    return entity;
}
Forge_CreateBattleBus(origin) {
	level.battlebus = spawn("script_origin", origin);
	level.bbents = [];
	SO = origin;
	z = origin[0];
	for(x = 0; x < 6; x++) {
		for(y = 0; y < 12; y++) { 
			level.bbents[level.bbents.size] = spawnEntity("t6_wpn_supply_drop_trap", SO, (0,0,0));
			level.bbents[level.bbents.size - 1] EnableLinkTo();
			level.bbents[level.bbents.size - 1] LinkTo(level.battlebus);
			SO += (0,72,0); // Long side
		}
		z += 41; // Short side
		SO = (z, origin[1], origin[2]);
		wait .05;
	}
}
TeleportToBattleBus() {
	id = 0;
	foreach(player in level.players) {
		player setorigin(level.bbents[id].origin + (0,0,-125));
		player setperk("specialty_fallheight");
		player thread DetachWhenReady(2);
		player.status = 1;
		player disableWeapons();
		id += 2;
	}
	wait 1;
	level thread MoveBattleBus();
}
MoveBattleBus() {
	level endon("game_ended");
	setDvar("bg_gravity", "180");
	level.battlebus moveTo(level.battlebusendorigin, level.battlebustimetotarget);
	for(x = 0; x < level.battlebustimetotarget; x++) {
		iprintln("You will be forcefuly pushed off in " + (level.battlebustimetotarget - x) + " seconds!"); 
		wait 1;
	}
	foreach(player in level.players) {
		player notify("force_player_to_detach_from_bb");
		if (player.status == 1) {
			player DetachAll();
			player.battlebus delete();
			player setorigin(player.origin - (0,0,250));
			player thread FlyToMap();
			player.status = 2;
		}
	}
	wait .5;
	for(x = 0; x < level.bbents.size; x++) {
		level.bbents[x] delete();
	}
	level.bbents = undefined;
	level.battlebus delete();
	foreach(player in level.players) {
		player.canbuild = true;
	}
	wait 10;
	setDvar("bg_gravity", "800");
}
FlyToMap() {
	self endon("disconnect");
	self endon("death");
	time = 590;
	self fadeInItemToolTip("^2Look in the dirrection you want to fall to.");
	self setperk("specialty_fallheight");
	z = self.origin[2];
	while(self DisToGround() > 15 && time > 0) {
		self setorigin(self FlyToGroundMoreAgreesiveSideways());
		wait .05;
		time--;
		if (self.origin[2] >= z && time < 510) {
			break;
		}
		z = self.origin[2];
	}
	self fadeOutItemToolTip();
	self updateControlsInfo("[{+actionslot 1}] Open Menu");
	self enableWeapons();
	self.status = 3;
}
DetachWhenReady(time) {
	self endon("disconnect");
	self endon("force_player_to_detach_from_bb");
	self.battlebus = spawn("script_origin", self.origin);
	self PlayerLinkTo(self.battlebus, undefined);
	wait 1;
	self.battlebus moveTo(level.battlebusendorigin - (0,0,125), level.battlebustimetotarget);
	wait time;
	self setperk("specialty_fallheight");
	self fadeInItemToolTip("Hold [{+usereload}] to Jump off the Battle Bus");
	while(true) {
		if (self usebuttonpressed() && time == 0) {
			self.ItemUseText = "Hold [{+usereload}] to Jump off the Battle Bus";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(10, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		} else if (self usebuttonpressed() && time > 0) {
			self.fortHUDS[16] updateBar(time / 10);
			self.fortHUDS[16].bar.color = HUD_RTG(10, time);
			time++;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 10) {
			self fadeOutItemToolTip();
			self DetachAll();
			self.battlebus delete();
			self.status = 2;
			self setorigin(self.origin - (0,0,250));
			self fadeOutProgressBar();
			self iprintlnbold("^2Jumped off the Battle Bus!");
			self thread FlyToMap();
			break;
		}
		wait .05;
	}
	
}
DeleteDeathBarriers()
{
    ents = getEntArray();
    for ( index = 0; index < ents.size; index++ )
    {
    	if(isSubStr(ents[index].classname, "trigger_hurt"))
    		ents[index].origin = (0, 0, 9999999);
    }
}
Forge_Teleport(start, end) {
	level endon("game_ended");
	obj = spawnEntity("mp_flag_neutral", start, (0,0,0));
	obj2 = spawnEntity("mp_flag_neutral", end, (0,0,0));
	while(1) {
	    foreach(player in level.players)  {
	    	if (Distance(player.origin, start) < 20 && player.canteleport) {
	    		player thread SetOrigin_fixed(end);
	    	}
	    	else if (Distance(player.origin, end) < 20 && player.canteleport) {
	    		player thread SetOrigin_fixed(start);
	    	}
	   	}
	   	wait .1;
	}
}
SetOrigin_fixed(origin)
{
	self.canteleport = false;
	self setorigin(origin);
	wait 1;
	self.canteleport = true;
}

// Placeable peices
PlayerGetDirrection() {
	// S = -180/180, W = -90, N = 0, E = 90
	if (self.angles[1] >= 135 || self.angles[1] <= -135) {
		return "South";
	} else if (self.angles[1] >= 45) {
		return "West";
	} else if (self.angles[1] <= 45 && self.angles[1] >= -45) {
		return "North";
	} else {
		return "East";
	}
}
PlayerGetBuildGridId(t){
	target = self.origin;
	if (isDefined(t)){ 
		target = t - (0,0,25);
	}
	//target += (0,0,20);
	dif = level.stormcenterpoint - target;
	// Each zone is 140 x 140 x 70
	// This point is the cordnate tabled version of the location to build.
	return (int((floor(dif[0] / 140) + 2) * -1), int((floor(dif[1] / 140) + 2) * -1), int(floor(dif[2] / 70) * -1));
}
DeleteAllCustomEntities() {
	if (self.hastodeleteentities) {
		self.hastodeleteentities = false;
		for(x = 0; x < self.buildentites.size; x++) {
			self.buildentites[x] delete();
		}
	} else {
		for(x = 0; x < self.activebuildindex; x++) {
			self.buildentites[x] delete();
		}
	}
	self.activebuildindex = 0;
	self iprintln("All your entities have been deleted!");
}
DeleteLastPlacedStructure() {
	if (!self.hastodeleteentities && self.activebuildindex == 0) {
		self iprintln("You don't got anything to delete!");
		return;
	} else if (self.hastodeleteentities) {
		count = 0;
		ref = 4;
		if (self.lastplacedramp) {
			ref = 6;
		} 
		while(count < ref) {
			self.activebuildindex--;
			if (self.activebuildindex < 0) {
				self.activebuildindex = (level.entitiesperplayer - 1);
				self.hastodeleteentities = false;
			}
			self.buildentites[self.activebuildindex] delete();
			count++;
		}
	} else {
		count = 0;
		ref = 4;
		if (self.lastplacedramp) {
			ref = 6;
		} 
		while(count < ref) {
			self.activebuildindex--;
			if (self.activebuildindex < 0) {
				break;
			}
			self.buildentites[self.activebuildindex] delete();
			count++;
		}
	}
}
PlayerBuildAddEntity(obj) {
	if (self.activebuildindex >= level.entitiesperplayer) {
		self.hastodeleteentities = true;
		self.activebuildindex = 0;
	}
	if (self.hastodeleteentities) {
		self.buildentites[self.activebuildindex] delete();
		//self iprintln("Deleted entity at index: " + self.activebuildindex);
	}
	self.buildentites[self.activebuildindex] = obj;
	self.activebuildindex++;
}
PlayerExtendOrigin(dir) {
	t = (0,0,0);
	if (dir == "North") {
		return (self.origin + (130,0,30));
	} else if (dir == "South") {
		return (self.origin - (130,0,-30));
	} else if (dir == "East") {
		return (self.origin - (0,130,-30));
	} 
	return (self.origin + (0,130,30));
}

BuildTestRamp() {
	if (!self.canbuild) {
		self iprintlnbold("^1We can not build right now!");
		return;
	}
	self.lastplacedramp = true;
	dir = self PlayerGetDirrection();
	SO = self PlayerGetBuildGridId(self PlayerExtendOrigin(dir));
	ref = self PlayerGetBuildGridId(self.origin);
	if (ref[0] == SO[0] && ref[1] == SO[0]) {
		self iprintln("Tried to build a ramp dirrectly on top of my self, Cancelled!");
		return;
	}
	x = SO[0] * 140;
	y = SO[1] * 140;
	z = SO[2] * 70;
	center = ((x + 70), (y + 70), z);
	top = (0,0,0);
	if (dir == "West") {
		top = ((x + 70), (y + 140), (z + 60));
		center = ((x + 70), (y + 10), z);
	} else if (dir == "East") {
		top = ((x + 70), y, (z + 60));
		center = ((x + 70), (y + 130), z);
	} else if (dir == "North") {
		top = ((x + 140), (y + 70), (z + 60));
		center = ((x + 10), (y + 70), z);
	} else {
		top = (x, (y + 70), (z + 60));
		center = ((x + 130), (y + 70), z);
	}
    blocks = 6;
    CX = top[0] - center[0];
    CY = top[1] - center[1];
    CZ = top[2] - center[2];
    XA = CX / blocks;
    YA = CY / blocks;
    ZA = CZ / blocks;
    Temp = VectorToAngles(top - center);
    BA =(Temp[0], Temp[1], Temp[2]);
    for(b = 0; b < blocks; b++) {
    	self PlayerBuildAddEntity(self spawnSafeEntity("t6_wpn_supply_drop_trap", (center + ((XA, YA, ZA) * B)), BA));
    }
}
BuildTestWall() {
	if (!self.canbuild) {
		self iprintlnbold("^1We can not build right now!");
		return;
	}
	self.lastplacedramp = false;
	SO = self PlayerGetBuildGridId();
	dir = self PlayerGetDirrection();
	// spawnSafeEntity("t6_wpn_supply_drop_trap", origin, (0,0,0));  70 long, 40 wide, 40 high
	x = SO[0] * 140;
	y = SO[1] * 140;
	z = SO[2] * 70;
	if (dir == "North" || dir == "South") {
		for(xx = 0; xx < 2; xx++) {
			for(yy = 0; yy < 2; yy++) {
				if (dir == "North") {
					self PlayerBuildAddEntity(self spawnSafeEntity("t6_wpn_supply_drop_trap", ((x + 140),y,z), (0,0,0)));
				} else {
					self PlayerBuildAddEntity(self spawnSafeEntity("t6_wpn_supply_drop_trap", (x,y,z), (0,0,0)));
				}
				z += 35;
			}
			y += 70;
			z = SO[2] * 70;
		}
	} else {
		for(xx = 0; xx < 2; xx++) {
			for(yy = 0; yy < 2; yy++) {
				if (dir == "West") {
					self PlayerBuildAddEntity(self spawnSafeEntity("t6_wpn_supply_drop_trap", ((x + 20),(y + 110),z), (0,90,0)));
				} else {
					self PlayerBuildAddEntity(self spawnSafeEntity("t6_wpn_supply_drop_trap", ((x + 20),(y - 30),z), (0,90,0)));
				}
				z += 35;
			}
			x += 70;
			z = SO[2] * 70;
		}
	}
}
DoNotBuildZone(cor1,cor2)
{
	level endon("game_ended");
	if (cor1[0] > cor2[0]) {
		low0 = cor2[0];
		high0 = cor1[0];
	} else {
		high0 = cor2[0];
		low0 = cor1[0];
	}
	
	if (cor1[1] > cor2[1]) {
		low1 = cor2[1];
		high1 = cor1[1];
	} else {
		high1 = cor2[1];
		low1 = cor1[1];
	}
	
	if (cor1[2] > cor2[2]) {
		low2 = cor2[2];
		high2 = cor1[2];
	} else {
		high2 = cor2[2];
		low2 = cor1[2];
	}
	while(true) {
    	wait .05;
	    foreach(player in level.players) {
			if (player.origin[0] >= low0 && player.origin[0] <= high0) {
				if (player.origin[1] >= low1 && player.origin[1] <= high1) {
					if (player.origin[2] >= low2 && player.origin[2] <= high2) {
						player.canbuild = false;
					} else {
						player.canbuild = true;
					}
				} else {
					player.canbuild = true;
				}
			} else {
				player.canbuild = true;
			}
		}
	    
	}
}



















