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
	sd = RandIntArrayNoDupe(level.spinningweaponlocations.size - 1, 0, level.spinningweaponlocations.size);
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
	item = PickCommonItem();
	if (luck >= 98 || level.solidgold) { retval.rarity = 4; item = PickLegendaryItem(); } // 5% for Legendary
	else if (luck >= 93) { retval.rarity = 3; item = PickEpicItem(); } // 10% for Epic
	else if (luck >= 82) { retval.rarity = 2; item = PickRareItem(); } // 15% for Rare
	else if (luck >= 66) { retval.rarity = 1; item = PickUncommonItem(); } // 20% for Uncommon
	if (level.debugger) {
		item = DebugItemSpawn();
		retval.rarity = 4;
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
GenerateChestLoot(onlylegn) {
	if (!isDefined(onlylegn)) {
		onlylegn = false;
	}
	luck = RandomIntRange(0, 100);
	retval = createInventorySlotStruct();
	retval.rarity = 0; // 50% of common
	item = PickCommonItem();
	if (luck >= 96 || level.solidgold || onlylegn) { retval.rarity = 4; item = PickLegendaryItem(); } // 5% for Legendary
	else if (luck >= 88) { retval.rarity = 3; item = PickEpicItem(); } // 10% for Epic
	else if (luck >= 73) { retval.rarity = 2; item = PickRareItem(); } // 15% for Rare
	else if (luck >= 50) { retval.rarity = 1; item = PickUncommonItem(); } // 20% for Uncommon
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
DebugItemSpawn() {
	c = RandomIntRange(0, 5);
	if (c == 0) { return "scar_mp+extclip"; }
	else if (c == 1) { return "svu_mp+ir"; }
	else if (c == 2) { return "pdw57_mp+fastads"; }
	else if (c == 3) { return "sig556_mp+stalker"; }
	else if (c == 4) { return "fnp45_mp+dualclip+fmj"; }
}
PickCommonItem()
{
	c = RandomIntRange(0, 12); // Only weapons for now
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	// Repation intentional to increase odds of these spawning.
	else if (c == 2) { return "mp7_mp+silencer"; }
	else if (c == 3) { return "fiveseven_mp"; }
	else if (c == 4) { return "fnp45_mp+dualclip"; }
	else if (c == 5) { return "mp7_mp+silencer"; }
	else if (c == 6) { return "fiveseven_mp"; }
	else if (c == 7) { return "fnp45_mp+dualclip"; }
	
	else if (c == 8) { return "870mcs_mp+extbarrel"; }
	else if (c == 9) { return "frag_grenade_mp"; }
	else if (c == 10) { return "Bandage"; }
	else if (c == 11) { return "Bandage"; }
}
PickUncommonItem()
{
	c = RandomIntRange(0, 16); // Only weapons for now
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	else if (c == 2) { return "mp7_mp+silencer"; }
	else if (c == 3) { return "fiveseven_mp"; }
	else if (c == 4) { return "fnp45_mp+dualclip"; }
	else if (c == 5) { return "870mcs_mp+extbarrel"; }
	else if (c == 6) { return "insas_mp"; }
	else if (c == 7) { return "ksg_mp"; }
	else if (c == 8) { return "ballista_mp+is"; }
	else if (c == 9) { return "sticky_grenade_mp"; }
	else if (c == 10) { return "Medkit"; }
	else if (c == 11) { return "Small Shield"; }
	else if (c == 12) { return "Small Shield"; }
	else if (c == 13) { return "Small Shield"; }
	else if (c == 14) { return "pdw57_mp+fastads"; }
	else if (c == 15) { return "pdw57_mp+fastads"; }
	//Medkit
}
PickRareItem()
{
	c = RandomIntRange(0, 19); // Only weapons for now
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	else if (c == 2) { return "mp7_mp+silencer"; }
	else if (c == 3) { return "fiveseven_mp"; }
	else if (c == 4) { return "fnp45_mp+dualclip"; }
	else if (c == 5) { return "870mcs_mp+extbarrel"; }
	else if (c == 6) { return "insas_mp"; }
	else if (c == 7) { return "ksg_mp"; }
	else if (c == 8) { return "ballista_mp+is"; }
	else if (c == 9) { return "sa58_mp+acog"; }
	else if (c == 10) { return "dsr50_mp+dualclip"; }
	else if (c == 11) { return "lsat_mp+steadyaim"; }
	else if (c == 12) { return "smaw_mp"; }
	else if (c == 13) { return "m32_wager_mp"; }
	else if (c == 14) { return "satchel_charge_mp"; }
	else if (c == 15) { return "Large Shield"; }
	else if (c == 16) { return "Large Shield"; }
	else if (c == 17) { return "pdw57_mp+fastads"; }
	else if (c == 18) { return "pdw57_mp+fastads"; }
}
PickEpicItem()
{
	c = RandomIntRange(0, 16); // Only weapons for now
	if (c == 0) { return "scar_mp+extclip"; }
	else if (c == 1) { return "sig556_mp+stalker"; }
	else if (c == 2) { return "m32_wager_mp"; }
	else if (c == 3) { return "fiveseven_mp+silencer"; }
	else if (c == 4) { return "fnp45_mp+dualclip+fmj"; }
	else if (c == 5) { return "srm1216_mp"; }
	else if (c == 6) { return "insas_mp+stalker"; }
	else if (c == 7) { return "as50_mp+extclip"; }
	else if (c == 8) { return "minigun_wager_mp"; }
	else if (c == 9) { return "sa58_mp+acog"; }
	else if (c == 10) { return "dsr50_mp+dualclip"; }
	else if (c == 11) { return "lsat_mp+steadyaim"; }
	else if (c == 12) { return "smaw_mp"; }
	else if (c == 13) { return "Slurp Juice"; }
	else if (c == 14) { return "svu_mp+ir"; }
	else if (c == 15) { return "svu_mp+ir"; }
}
PickLegendaryItem()
{
	c = RandomIntRange(0, 18); // Only weapons for now
	if (c == 0) { return "scar_mp+extclip"; }
	else if (c == 1) { return "sig556_mp+stalker"; }
	else if (c == 2) { return "m32_wager_mp"; }
	else if (c == 3) { return "fiveseven_mp+silencer"; }
	else if (c == 4) { return "fnp45_mp+dualclip+fmj"; }
	else if (c == 5) { return "srm1216_mp"; }
	else if (c == 6) { return "smaw_mp"; }
	else if (c == 7) { return "as50_mp+extclip"; }
	else if (c == 8) { return "minigun_wager_mp"; }
	else if (c == 9) { return "sa58_mp+acog"; }
	else if (c == 10) { return "dsr50_mp+dualclip"; }
	else if (c == 11) { return "Chug Jug"; }
	
	else if (c == 12) { return "sig556_mp+stalker"; }
	else if (c == 13) { return "fiveseven_mp+silencer"; }
	else if (c == 14) { return "fnp45_mp+dualclip+fmj"; }
	else if (c == 15) { return "sa58_mp+acog"; }
	else if (c == 16) { return "svu_mp+ir"; }
	else if (c == 17) { return "svu_mp+ir"; }
}






























