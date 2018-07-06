createInventory() {
	// 5 slots each with a weapon
	// 0 = Weapon, 1 = Clip, 2 = Rarity, 3 = index of type of ammo, 4 = isweapon
	retval = [];
	for(x = 0; x < 5; x++) {
		retval[x] = createInventorySlotStruct();
	}
	return retval;
}
createInventorySlotStruct() {
	inv = spawnstruct();
	inv.weapon = "knife_held_mp";
	inv.clip = 0;
	inv.rarity = 0;
	inv.ammotype = 0;
	inv.isweapon = true;
	inv.slotfilled = false;
	return inv;
}
addItemToInventory(index, weap, mag, rarity, ammotype, isweapon)
{
	
	replace = false;
	add = false;
	olditem = [];
	// Is the player is holding the weapon that is being replaced?
	if (self.lastusedinvslotindex == index && self.inv[index][0] == self.activeweapon) {
		replace = true;
	}
	if (!IsEmpty(index)) {
		olditem = self.inv[index];
		if (replace) {
			self.ammotypes[self.activetype] += self getweaponammostock(self.activeweapon);
		}
	}
	for(x = 0; x < 5; x++) {
		if (IsEmpty(x)) {
			index = x;
			break;
		}
	}
	// Guns
	// 0 = Weapon, 1 = Clip, 2 = Rarity, 3 = index of type of ammo, 4 = isweapon
	// Items
	// 0 = itemname, 1 = ammout of it, 2 = Rarity, 3 (set to 0), 4 = (set to false)
	//self iprintln("Index: " + index + " Weapon: " + weap);
	if (self.inv[index][0] == weap) {
		if (self.inv[index][4] == "f") {
			add = true;
		} else if (self.inv[index][0] == "frag_grenade_mp" || self.inv[index][0] == "sticky_grenade_mp" || self.inv[index][0] == "satchel_charge_mp") {
			add = true;
		}
	}
	if (add) {
		ammo = int(self.inv[index][1]);
		ammo += int(mag);
		self.inv[index][1] = "" + ammo;
	} else {
		self.inv[index][0] = weap;
		self.inv[index][1] = "" + mag;
		self.inv[index][2] = "" + rarity;
		self.inv[index][3] = "" + ammotype;
	}
	if (isweapon) { 
		self.inv[index][4] = "t";
	} else { 
		self.inv[index][4] = "f";
	}
	if (replace) { 
		SetLoadout(index); 
	}
	// Inventory updated, lets do the HUD now
	self updateInvHudShader(index, int(rarity), weap);
	
	// Return old item
	return olditem;
}
ActivateItem(index) {
	if (self.inv[index][0] == "Bandage") {
		self thread Bandageitem(index, int(self.inv[index][3]));
		//self thread itemProgressBar();
	}
	else if (self.inv[index][0] == "Medkit") {
		self thread Medkititem(index, int(self.inv[index][3]));
	}
	else if (self.inv[index][0] == "Small Shield") { 
		self thread SmallShielditem(index, int(self.inv[index][3]));
	}
	else if (self.inv[index][0] == "Large Shield") {
		self thread LargeShielditem(index, int(self.inv[index][3]));
	}
	else if (self.inv[index][0] == "Chug Jug") {
		self thread ChugJugItem(index, int(self.inv[index][3]));
	}
	else if (self.inv[index][0] == "Slurp Juice") {
		self thread SlurpJuiceItem(index, int(self.inv[index][3]));
	}
}


