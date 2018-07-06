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
        	self suicide();
        }
	}
}
ApplyStormDammage() {
	self iprintln("^1You took 5 dammage from the storm!");
	self.forthealth -= 5;
	self playlocalsound("mpl_wager_humiliate");
	if (self.forthealth <= 0) {
		self suicide();
		iprintln("The storm claimed " + self.name + "!");
	}
}
appHit(damage, attacker, weapon) {
	self iprintln("^5You took " + damage + " from " + attacker.name + " bymeans of " + weapon);
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
	if (self.forthealth <= 0) { 
		self DoDamage(self.health + 1, self.origin, attacker, attacker, "none", "MOD_PROJECTILE_SPLASH", 0, weapon);
	}
}
dammageMap(weap) {
	// Burst rifle
	if (weap == "sig556_mp" || weap == "sig556_mp+stalker") {
		return 27;
	}
	// Auto rifle
	else if (weap == "scar_mp" || weap == "scar_mp+extclip") {
		return 30;
	}
	// Scoped rifle
	else if (weap == "sa58_mp+acog") {
		return 21;
	}
	// Tatical SMG
	else if (weap == "insas_mp" || weap == "insas_mp+stalker") {
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
	// Assuming 8 pelets, heavy shotgun .. Dammage at Gold end is VERY high
	else if (weap == "srm1216_mp") {
		return 35; //6
	}
	// Bolt action sniper
	else if (weap == "dsr50_mp+dualclip") {
		return 96;
	}
	// Semi-auto sniper
	else if (weap == "as50_mp+extclip") {
		return 55;
	}
	// Hunting Rifle
	else if (weap == "ballista_mp+is") {
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
		return 38; //Applied a large nerf due the explode on inpact nature of the weapon
	}
	// Grenade / Clinger
	else if (weap == "frag_grenade_mp" || weap == "sticky_grenade_mp") {
		return 105;
	}
	// Remote Explosives
	else if (weap == "satchel_charge_mp") {
		return 95;
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





























