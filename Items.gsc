getDefaultItemSpawnCount(item)
{
	if (item == "Chug Jug" || "Large Shield" == item || item == "Medkit" || item == "Slurp Juice" || item == "Port-a-Rift") {
		return 1;
	} else if (item == "Bandage") {
		return 5;
	} else if (item == "Jet Pack") {
		return 150;
	}
	return 3;
}
// I assume I have atleast 1 grenade when I start this function
// And that I will terminate the item should I hit 0 of it.
GrenadeInventoryUpdator(weap, index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	while(weap == self.activeweapon) {
		self GiveWeapon(weap);
		self setWeaponAmmoClip(weap, 1);
		self waittill("grenade_fire");
		if (weap != self.activeweapon) {
			return;
		}
		// Update Ammo
		self.inv[index].clip--;
		if (self.inv[index].clip < 1) {
			self thread SetandChangeInventoryToDefaultWeapon(index);
			self ChangeToNextItemInInvetory();
		}
		self iprintln("We have " + self.inv[index].clip + " of this grenade left");
	}
}
JetPackitem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_jet_pack");
	self.hasjetpack = true;
	//self iprintln("[DEBUG]: ^2Jet pack started!");
	if (self.inv[index].clip > 150) {
		self.inv[index].clip = 150;
	}
	while(true) {
		if (self jumpbuttonpressed()){
			if (self getvelocity()[2] < 300 && self.inv[index].clip > 0){
				self setvelocity(self getvelocity() + (0,0,50));
				self.inv[index].clip--;
			} else { 
				self iprintln("^1Jet pack overheated!");
				wait 1;
			}
		} else if (self.inv[index].clip < 150) {
			self.inv[index].clip++; 
		}
		wait .05;
	}
}
Bandageitem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	time = 0;
	if (self.forthealth >= 75) {
		self fadeInItemToolTip("You have too much health to use the Bandage");
	} else {
		self fadeInItemToolTip("Hold [{+gostand}] to use Bandage");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self jumpbuttonpressed() && self.forthealth < 75 && time == 0 && !self.menuopen) {
			self.ItemUseText = "Hold [{+gostand}] to use Bandage";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(80, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self jumpbuttonpressed() && self.forthealth < 75 && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 80);
			self.fortHUDS[16].bar.color = HUD_RTG(80, time);
			time++;
		} else if (self jumpbuttonpressed() && self.forthealth >= 75) {
			time = 0;
			self.ItemUseText = "You have too much health to use the Bandage";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self fadeOutProgressBar();
			
			self.fortHUDS[16] updateBar(0);
			wait .5;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 80) {
			if (self.forthealth < 75) {
				self.forthealth += 15;
				if (self.forthealth > 75) {
					self.forthealth = 75;
				}
				// Update Ammo
				self.inv[index].clip--;
				if (self.inv[index].clip < 1) {
					self fadeOutProgressBar();
					self thread SetandChangeInventoryToDefaultWeapon(index);
					self fadeOutItemToolTip();
					self ChangeToNextItemInInvetory();
				}
				self iprintln("We have " + self.inv[index].clip + " bandages left");
				time = 0;
				self.fortHUDS[16] updateBar(0);
			}
		}
		wait .05;
	}
}
Medkititem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	time = 0;
	if (self.forthealth >= 100) {
		self fadeInItemToolTip("You have too much health to use the Medkit");
	} else {
		self fadeInItemToolTip("Hold [{+gostand}] to use Medkit");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self jumpbuttonpressed() && self.forthealth < 100 && time == 0 && !self.menuopen) {
			self.ItemUseText = "Hold [{+gostand}] to use Medkit";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(200, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self jumpbuttonpressed() && self.forthealth < 100 && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 200);
			self.fortHUDS[16].bar.color = HUD_RTG(200, time);
			time++;
		} else if (self jumpbuttonpressed() && self.forthealth >= 100) {
			time = 0;
			self.ItemUseText = "You have too much health to use the Medkit";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			wait .5;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 200) {
			self.forthealth = 100;
			self.inv[index].clip--;
			if (self.inv[index].clip < 1) {
				self fadeOutProgressBar();
				self thread SetandChangeInventoryToDefaultWeapon(index);
				self fadeOutItemToolTip();
				self ChangeToNextItemInInvetory();
			}
			self iprintln("We have " + self.inv[index].clip + " medkits left");
			time = 0;
			self.fortHUDS[16] updateBar(0);
		}
		wait .05;
	}
}
SmallShielditem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	time = 0;
	if (self.fortshield >= 50) {
		self fadeInItemToolTip("Your Shield is above 50 percent!");
	} else {
		self fadeInItemToolTip("Hold [{+gostand}] to use Small Shield");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self jumpbuttonpressed() && self.fortshield < 50 && time == 0 && !self.menuopen) {
			self.ItemUseText = "Hold [{+gostand}] to use Small Shield";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(40, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self jumpbuttonpressed() && self.fortshield < 50 && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 40);
			self.fortHUDS[16].bar.color = HUD_RTG(40, time);
			time++;
		} else if (self jumpbuttonpressed() && self.fortshield >= 50) {
			time = 0;
			self.ItemUseText = "Your Shield is already halfway or more charged!";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self fadeOutProgressBar();
			
			self.fortHUDS[16] updateBar(0);
			wait .5;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 40) {
			if (self.fortshield < 50) {
				self.fortshield += 25;
				if (self.fortshield > 50) {
					self.fortshield = 50;
				}
				// Update Ammo
				self.inv[index].clip--;
				if (self.inv[index].clip < 1) {
					self fadeOutProgressBar();
					self thread SetandChangeInventoryToDefaultWeapon(index);
					self fadeOutItemToolTip();
					self ChangeToNextItemInInvetory();
				}
				self iprintln("We have " + self.inv[index].clip + " small shields left");
				time = 0;
				self.fortHUDS[16] updateBar(0);
			}
		}
		wait .05;
	}
}
LargeShielditem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	time = 0;
	if (self.fortshield >= 100) {
		self fadeInItemToolTip("Your Shield is already fully charged!");
	} else {
		self fadeInItemToolTip("Hold [{+gostand}] to use Large Shield");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self jumpbuttonpressed() && self.fortshield < 100 && time == 0 && !self.menuopen) {
			self.ItemUseText = "Hold [{+gostand}] to use Shield";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(100, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self jumpbuttonpressed() && self.fortshield < 100 && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 100);
			self.fortHUDS[16].bar.color = HUD_RTG(100, time);
			time++;
		} else if (self jumpbuttonpressed() && self.fortshield >= 100) {
			time = 0;
			self.ItemUseText = "Your shield is already fully charged!";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self fadeOutProgressBar();
			
			self.fortHUDS[16] updateBar(0);
			wait .5;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 100) {
			if (self.fortshield < 100) {
				self.fortshield += 50;
				if (self.fortshield > 100) {
					self.fortshield = 100;
				}
				// Update Ammo
				self.inv[index].clip--;
				if (self.inv[index].clip < 1) {
					self fadeOutProgressBar();
					self thread SetandChangeInventoryToDefaultWeapon(index);
					self fadeOutItemToolTip();
					self ChangeToNextItemInInvetory();
				}
				self iprintln("We have " + self.inv[index].clip + " large shields left");
				time = 0;
				self.fortHUDS[16] updateBar(0);
			}
		}
		wait .05;
	}
}
ChugJugItem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	time = 0;
	if (self.fortshield >= 100 && self.forthealth >= 100) {
		self fadeInItemToolTip("Your Health and Shield is already maxed out");
	} else {
		self fadeInItemToolTip("Hold [{+gostand}] to use Chug Jug");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self jumpbuttonpressed() && CanuseAddShieldAndHealthPotions() && time == 0 && !self.menuopen) {
			self fadeInItemToolTip("Hold [{+gostand}] to use Chug Jug");
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(300, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self jumpbuttonpressed() && CanuseAddShieldAndHealthPotions() && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 300);
			self.fortHUDS[16].bar.color = HUD_RTG(300, time);
			time++;
		} else if (self jumpbuttonpressed() && self.fortshield >= 100 && self.forthealth >= 100) {
			time = 0;
			self.ItemUseText = "Your health and shield is already maxed out";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self fadeOutProgressBar();
			
			self.fortHUDS[16] updateBar(0);
			wait .5;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 300) {
			if (self.fortshield < 100) {
				self.fortshield = 100;
				self.forthealth = 100;
				// Update Ammo
				self.inv[index].clip--;
				if (self.inv[index].clip < 1) {
					self fadeOutProgressBar();
					self thread SetandChangeInventoryToDefaultWeapon(index);
					self fadeOutItemToolTip();
					self ChangeToNextItemInInvetory();
				}
				self iprintln("We have " + self.inv[index].clip + " Chug Jugs left");
				time = 0;
				self.fortHUDS[16] updateBar(0);
			}
		}
		wait .05;
	}
}
SlurpJuiceItem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	time = 0;
	self fadeInItemToolTip("Hold [{+gostand}] to use Slurp Juice");
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self jumpbuttonpressed() && time == 0 && !self.menuopen) {
			self fadeInItemToolTip("Hold [{+gostand}] to use Slurp Juice");
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(40, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self jumpbuttonpressed() && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 40);
			self.fortHUDS[16].bar.color = HUD_RTG(40, time);
			time++;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 40) {
			self thread SlurpJuice_Effect();
			// Update Ammo
			self.inv[index].clip--;
			if (self.inv[index].clip < 1) {
				self fadeOutProgressBar();
				self thread SetandChangeInventoryToDefaultWeapon(index);
				self fadeOutItemToolTip();
				self ChangeToNextItemInInvetory();
			}
			self iprintln("We have " + self.inv[index].clip + " Slurp Juices left");
			time = 0;
			self.fortHUDS[16] updateBar(0);
		}
		wait .05;
	}
}
SlurpJuice_Effect() {
	self endon("death");
	self endon("disconnect");
	for(x = 0; x < 75; x++) {
		if (self.forthealth < 100) {
			self.forthealth++;
		} else if (self.fortshield < 100) {
			self.fortshield++;
		}
		if (!CanuseAddShieldAndHealthPotions()){
			break;
		}
		wait .3;
	}
}
PortaRiftItem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	self fadeInItemToolTip("Hold [{+gostand}] to use Port-a-Rift!");
	time = 0;
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self jumpbuttonpressed() && time == 0 && !self.menuopen && self.canteleport) {
			self fadeInItemToolTip("Hold [{+gostand}] to use Port-a-Rift!");
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(20, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self jumpbuttonpressed() && time > 0 && !self.menuopen && self.canteleport) {
			self.fortHUDS[16] updateBar(time / 20);
			self.fortHUDS[16].bar.color = HUD_RTG(20, time);
			time++;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 20) {
			// Update Ammo
			self.inv[index].clip--;
			self thread PortaRiftItemEffect();
			if (self.inv[index].clip < 1) {
				self fadeOutProgressBar();
				self thread SetandChangeInventoryToDefaultWeapon(index);
				self fadeOutItemToolTip();
				self ChangeToNextItemInInvetory();
			}
			self iprintln("We have " + self.inv[index].clip + " Port-a-Rifts left");
			time = 0;
			self.fortHUDS[16] updateBar(0);
		}
		wait .05;
	}
}
PortaRiftItemEffect() {
	wait .1;
	self.canteleport = false;
	self.unstuckability = true;
	iprintln(self.name + " used a port-a-rift!");
	self setorigin((self.origin[0], self.origin[1], level.battlebusendorigin[2] - 350));
	self notify("restart_patch_thread");
	self.status = 2;
	self ResetMenu();
	self thread FlyToMap();
}
UnstableItem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	time = 0;
	self fadeInItemToolTip("Hold [{+gostand}] to use Unstable Item");
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self jumpbuttonpressed() && time == 0 && !self.menuopen) {
			self fadeInItemToolTip("Hold [{+gostand}] to use Unstable Item");
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(60, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		} else if (self jumpbuttonpressed() && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 60);
			self.fortHUDS[16].bar.color = HUD_RTG(60, time);
			time++;
		} else {
			self fadeOutProgressBar();
			self.fortHUDS[16] updateBar(0);
			time = 0;
		}
		if (time >= 30) {
			// Update Ammo
			self.inv[index].clip--;
			self thread UnstableItemEffect(self.inv[index].rarity);
			if (self.inv[index].clip < 1) {
				self fadeOutProgressBar();
				self thread SetandChangeInventoryToDefaultWeapon(index);
				self fadeOutItemToolTip();
				self ChangeToNextItemInInvetory();
			}
			self iprintln("We have " + self.inv[index].clip + " Unstable Items left");
			time = 0;
			self.fortHUDS[16] updateBar(0);
		}
		wait .05;
	}
}
UnstableItemEffect(teir) {
	if (teir == 0) { // Common
		luck = randomintrange(0, 100);
		if (luck > 80) {
			self.forthealth += 15;
			if (self.forthealth >= 100) {
				self.forthealth = 100;
			}
		} else if (luck > 68) {
			self.fortshield += 10;
			if (self.fortshield >= 100) {
				self.fortshield = 100;
			}
		}
		item = GenerateChestLoot(false, true, 0);
		self addItemToInventory(self.lastusedinvslotindex, item);
		if (item.isweapon) {
			self addAmmo(getAmmoType(item.weapon), GetRandomAmmoAmmout(item.ammotype));
		}
	} else if (teir == 1) {
		luck = randomintrange(0, 100);
		if (luck > 75) {
			self.forthealth += 30;
			if (self.forthealth >= 100) {
				self.forthealth = 100;
			}
		} else if (luck > 55) {
			self.fortshield += 15;
			if (self.fortshield >= 100) {
				self.fortshield = 100;
			}
		}
		item = GenerateChestLoot(false, true, 1);
		self addItemToInventory(self.lastusedinvslotindex, item);
		if (item.isweapon) {
			self addAmmo(getAmmoType(item.weapon), GetRandomAmmoAmmout(item.ammotype));
		}
	} else if (teir == 2) {
		luck = randomintrange(0, 100);
		if (luck > 75) {
			self.forthealth += 45;
			if (self.forthealth >= 100) {
				self.forthealth = 100;
			}
		} else if (luck > 55) {
			self.fortshield += 25;
			if (self.fortshield >= 100) {
				self.fortshield = 100;
			}
		}
		item = GenerateChestLoot(false, true, 2);
		self addItemToInventory(self.lastusedinvslotindex, item);
		if (item.isweapon) {
			self addAmmo(getAmmoType(item.weapon), GetRandomAmmoAmmout(item.ammotype));
		}
	} else if (teir == 3) {
		luck = randomintrange(0, 100);
		if (luck > 75) {
			self.forthealth = 100;
		} else if (luck > 60) {
			self.fortshield += 50;
			if (self.fortshield >= 100) {
				self.fortshield = 100;
			}
		}
		item = GenerateChestLoot(false, true, 3);
		self addItemToInventory(self.lastusedinvslotindex, item);
		if (item.isweapon) {
			self addAmmo(getAmmoType(item.weapon), GetRandomAmmoAmmout(item.ammotype));
		}
	} else {
		luck = randomintrange(0, 100);
		if (luck > 65) {
			self.forthealth = 100;
			self.fortshield = 100;
		}
		item = GenerateChestLoot(false, true, 4);
		self addItemToInventory(self.lastusedinvslotindex, item);
		if (item.isweapon) {
			self addAmmo(getAmmoType(item.weapon), GetRandomAmmoAmmout(item.ammotype));
		}
	}
}
ShadowStoneConsumeable() {
	self endon("end_shadow_stone");
	self endon("death");
	self endon("disconnect");
	wait 2;
	self disableWeapons();
	iprintln(self.name + " used a shadow stone");
	self iprintlnbold("Hold [{+usereload}] to end the shadow stone effect!");
	self hide();
	for(x = 0; x < 250; x++) {
		if (self usebuttonpressed()) {
			break;
		} else if (x == 220) {
			self iprintln("Shadow Stone expiring in 3 seconds!");
		}
		wait .1;
	}
	self iprintln("Shadow Stone effect lifting!");
	self show();
	wait 1;
	self enableWeapons();
}
PopRockConsumeable() {
	self endon("end_pop_rock");
	self endon("death");
	self endon("disconnect");
	for(x = 0; x < 350; x++) {
		if (self jumpbuttonpressed() && self DisToGround() < 10) {
			self thread PopRockComsumeable_Jolt();
			wait .3;
		} else if (x == 320) {
			self iprintln("Pop Rock expiring in 3 seconds!");
		}
		wait .1;
	}
	self iprintln("Pop Rock effect ended!");
}
PopRockComsumeable_Jolt() {
	for(x = 0; x < 10; x++) {
		self setvelocity((self getvelocity()[0] , self getvelocity()[1] ,self getvelocity()[2] + 15000));
		wait .05;
	}
}














