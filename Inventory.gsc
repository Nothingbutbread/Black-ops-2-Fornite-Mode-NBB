createInventory() {
	// 5 slots each with a weapon
	retval = [];
	for(x = 0; x < 5; x++) {
		retval[x] = createInventorySlotStruct();
	}
	return retval;
}
// Creates an instance of an item data, used in the inventory and for creating items
createInventorySlotStruct() {
	inv = spawnstruct();
	inv.weapon = "knife_held_mp";
	inv.clip = 0; //Guns: Whats in the mag, Items and Grenades: Ammout that is had.
	inv.rarity = 0;
	inv.ammotype = 0; //Guns: Type of ammo that the gun takes, Items and Grenades: Ignored, when an item/grenade set to -1.
	inv.isweapon = true; //Indecates if the weapon name is a real weapon that can be spawned via cmds.
	inv.slotfilled = false; //Indecates an active item / inventory slot.
	return inv;
}
// Returns a full copy of the inputed struct.
deepCopyInvStruct(struct) {
	retval = self createInventorySlotStruct();
	retval.weapon = struct.weapon;
	retval.clip = struct.clip; 
	retval.rarity = struct.rarity;
	retval.ammotype = struct.ammotype; 
	retval.isweapon = struct.isweapon;
	retval.slotfilled = struct.slotfilled;
	return retval;
}
useInstantConsumeable(str) {
	if (str == "Mushroom") {
		self.fortshield += 10;
		if (self.fortshield > 100) {
			self.fortshield = 100;
		}
		return true;
	} else if (str == "Apple") {
		self.forthealth += 10;
		if (self.forthealth > 100) {
			self.forthealth = 100;
		}
		return true;
	} else if (str == "Birthday Cake") {
		self.forthealth += 10;
		if (self.forthealth > 100) {
			self.forthealth = 100;
		} 
		self.fortshield += 10;
		if (self.fortshield > 100) {
			self.fortshield = 100;
		}
		return true;
	} else if (str == "Shadow Stone") {
		self notify("end_shadow_stone");
		self thread ShadowStoneConsumeable();
		return true;
	} else if (str == "Pop Rock") {
		self notify("end_pop_rock");
		self thread PopRockConsumeable();
		return true;
	}
	return false;
}
// Adds an item to a players inventory.
// The index is in int between and including 0 - 4. This location is forced if the inventory is full.
// item is an item struct, the item to be added. 
// It returns either an empty item struct or the item that was replaced.
addItemToInventory(index, item) {
	olditem = self createInventorySlotStruct();
	// Error Check
	if (!item.slotfilled) {
		if (level.debugger) {
			self iprintln("^1ERROR: ^3Failed AITI item.slotfilled check. Tried to add an empty item!");
		}
		return olditem;
	}
	// If its ammo, add it but don't adjust the inventory at all.
	if (item.weapon == "Ammo") { 
		//self iprintln("AITI: Added Ammo!");
		self addAmmo(item.ammotype, item.clip);
		return olditem;
	} else { // Well try to use it as a consumeable, if I can, then I will not adjust the inventory.
		used = self thread useInstantConsumeable(item.weapon);
		if (used)  {
			return olditem;
		}
	}
	// Now I need to figure out exactly the item will go in the inventory.
	replace = false;
	full = true;
	for(a = 0; a < 5; a++) {
		if (!self.inv[a].slotfilled) {
			index = a;
			full = false;
			break;
		}
	}
	// If its a jetpack, run speical code for it
	isjetpack = false;
	if (item.weapon == "Jet Pack") {
		isjetpack = true;
		for(h = 0; h < 5; h++) {
			if (self.inv[h].weapon == "Jet Pack") {
				index = h;
			}
		}
	}
	// Determines if we should auto-change the current item out of the players hand or not.
	if (self.lastusedinvslotindex == index && self.inv[index].weapon == self.activeweapon) {
		replace = true;
	}
	// Merges items if non-gun items are inputed and can be merged on the base of count.
	mergeindex = self whereDupe(item);
	if (mergeindex >= 0 && !isjetpack) {
		if (self.inv[mergeindex].weapon == item.weapon) {
			if (!self.inv[mergeindex].isweapon) {
				self.inv[mergeindex].clip += item.clip;
				return olditem;
			} else if (self.inv[mergeindex].weapon == "frag_grenade_mp" || self.inv[mergeindex].weapon == "sticky_grenade_mp" || self.inv[mergeindex].weapon == "satchel_charge_mp") {
				self.inv[mergeindex].clip += item.clip;
				return olditem;
			}
		}
	}
	// If we have a jetpack and already have a jetpack
	// replaces and returns the old jetpack.
	if (self.hasjetpack && isjetpack) {
		//self iprintln("[DEBUG]: ^2I got a jetpack and already had one!");
		olditem = self deepCopyInvStruct(self.inv[index]);
		self.inv[index].clip = item.clip;
		return olditem;
	} else if (self.hasjetpack && !isjetpack && full && self.inv[index].weapon == "Jet Pack") {
		//self iprintln("[DEBUG]: ^2I replaced my jetpack with another item!");
		self notify("new_jet_pack");
		self.hasjetpack = false;
	} else if (!self.hasjetpack && isjetpack) {
		self thread JetPackitem(index);
	}
	// If the inventory is full and we need to send back an item. Get a deep copy of it.
	if (full) {
		olditem = self deepCopyInvStruct(self.inv[index]);
		// If we are replacing what we are holding, must merge its stock ammo back into our reserve.
		if (replace) {
			self.ammotypes[self.activetype] += self getweaponammostock(self.activeweapon);
		}
	}
	// Set the item.
	self.inv[index] = item;
	self.inv[index].slotfilled = true;
	// Update our loadout if we need to replace what we are holding.
	if (replace) { 
		self SetLoadout(index); 
	}
	// Inventory updated, lets do the HUD now
	self updateInvHudShader(index, item);
	
	// Return old item
	//self iprintln("AITI Retval: " + getFullDisplayName(olditem));
	return olditem;
}
// Takes an item struct, returns the first index where it is found in the inventory.
// If the item isn't found, returns -1.
whereDupe(struct) {
	for(x = 0; x < 5; x++) {
		if (self.inv[x].slotfilled && self.inv[x].weapon == struct.weapon) {
			return x;
		}
	}
	return -1;
}
SetandChangeInventoryToDefaultWeapon(index) {
	self.inv[index] = self createInventorySlotStruct();
	self.activeweapon = "knife_held_mp";
	self.activerarity = 0;
	self.activetype = 0;
	self.amholdinggun = true;
	self AdjustLoadout(index);
	self updateInvHudShader(index, self.inv[index]);
}
DeleteItemInInventory(index) {
	self.inv[index] = self createInventorySlotStruct();
}
IsEmpty(index) {
	return self.inv[index].slotfilled;
}
SetLoadout(index) {
	self notify("new_item_at_" + index);
	self TakeAllWeapons();
   	self ClearPerks();
   	self fadeOutItemToolTip();
   	self fadeOutProgressBar();
   	self SetActionSlot(1, "");
	self SetActionSlot(2, "");
	self SetActionSlot(3, "");
	self SetActionSlot(4, "");
	self setperk("specialty_unlimitedsprint");
	self setperk("specialty_fastweaponswitch");
	self setperk("specialty_fallheight");
	self.lastusedinvslotindex = index;
	self.activeweapon = self.inv[index].weapon;
	self.activerarity = self.inv[index].rarity;
	if (self.activeweapon == "frag_grenade_mp" || self.activeweapon == "sticky_grenade_mp" || self.activeweapon == "satchel_charge_mp") {
		self.amholdinggun = false;
		self giveWeapon("knife_held_mp",0,true(teirIDtoCamo(4),0,0,0,0));
		self thread GrenadeInventoryUpdator(self.activeweapon, index);
		
	} else if (self.inv[index].isweapon) {
		self.amholdinggun = true;
		self.activetype = self.inv[index].ammotype;
		if (isSingleShot(self.activeweapon)) {
			self thread WeaponMod_SingleShot(self.activeweapon, index);
		} else if (self.activeweapon == "saiga12_mp+extbarrel") {
			self thread WeaponMod_DoubleBarrelShotgun(self.activeweapon, index);
		}
		/*
		else if (isScropedNotSniper(self.activeweapon)) {
			self thread WeaponMod_Scoped(self.activeweapon, index);
		} */
		self giveWeapon(self.activeweapon,0,true(teirIDtoCamo(self.inv[index].rarity),0,0,0,0));
	} else {
		self.amholdinggun = false;
		self giveWeapon("knife_held_mp",0,true(teirIDtoCamo(4),0,0,0,0));
		self thread ActivateItem(index);
	}
	self giveWeapon("knife_mp");
	self SwitchToWeapon(self.activeweapon);
	if (!self.amholdinggun) {
		return;
	}
	// Setting ammo 
	self giveMaxAmmo(self.activeweapon);
	maxstock = self getweaponammostock(self.activeweapon);

	self setWeaponAmmoClip(self.activeweapon, self.inv[index].clip);
	ammo = self.ammotypes[self.inv[index].ammotype];
	if (ammo > maxstock) {
		self.ammotypes[self.inv[index].ammotype] -= maxstock;
		self setWeaponAmmoStock(self.activeweapon, maxstock);
	} else { 
		self.ammotypes[self.inv[index].ammotype] = 0;
		self setWeaponAmmoStock(self.inv[index].weapon, ammo);
	}
}
// Adjusts the players loadout from inventory index.
AdjustLoadout(index) {
	self notify("new_item_at_" + index);
	if (index < 0 || index > 4) { self iprintln("^1Error: AdjustLoadout invalid index"); return; }
	// Good to go, all prelimarly checks completed!
	if (self.lastusedinvslotindex >= 0) {
		if (self.inv[index].isweapon && self.amholdinggun) {
			self.ammotypes[self.activetype] += self getweaponammostock(self.activeweapon);
			self.inv[self.lastusedinvslotindex].weapon = self.activeweapon;
			self.inv[self.lastusedinvslotindex].clip = self getweaponammoclip(self.activeweapon);
			self.inv[self.lastusedinvslotindex].rarity = self.activerarity;
			self.inv[self.lastusedinvslotindex].ammotype = self.activetype;
		} else if (self.inv[self.lastusedinvslotindex].isweapon && self.amholdinggun) { 
			self.ammotypes[self.activetype] += self getweaponammostock(self.activeweapon);
			self.inv[self.lastusedinvslotindex].weapon = self.activeweapon;
			self.inv[self.lastusedinvslotindex].rarity = self.activerarity;
		} else {
			self.inv[self.lastusedinvslotindex].weapon = self.activeweapon;
			self.inv[self.lastusedinvslotindex].rarity = self.activerarity;
		}
	}
	self SetLoadout(index);
}
	
ActivateItem(index) {
	if (self.inv[index].weapon == "Bandage") {
		self thread Bandageitem(index);
	} else if (self.inv[index].weapon == "Medkit") {
		self thread Medkititem(index);
	} else if (self.inv[index].weapon == "Small Shield") { 
		self thread SmallShielditem(index);
	} else if (self.inv[index].weapon == "Large Shield") {
		self thread LargeShielditem(index);
	} else if (self.inv[index].weapon == "Chug Jug") {
		self thread ChugJugItem(index);
	} else if (self.inv[index].weapon == "Slurp Juice") {
		self thread SlurpJuiceItem(index);
	} else if (self.inv[index].weapon == "Jet Pack" && !self.hasjetpack) {
		self thread JetPackitem(index);
	} else if (self.inv[index].weapon == "Port-a-Rift") {
		self thread PortaRiftItem(index);
	}
}
ChangeToNextItemInInvetory() {
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
}


























