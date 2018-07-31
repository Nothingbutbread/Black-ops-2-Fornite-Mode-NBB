StartingLoadout()
{
	self SetActionSlot(1, "");
	self SetActionSlot(2, "");
	self SetActionSlot(3, "");
	self SetActionSlot(4, "");
	self.zperks = [];
	self takeAllWeapons();
	self.spawnWeapons[0] = "knife_ballistic_mp"; //Primary
	self.spawnWeapons[1] = "knife_held_mp"; //Secondary
	self.spawnWeapons[2] = ""; //Lethal
	self.spawnWeapons[3] = ""; //Tacitcal
	self.spawnWeapons[4] = "knife_mp"; //Extra
	for (i = 0; i < 5; i++)
	{
		if (isDefined(self.spawnWeapons[i]))
		{
			self GiveWeapon(self.spawnWeapons[i]);
			self setWeaponAmmoClip(self.spawnWeapons[i], weaponClipSize(self.spawnWeapons[i]));
			self GiveStartAmmo(self.spawnWeapons[i]);
			self SwitchToWeapon(self.spawnWeapons[0]); 
		}
		wait 0.05;
	}
}
GiveGun(weapon, camo)
{
	if (weapon == "") { return ""; }
	if (!isDefined(camo)) { camo = 3; }
	oldweapon = self.currentWeapon;
	//if (!isanotWeapon(weapon)) { self TakeWeapon(self.currentWeapon); }
	self TakeWeapon(self.currentWeapon);
	self GiveWeapon(weapon);
	self setWeaponAmmoClip(weapon, weaponClipSize(weapon));
	self SwitchToWeapon(weapon);
	self setcamo(camo, weapon);
	self SwitchToWeapon(weapon);
	self GiveStartAmmo(weapon);
	if (self CheckForLostGun()) { self GiveGun("knife_held_mp", 3); } // The player must have given himself a dupe, replenishes gun slot.
	return oldweapon;
}
CheckForLostGun()
{
	count = 0;
	target = 3;
	if (self.zperks[5]) { target = 4; }
	foreach (gun in self GetWeaponsList())  { count++; }
	if (target >= 3) { return false; } // The player should always have 3 weapons. Otherwise he is missing one.
	return true;
}
isanotWeapon(gun)
{
	for(x=0;x<level.WeaponArray2.size;x++) { if (level.WeaponArray2[x] == gun) { return true; } }
	for(x=0;x<level.WeaponArray3.size;x++) { if (level.WeaponArray3[x] == gun) { return true; } }
	return false;
}
// id = Index to acess the item array
// gun = item name
// replace = boolean, If the inventory is full, when true, will replace the highlighted item. Otherwise it's not added.
// index is the ideal location to place the item in the inventory array.
add_Thing_To_Inventory(id, item, replace, index)
{
	if (id < 1) { return; }
	max = self.invlimmit[id - 1]; // Max is always the size max and the index value that shouldn't be reached.
	if (!isDefined(index)) { index = self.invlimmit[id - 1] - 1; }
	if (!isDefined(replace)) { replace = true; }
	if (index >= max) { index = self.invlimmit[id - 1] - 1; self iprintln("^3Warning: ^7Code 1 error detected and auto-corrected!"); }
	filled = true;
	array = [];
	if (id == 1) { array = self.invgun; }
	else if (id == 2) { array = self.invboo; }
	else if (id == 3) { array = self.invabi; }
	else if (id == 4) { array = self.invaat; }
	else { self iprintln("^1Game Error: ^3Function: add_Thing_To_Inventory ^1got an invalid id!\n^6Report this to the dev!"); array = self.invgun; }
	for(x=0;x<max;x++) 
	{ 
		if (array[x] == "") 
		{ 
			filled = false;
			index = x; 
			break; 
		} 
	}
	if (filled)
	{
		if (index < max) { array[index] = item; }
		else if (replace) { array[max - 1] = item; }
	}
	else if (index < max) { array[index] = item; }
	if (id == 1) { self.invgun = array; }
	else if (id == 2) { self.invboo = array; }
	else if (id == 3) { self.invabi = array; }
	else if (id == 4) { self.invaat = array; }
}
setcamo(camo, g)
{
	if (!isdefined(g))
		g = self getCurrentWeapon();
	if (g != "minigun_wager_mp" && "m32_wager_mp" != g)
	{
		self takeWeapon(g);
		self giveWeapon(g,0,true(camo,0,0,0,0));
	}
}
// Used to determine the type id of an item from it's display string.
// The returned value is used to index into the inventory.
whatisthatobject(str)
{
	// 1 = Weapon, 2 = Booster, 3 = Ability, 4 = AAT, 9 == Perk,
	if ("Hearty" == str) { return 2; } // Booster
	else if ("Speedo" == str) { return 2; } 
	else if ("Quick Heal" == str) { return 2; } 
	else if ("Vanish" == str) { return 2; }
	else if ("Restock" == str) { return 2; } 
	else if ("Unlimited Clip" == str) { return 2; } 
	else if ("New Camo" == str) { return 2; } 
	else if ("Birds Eye View" == str) { return 2; } 
	else if ("Loot Box Hack" == str) { return 2; }
	else if ("Inv Upgrade" == str) { return 9; }
	else if ("Stat Upgrade" == str) { return 9; }
	else if ("Double Tap II" == str) { return 3; } 
	else if ("Unlimited Ammo" == str) { return 3; } 
	else if ("Electric Cherry" == str) { return 3; } 
	else if ("Dynamic Camo" == str) { return 3; } 
	else if ("Gun Game" == str) { return 3; }
	else if ("Resistant" == str) { return 3; }
	else if ("Blood to Lead" == str) { return 3; }
	else if ("Explosive Decoy" == str) { return 4; }
	else if ("Explosive Trap" == str) { return 4; }
	else if ("Rocket Launcher" == str) { return 4; }
	else if ("Slug Ray" == str) { return 4; }
	else if ("Shell Shock" == str) { return 4; }
	else if ("Proxy Attack" == str) { return 4; }
	else if ("Recon Palse" == str) { return 4; }
	else if ("EMP" == str) { return 4; }
	else if ("Drained" == str) { return 4; }
	else if ("Explosive Bullets" == str) { return 4; }
	else if ("<null>" == str) { return 4; }
	else if ("Speed Cola" == str) { return 9; } 
	else if ("Double Tap" == str) { return 9; } 
	else if ("Stamina Up" == str) { return 9; } 
	else if ("Scrounger" == str) { return 9; } 
	else if ("Resistance" == str) { return 9; } 
	else if ("Mule Kick" == str) { return 9; }
	else if ("Sixth Sense" == str) { return 9; }
	else if (str.size == 6 || str.size == 7){ if (DisplayStringMod(str, 4) == "[SP]") { return 8; } }
	return 1; // A weapon
}
// Takes a size value and two intergers for the range.
// Returns an array of values that fall in the range and are unique.
RandIntArrayNoDupe(size, min, max)
{
	nums = [];
	if ((max - min) < size) { return nums; } // When the size is larger than the range, the function breaks.
	while(nums.size < size)
	{
		n = RandomIntRange(min, max);
		x = 0;
		while(x < nums.size)
		{
			if (nums[x] == n)
			{ 
				n++;
				if (n >= max) { n = min; }
				x = 0;
			}
			else { x++; }
		}
		nums[nums.size] = n;
	}
	return nums;
}
ValidforTrueUnlimmitedAmmo(g)
{
	if (!isDefined(g)) { g = self.currentWeapon; }
	if (g == "smaw_mp" || g == "usrpg_mp" || g == "m32_wager_mp" || g == "crossbow_mp" || g == "knife_ballistic_mp") { return false; }
	return true;
}
LootCreateDupeCheck(index, location)
{
	if (level.lca[index] != -1) { return false; } // There is an active create here, cancel!
	for(x=0;x<8;x++) { if (level.lca[x] == location) { return false; }  }
	return true;
}
DisplayStringMod(string, limmit)
{
	s = "";
	if (limmit < string.size)
	{
		for(x=0;x<limmit;x++) { s += string[x]; }
	}
	else { s = string; }
	return s;
}
playerAnglesToForward(player, distance)
{
	return player.origin + VectorScale(AnglesToForward(player getPlayerAngles(), distance));
}
DeleteDeathBarriers()
{
    ents = getEntArray();
    for ( index = 0; index < ents.size; index++ )
    {
    	if(isSubStr(ents[index].classname, "trigger_hurt"))
    		ents[index].origin = (0, 0, 9999999);
    }
}
SpawnIcon(origin, icon, onEntity)
{
	Objective_Add(level.mmiconsspawned, "active", origin);
	Objective_Icon(level.mmiconsspawned, icon);
	
	if (isDefined(onEntity))
		Objective_OnEntity(level.mmiconsspawned, onEntity);
	level.mmiconsspawned++;
}

printInventoryType(id)
{
	if (id == 0) { self iprintln("Weapon storage increased!"); }
	else if (id == 1) { self iprintln("Booster storage increased!"); }
	else if (id == 2) { self iprintln("Ability storage increased!"); }
	else if (id == 3) { self iprintln("AAT storage increased!"); }
}
TraceShot()
{
	return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}
ModTraceShot(degree)
{
	angle = self getPlayerAngles();
	adjustx = RandomIntRange(degree * -1, degree);
	adjusty = RandomIntRange(degree * -1, degree);
	temp = angle[0] + adjustx;
	if (temp < 0)
	{
		temp = NoN(temp);
		temp = 360 - temp;
	}
	else if (temp >= 360)
		temp -= 360;
	adjustx = temp;
	temp = angle[1] + adjusty;
	if (temp < 0)
	{
		temp = NoN(temp);
		temp = 360 - temp;
	}
	else if (temp >= 360)
		temp -= 360;
	adjusty = temp;
	angle = (adjustx, adjusty, angle[2]);
	return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(angle), 1000000), false, self)["position"];
}
NoN(num)
{
	if (num >= 0)
		return num;
	return num * -1;
}
GetExpandableInventoryIndex(y)
{
	if (self.invlimmit[y] < 6) { return y; }
	else
	{
		count = 0;
		while(self.invlimmit[y] < 6 && count < 5)
		{
			y++;
			if (y > 3) { y = 0; }
			if (self.invlimmit[y] < 6) { return y; }
			count++;
		}
		return y;
	}
}
UnstuckPlayer()
{
	if (self.savedfromthedepths)
	{
		self.savedfromthedepths = false;
		self setorigin(self.spawnorigin);
		self iprintln("^1This the only time you can use unstuck this game!");
		self iprintln("^1Next time will result in death");
		self iprintln("^2Killing other players will reset this!");
	}
	else { self suicide(); iprintln("^3" + self.name + " ^7used unstuck too many times!\n^1Consider reading the infobar!"); }
}
Menu_Inventory_Info_Bar_Update_Mapping()
{
	if (self.eastereggeffect) { self.infobarstr2 = "<null> <null> | <null> <null> | <null> / <null> <null> <null>/<null>"; }
	else { self.infobarstr2 = "[{+usereload}] Select | [{+gostand}] Close menu | [{+actionslot 1}] / [{+actionslot 2}] Move Up/Down"; }
	if (self.inventory_menu_menu == -1)
	{
		if (self.inventory_menu_pos == 0)
		{
			self.infobarstr1 = "^3Addict^7: ^5Increased booster duration. Given the ability Resistant and the booster Loot Box Hack";
			self.infobarstr2 = "^7On kill: Max health goes up by 6, Movement speed goes up by 6 percent.";
		}
		else if (self.inventory_menu_pos == 1)
		{
			self.infobarstr1 = "^3Bookie^7: ^5Better chance of obtaining Uncommon and Rare Loot boxes (65/25/10) -> (45/35/20)";
			self.infobarstr2 = "^7Min items per loot box increased by 1. 2 kill streak makes the next loot box rare. 3 kill streak maxes inventory space.";
		}
		else if (self.inventory_menu_pos == 2)
		{
			self.infobarstr1 = "^3Warrior^7: ^5Start with Speed cola and Resistance perks and max storage space for weapons.";
			self.infobarstr2 = "^7The next lootbox you open will have an automatic weapon or riffle. 3 kill streak gives you all perks.";
		}
		else if (self.inventory_menu_pos == 3)
		{
			self.infobarstr1 = "^3Tank^7: ^5Start with 150 health and max inventory space.";
			self.infobarstr2 = "^7On kill: The weapon you are holdings mag gets auto-refilled. Hearty boosters have double duration.";
		}
		
		else if (self.inventory_menu_pos == 4)
		{
			self.infobarstr1 = "^3Scout^7: ^5Given stealth perks, The next you loot box will have a sniper riffle.";
			self.infobarstr2 = "^7On kill after 2 killstreak: Auto-trigger a Birds Eye view booster. Birds Eye view boosters have double duration.";
		}
		else if (self.inventory_menu_pos == 5)
		{
			self.infobarstr1 = "^3Athlete^7: ^5Move 20 percent faster and have speed perks with no fall damage.";
			self.infobarstr2 = "^73 kill streak gives you a 40 percent additional speed. Speedo boosters have double durration.";
		}
		else if (self.inventory_menu_pos == 6)
		{
			self.infobarstr1 = "^3Specialist^7: ^5Double ammo for AAT's with 2+ ammo. The next loot box you open will have an AAT.";
			self.infobarstr2 = "^73 kill streak gives 25 extra health and 20 percent extra speed. Increased chance for AAT's in Loot boxes.";
		}
		else if (self.inventory_menu_pos == 7)
		{
			self.infobarstr1 = "^3Secret Shopper^7: ^5Start with 5 SP. Double SP on kill, More SP from Loot boxes.";
			self.infobarstr2 = "^73 kill streak gives 50 SP, additional kills afterward award 10 SP.";
		}
	}
	else if (self.inventory_menu_menu == 0 && !self.loot_menu_open)
	{
		if (self.inventory_menu_pos == 0)
		{ self.infobarstr1 = "^3Weapons^7: ^5Opens the Weapons inventory. Select weapons there to swap your held weapon with them."; }
		else if (self.inventory_menu_pos == 1)
		{ self.infobarstr1 = "^3Boosters^7: ^5Opens the Boosters inventory. Select boosters there to use them."; }
		else if (self.inventory_menu_pos == 2)
		{ self.infobarstr1 = "^3Abilities^7: ^5Opens the Abilities inventory. Select Abilities there to change your active ability."; }
		else if (self.inventory_menu_pos == 3)
		{ self.infobarstr1 = "^3AAT's^7: ^5Opens the Alternate Ammo Type inventory. Select AAT's there to change your active bullet effect."; }
		else if (self.inventory_menu_pos == 4)
		{ self.infobarstr1 = "^3Taunt^7: ^5Prints a random message to the kill feed. Can only do so every 7 seconds."; }
		else if (self.inventory_menu_pos == 5)
		{ self.infobarstr1 = "^3Utility Menu^7: ^5Opens a menu with utility options such as Unstuck and developer only commands."; }
		else if (self.inventory_menu_pos == 6)
		{ self.infobarstr1 = "^3Shop Menu^7: ^5Opens a menu where you can spend Survivor Points [SP] for varrious things."; }
		else if (self.inventory_menu_pos == 7)
		{ self.infobarstr1 = "^3Exit Menu^7: ^5Closes the menu."; }

	}
	else if (self.inventory_menu_menu == 1 && !self.loot_menu_open)
	{
		if (isDefined(self.invgun[self.inventory_menu_pos]) && self.invgun[self.inventory_menu_pos] != "")
		{ self.infobarstr1 = "Swaps held gun with " + DisplayStringMod(self.invgun[self.inventory_menu_pos], 25); }
		else if (self.inventory_menu_pos == 7)
		{ self.infobarstr1 = "^3Back^7: ^5Closes this menu, goes back to the main menu."; }
		else
		{ self.infobarstr1 = "^1Empty gun slot! You can't do anything with that right now"; }
	}
	else if (self.inventory_menu_menu == 2 && !self.loot_menu_open)
	{
		if (!isDefined(self.invboo[self.inventory_menu_pos]) || self.inventory_menu_pos == 7)
		{ self.infobarstr1 = "^3Back^7: ^5Closes this menu, goes back to the main menu."; }
		else
		{
			if (self.invboo[self.inventory_menu_pos] == "")
			{ self.infobarstr1 = "^1Empty booster slot! You can't do anything with that right now."; }
			else if (self.invboo[self.inventory_menu_pos] == "Hearty")
			{ self.infobarstr1= "^3Hearty^7: Increases health to 200 for 13 seconds. Addict: 22 / Tank: 26"; }
			else if (self.invboo[self.inventory_menu_pos] == "Speedo")
			{ self.infobarstr1= "^3Speedo^7: Doubles base speed. Stacks with speed bonuses for 15 seconds. Addict: 25 / Athlete: 30"; }
			else if (self.invboo[self.inventory_menu_pos] == "Quick Heal")
			{ self.infobarstr1 = "^3Quick Heal^7: Instantly heal to full health. Clears negative states."; }
			else if (self.invboo[self.inventory_menu_pos] == "Vanish")
			{ self.infobarstr1 = "^3Vanish^7: Go invisable for 15 seconds. Can't shoot while active. Addict: 25 / Scout: 30"; }
			else if (self.invboo[self.inventory_menu_pos] == "Restock")
			{ self.infobarstr1 = "^3Restock^7: Refills your guns ammo."; }
			else if (self.invboo[self.inventory_menu_pos] == "Unlimited Clip")
			{ self.infobarstr1 = "^3Unlimited Clip^7: Unlimited Clip Ammo for 10 seconds. Addict: 16 / Warrior: 20"; }
			else if (self.invboo[self.inventory_menu_pos] == "New Camo")
			{ self.infobarstr1 = "^3New Camo^7: Applies a random camo to your held gun. Refills it too."; }
			else if (self.invboo[self.inventory_menu_pos] == "Birds Eye View")
			{ self.infobarstr1 = "^3Birds Eye View^7: Activates constant UAV for 15 seconds. Addict: 25 / Scout: 30"; }
			else if (self.invboo[self.inventory_menu_pos] == "Loot Box Hack")
			{ self.infobarstr1 = "^3Loot Box Hack^7: Teleport to a random active loot box"; }
			else if (self.invboo[self.inventory_menu_pos] == "Inv Upgrade")
			{ self.infobarstr1 = "^3Inventory Upgrade^7: Increases one of capacity of one of your inventorys by 1."; }
			else if (self.invboo[self.inventory_menu_pos] == "Stat Upgrade")
			{ self.infobarstr1= "^3Stat Upgrade^7: Increases your speed and health by a small amount."; }
		}
	}
	else if (self.inventory_menu_menu == 3 && !self.loot_menu_open)
	{
		if (!isDefined(self.invabi[self.inventory_menu_pos]) || self.inventory_menu_pos == 7)
		{ self.infobarstr1 = "^3Back^7: ^5Closes this menu, goes back to the main menu."; }
		else
		{
			if (self.invabi[self.inventory_menu_pos] == "")
			{ self.infobarstr1 = "^1Empty Ability slot! You can't do anything with that right now."; }
			else if (self.invabi[self.inventory_menu_pos] == "Double Tap II")
			{ self.infobarstr1 = "^3Double Tap II^7: Shoot an extra bullet when you shoot. Only works on bullet weapons."; }
			else if (self.invabi[self.inventory_menu_pos] == "Unlimited Ammo")
			{ self.infobarstr1 = "^3Unlimmited Ammo^7: The stock of you weapons are unlimited."; }
			else if (self.invabi[self.inventory_menu_pos] == "Electric Cherry")
			{ self.infobarstr1 = "^3Electric Cherry^7: Damage nearby players when you reload."; }
			else if (self.invabi[self.inventory_menu_pos] == "Dynamic Camo")
			{ self.infobarstr1 = "^3Dynamic Camo^7: Get a new camo on your gun once every 15 seconds."; }
			else if (self.invabi[self.inventory_menu_pos] == "Gun Game")
			{ self.infobarstr1 = "^3Gun Game^7: Get a new gun once every 15 seconds."; }
			else if (self.invabi[self.inventory_menu_pos] == "Resistant")
			{ self.infobarstr1 = "^3Resistant^7: Block the effects of several AAT's including the explosive decoy."; }
			else if (self.invabi[self.inventory_menu_pos] == "Blood to Lead")
			{ self.infobarstr1 = "^3Blood to Lead^7: Taking damage refills your ammo."; }
		}
	}
	else if (self.inventory_menu_menu == 4 && !self.loot_menu_open)
	{
		if (!isDefined(self.invaat[self.inventory_menu_pos]) || self.inventory_menu_pos == 7)
		{ self.infobarstr1 = "^3Back^7: ^5Closes this menu, goes back to the main menu."; }
		else
		{
			if (self.invaat[self.inventory_menu_pos] == "")
			{ self.infobarstr1 = "^1Empty Alternate Ammo Type slot! You can't do anything with that right now."; }
			else if (self.invaat[self.inventory_menu_pos] == "Explosive Decoy")
			{ self.infobarstr1 = "^3Explosive Decoy^7: 1 shot, Spawns an fake loot box that explodes when opened."; }
			else if (self.invaat[self.inventory_menu_pos] == "Explosive Trap")
			{ self.infobarstr1 = "^3Explosive Trap^7: 1 shot, Spawns an package that explodes when someone is nearby."; }
			else if (self.invaat[self.inventory_menu_pos] == "Rocket Launcher")
			{ self.infobarstr1 = "^3Rocket Launcher^7: 2 shots, Shoots a rocket that hits the target after 2 seconds."; }
			else if (self.invaat[self.inventory_menu_pos] == "Slug Ray")
			{ self.infobarstr1 = "^3Slug Ray^7: 5 shots, Sets effected players speed to 17 percent of normal speed."; }
			else if (self.invaat[self.inventory_menu_pos] == "Shell Shock")
			{ self.infobarstr1 = "^3Shell Shock^7: 6 shots, Plays loud noises and randomly sets effected players angles."; }
			else if (self.invaat[self.inventory_menu_pos] == "Proxy Attack")
			{ self.infobarstr1 = "^3Proxy Attack^7: 3 shots, disables effected players menu for 15 seconds."; }
			else if (self.invaat[self.inventory_menu_pos] == "Recon Palse")
			{ self.infobarstr1 = "^3Recon Palse^7: 4 shots, Nearby players are tagged for 15 seconds. Tags visible though walls."; }
			else if (self.invaat[self.inventory_menu_pos] == "EMP")
			{ self.infobarstr1 = "^3EMP^7: 5 shots, Nearby players active abilities, AAT's and boosters are disabled."; }
			else if (self.invaat[self.inventory_menu_pos] == "Drained")
			{ self.infobarstr1 = "^3Drained^7: 4 shots, Nearby players weapons loss their mags."; }
			else if (self.invaat[self.inventory_menu_pos] == "Explosive Bullets")
			{ self.infobarstr1 = "^3Explosive Bullets^7: 5 shots, Nearby players take damage."; }
			else if (self.invaat[self.inventory_menu_pos] == "<null>")
			{ self.infobarstr1 = "^3<null>^7: <null> <null><null> <null> <null> <null> <null><null>"; }
		}
	}
	else if (self.inventory_menu_menu == 7 && !self.loot_menu_open)
	{
		if (self.inventory_menu_pos == 0 && self.savedfromthedepths)
		{ self.infobarstr1 = "^3Unstuck^7: ^5Teleports you back to your spawn point. Can only be used once. Falling out of the map uses it."; }
		else if (self.inventory_menu_pos == 0 && !self.savedfromthedepths)
		{ self.infobarstr1 = "^3Unstuck^7: ^1Will kill you!^5 You've already used your save me token this game!"; }
		else if (self.inventory_menu_pos == 1)
		{ self.infobarstr1 = "^3Noclip^7: ^5Allows you to move though walls and fly."; }
		else if (self.inventory_menu_pos == 2)
		{ self.infobarstr1 = "^3Godmode^7: ^5Disables death by normal means. Any command using suicide() will still kill you."; }
		else if (self.inventory_menu_pos == 3)
		{ self.infobarstr1 = "^3Print Origin^7: ^5Toggles the printing of your origin to the kill feed."; }
		else if (self.inventory_menu_pos == 4)
		{ self.infobarstr1 = "^3Common Loot Box^7: ^5Closes this menu and gives you a Common Loot Box."; }
		else if (self.inventory_menu_pos == 5)
		{ self.infobarstr1 = "^3Uncommon Loot Box^7: ^5Closes this menu and gives you a Uncommon Loot Box."; }
		else if (self.inventory_menu_pos == 6)
		{ self.infobarstr1 = "^3Rare Loot Box^7: ^5Closes this menu and gives you a Rare Loot Box."; }
		else if (self.inventory_menu_pos == 7)
		{ self.infobarstr1 = "^3Back^7: ^5Closes this menu, goes back to the main menu."; }
	}
	else if (self.inventory_menu_menu == 8 && !self.loot_menu_open)
	{
		if (self.inventory_menu_pos == 0)
		{ self.infobarstr1 = "^3Buy Common Loot Box^7: ^5Cost: ^13^7SP ^7Closes this menu and gives you a Common Loot Box."; }
		else if (self.inventory_menu_pos == 1)
		{ self.infobarstr1 = "^3Buy Uncommon Loot Box^7: ^5Cost: ^19^7SP ^7Closes this menu and gives you a Uncommon Loot Box."; }
		else if (self.inventory_menu_pos == 2)
		{ self.infobarstr1 = "^3Buy Rare Loot Box^7: ^5Cost: ^120^7SP ^7Closes this menu and gives you a Rare Loot Box."; }
		else if (self.inventory_menu_pos == 3)
		{ self.infobarstr1 = "^3Buy Random Gun^7: ^5Cost: ^13^7SP ^7Adds a random gun to your weapons inventory"; }
		else if (self.inventory_menu_pos == 4)
		{ self.infobarstr1 = "^3Buy Random Booster^7: ^5Cost: ^15^7SP ^7Adds a random booster to your boosters inventory"; }
		else if (self.inventory_menu_pos == 5)
		{ self.infobarstr1 = "^3Buy Random AAT^7: ^5Cost: ^17^7SP ^7Adds a random AAT to your AATs inventory"; }
		else if (self.inventory_menu_pos == 6)
		{ self.infobarstr1 = "^3Buy Random Ability^7: ^5Cost: ^110^7SP ^7Adds a random ability to your abilities inventory"; }
		else if (self.inventory_menu_pos == 7)
		{ self.infobarstr1 = "^3Back^7: ^5Closes this menu, goes back to the main menu."; }
	}
	else if (self.loot_menu_open)
	{
		if (self.eastereggeffect) { self.infobarstr2 = "<null> <null> <null> <null> | <null> <null> <null> | <null> / <null> <null> <null>/<null>"; }
		else { self.infobarstr2 = "[{+usereload}] Move to Inv | [{+gostand}] Take All | [{+actionslot 1}] / [{+actionslot 2}] Move Up/Down"; }
		if (isDefined(self.loot[self.loot_menu_pos]))
		{
			if (self.loot[self.loot_menu_pos] != "") 
			{
				in = whatisthatobject(self.loot[self.loot_menu_pos]);
				if (in == 1) { self.infobarstr1 = "^3Weapon^7: " + DisplayStringMod(self.loot[self.loot_menu_pos], 14); }
				else if (in == 2) { self.infobarstr1 = "^3Booster^7: " + self.loot[self.loot_menu_pos]; }
				else if (in == 3) { self.infobarstr1 = "^3Ability^7: " + self.loot[self.loot_menu_pos]; }
				else if (in == 4) { self.infobarstr1 = "^3[AAT] Alternate Ammo Type^7: " + self.loot[self.loot_menu_pos]; }
				else if (in == 8) { self.infobarstr1 = "^3Survivor Points^7: ^2" + DisplayStringModAlt(self.loot[self.loot_menu_pos], 5) + " ^7Survival Points (used instantly)"; }
				else if (in == 9) { self.infobarstr1 = "^3Perk^7: " + self.loot[self.loot_menu_pos] + " (used instantly)"; }
				else { self.infobarstr1 = "^1Empty loot slot: ^3Nothing to see here!"; }
			}
			else { self.infobarstr1 = "^1Empty loot slot: ^3Nothing to see here!"; }
		}
		else { self.infobarstr1 = "^3Exit Menu^7: Exits the Loot box inventory!"; }
	}
	self.infobar_text_1 setSafeText(self.infobarstr1);
	self.infobar_text_2 setSafeText(self.infobarstr2);
}
DisplayStringModAlt(str, offset)
{
	s = "";
	if (offset < str.size)
	{
		for(x=offset;x<str.size;x++) { s += str[x]; }
	}
	else { s = string; }
	return s;
}


