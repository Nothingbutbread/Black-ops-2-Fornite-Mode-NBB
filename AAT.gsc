AAT_FakeLootCrateToQueue(origin)
{
	if (level.trapsqueue.size > 99)
	{
		level.trapsqueue = [];
		level.trapsqueueplayers = [];
	}
	level.trapsqueue[level.trapsqueue.size] = origin;
	level.trapsqueueplayers[level.trapsqueueplayers.size] = self;
}
AAT_Spawn_FakeLootCrate(index, location, placer) // Fake loot crate, intended as a trap.
{
	level endon("game_ended");
	// Checks complete, we are go for spawning a crate here.
	level.activelootboxes++;
	level.lca[index] = -2; // -2 indecates it's a trapped location and not an empty location
	killloop = false;
	obj = spawnEntity("t6_wpn_supply_drop_trap",location, (0,0,90));
	marker = CreateWaypoint("perk_hardline", location + (0,0,50) , 5, 5, .7, true);
	tick = 0;
	while(tick < 1200) // 2 minutes max durration of the trap.
	{
		foreach(player in level.players)
		{
			if (Distance(player.origin, location) < 60)
			{
				if (player meleebuttonpressed())
				{
					if (player.resistanceabilityactive)
					{
						iprintln(player.name + " just disarmed a loot box trap placed by " + placer.name);
					}
					else
					{
						playFx(level.remote_mortar_fx["missileExplode"],location + (0,0,30));
						PlaySoundAtPosition("wpn_rocket_explode", location);
						iprintln(Fun_taunt_trap(placer, player));
						foreach(player in level.players)
						{
							if (Distance(player.origin, obj.origin) < 150)
							{ player DoDamage(999, player.origin, placer, placer, "none", "MOD_BURNED", 0, "supplydrop_mp"); }
							else if (Distance(player.origin, obj.origin) < 200)
							{ player DoDamage(140, player.origin, placer, placer, "none", "MOD_BURNED", 0, "supplydrop_mp"); }
							else if (Distance(player.origin, obj.origin) < 325)
							{ player DoDamage(90, player.origin, placer, placer, "none", "MOD_BURNED", 0, "supplydrop_mp"); }
						}
					}
					killloop = true;
					break;
				}
			}
		}
		if (killloop) { break; }
		tick++;
		wait .1;
	}
	//
	marker Destroy();
	obj delete();
	level.lca[index] = -1; // Create is now longer active.
	level.activelootboxes--;
}
AAT_FakeLootBox()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6Fake Lootbox trap bullet ready!");
	self waittill("weapon_fired");
	target = self TraceShot();
	self iprintln("^2A Fake Lootbox will spawn where you just shot!");
	self AAT_FakeLootCrateToQueue(target);
}
AAT_LayExplosiveTrap()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintln("^6Explosive Trap ready!\nShoot at the spot to deploy it.");
	// level.activetraps
	while(true)
	{
		self waittill("weapon_fired");
		if (level.activetraps < 3)
		{
			level.activetraps++;
			target = self TraceShot();
			level thread AAT_ExplosiveTrap(self, target);
			self iprintln("^2Trap deployed!");
			break;
		}
		else { self iprintln("^1Too many traps are active right now. Try again later."); }
		wait 2;
	}
}
AAT_ExplosiveTrap(placer, location)
{
	level endon("game_ended");
	tick = 0;
	obj = spawnEntity("t6_wpn_supply_drop_trap",location, (0,0,0));
	tripped = false;
	while(tick < 1200) // 2 minutes max durration of the trap.
	{
		foreach(player in level.players)
		{
			if (Distance(player.origin, location) < 80)
			{
				playFx(level.remote_mortar_fx["missileExplode"],location + (0,0,30));
				PlaySoundAtPosition("wpn_rocket_explode", location);
				iprintln(Fun_taunt_trap(placer, player));
				tripped = true;
				foreach(player in level.players)
				{
					if (Distance(player.origin, obj.origin) < 150)
					{ player DoDamage(999, player.origin, placer, placer, "none", "MOD_BURNED", 0, "frag_grenade_mp"); }
					else if (Distance(player.origin, obj.origin) < 225)
					{ player DoDamage(140, player.origin, placer, placer, "none", "MOD_BURNED", 0, "frag_grenade_mp"); }
					else if (Distance(player.origin, obj.origin) < 300)
					{ player DoDamage(90, player.origin, placer, placer, "none", "MOD_BURNED", 0, "frag_grenade_mp"); }
				}
				break;
				
			}
		}
		if (tripped) { break; }
		tick++;
		wait .1;
	}
	level.activetraps--;
	obj delete();
}
AAT_ExplosiveBullets()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6Explosive bullets!");
	ammo = 5;
	if (self.occupation == "Specialist") { ammo = 10; }
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		RadiusDamage(target,80,70,50,self);
		ammo--;
		wait 1;
	}
	self iprintlnbold("^1Explosive bullets out of ammo!");
}
AAT_RocketLauncher()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6Rocket launcher Activated!");
	ammo = 2;
	if (self.occupation == "Specialist") { ammo = 4; }
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		bullet = spawnEntity("projectile_sidewinder_missile", self GetTagOrigin("tag_weapon_right") + (AnglesToForward(self GetPlayerAngles()) * 50), (0,0,0));
		bullet rotateto(VectorToAngles(target - bullet.origin),0.05);
		bullet moveto(target, 2);
		wait 2;
		playFx(level.remote_mortar_fx["missileExplode"],bullet.origin+(0,0,1));
		PlaySoundAtPosition("wpn_rocket_explode", bullet.origin);
		foreach(player in level.players)
		{
			if (Distance(player.origin, target) < 500)
			{
				player DoDamage(9999, player.origin, self, self, "none", "MOD_PROJECTILE_SPLASH", 0, "remote_missile_bomblet_mp");
			}
		}
		bullet delete();
		ammo--;
		if (ammo == 0) { break; }
		wait 5;
		self iprintlnbold("^6Rocket Ready!");
	}
	self iprintlnbold("^1Out of Rockets!");
}
AAT_SlugRay()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6Slug ray bullets Activated!");
	ammo = 5;
	if (self.occupation == "Specialist") { ammo = 10; }
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		foreach(player in level.players)
		{
			if (Distance(player.origin, target) < 400)
			{ player thread AAT_SlugRayEffect(); }
		}
		ammo--;
		if (ammo == 0) { break; }
		wait 5;
	}
	self iprintln("^1No more Slug ray bullets remain!");
}
AAT_SlugRayEffect()
{
	self endon("death");
	self endon("disconnect");
	self notify("booster_speedo");
	self iprintln("^1You were hit by a slug ray bullet!\n^7Our speed has been reduced to a 1/6 speed.");
	self setmovespeedscale(self.basespeed / 6);
	self.curspeed = self.basespeed / 6;
	wait 10;
	self setmovespeedscale(self.basespeed);
}
AAT_ShellShock()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6Shell Shock bullets Activated!");
	ammo = 6;
	if (self.occupation == "Specialist") { ammo = 12; }
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		foreach(player in level.players)
		{
			if (Distance(player.origin, target) < 450)
			{ player thread AAT_ShellShock_Effect(); }
		}
		ammo--;
		if (ammo == 0) { break; }
		wait 5;
	}
	self iprintln("^1No more Shell Shock bullets remain!");
}
AAT_ShellShock_Effect()
{
	a = RandomIntRange(-180, 180);
	if (a < 0) { a -= 180; NoN(a); }
	b = RandomIntRange(-180, 180);
	if (b < 0) { b -= 180; NoN(b); }
	self setPlayerAngles((a,b,0));
	self playlocalsound("wpn_rocket_explode_brick");
	self playlocalsound("wpn_rocket_explode_brick");
	self playlocalsound("wpn_rocket_explode_brick");
	self playlocalsound("wpn_rocket_explode_brick");
	self playlocalsound("wpn_shotgun_pump");
	self playlocalsound("wpn_smoke_hiss");
	self playlocalsound("mpl_wager_humiliate");
}
AAT_ProxyAttack()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6Proxy Attack bullets Activated!");
	ammo = 3;
	if (self.occupation == "Specialist") { ammo = 6; }
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		foreach(player in level.players)
		{
			if (Distance(player.origin, target) < 400)
			{ player notify("menu_proxy_attack"); player thread AAT_ProxyAttack_Effect(); }
		}
		ammo--;
		if (ammo == 0) { break; }
		wait 16;
	}
	self iprintln("^1No more Proxy attack bullets remain!");
}
AAT_ProxyAttack_Effect()
{
	self endon("death");
	self endon("disconnect");
	self endon("menu_proxy_attack");
	self iprintlnbold("^1Proxy attack active!");
	self.canusemenu = false;
	if (self.inventory_menu_open) { self thread Menu_Inventory_Close(); }
	else if (self.loot_menu_open) { self thread Menu_Loot_Close(); }
	if (self.resistanceabilityactive) { wait 7; }
	else { wait 15; }
	self.canusemenu = true;
	self iprintlnbold("^2Proxy attack disabled!");
}
AAT_ReconPaluse()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6Recon Paluse bullets Activated!");
	ammo = 4;
	if (self.occupation == "Specialist") { ammo = 8; }
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		foreach(player in level.players)
		{
			if (Distance(player.origin, target) < 400 && !player.istargted && level.targtedplayers < 5)
			{ player thread AAT_ReconPaluse_Effect(); }
		}
		ammo--;
		if (ammo == 0) { break; }
		wait 15;
	}
	self iprintln("^1No more Recon Paluse bullets remain!");
}
AAT_ReconPaluse_Effect()
{
	self endon("disconnect");
	self endon("death");
	self endon("end_AAT_ReconPaluse_Effect");
	level.targtedplayers++;
	self.istargted = true;
	self.waypointHUD Destroy();
	self.waypointHUD = self CreateWaypoint("perk_awareness", self.origin, 8, 8, .8, true);
	tick = 0;
	while(tick < 52)
	{
		wait .2;
		self.waypointHUD moveOverTime(.05);
		self.waypointHUD.x = self.origin[0];
		self.waypointHUD.y = self.origin[1];
		self.waypointHUD.z = self.origin[2];
		wait .05;
		tick++;
		
	}
	self.waypointHUD Destroy();
	level.targtedplayers--;
	self.istargted = false;
}
AAT_EMP()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6EMP bullets Activated!");
	ammo = 5;
	if (self.occupation == "Specialist") { ammo = 10; }
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		foreach(player in level.players)
		{
			if (Distance(player.origin, target) < 500)
			{ player thread AAT_EMP_Effect(); }
		}
		ammo--;
		if (ammo == 0) { break; }
		wait 8;
	}
	self iprintln("^1No more EMP bullets remain!");
}
AAT_EMP_Effect()
{
	if (self.resistanceabilityactive) { return; } // Effect Blocked!
	self iprintln("^1Hit by an EMP bullet!");
	self notify("new_booster");
	self notify("new_ability");
	self notify("new_AAT");
	// Closes menu
	if (self.inventory_menu_open) { self thread Menu_Inventory_Close(); }
	else if (self.loot_menu_open) { self thread Menu_Loot_Close(); }
	self show(); // Counters Vanish Booster
	self SetClientUIVisibilityFlag("g_compassShowEnemies", 0); // Counters Birds Eye View Booster
	self iprintln("^1Hit by an EMP bullet!");
	
}
AAT_Drained()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6Drained bullets Activated!");
	ammo = 4;
	if (self.occupation == "Specialist") { ammo = 8; }
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		foreach(player in level.players)
		{
			if (Distance(player.origin, target) < 450)
			{ player thread AAT_Drained_Effect(); }
		}
		ammo--;
		if (ammo == 0) { break; }
		wait 10;
	}
	self iprintln("^1No more Drained bullets remain!");
}
AAT_Drained_Effect()
{
	foreach (gun in self GetWeaponsList())
	{
		if (gun != "knife_held_mp")
		{
			self setWeaponAmmoClip(gun, 0);
		}
	}
	self iprintln("^1Your guns mag was drained!");
}
/*
	This effect is unique due to the restrictive nature of this effect.
	Titled the <null> effect. Only the Brokkie class players can obtain it.
	It causes the menu to "glitch" while active, causing "curuption" of some menu options.
	The menu its self isn't effected, just its look. Also random printing in the kill feed.
	If you are reading this, let this effect be a fun secret for others to ... discover.
*/
AAT_EasterEgg()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_AAT");
	self iprintlnbold("^6<null> bullets Activated!");
	self iprintln("^1Behold the power of the <null>!");
	self iprintln("^1Bullets send out a <null> virus!");
	ammo = 100;
	while(ammo > 0)
	{
		self waittill("weapon_fired");
		target = self TraceShot();
		foreach(player in level.players)
		{
			if (Distance(player.origin, target) < 350 && player != self)
			{ player notify("end_EE1_Effect"); player thread AAT_EasterEgg_Effect(); }
			else if (Distance(player.origin, target) < 350 && player == self)
			{ player notify("end_EE1_Effect"); player thread AAT_EasterEgg_Counter_Effect(); }
		}
		ammo--;
		if (ammo == 0) { break; }
		wait 5;
		self iprintlnbold("<null> bullet ready!");
	}
	self iprintln("^1<null> more <null> bullets remain!");
}
AAT_EasterEgg_Counter_Effect()
{
	self endon("death");
	self endon("disconnect");
	self endon("end_EE1_Effect");
	self.eastereggeffect = true;
	tick = 0;
	self iprintlnbold("<null> virus origin hit, <null> effects self <null>!");
	while(tick < 1000)
	{
		self iprintln("<null>");
		tick++;
		wait .2;
	}
	self.eastereggeffect = false;
}
AAT_EasterEgg_Effect()
{
	self endon("death");
	self endon("disconnect");
	self endon("end_EE1_Effect");
	tick = 0;
	self iprintlnbold("<null> have been hit <null> a <null> <null> bullet!");
	self.eastereggeffect = true;
	while(tick < 130)
	{
		if (tick == 10) { self iprintlnbold("Compiling auto-generated client repair code!"); }
		if (tick == 40) { r = RandomIntRange(2, 32); self iprintlnbold("Complete, found " + r + " bad sectors!"); }
		if (tick == 50) { self iprintlnbold("Repairing bad sectors!"); }
		if (tick == 115) { self iprintlnbold("Repaired bad code, executing now!"); }
		self iprintln(AAT_EasterEgg_Effect_CodePrints());
		self iprintln(AAT_EasterEgg_Effect_CodePrints());
		tick++;
		wait .2;
	}
	self.eastereggeffect = false;
	self iprintlnbold("Client repair code ran succesfuly!");
}
AAT_EasterEgg_Effect_CodePrints()
{
	luck = RandomIntRange(0,15);
	if (luck == 0) { return "<null> x = 10; fight = ''kill'';"; }
	else if (luck == 1) { return "{ self iprintln(''fuck''); }"; }
	else if (luck == 2) { return "<null> <null> <null> <null>"; }
	else if (luck == 3) { return "[{+usereload}] + [{+gostand}]"; }
	else if (luck == 4) { return "punch = [{+melee}]"; }
	else if (luck == 5) { return "if(dead) { killed = true; }"; }
	else if (luck == 6) { return "self AAT_EasterEgg_Effect_CodePrints();"; }
	else if (luck == 7) { return "self notify(''end_EE1_Effect''); "; }
	else if (luck == 8) { return "while(home) { self fuckMom(); }"; }
	else if (luck == 9) { return "error: UI error code: 99921"; }
	else if (luck == 10) { return "<null> ** ::repair();"; }
	else if (luck == 11) { return "self.fuckme = true;"; }
	else if (luck == 12) { return "player.origin = (0,0,-2392);"; }
	else if (luck == 13) { return "<null>"; }
	else if (luck == 14) { return "10011010 11101000 11101110 00001111 10001010"; }
}





















