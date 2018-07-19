getDefaultItemSpawnCount(item)
{
	if (item == "Chug Jug" || "Large Shield" == item || item == "Medkit" || item == "Slurp Juice") {
		return 1;
	} else if (item == "satchel_charge_mp") {
		return 4;
	} else if (item == "Bandage") {
		return 5;
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
		}
		self iprintln("We have " + self.inv[index].clip + " of this grenade left");
	}
}
itemProgressBar() {
	self endon("death");
	self endon("disconnect");
 	self.fortHUDS[16] = createPrimaryProgressBar();
 	for(i=1; i<101;i++) {
	 	self.fortHUDS[16] updateBar(i / 100);
	  	self.fortHUDS[16] setPoint("CENTER","CENTER",0,0);
	  	self.fortHUDS[16].color=(0,0,0);
	  	self.fortHUDS[16].bar.color = (1,1,0);
	  	self.fortHUDS[16].alpha = 1;
  		wait .1;
 	}
 	self.fortHUDS[16] destroyElem();
}
CreateProgressBar(x, y, alpha, bgcolor, barcolor) {
 	hudele = createPrimaryProgressBar();
	hudele updateBar(0);
	hudele setPoint("CENTER","CENTER",x,y);
	hudele.color = bgcolor;
	hudele.bar.color = barcolor;
	hudele.alpha = alpha;
	return hudele;
}
Bandageitem(index) {
	self endon("disconnect");
	self endon("death");
	self endon("new_item_at_" + index);
	time = 0;
	if (self.forthealth >= 75) {
		self fadeInItemToolTip("You have too much health to use the Bandage");
	} else {
		self fadeInItemToolTip("Hold [{+usereload}] to use Bandage");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self usebuttonpressed() && self.forthealth < 75 && time == 0 && !self.menuopen) {
			self.ItemUseText = "Hold [{+usereload}] to use Bandage";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(80, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self usebuttonpressed() && self.forthealth < 75 && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 80);
			self.fortHUDS[16].bar.color = HUD_RTG(80, time);
			time++;
		} else if (self usebuttonpressed() && self.forthealth >= 75) {
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
			if (self.forthealth >= 75) {
				continue;
			} else {
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
		self fadeInItemToolTip("Hold [{+usereload}] to use Medkit");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self usebuttonpressed() && self.forthealth < 100 && time == 0 && !self.menuopen) {
			self.ItemUseText = "Hold [{+usereload}] to use Medkit";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(200, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self usebuttonpressed() && self.forthealth < 100 && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 200);
			self.fortHUDS[16].bar.color = HUD_RTG(200, time);
			time++;
		} else if (self usebuttonpressed() && self.forthealth >= 100) {
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
		self fadeInItemToolTip("Your shield is above 50 percent!");
	} else {
		self fadeInItemToolTip("Hold [{+usereload}] to use Shield");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self usebuttonpressed() && self.fortshield < 50 && time == 0 && !self.menuopen) {
			self.ItemUseText = "Hold [{+usereload}] to use Shield";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(40, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self usebuttonpressed() && self.fortshield < 50 && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 40);
			self.fortHUDS[16].bar.color = HUD_RTG(40, time);
			time++;
		} else if (self usebuttonpressed() && self.fortshield >= 50) {
			time = 0;
			self.ItemUseText = "Your shield is already halfway or more charged!";
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
			if (self.fortshield >= 50) {
				return;
			} else {
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
		self fadeInItemToolTip("Your shield is already fully charged!");
	} else {
		self fadeInItemToolTip("Hold [{+usereload}] to use shield");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self usebuttonpressed() && self.fortshield < 100 && time == 0 && !self.menuopen) {
			self.ItemUseText = "Hold [{+usereload}] to use Shield";
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(100, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self usebuttonpressed() && self.fortshield < 100 && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 100);
			self.fortHUDS[16].bar.color = HUD_RTG(100, time);
			time++;
		} else if (self usebuttonpressed() && self.fortshield >= 100) {
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
			if (self.fortshield >= 100) {
				return;
			} else {
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
		self fadeInItemToolTip("Your health and shield is already maxed out");
	} else {
		self fadeInItemToolTip("Hold [{+usereload}] to use Chug Jug");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self usebuttonpressed() && CanuseAddShieldAndHealthPotions() && time == 0 && !self.menuopen) {
			self fadeInItemToolTip("Hold [{+usereload}] to use Chug Jug");
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(300, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self usebuttonpressed() && CanuseAddShieldAndHealthPotions() && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 300);
			self.fortHUDS[16].bar.color = HUD_RTG(300, time);
			time++;
		} else if (self usebuttonpressed() && self.fortshield >= 100 && self.forthealth >= 100) {
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
			if (self.fortshield >= 100) {
				return;
			} else {
				self.fortshield = 100;
				self.forthealth = 100;
				// Update Ammo
				self.inv[index].clip--;
				if (self.inv[index].clip < 1) {
					self fadeOutProgressBar();
					self thread SetandChangeInventoryToDefaultWeapon(index);
					self fadeOutItemToolTip();
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
	if (self.fortshield >= 100 && self.forthealth >= 100) {
		self fadeInItemToolTip("Your health and shield is already maxed out");
	} else {
		self fadeInItemToolTip("Hold [{+usereload}] to use Slurp Juice");
	}
	wait .5;
	while(index == self.lastusedinvslotindex) {
		if (self usebuttonpressed() && CanuseAddShieldAndHealthPotions() && time == 0 && !self.menuopen) {
			self fadeInItemToolTip("Hold [{+usereload}] to use Slurp Juice");
			self.fortHUDS[15] setSafeText(self.ItemUseText);
			self.fortHUDS[16].bar.color = HUD_RTG(40, time);
			self fadeInProgressBar();
			self.fortHUDS[16] updateBar(0);
			time++;
		}
		if (self usebuttonpressed() && CanuseAddShieldAndHealthPotions() && time > 0 && !self.menuopen) {
			self.fortHUDS[16] updateBar(time / 40);
			self.fortHUDS[16].bar.color = HUD_RTG(40, time);
			time++;
		} else if (self usebuttonpressed() && self.fortshield >= 100 && self.forthealth >= 100) {
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
		if (time >= 40) {
			if (self.fortshield >= 100 && self.forthealth >= 100) {
				return;
			} else {
				self thread SlurpJuice_Effect();
				// Update Ammo
				self.inv[index].clip--;
				if (self.inv[index].clip < 1) {
					self fadeOutProgressBar();
					self thread SetandChangeInventoryToDefaultWeapon(index);
					self fadeOutItemToolTip();
				}
				self iprintln("We have " + self.inv[index].clip + " Slurp Juices left");
				time = 0;
				self.fortHUDS[16] updateBar(0);
			}
		}
		wait .05;
	}
}
SlurpJuice_Effect() {
	self endon("death");
	self endon("disconnect");
	for(x = 0; x < 25; x++) {
		if (self.fortshield < 100) {
			self.fortshield++;
		}
		if (self.forthealth < 100) {
			self.forthealth++;
		}
		if (!CanuseAddShieldAndHealthPotions()){
			break;
		}
		wait 1;
	}
}




























