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
GenerateLoot()
{
	luck = RandomIntRange(0, 100);
	rarity = 0; // 50% of common
	item = PickCommonItem();
	if (luck >= 96) { rarity = 4; item = PickLegemdaryItem(); } // 5% for Legendary
	else if (luck >= 88) { rarity = 3; item = PickEpicItem(); } // 10% for Epic
	else if (luck >= 76) { rarity = 2; item = PickRareItem(); } // 15% for Rare
	else if (luck >= 58) { rarity = 1; item = PickUncommonItem(); } // 20% for Uncommon
	// 
	//item = PickDebugItem();
	//
	if (level.solidgold) {
		rarity = 4; item = PickLegemdaryItem();
	}
	retval = []; retval[0] = item; retval[1] = "" + rarity;
	return retval;
}
GenerateChestLoot(onlylegn)
{
	if (!isDefined(onlylegn)) {
		onlylegn = false;
	}
	luck = RandomIntRange(0, 100);
	rarity = 0; // 50% of common
	item = PickCommonItem();
	if (luck >= 96) { rarity = 4; item = PickLegemdaryItem(); } // 5% for Legendary
	else if (luck >= 88) { rarity = 3; item = PickEpicItem(); } // 10% for Epic
	else if (luck >= 76) { rarity = 2; item = PickRareItem(); } // 15% for Rare
	else if (luck >= 58) { rarity = 1; item = PickUncommonItem(); } // 20% for Uncommon
	//
	//item = PickDebugItem();
	if (level.solidgold || onlylegn) {
		rarity = 4; item = PickLegemdaryItem();
	}
	retval = []; retval[0] = ""; retval[1] = ""; retval[2] = ""; retval[3] = ""; retval[4] = "";
	
	model = getRawWeapon(item);
	isweap = isAWeapon(model);
	retval[2] = "" + rarity;
	retval[1] = "" + teirIDToStringColor(rarity) + "" + getDisplayName(item);
	if (isweap) {
		retval[0] = item;
		retval[3] = "999"; //Full mag
		retval[4] = "t";
	} else {
		retval[0] = "knife_held_mp";
		retval[3] = "" + getDefaultItemSpawnCount(model);
		retval[4] = "f";
	}
	if (model == "frag_grenade_mp" || model == "sticky_grenade_mp" || model == "satchel_charge_mp") {
		retval[3] = "" + getDefaultItemSpawnCount(model);
	}
	return retval;
}
PickDebugItem() {
	return "sa58_mp+acog";
}
PickCommonItem()
{
	c = RandomIntRange(0, 11); // Only weapons for now
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
}
PickUncommonItem()
{
	c = RandomIntRange(0, 12); // Only weapons for now
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
	//Medkit
}
PickRareItem()
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
	else if (c == 9) { return "sa58_mp+acog"; }
	else if (c == 10) { return "dsr50_mp+dualclip"; }
	else if (c == 11) { return "lsat_mp+steadyaim"; }
	else if (c == 12) { return "smaw_mp"; }
	else if (c == 13) { return "m32_wager_mp"; }
	else if (c == 14) { return "satchel_charge_mp"; }
	else if (c == 15) { return "Large Shield"; }
}
PickEpicItem()
{
	c = RandomIntRange(0, 14); // Only weapons for now
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	else if (c == 2) { return "m32_wager_mp"; }
	else if (c == 3) { return "fiveseven_mp+silencer"; }
	else if (c == 4) { return "fnp45_mp+dualclip"; }
	else if (c == 5) { return "srm1216_mp"; }
	else if (c == 6) { return "insas_mp"; }
	else if (c == 7) { return "as50_mp+extclip"; }
	else if (c == 8) { return "minigun_wager_mp"; }
	else if (c == 9) { return "sa58_mp+acog"; }
	else if (c == 10) { return "dsr50_mp+dualclip"; }
	else if (c == 11) { return "lsat_mp+steadyaim"; }
	else if (c == 12) { return "smaw_mp"; }
	else if (c == 13) { return "Slurp Juice"; }
}
PickLegemdaryItem()
{
	c = RandomIntRange(0, 16); // Only weapons for now
	if (c == 0) { return "scar_mp"; }
	else if (c == 1) { return "sig556_mp"; }
	else if (c == 2) { return "m32_wager_mp"; }
	else if (c == 3) { return "fiveseven_mp+silencer"; }
	else if (c == 4) { return "fnp45_mp+dualclip"; }
	else if (c == 5) { return "srm1216_mp"; }
	else if (c == 6) { return "smaw_mp"; }
	else if (c == 7) { return "as50_mp+extclip"; }
	else if (c == 8) { return "minigun_wager_mp"; }
	else if (c == 9) { return "sa58_mp+acog"; }
	else if (c == 10) { return "dsr50_mp+dualclip"; }
	else if (c == 11) { return "Chug Jug"; }
	
	else if (c == 12) { return "sig556_mp"; }
	else if (c == 13) { return "fiveseven_mp+silencer"; }
	else if (c == 14) { return "fnp45_mp+dualclip"; }
	else if (c == 15) { return "sa58_mp+acog"; }
}




























