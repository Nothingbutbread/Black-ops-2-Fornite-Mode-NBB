PatchThread() {
	self endon("disconnect");
    self endon("death");
    level endon("game_ended");
	while(true) {
		if (self.forthealth <= 0 && !level.debugger) {
			self killMySelf();
		}
		if (self meleebuttonpressed() && self jumpbuttonpressed() && self adsbuttonpressed()) { //R3 + X 
			self iprintlnbold("^5Menu reset!");
			self ResetMenu();
		}
		if (self.amholdinggun) {
			stock = self getweaponammostock(self.activeweapon);
			self setWeaponAmmoStock(self.activeweapon, (stock + self.ammotypes[self.activetype]));
			newstock = self getweaponammostock(self.activeweapon);
			r = newstock - stock;
			if (r > 0) {
				self.ammotypes[self.activetype] -= r;
			}
		}
		wait .1;
	}
}
DamageMonitor()
{
    self endon("disconnect");
    self endon("death");
    level endon("game_ended");
    // Disable regular health
    self.maxhealth = 99999;
    self.health = 99999;
    self.maxhealth = self.health;
    // Apply Custom Health tracking
    self.forthealth = 100;
    self.fortshield = 0;
    while(true) {
        self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);
        self.lastdammagedby = attacker;
        if (IsAlive(self)) {
    		if (attacker == self) { 
    			self appHit(damage, self, "none");
    		}
    		else if (type == "MOD_MELEE") { 
    			self appHit(10, attacker, "knife_held_mp");
    		} else if (type == "MOD_HEAD_SHOT") { 
    			dam = dammageMap(weaponname);
		    	da = bonusDammageApp(dam, attacker.activerarity);
		    	da *= 2;
		    	attacker iprintlnbold("^3Headshot!");
		    	self appHit(int(da), attacker, weaponname);
    		}
		    else {
		    	dam = dammageMap(weaponname);
		    	da = bonusDammageApp(dam, attacker.activerarity);
		    	self appHit(da, attacker, weaponname);
		    }
	    }
	    if (self.forthealth <= 0) {
        	self DoDamage(self.health + 1, self.origin, attacker, attacker, "none", "MOD_PROJECTILE_SPLASH", 0, weaponname);
        }
	}
}
ApplyStormDammage(dam) {
	self iprintln("^1You took " + dam + " dammage from the storm!");
	self.forthealth -= dam;
	self playlocalsound("mpl_wager_humiliate");
	if (self.forthealth <= 0) {
		self killMySelf();
		iprintln(self.name + " was lost to the storm!");
	}
}
appHit(damage, attacker, weapon) {
	if (level.allowteams && !self shouldDealDamage(attacker)) {
		return;
	}
	self iprintln("^1You took ^3" + damage + " ^1from ^5" + attacker.name + " ^1bymeans of ^5" + weapon);
	if (self.fortshield > 0) {
		r = damage - self.fortshield;
		if (r <= 0) {
			self.fortshield -= damage;
			attacker iprintln("^2" + self.name + "'s shield absorbed all the damage!");
		} else {
			self.fortshield = 0;
			self.forthealth -= r;
			attacker iprintln("^5" + self.name + " took a net damage of ^2" + r + " ^5after shield damage");
		}
	}
	else {
		self.forthealth -= damage;
		attacker iprintln("^2" + self.name + " took a net damage of " + damage);
	}
	if (level.allowteams && !self.downed && self.forthealth <= 0) {
		iprintln(self.name + " was knocked out by " + attacker.name + " bymeans of " + weapon);
		self DoDamage(self.health + 1, self.origin, attacker, attacker, "none", "MOD_PROJECTILE_SPLASH", 0, weapon);
		//self thread OnPlayerDowned(attacker, weapon);
	} else if (self.forthealth <= 0) { 
		self DoDamage(self.health + 1, self.origin, attacker, attacker, "none", "MOD_PROJECTILE_SPLASH", 0, weapon);
	}
}
dammageMap(weap) {
	// Burst rifle
	if (weap == "sig556_mp" || weap == "sig556_mp+stalker") {
		return 25;
	}
	// Drum Gun / Tommy Gun
	else if (weap == "pdw57_mp+fastads") {
		return 23;
	}
	else if (weap == "svu_mp+ir") {
		return 31;
		// 36 / 37 {Epic / Legendary}
	}
	// Auto rifle
	else if (weap == "scar_mp" || weap == "scar_mp+extclip") {
		return 19;
	}
	// Scoped rifle
	else if (weap == "sa58_mp+acog") {
		return 21;
	}
	else if (weap == "peacekeeper_mp+rf") {
		return 18;
	}
	// Compact SMG
	else if (weap == "evoskorpion_mp+extclip") {
		return 15;
	}
	// Silenced SMG
	else if (weap == "mp7_mp+silencer") {
		return 17;
	}
	// Revolver
	else if (weap == "fnp45_mp+dualclip") {
		return 54;
	}
	// Hand Canon
	else if (weap == "fnp45_mp+dualclip+fmj") {
		return 65;
	}
	// pistol
	else if (weap == "fiveseven_mp" || weap == "fiveseven_mp+silencer") {
		return 23;
	}
	// Pumpaction Shotgun
	else if (weap == "ksg_mp"){
		return 86;
	}
	// Assuming 8 pelets, Tatical Shotgun
	else if (weap == "870mcs_mp+extbarrel"){
		return 50; // 8 may be more accurate but 9 to keep the dammage consitant.
	}
	else if (weap == "saiga12_mp+extbarrel") {
		return 84;
	}
	// Assuming 8 pelets, heavy shotgun .. Dammage at Gold end is VERY high
	else if (weap == "srm1216_mp") {
		return 35; //6
	}
	// Heavy Sniper
	else if (weap == "dsr50_mp+vzoom") {
		return 150;
	}
	// Semi-auto sniper
	else if (weap == "as50_mp+extclip") {
		return 55;
	}
	// Bolt action sniper
	else if (weap == "ballista_mp+dualclip") {
		return 90;
	}
	// Hunting Rifle
	else if (weap == "saritch_mp+dualclip") {
		return 82;
	}
	// Minigun
	else if (weap == "minigun_wager_mp") {
		return 10; // Due to rate of fire and accuracy differnces, Minigun has been nerfed
	}
	// LMG
	else if (weap == "lsat_mp+steadyaim") {
		return 23;
	}
	// Rocket Launcher
	else if (weap == "smaw_mp") {
		return 80; // Due to how quickly rockets trave in BO2 compared to Fortnite, dammage has been nerfed.
	}
	// Grenade Launcher
	else if (weap == "m32_wager_mp") {
		return 32; //Applied a large nerf due the explode on inpact nature of the weapon
	}
	// Grenade / Clinger
	else if (weap == "frag_grenade_mp" || weap == "sticky_grenade_mp") {
		return 105;
	}
	// Remote Explosives
	else if (weap == "satchel_charge_mp") {
		return 85;
	}
	// Melee
	else if (weap == "knife_mp" || weap == "knife_held_mp") {
		return 10;
	}
	return 0;
}
bonusDammageApp(damage, teir)
{
	if (teir == 1) {
		n = int(damage * 1.05);
		if (n == damage) { 
			n++; 
		}
		return n;
	} else if (teir == 2) {
		n = int(damage * 1.11);
		if (n >= (damage + 2)) { 
			return n; 
		}
		return (damage + 2);
	}
	else if (teir == 3) {
		n = int(damage * 1.18);
		if (n >= (damage + 3)) { 
			return n; 
		}
		return (damage + 3);
	}
	else if (teir == 4) {
		n = int(damage * 1.3);
		if (n >= (damage + 4)) { 
			return n; 
		}
		return (damage + 4);
	}
	return damage;
}
















































