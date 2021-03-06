LootSpawnerGeneator() {
	level endon("game_ended");
	level.activechests = 0;
	level.activeammodrops = 0;
	level.activespiningitems = 0;
	sc = RandIntArrayNoDupe(level.chestspawnlocations.size - 1, 0, level.chestspawnlocations.size);
	scindex = 0;
	sa = RandIntArrayNoDupe(level.ammospawnlocations.size - 1, 0, level.ammospawnlocations.size);
	saindex = 0;
	
	wait .1;
	
	ss = RandIntArrayNoDupe(level.spinningweaponlocations.size - 1, 0, level.spinningweaponlocations.size);
	ssindex = 0;
	sd = RandIntArrayNoDupe(level.supplydroplocations.size - 1, 0, level.supplydroplocations.size);
	sdindex = 0;
	time = 0;
	// Spawns the first and only lamma into the map.
	wait .1;
	g = sd[sdindex];
	level thread SpawnLamma(level.supplydroplocations[g]);
	sdindex = 1;
	
	wait 1;
	while(true) {
		if (level.activechests < 8 && level.chestspawnlocations.size > scindex) {
			i = sc[scindex];
			level thread SpawnChest(level.chestspawnlocations[i], (0,0,0));
			scindex++;
		}
		if (level.activeammodrops < 8 && level.ammospawnlocations.size > saindex) {
			s = sa[saindex];
			level thread SpawnAmmoCrate(level.ammospawnlocations[s], (0,0,0));
			saindex++;
		}
		if (level.activespiningitems < 8 && level.spinningweaponlocations.size > ssindex) {
			a = ss[ssindex];
			level thread SpawnItemDrop(level.spinningweaponlocations[a]);
			ssindex++;
		}
		if (level.activespeicallootdrops < 3 && level.supplydroplocations.size > sdindex && time >= 50) {
			d = sd[sdindex];
			level thread SpawnSupplyDrop(level.supplydroplocations[d] + (0,0,3000) , level.supplydroplocations[d], 20);
			time = 0;
			sdindex++;
		}
		wait 1;
		time++;
	}
}
GenerateSpiningDropLoot()
{
	luck = RandomIntRange(0, 100);
	retval = createInventorySlotStruct();
	retval.rarity = 0; // 50% of common
	pool = RandomIntRange(0, 100);
	retval = createInventorySlotStruct();
	retval.rarity = 0;
	if (pool < 75) {
		item = PickCommonWeapon();
		if (luck >= 96 || level.solidgold) { retval.rarity = 4; item = PickLegendaryWeapon(); }
		else if (luck >= 88) { retval.rarity = 3; item = PickEpicWeapon(); } 
		else if (luck >= 73) { retval.rarity = 2; item = PickRareWeapon(); }
		else if (luck >= 50) { retval.rarity = 1; item = PickUncommonWeapon(); }
		if (level.fantasy) { 
			item = PickAnyWeapon();
		}
		if(level.snipershootout) {
			if (retval.rarity == 0) {
				retval.rarity = 1;
			}
			item = SSweapon(retval.rarity);
		}
	} else if (pool < 85) {
		item = PickCommonItem();
		if (luck >= 95) { retval.rarity = 4; item = PickLegendaryItem(); }
		else if (luck >= 85) { retval.rarity = 3; item = PickEpicItem(); }
		else if (luck >= 70) { retval.rarity = 2; item = PickRareItem(); }
		else if (luck >= 40) { retval.rarity = 1; item = PickUncommonItem(); }
	} else {
		item = PickCommonGrenade();
		if (luck >= 75) { retval.rarity = 3; item = PickEpicGrenade(); }
		else if (luck >= 40) { retval.rarity = 1; item = PickUncommonGrenade(); }
	}
	if (level.flyexplosives) {
		item = "Jet Pack";
		retval.rarity = 4;
	}
	if (level.debugger) {
		item = DebugItemSpawn();
		retval.rarity = 3;
	}
	retval.weapon = item;
	retval.isweapon = isAWeapon(item);
	retval.slotfilled = true;
	if (retval.isweapon) {
		retval.clip = 999;
		retval.ammotype = getAmmoType(item);
	} else {
		retval.clip = getDefaultItemSpawnCount(item);
		retval.ammotype = -1;
	}
	if (item == "frag_grenade_mp" || item == "sticky_grenade_mp" || item == "satchel_charge_mp") {
		retval.clip = getDefaultItemSpawnCount(item);
	}
	return retval;
}
GenerateChestLoot(onlylegn, forceteir, custteir) {
	if (!isDefined(onlylegn)) {
		onlylegn = false;
	}
	if (!isDefined(forceteir)) {
		forceteir = false;
	}
	if (!isDefined(custteir)) {
		custteir = 0;
	}
	pool = RandomIntRange(0, 100);
	luck = RandomIntRange(0, 100);
	retval = createInventorySlotStruct();
	retval.rarity = 0;
	// Allows a bypass of the Guns.
	if (forceteir) {
		if (custteir == 0) {
			luck = 1;
		} else if (custteir == 1) {
			luck = 50;
		} else if (custteir == 2) {
			luck = 70;
		} else if (custteir == 3) {
			luck = 90;
		} else {
			luck = 99;
		}
	}
	if (pool < 60) {
		item = PickCommonWeapon();
		if (luck >= 94 || level.solidgold || onlylegn) { retval.rarity = 4; item = PickLegendaryWeapon(); }
		else if (luck >= 85) { retval.rarity = 3; item = PickEpicWeapon(); } 
		else if (luck >= 69) { retval.rarity = 2; item = PickRareWeapon(); }
		else if (luck >= 45) { retval.rarity = 1; item = PickUncommonWeapon(); }
		if (level.fantasy) { 
			item = PickAnyWeapon();
		}
		if (level.flyexplosives) {
			item = FEWeapon();
			if (retval.rarity < 2) {
				retval.rarity = 2;
			}
		}
		if(level.snipershootout) {
			if (retval.rarity == 0) {
				retval.rarity = 1;
			}
			item = SSweapon(retval.rarity);
		}
	} else if (pool < 79) {
		item = PickCommonItem();
		if (luck >= 95) { retval.rarity = 4; item = PickLegendaryItem(); }
		else if (luck >= 85) { retval.rarity = 3; item = PickEpicItem(); }
		else if (luck >= 70) { retval.rarity = 2; item = PickRareItem(); }
		else if (luck >= 40) { retval.rarity = 1; item = PickUncommonItem(); }
	} else if (pool < 86) {
		item = PickCommonGrenade();
		if (luck >= 75) { retval.rarity = 3; item = PickEpicGrenade(); }
		else if (luck >= 40) { retval.rarity = 1; item = PickUncommonGrenade(); }
	} else {
		item = PickConsumeableItem();
		retval.rarity = 1;
	}
	retval.weapon = item;
	retval.isweapon = isAWeapon(item);
	retval.slotfilled = true;
	if (retval.isweapon) {
		retval.clip = 999;
		retval.ammotype = getAmmoType(item);
	} else {
		retval.clip = getDefaultItemSpawnCount(item);
		retval.ammotype = -1;
	}
	if (item == "frag_grenade_mp" || item == "sticky_grenade_mp" || item == "satchel_charge_mp") {
		retval.clip = getDefaultItemSpawnCount(item);
	}
	return retval;
}
GenerateSupplyDropLoot_Meds() {
	luck = RandomIntRange(0, 100);
	retval = createInventorySlotStruct();
	retval.rarity = 0;
	item = "";
	if (luck < 20) {
		item = PickCommonItem();
	} else if (luck < 55) {
		item = PickUncommonItem();
		retval.rarity = 1;
	} else if (luck < 75) {
		item = PickRareItem();
		retval.rarity = 2;
	} else if (luck < 90) {
		item = PickEpicItem();
		retval.rarity = 3;
	} else {
		item = PickLegendaryItem();
		retval.rarity = 4;
	}
	retval.weapon = item;
	retval.isweapon = false;
	retval.slotfilled = true;
	retval.clip = getDefaultItemSpawnCount(item);
	retval.ammotype = -1;
	return retval;
}
GenerateSupplyDropLoot() {
	retval = createInventorySlotStruct();
	retval.rarity = 4; 
	item = PickLegendaryWeapon();
	if (level.flyexplosives) {
		item = FEWeapon();
	}
	if(level.snipershootout) {
		item = SSweapon(4);
	}
	retval.weapon = item;
	retval.isweapon = isAWeapon(item);
	retval.slotfilled = true;
	if (retval.isweapon) {
		retval.clip = 999;
		retval.ammotype = getAmmoType(item);
	} else {
		retval.clip = getDefaultItemSpawnCount(item);
		retval.ammotype = -1;
	}
	if (item == "frag_grenade_mp" || item == "sticky_grenade_mp" || item == "satchel_charge_mp") {
		retval.clip = getDefaultItemSpawnCount(item);
	}
	return retval;
}
FEWeapon() {
	c = RandomIntRange(0, 2);
	if (c == 0) { return "m32_wager_mp"; }
	else { return "smaw_mp"; }
}
SSweapon(teir) {
	c = 0;
	if( teir == 1) {
		c = randomintrange(0, 2);
	} else if ( teir == 2 ) {
		c = randomintrange(0, 3);
	} else {
		c = randomintrange(2, 4);
	}
	if (c == 0) {
		return "saritch_mp+dualclip";
	} else if(c == 1) {
		return "as50_mp+extclip";
	} else if (c == 2) {
		return "ballista_mp+dualclip";
	} else {
		return "dsr50_mp+vzoom";
	}
}
DebugItemSpawn() {
	return "Unstable Item";
}
PickAnyWeapon() {
	c = RandomIntRange(0, 25);
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	else if (c == 2) { return "mp7_mp+silencer"; }
	else if (c == 3) { return "fiveseven_mp"; }
	else if (c == 4) { return "scar_mp+silencer"; }
	else if (c == 5) { return "870mcs_mp+extbarrel"; }
	else if (c == 6) { return "peacekeeper_mp+rf"; }
	else if (c == 7) { return "evoskorpion_mp+extclip"; }
	else if (c == 8) { return "ksg_mp"; }
	else if (c == 9) { return "ballista_mp+dualclip"; }
	else if (c == 10) { return "sa58_mp+acog"; }
	else if (c == 11) { return "dsr50_mp+vzoom"; }
	else if (c == 12) { return "lsat_mp+steadyaim"; }
	else if (c == 13) { return "smaw_mp"; }
	else if (c == 14) { return "m32_wager_mp"; }
	else if (c == 15) { return "saritch_mp+dualclip"; }
	else if (c == 16) { return "svu_mp+ir"; }
	else if (c == 17) { return "scar_mp+extclip"; }
	else if (c == 18) { return "sig556_mp+stalker"; }
	else if (c == 19) { return "fiveseven_mp+silencer"; }
	else if (c == 20) { return "fnp45_mp+dualclip+fmj"; }
	else if (c == 21) { return "saiga12_mp+extbarrel"; }
	else if (c == 22) { return "crossbow_mp"; }
	else if (c == 23) { return "an94_mp"; }
	else if (c == 24) { return "qcw05_mp+steadyaim"; }
}
PickCommonWeapon() {
	c = RandomIntRange(0, 6);
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	else if (c == 2) { return "mp7_mp+silencer"; }
	else if (c == 3) { return "fiveseven_mp"; }
	else if (c == 4) { return "peacekeeper_mp+rf"; }
	else if (c == 5) { return "qcw05_mp+steadyaim"; }
}
PickCommonItem() {
	c = RandomIntRange(0, 4);
	if (c == 1) {
		return "Unstable Item";
	}
	return "Bandage";
}
PickCommonGrenade() {
	return "frag_grenade_mp";
}
PickUncommonWeapon() {
	c = RandomIntRange(0, 11);
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	else if (c == 2) { return "mp7_mp+silencer"; }
	else if (c == 3) { return "fiveseven_mp"; }
	else if (c == 5) { return "870mcs_mp+extbarrel"; }
	else if (c == 6) { return "ksg_mp"; }
	else if (c == 7) { return "saritch_mp+dualclip"; }
	else if (c == 8) { return "peacekeeper_mp+rf"; }
	else if (c == 9) { return "as50_mp+extclip"; }
	else if (c == 10) { return "qcw05_mp+steadyaim"; }
}
PickUncommonGrenade() {
	return "sticky_grenade_mp";
}
PickUncommonItem()
{
	c = RandomIntRange(0, 4); 
	if (c == 0) { return "Medkit"; }
	else if (c == 1 || c == 2) { return "Small Shield"; }
	else { return "Unstable Item"; }
}
PickRareWeapon() {
	c = RandomIntRange(0, 16);
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	else if (c == 2) { return "mp7_mp+silencer"; }
	else if (c == 3) { return "fiveseven_mp+silencer"; }
	else if (c == 4) { return "as50_mp+extclip"; }
	else if (c == 5) { return "870mcs_mp+extbarrel"; }
	else if (c == 6) { return "ksg_mp"; }
	else if (c == 7) { return "ballista_mp+dualclip"; }
	else if (c == 8) { return "sa58_mp+acog"; }
	else if (c == 9) { return "saritch_mp+dualclip"; }
	else if (c == 10) { return "lsat_mp+steadyaim"; }
	else if (c == 11) { return "smaw_mp"; }
	else if (c == 12) { return "m32_wager_mp"; }
	else if (c == 13) { return "peacekeeper_mp+rf"; }
	else if (c == 14) { return "an94_mp"; }
	else if (c == 15) { return "qcw05_mp+steadyaim"; }
}
PickEpicGrenade() {
	return "satchel_charge_mp";
}
PickRareItem() {
	c = RandomIntRange(0, 4);
	if (c == 0) {
		return "Unstable Item";
	}
	return "Large Shield";
}
PickEpicWeapon() {
	c = RandomIntRange(0, 19);
	if (c == 0) { return "scar_mp+extclip"; }
	else if (c == 1) { return "sig556_mp+stalker"; }
	else if (c == 2) { return "m32_wager_mp"; }
	else if (c == 3) { return "fiveseven_mp+silencer"; }
	else if (c == 4) { return "crossbow_mp"; }
	else if (c == 5) { return "srm1216_mp"; }
	else if (c == 6) { return "evoskorpion_mp+extclip"; }
	else if (c == 7) { return "as50_mp+extclip"; }
	else if (c == 8) { return "minigun_wager_mp"; }
	else if (c == 9) { return "sa58_mp+acog"; }
	else if (c == 10) { return "dsr50_mp+vzoom"; }
	else if (c == 11) { return "lsat_mp+steadyaim"; }
	else if (c == 12) { return "smaw_mp"; }
	else if (c == 13) { return "svu_mp+ir"; }
	else if (c == 14) { return "saiga12_mp+extbarrel"; }
	else if (c == 15) { return "ballista_mp+dualclip"; }
	else if (c == 16) { return "scar_mp+silencer"; }
	else if (c == 17) { return "fnp45_mp+dualclip+fmj"; }
	else if (c == 18) { return "an94_mp"; }
}
PickEpicItem() {
	c = RandomIntRange(0, 5);
	if (c == 1 || c == 0) {
		return "Port-a-Rift";
	} else if (c == 2 || c == 3) {
		return "Slurp Juice";
	} 
	return "Unstable Item";
}
PickLegendaryWeapon() {
	c = RandomIntRange(0, 16); // Only weapons for now
	if (c == 0) { return "scar_mp+extclip"; }
	else if (c == 1) { return "sig556_mp+stalker"; }
	else if (c == 2) { return "m32_wager_mp"; }
	else if (c == 3) { return "scar_mp+silencer"; }
	else if (c == 4) { return "fnp45_mp+dualclip+fmj"; }
	else if (c == 5) { return "srm1216_mp"; }
	else if (c == 6) { return "smaw_mp"; }
	else if (c == 8) { return "minigun_wager_mp"; }
	else if (c == 9) { return "dsr50_mp+vzoom"; }
	else if (c == 10) { return "sig556_mp+stalker"; }
	else if (c == 11) { return "svu_mp+ir"; }
	else if (c == 12) { return "evoskorpion_mp+extclip"; }
	else if (c == 13) { return "saiga12_mp+extbarrel"; }
	else if (c == 14) { return "ballista_mp+dualclip"; }
	else if (c == 15) { return "an94_mp"; }
}
PickLegendaryItem() {
	c = RandomIntRange(0, 4);
	if (c == 0) {
		return "Jet Pack";
	} else if (c == 1 || c == 2) {
		return "Chug Jug";
	}
	return "Unstable Item";
}
PickConsumeableItem() {
	c = RandomIntRange(0, 100);
	if (c < 20) {
		return "Mushroom";
	} else if (c < 50) {
		return "Apple";
	} else if (c < 65) {
		return "Birthday Cake";
	} else if (c < 80) {
		return "Shadow Stone";
	}
	return "Pop Rock";
}
















