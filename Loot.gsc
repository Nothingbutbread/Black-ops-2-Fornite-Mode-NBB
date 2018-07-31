Give_Cool_Perk(str)
{
	if (str == "Speed Cola")
		self Perk_Speedcola();
	else if (str == "Double Tap")
		self Perk_Doubletap();
	else if (str == "Stamina Up")
		self Perk_Staminia_up();
	else if (str == "Scrounger")
		self Perk_Scrounger();
	else if (str == "Resistance")
		self Perk_Resistance();
	else if (str == "Mule Kick")
		self Perk_Mulekick();
	else if (str == "Sixth Sense")
		self thread Perk_sixithsense();
	else if (str == "Stat Upgrade") { self thread Booster_IncreasedBaseStats(); }
	else if (str == "Inv Upgrade") { self thread Booster_IncreasedInventorySpace(); }
}
Use_Ability(str)
{
	self notify("new_ability");
	self.resistanceabilityactive = false;
	if (str == "Double Tap II" ) { self thread Ability_DoubleTap2(); }
	else if (str == "Unlimited Ammo") { self thread Ability_UnlimmitedAmmo(); }
	else if (str == "Gun Game") { self thread Ability_GunGame(); }
	else if (str == "Electric Cherry") { self thread Ability_ElectricCherry(); }
	else if (str == "Dynamic Camo") { self thread Ability_DynamicCamo(); }
	else if (str == "Resistant") { self.resistanceabilityactive = true; self iprintln("^5Resistance Ability ^2Active!"); }
	else if (str == "Blood to Lead") { self thread Ability_BloodToLead(); }
}
Use_Booster(str)
{
	if (str == "Hearty") { self notify("booster_hearty"); self thread Booster_Hearty(); }
	else if (str == "Speedo") { self notify("booster_speedo"); self thread Booster_Speedo(); }
	else if (str == "Quick Heal") { self thread Booster_QuickHeal(); }
	else if (str == "Vanish") { self notify("booster_vanish"); self thread Booster_Vanish(); }
	else if (str == "Restock") { self thread Booster_Restock(); }
	else if (str == "Unlimited Clip"){ self notify("booster_tua"); self thread Booster_True_Unlimmited_Ammo(); }
	else if (str == "New Camo") { self thread Booster_NewCamo(); }
	else if (str == "Birds Eye View") { self notify("booster_bev"); self thread Booster_BirdsEyeView(); }
	else if (str == "Loot Box Hack") { self thread Booster_TeleportToLootBox(); }
	else if (str == "Stat Upgrade") { self thread Booster_IncreasedBaseStats(); }
	else if (str == "Inv Upgrade") { self thread Booster_IncreasedInventorySpace(); }
}
Use_AAT(str)
{
	self notify("new_AAT");
	if (str == "Explosive Decoy") { self thread AAT_FakeLootBox(); }
	else if (str == "Explosive Trap") { self thread AAT_LayExplosiveTrap(); }
	else if (str == "Rocket Launcher") { self thread AAT_RocketLauncher(); }
	else if (str == "Slug Ray") { self thread AAT_SlugRay(); }
	else if (str == "Shell Shock") { self thread AAT_ShellShock(); }
	else if (str == "Proxy Attack") { self thread AAT_ProxyAttack(); }
	else if (str == "Recon Palse") { self thread AAT_ReconPaluse(); }
	else if (str == "EMP") { self thread AAT_EMP(); }
	else if (str == "Drained") { self thread AAT_Drained(); }
	else if (str == "Explosive Bullets") { self thread AAT_ExplosiveBullets(); }
	else if (str == "<null>") { self thread AAT_EasterEgg(); }
}
Booster_Speedo()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_booster");
	self endon("booster_speedo");
	self iprintlnbold("^5The Speedo Booster is now ^2Active!");
	self setmovespeedscale(self.basespeed * 2);
	self.curspeed = self.basespeed * 2;
	if (self.occupation == "Addict") { wait 25; }
	else if(self.occupation == "Athlete") { wait 30; }
	else { wait 15; }
	self setmovespeedscale(self.basespeed);
	self.curspeed = self.basespeed;
	self iprintlnbold("^5The Speedo Booster effect ^1Expired!");
}
Booster_Hearty()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_booster");
	self endon("booster_hearty");
	self.maxhealth = 200;
	self.health = self.maxhealth;
	self iprintlnbold("^5The Hearty Booster is now ^2Active!");
	if (self.occupation == "Addict") { wait 22; }
	else if (self.occupation == "Tank") { wait 26; }
	else { wait 13; }
	self iprintlnbold("^5The Hearty Booster effect ^1Expired!");
	self.maxhealth = self.basehealth;
}
Booster_QuickHeal()
{
	self.health = self.maxhealth;
	self iprintlnbold("^5You just instantly healed!");
}
Booster_Vanish()
{
	self endon("death");
	self endon("disconnect");
	self endon("booster_vanish");
	self iprintlnbold("^5The Vanish Booster is now ^2Active!");
	self iprintln("Your weapons are disabled while the effect is active");
	self disableWeapons();
	self hide();
	if (self.occupation == "Addict") { wait 22; }
	else if (self.occupation == "Scout") { wait 27; }
	else { wait 12; }
	self iprintlnbold("^3The Vanish Booster effect will expire in 3 seconds!");
	wait 3;
	self enableWeapons();
	self show();
	self iprintlnbold("^5The Vanish Booster effect ^1Expired!");
}
Booster_Restock()
{
	foreach (gun in self GetWeaponsList())  
	{
		self setWeaponAmmoClip(gun, weaponClipSize(gun));
		self giveMaxAmmo(gun);
	}
	self iprintlnbold("^5Your held weapons have been refilled with ammo!");
}
Booster_True_Unlimmited_Ammo()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_booster");
	self endon("booster_tua");
	tick = 50;
	if (self.occupation == "Addict") { tick = 80; }
	else if (self.occupation == "Warrior") { tick = 100; }
	self iprintlnbold("^5Unlimited Clip Ammo ^2Active!");
	self iprintln("^3This effect only works bullet weapons!");
	self setWeaponAmmoClip(self.currentWeapon, weaponClipSize(self.currentWeapon));
	wait .2;
	while(tick > 0)
	{
		if (ValidforTrueUnlimmitedAmmo(self.currentWeapon)) { self setWeaponAmmoClip(self.currentWeapon, weaponClipSize(self.currentWeapon)); }
		wait .2;
		tick--;
	}
	self iprintlnbold("^5Unlimited Clip Ammo ^1Disabled!");
}
Booster_NewCamo()
{
	camo = RandomIntRange(1,44);
	self setcamo(camo, self.currentWeapon);
	self setWeaponAmmoClip(self.currentWeapon, weaponClipSize(self.currentWeapon));
	self giveMaxAmmo(self.currentWeapon);
	self iprintlnbold("^5Your held gun got a new camo and has been refilled with ammo!");
}
Booster_BirdsEyeView()
{
	self endon("death");
	self endon("disconnect");
	self endon("booster_bev");
	iprintln("^1" + self.name + " has Enabled UAV");
	self SetClientUIVisibilityFlag("g_compassShowEnemies", 1);
	if (self.occupation == "Addict") { wait 25; }
	else if (self.occupation == "Scout") { wait 30; }
	else { wait 15; }
	self iprintlnbold("Birds Eye View has been ^1Disabled!");
	self SetClientUIVisibilityFlag("g_compassShowEnemies", 0);
}
Booster_TeleportToLootBox()
{
	self endon("death");
	self endon("disconnect");
	n = 0;
	while(true) { n = RandomIntRange(0,8); if (level.lca[n] >= 0) { break; } wait .05; }
	self setorigin( level.lc[ level.lca[n] ] + (0,0,20) );
	self iprintln("^1Teleported to a random loot box!");
}
Booster_IncreasedBaseStats()
{
	inc = RandomIntRange(6,13); // 6 - 12
	incs = inc / 100;
	if (self.basespeed < 2.5) { self.basespeed += incs; } 
	if (self.curspeed < self.basespeed) { self setmovespeedscale(self.basespeed); }
	self.basehealth += inc;
	self.maxhealth = self.basehealth;
	if (self.basehealth > 200) { self.basehealth = 200; self.maxhealth = 200; self.health = 200; }
	self.health = self.maxhealth;
	self iprintln("^2Max Health increased by: ^5" + inc + " ^2Speed increased by: ^5" + incs);
}
Booster_IncreasedInventorySpace()
{
	n = [];
	for(x=0;x<4;x++) { if (self.invlimmit[x] < 7) { n[n.size] = x; } }
	if (n.size == 0) { self iprintln("Your inventory space was already at max.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }
	else
	{
		r = RandomIntRange(0,n.size);
		if (n.size == 4)
		{
			self.invlimmit[r]++;
			self printInventoryType(r);
		}
		else
		{
			if (self.invlimmit[r] < 7) 
			{ 
				self.invlimmit[r]++;
				self printInventoryType(r);
			}
			else
			{
				i = self GetExpandableInventoryIndex(r);
				if (i < 7) 
				{
					self.invlimmit[i]++;
					self printInventoryType(i); 
				}
				else { self iprintln("Your inventory space was already at max.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }
			}
		}
	}
}
Ability_DoubleTap2()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Double tap II ^2Active!");
	while(true)
	{
		self waittill("weapon_fired", weapon);
		if (ValidforTrueUnlimmitedAmmo(weapon))
		{
			trace = BulletTrace(self GetEye(), self GetEye() + (AnglesToForward(self GetPlayerAngles()) * 10000000), true, self);
			MagicBullet(weapon, self GetTagOrigin("tag_weapon_right") + (AnglesToForward(self GetPlayerAngles()) * 50), trace["position"], self);
		}
		wait .2;
	}
}
Ability_DynamicCamo()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Dynamic Camo ^2Actived!");
	while(true)
	{
		camo = RandomIntRange(1,44);
		self setcamo(camo, self.currentWeapon);
		self giveMaxAmmo(self.currentWeapon);
		wait 10;
	}
}
Ability_BloodToLead()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_abilty");
	self iprintlnbold("^5Blood to Lead ^2Activated!");
	while(true)
	{
		if (self.health != self.maxhealth)
		{
			self setWeaponAmmoClip(self.currentWeapon, weaponClipSize(self.currentWeapon));
			self giveMaxAmmo(self.currentWeapon);
			wait .2;
		}
		wait .1;
	}
}
Ability_UnlimmitedAmmo()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Unlimmited Stock Ammo ^2Actived!");
	while(true)
	{
		self giveMaxAmmo(self.currentWeapon);
		wait 1;
	}
}
Ability_GunGame()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Gun game ^2Actived!");
	while(true)
	{
		wait 15;
		camo = RandomIntRange(1,44);
		weapon = Loot_Uncommon_gun();
		GiveGun(weapon, camo);
	}
}
Ability_ElectricCherry()
{
	self endon("death");
	self endon("disconnect");
	self endon("new_ability");
	self iprintlnbold("^5Electric Cherry ^2Active!");
	while(true)
	{
		self waittill("reload_start");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "j_head");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "J_Spine1");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "J_Spine4");
		playFxOnTag( level._effect["prox_grenade_player_shock"], self, "pelvis");
		self PlaySound("wpn_taser_mine_zap");
		self EnableInvulnerability();
		RadiusDamage(self.origin,200,9999,50,self);
		wait .5;
		self DisableInvulnerability();
		wait 8;
	}
}
////////////////////////////////////////////
//     Loot generateing functions         //
////////////////////////////////////////////
Loot_Ability()
{
	per = RandomIntRange(0, 7);
	if (per == 0) { return "Double Tap II"; }
	else if (per == 1) { return "Unlimited Ammo"; }
	else if (per == 2) { return "Gun Game"; }
	else if (per == 3) { return "Electric Cherry"; }
	else if (per == 4) { return "Dynamic Camo"; }
	else if (per == 5) { return "Resistant"; }
	else if (per == 6) { return "Blood to Lead"; }
}
Loot_Booster()
{
	per = RandomIntRange(0, 11);
	if (per == 0) { return "Hearty"; }
	else if (per == 1) { return "Speedo"; }
	else if (per == 2) { return "Quick Heal"; }
	else if (per == 3) { return "Vanish"; }
	else if (per == 4) { return "Restock"; }
	else if (per == 5) { return "Unlimited Clip"; }
	else if (per == 6) { return "New Camo"; }
	else if (per == 7) { return "Birds Eye View"; }
	else if (per == 8) { return "Loot Box Hack"; }
	else if (per == 9) { return "Stat Upgrade"; }
	else if (per == 10) { return "Inv Upgrade";}
}
Loot_Perk()
{
	per = RandomIntRange(0, 7);
	if (per == 0) { return "Speed Cola"; }
	else if (per == 1) { return "Double Tap"; }
	else if (per == 2) { return "Stamina Up"; }
	else if (per == 3) { return "Scrounger"; }
	else if (per == 4) { return "Resistance"; }
	else if (per == 5) { return "Mule Kick"; }
	else if (per == 6) { return "Sixth Sense"; }
}
Loot_AAT()
{
	per = 3;
	if (self.occupation != "Bookie")
	{ per = RandomIntRange(0, 10); }
	else { per = RandomIntRange(0, 11); } // The <null> AAT is only for Bookies
	if (per == 0) { return "Explosive Decoy"; }
	else if (per == 1) { return "Explosive Trap"; }
	else if (per == 2) { return "Rocket Launcher"; }
	else if (per == 3) { return "Explosive Bullets"; }
	else if (per == 4) { return "Slug Ray"; }
	else if (per == 5) { return "Shell Shock"; }
	else if (per == 6) { return "Proxy Attack"; }
	else if (per == 7) { return "Recon Palse"; }
	else if (per == 8) { return "EMP"; }
	else if (per == 9) { return "Drained"; }
	else if (per == 10) { return "<null>"; }
}
// Guns in this catogory are intended for Common Loot boxes
// These guns include lowlevel launchers, pistols and shotguns.
Loot_Common_gun()
{
	att = RandIntArrayNoDupe(3, 0, 17);
	gun = RandomIntRange(0,20);
	if (gun >= 9) { str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]]; }
	else { str = level.WeaponArray[gun]; }
	return str;
}
// Guns in this catorgory are intended for Uncommon Loot boxes
// These guns include all but nondual weild postols and launchers.
Loot_Uncommon_gun()
{
	att = RandIntArrayNoDupe(3, 0, 21);
	gun = RandomIntRange(11, 44);
	str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]];
	return str;
}
// Guns in this catorgry are inteded for rare loot boxes
// These guns include automatic and semiautomatic riffles and war/death machines
Loot_Rare_gun()
{
	att = RandIntArrayNoDupe(3, 0, 21);
	gun = RandomIntRange(20,46);
	if (gun < 43) { str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]]; }
	else { str = level.WeaponArray[gun]; }
	return str;
}
Loot_Warrior_First()
{
	att = RandIntArrayNoDupe(3, 0, 19);
	gun = RandomIntRange(20,40);
	str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]];
	return str;
}
Loot_Scout_First()
{
	att = RandIntArrayNoDupe(3, 10, 21);
	gun = RandomIntRange(40,44);
	str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]];
	return str;
}
Loot_SP_Common()
{
	cash = 0;
	if (self.occipation == "Secret Shopper")
	{ cash = RandomIntRange(2,4); }
	else { cash = RandomIntRange(1,3); }
	return "[SP] " + cash;
}
Loot_SP_Uncommon()
{
	cash = 0;
	if (self.occipation == "Secret Shopper")
	{ cash = RandomIntRange(4,10); }
	else { cash = RandomIntRange(3,9); }
	return "[SP] " + cash;
}
Loot_SP_Rare()
{
	cash = 0;
	if (self.occipation == "Secret Shopper")
	{ cash = RandomIntRange(8,21); }
	else { cash = RandomIntRange(6,19); }
	return "[SP] " + cash;
}
Loot_Purchased_gun()
{
	att = RandIntArrayNoDupe(3, 0, 21);
	gun = RandomIntRange(0, 44);
	str = level.WeaponArray[gun] + "+"+ level.AttachmentArray[att[0]] + "+" + level.AttachmentArray[att[1]] + "+" + level.AttachmentArray[att[2]];
	return str;
}


