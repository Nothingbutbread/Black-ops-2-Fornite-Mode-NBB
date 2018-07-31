Forge_Spawn_Object(model, origin, angle)
{
	obj = spawnEntity(model, origin, angle);
}
spawnEntity(model, origin, angle)
{
	if (!isdefined(angle)) { angle = (0,0,0); }
    entity = spawn("script_model", origin);
    entity.angles = angle;
    entity setModel(model);
    return entity;
}
ACL(origin)  { level.lc[level.lc.size] = origin; } // Add Create Location
Player_Drop_Inventory()
{
	self endon("disconnect");
	o = self.origin;
	array1 = self.invgun;
	array2 = self.invboo;
	array3 = self.invabi;
	array4 = self.invaat;
	sp = self.sp;
	level thread Player_Spawn_InventoryLootCrate(o, self.name, sp, array1, array2, array3, array4);
}
Player_Spawn_InventoryLootCrate(location, placer, sp, array1, array2, array3, array4) // Inventory of dead player.
{
	level endon("game_ended");
	killloop = false;
	obj = spawnEntity("t6_wpn_supply_drop_trap",location, (0,0,90));
	marker = CreateWaypoint("perk_flak_jacket", location + (0,0,50) , 5, 5, .7, true);
	tick = 0;
	while(tick < 600) // 1 minute max durration of the inventory being there.
	{
		foreach(player in level.players)
		{
			if (Distance(player.origin, location) < 60)
			{
				if (player meleebuttonpressed())
				{
					player iprintln("^2Collected " + placer + "'s Inventory!");
					player.sp += sp;
					for(x=0;x < 7; x++)
					{ 
						if (isDefined(array1[x]) && array1[x] != "") { player add_Thing_To_Inventory(0, array1[x], true); }
						if (isDefined(array2[x]) && array2[x] != "") { player add_Thing_To_Inventory(1, array2[x], true); }
						if (isDefined(array3[x]) && array3[x] != "") { player add_Thing_To_Inventory(2, array3[x], true); }
						if (isDefined(array4[x]) && array4[x] != "") { player add_Thing_To_Inventory(3, array4[x], true); }
					}
					killloop = true;
					break;
				}
			}
		}
		if (killloop) { break; }
		tick++;
		wait .1;
	}
	//
	marker Destroy();
	obj delete();
}
CollectPlayerInventory()
{
}
Spawn_LootCrate(index, location) // Generic loot crate. Contents generated are players based on thier varribles.
{
	level endon("game_ended");
	// Checks complete, we are go for spawning a crate here.
	if (LootCreateDupeCheck(index, location))
	{
		level.activelootboxes++;
		level.lca[index] = location; // Set
		killloop = false;
		obj = spawnEntity("t6_wpn_supply_drop_trap", level.lc[location], (0,0,90));
		//iprintln("Loot Crate " + index + " spawned at " + location);
		marker = CreateWaypoint("perk_hardline", level.lc[location] + (0,0,50) , 5, 5, .7, true);
		while(true)
		{
			foreach(player in level.players)
			{
				if (Distance(player.origin, level.lc[location]) < 50)
				{
					if (player meleebuttonpressed() && !player.inventory_menu_open && !player.loot_menu_open && player.canusemenu)
					{
						player thread giveSupplyDrop();
						killloop = true;
						break;
					}
					if (player meleebuttonpressed() && !player.canusemenu)
					{
						player iprintln("^1Can't open loot box while under a proxy attack!");
					}
				}
			}
			if (killloop) { break; }
			wait .1;
		}
		//
		marker Destroy();
		obj delete();
		level.lca[index] = -1; // Create is now longer active.
		level.activelootboxes--;
	}
}
Forge_Teleport(start, end)
{
	level endon("game_ended");
	obj = spawnEntity("mp_flag_neutral", start, (0,0,0));
	SpawnIcon(start, "waypoint_recon_artillery_strike");
	obj2 = spawnEntity("mp_flag_neutral", end, (0,0,0));
	SpawnIcon(end, "waypoint_recon_artillery_strike");
	while(1)
    {
	    foreach(player in level.players)
	    {
	    	if (Distance(player.origin, start) < 20 && player.canteleport)
	    		player thread SetOrigin_fixed(end);
	    	else if (Distance(player.origin, end) < 20 && player.canteleport)
	    		player thread SetOrigin_fixed(start);
	   	}
	   	wait .1;
	}
}
SetOrigin_fixed(origin)
{
	self.canteleport = false;
	self setorigin(origin);
	wait 1;
	self.canteleport = true;
}
SetDistanceCap(radius, point)
{
	level endon("game_ended");
	if (!isDefined(point)) { point = level.finalspawnpoint; }
	if (level.debugger){
		while(true){
			foreach(player in level.players){
				if (Distance(player.origin, point) > radius){
					player iprintlnbold("Out of range! Distance: " + int(Distance(player.origin, point)));
				}
			}
			wait 1;
		}
	}
	else {
		level waittill("prematch_over");
		wait 30;
		foreach(player in level.players){
			player thread Client_DistanceChecker(radius, point);
		}
	}
}
Client_DistanceChecker(radius, point)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(true){
		if (Distance(self.origin, point) > radius){
			self playlocalsound("mpl_wager_humiliate");
			self iprintlnbold("^1You are too far from the map!");
			t = int(self.health / 3);
			self iprintln("Health lost: ^1" + t);
			if (t < 10) { t = 10; }
			self DoDamage(t , self.origin, self, self, "none", "MOD_BURNED", 0, "supplydrop_mp");
		}
		wait 1;
	}
}
BlackListedZone(cor1,cor2)
{
	level endon("game_ended");
	if (cor1[0] > cor2[0])
	{
		low0 = cor2[0];
		high0 = cor1[0];
	}
	else
	{
		high0 = cor2[0];
		low0 = cor1[0];
	}
	
	if (cor1[1] > cor2[1])
	{
		low1 = cor2[1];
		high1 = cor1[1];
	}
	else
	{
		high1 = cor2[1];
		low1 = cor1[1];
	}
	
	if (cor1[2] > cor2[2])
	{
		low2 = cor2[2];
		high2 = cor1[2];
	}
	else
	{
		high2 = cor2[2];
		low2 = cor1[2];
	}
	while(true)
    {
    	wait .1;
	    foreach(player in level.players)
	    {
			if (player.origin[0] >= low0 && player.origin[0] <= high0)
			{
				if (player.origin[1] >= low1 && player.origin[1] <= high1)
				{
					if (player.origin[2] >= low2 && player.origin[2] <= high2)
					{
						if (player.savedfromthedepths)
						{
							player iprintln("^1You've walked into a blacklisted zone.\nNext time you will die instead!");
							player.savedfromthedepths = false;
							n = RandomIntRange(0,8);
							player setorigin( level.lc[ level.lca[n] ] + (0,0,20) );
						}
						else { player suicide(); }
					}
				}
			}
		}
	}
}

























