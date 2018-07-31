#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
///////////////////////////////////////////////////
//  The Survival Games                           //
///////////////////////////////////////////////////
//  Created by: Nothingbutbread                  //
///////////////////////////////////////////////////
//  Build: V1.2.1 Initial Release                //
///////////////////////////////////////////////////////////
//  Usage of this mod must be inaccordance               //
//  to the terms termsofuse.txt                          // 
///////////////////////////////////////////////////////////
//  Credits: For whose works I drew external assets from //
//  Note: Most assets in this mod not derived from       //
//  external sources. However not 100% of it my own code.//
//                                                       //
//  Shark: Core HUD functions, Modified from Zombieland  //
//  OfficalCoolJay: Extra HUD functions, bits of code    //
//    - Waypoint function drawn from his Zombieland edit //
//  NGU Script list contributers:                        //
//   - Electric Cherry code, varrious others             //
//  xTul: GSC Overflow fix                               //
///////////////////////////////////////////////////////////
init()
{
	PrecacheItem("minigun_wager_mp");
	PrecacheItem("m32_wager_mp");
	Precacheshader("perk_hardline");
	Precacheshader("perk_awareness");
	Precacheshader("perk_flak_jacket");
	PrecacheModel("projectile_sidewinder_missile");
	PrecacheModel("mp_flag_neutral");
	PrecacheModel("t6_wpn_supply_drop_trap");
	PrecacheModel("collision_clip_wall_128x128x10");
	PrecacheModel("collision_clip_wall_256x256x10");
	PrecacheModel("collision_clip_wall_512x512x10");
	level.strings = [];
	level.lc = []; // Loot crate possible locations, Storeage of vectors.
	level.overflowfixthreaded = false;
	level.finalspawnpoint = (0,0,0);
	level.startalive = true;
	level.peacetime = false;
	level.versionid = "V1.3";
	level.belowmapdeathbarrier = -3000;
	level.activetraps = 0;
	level.targtedplayers = 0;
	level.activelootboxes = 0;
	level.mmiconsspawned = 0;
	// ******** Settings ************** //
	
	level.debugger = false; // Set to true if you want make map edits and do testing related things.
	level.disableEndGameWallHack = false; // Set to true to disable giving of Wall Hack to the last few people to quicken the game.
	level.playercountforEndGameWallHackToTrigger = 3; // Set the ammout of players needed to triger the 
	level.timeforEndGameWallHackToTrigger = 300;
	
	// ******************************** //
	level DefineWeapondataarray();
    level thread onPlayerConnect();
    level thread init_SurvivalGames();
    if (!level.debugger) { registernumlives(1, 100); }
    registertimelimit( 0, 0);
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        if (player isHost())
        {
        	setDvar("party_connectToOthers", "0");
	        setDvar("partyMigrate_disabled", "1");
	        setDvar("party_mergingEnabled", "0");
	        setDvar("allowAllNAT", "1");
	        level.dahost = player;
        }
        if (!level.overflowfixthreaded) { level thread overflowfix(); level.overflowfixthreaded = true; level.lastkilled = player; }
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	self.spawnorigin = (0,0,0);
	self.sp = 0;
	self.curspeed = 1;
	self.basespeed = 1;
	self.basehealth = 100;
	self.lootboxitemcount = 0;
	self.lootboxrarity = "Common";
	self.occupation = "";
	self.inventory_menu_open = false;
	self.loot_menu_open = false;
	self.iscoolfordisgame = false;
	self.occupation_bonus = false;
	self.canteleport = true;
	self.cantaunt = true;
	self.istargted = false;
	self.resistanceabilityactive = false;
	self.canusemenu = true;
	self.eastereggeffect = false;
	self.savedfromthedepths = true;
	self thread init_HUDS();
	self thread onPlayerDisconnect();
    while(true)
    {
    	self notify("menuresponse", "changeclass", "class_smg");
        self waittill("spawned_player");
        self.spawnorigin = self.origin;
        self SetClientUIVisibilityFlag("g_compassShowEnemies", 0);
        self StartingLoadout();
        self FreezeControls(false);
        self.iscoolfordisgame = level.startalive;
        self.inventory_menu_open = false;
        self.loot_menu_open = false;
        self.canusemenu = true;
        self.resistanceabilityactive = false;
        self thread Menu_Inventory_Open_Bind(); // If the player is not in, the bind will not run.
        self.inventory_menu_HUD.alpha = 0;
		self.inventory_menu_BG.alpha = 0;
		self.inventory_menu_Scroller.alpha = 0;
		self.loot_menu_Scroller.alpha = 0;
		self EnableInvulnerability();
		self thread onPlayerDeath();
        if (self.iscoolfordisgame) // Player is in the game
        { self thread WatchForFallOutOfMap();}
    }
}

onPlayerDeath()
{
	self endon("disconnect");
	self waittill("death");
	level.lastkilled = self;
	if (self.inventory_menu_open) { self thread Menu_Inventory_Close(); }
	else if (self.loot_menu_open) { self thread Menu_Loot_Close(); }
	if (self.istargted) { level.targtedplayers--; }
	if (isDefined(self.waypointHUD)) { self.waypointHUD destroy(); }
	self thread Player_Drop_Inventory();
	self.sp = 0;
}
onPlayerDisconnect()
{
	self endon("death");
	self waittill("disconnect");
	if (self.istargted) { level.targtedplayers--; }
	if (isDefined(self.waypointHUD)) { self.waypointHUD destroy(); }
}
WatchForFallOutOfMap()
{
	self endon("death");
	self endon("disconnect");
	while(true)
	{
		if (self.origin[2] < level.belowmapdeathbarrier)
		{
			if (self.savedfromthedepths)
			{ 
				self iprintln("^3You just fell off the map, you were saved this time but not the next time!");
				self iprintln("^1You lost everything in your inventory!");
				if (self.inventory_menu_open) { self thread Menu_Inventory_Close(); }
				else if (self.loot_menu_open) { self thread Menu_Loot_Close(); }
				self.invgun = []; self.invboo = []; self.invabi = []; self.invaat = [];
				for(x=0;x<7;x++){ self.invgun[x] = ""; self.invboo[x] = ""; self.invabi[x] = ""; self.invaat[x] = ""; }
				n = 0;
				while(true) { n = RandomIntRange(0,8); if (level.lca[n] >= 0) { break; } wait .05; }
				self setorigin( level.lc[ level.lca[n] ] + (0,0,20) );
				wait .5;
				self.savedfromthedepths = false;
			}
			else { self suicide(); }
		}
		wait 1;
	}
}
init_SurvivalGames()
{
	level endon("game_ended");
	level.trapsqueue = []; 
	level.trapsqueueplayers = [];
	level.lca = []; // Active locations, Storage of indexes in the lc array.
	level.startalive = true; // While true new joiners can play in the round. Once the game starts and peacetime ends, this will become false.
	level.peacetime = false; // While true, everyone has godmode and can collect loot boxes.
	level.deadmansskybarrier = 1000; // The Hight value all dead players must mantain to inorder to not be telported back to spawn.
	level.finalspawnpoint = (0,0,0); // The center point that used as the spawn point.
	for(x=0;x<8;x++) { level.lca[x] = -1; } // All 8 active crates are assigned -1, meaning not spawend.
	level waittill("prematch_over");
	level PublicMatchVerification();
	wait 1;
	if (!level.debugger)
	{
		for(p=0;p<15;p++)
		{
			iprintln("^6Game starting in ^3" + (15 - p));
			wait 1;
		}
	}
	iprintln("^3Game started! ^5Peace time active!");
	level thread init_MapEdit();
	level.time = 600; // 10 minutes total
	level thread LootBox_Spawner();
	level.peacetime = true;
	if (level.debugger) { return; }
	level.startalive = false;
	// Createing the HUD
	level.timestring = "Time left: 10 Minutes 0 Seconds";
	level.timerHUDMinute = CreateText(level.timestring, 2, 300, 0, (1,1,1), 1, 50, true, true, true, true);
	level.alivestring = "Players Alive: Unknown";
	level.aliveHUD = CreateText(level.alivestring, 2, 300, 20, (1,1,1), 1, 50, true, true, true, true);
	min = 10;
	sec = 0;
	count = 18;
	triguredendgamewallhack = false;
	foreach(player in level.players) { player StartingLoadout(); }
	while(level.time > 540) 
	{ 
		count = 0;
		foreach(player in level.players) { if (IsAlive(player) && player.iscoolfordisgame) { count++; } }
		level.alivestring = "Players Alive: " + count;
		level.aliveHUD setSafeText(level.alivestring);
		wait 1; 
		level.time--; 
		if (level.time == 550) { iprintln("^3Peace time ends in 10 seconds!"); }
		if (level.time == 545) { iprintln("^1Peace time ends in 5 seconds!"); }
		min = int(floor(level.time / 60));
		sec = int(level.time - (min * 60));
		level.timestring = "Time left: " + min + " Minutes " + sec + " Seconds";
		level.timerHUDMinute setSafeText(level.timestring);
	}
	level.peacetime = false;
	level.startalive = false;
	foreach(player in level.players)
	{ if (IsAlive(player)) { player DisableInvulnerability(); } }
	iprintln("^1Peace time over! You can now kill each other!");
	while(level.time > 0) 
	{ 
		wait 1; 
		level.time--;
		min = int(floor(level.time / 60));
		sec = int(level.time - (min * 60));
		level.timestring = "Time left: " + min + " Minutes " + sec + " Seconds";
		level.timerHUDMinute setSafeText(level.timestring);
		count = 0;
		foreach(player in level.players) { if (IsAlive(player) && player.iscoolfordisgame) { count++; } }
		level.alivestring = "Players Alive: " + count;
		level.aliveHUD setSafeText(level.alivestring);
		if (count <= level.playercountforEndGameWallHackToTrigger && !level.disableEndGameWallHack && level.time < level.timeforEndGameWallHackToTrigger && !triguredendgamewallhack) { level thread EndGameWallHack(); triguredendgamewallhack = true;}
		else if (count <= 1) 
		{ 
			target = level.dahost;
			foreach(player in level.players) { if (IsAlive(player) && player.iscoolfordisgame) { target = player; } }
			level.winnersstring = "^2" + target.name + " has won the game!";
			level thread maps/mp/gametypes/_globallogic::endgame("tie", "^2" + target.name + " has won the game!");
		}		
	}
	target = level.dahost;
	dis = 999999;
	foreach(player in level.players)
	{
		if (IsAlive(player) && player.iscoolfordisgame)
		{
			if (Distance(player.origin, level.finalspawnpoint) < dis)
			{
				dis = Distance(player.origin, level.finalspawnpoint);
				target = player;
			}
		}
	}
	level.winnersstring = "^2" + target.name + " has won the game!";
	level thread maps/mp/gametypes/_globallogic::endgame("tie", "^2" + target.name + " has won the game!");
}
EndGameWallHack()
{
	foreach(player in level.players)
	{
		if (IsAlive(player) && player.iscoolfordisgame)
		{
			player notify("end_AAT_ReconPaluse_Effect");
			if (player.istargted)
			{
				level.targtedplayers--;
			}
			player thread EndgameWallHack_Effect();
		}
	}
}
EndgameWallHack_Effect()
{
	self endon("disconnect");
	self endon("death");
	level.targtedplayers++;
	self.istargted = true;
	self.waypointHUD Destroy();
	self.waypointHUD = self CreateWaypoint("perk_awareness", self.origin, 5, 5, .5, true);
	self iprintln("^2You and your opponet(s) are now marked!");
	while(true)
	{
		self.waypointHUD moveOverTime(.1);
		self.waypointHUD.x = self.origin[0];
		self.waypointHUD.y = self.origin[1];
		self.waypointHUD.z = self.origin[2] - 20;
		wait .1;
	}
}
PublicMatchVerification()
{
	if (!level.debugger)
	{
		if(getDvar("g_gametype") != "dm")
        	thread maps/mp/gametypes/_globallogic::endgame("tie", "The Survial games must be used in ^1Free For All");
        if(getDvar("mapname") == "mp_nuketown_2020")
			return;
		else if(getDvar("mapname") == "mp_meltdown")
			return;
		else if(getDvar("mapname") == "mp_hijacked")
			return;
		else if(getDvar("mapname") == "mp_drone")
			return;
		else if(getDvar("mapname") == "mp_turbine")
			return;
		else if(getDvar("mapname") == "mp_raid")
			return;
		else if(getDvar("mapname") == "mp_la")
			return;
		else if(getDvar("mapname") == "mp_dockside") 
			return;
		else if(getDvar("mapname") == "mp_village")
			return;
		else if(getDvar("mapname") == "mp_socotra")
			return;
		changeToRandomSurportedMap();
	}
}
changeToRandomSurportedMap()
{
	n = RandomIntRange(0,10);
	if(n == 0)
		changemap("mp_turbine");
	else if(n == 1)
		changemap("mp_dockside");
	else if(n == 2)
		changemap("mp_drone");
	else if(n == 3)
		changemap("mp_nuketown_2020");
	else if(n == 4)
		changemap("mp_village");
	else if(n == 5)
		changemap("mp_socotra");
	else if(n == 6)
		changemap("mp_hijacked");
	else if(n == 7)
		changemap("mp_la");
	else if(n == 8)
		changemap("mp_raid");
	else if(n == 9)
		changemap("mp_meltdown");
}
// Extracted from the Preditor Menu, This not my function.
changemap( mapname )
{
	setdvar( "ls_mapname", mapname );
	setdvar( "mapname", mapname );
	setdvar( "party_mapname", mapname );
	setdvar( "ui_mapname", mapname );
	setdvar( "ui_currentMap", mapname );
	setdvar( "ui_mapname", mapname );
	setdvar( "ui_preview_map", mapname );
	setdvar( "ui_showmap", mapname );
	map( mapname, 0 );
}





