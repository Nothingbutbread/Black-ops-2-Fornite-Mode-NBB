///////////////////////////////////////////////
//    Fortnite V1.6.0                        //
///////////////////////////////////////////////
//   Created by Nothingbutbread              //
///////////////////////////////////////////////
#include maps/mp/gametypes/_globallogic_score;
#include maps/mp/gametypes/_globallogic_utils;
#include maps/mp/_scoreevents;
#include maps/mp/teams/_teams;
#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/gametypes/_spawning;
#include maps/mp/killstreaks/_turret_killstreak;
#include maps/mp/gametypes/_globallogic_ui;

init()
{
	level.strings = [];
	level.chestspawnlocations = [];
	level.ammospawnlocations = [];
	level.spinningweaponlocations = [];
	level.supplydroplocations = [];
	level.activechests = 0;
	level.activeammodrops = 0;
	level.activespiningitems = 0;
	level.activespeicallootdrops = 0;
	level.stormcenterpoint = (0,0,0);
	level.stormstartingradius = 20000;
	level.stormcircles = (10000,4000,1000);
	level.belowmapdeathbarrier = -3000;
	level.playersalive = 2;
	// You Can Change these:
	level.versionID = "^11.5.2 Public Beta";
	level.debugger = false;
	level.solidgold = false;
	level.blitz = false;
	level.fantasy = false;
	level.flyexplosives = false;
	level.snipershootout = false;
	// Do not change anything else ...
	level.mapcustomentitylimit = 440;
	level.entitiesperplayer = 30;
	level.hostinHostMenu = 0; // Must be 0 or lower for the game to finish initing. 
	// When the host is in menu, is set to greater than 1, then set back to 0 when he is out.
	level PrecacheAll();
    level thread onPlayerConnect();
    level thread gameManager();
    if (!level.debugger) { 
    	registernumlives(1, 999999); 
    }
    registertimelimit( 0, 0);
}

onPlayerConnect()
{
    while(true) {
        level waittill("connected", player);
        if (player isHost()) {
        	setDvar("party_connectToOthers", "0");
	        setDvar("partyMigrate_disabled", "1");
	        setDvar("party_mergingEnabled", "0");
	        setDvar("allowAllNAT", "1");
	        level.debuggerhost = player;
	        level.hostclantag = fetchClantag(player.name);
        }
        if (!level.overflowfixthreaded) { 
        	level thread overflowfix(); 
        	level.overflowfixthreaded = true;
        }
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");
	level endon("game_ended");
	self init_player_vars();
	self thread CreatePlayerHUDS();
	self.inthisgame = false;
	level.disableweapondrop = true;
    while(true) {
    	self notify("menuresponse", "changeclass", "class_smg");
        self waittill("spawned_player");
        self.spawnorigin = self.origin;
        self thread onDisconnect();
		self thread onDeath();
        self FreezeControls(false);
        self.inthisgame = true;
        if (level.debugger) {
        	self.status = 3;
        	self thread PatchThread();
        	//self thread VarPrinter();
        	//self GiveTestInventory();
        	self thread printOrigin();
        }
        self AdjustLoadout(0);
        self EnableInvulnerability();
        
        //self setclientthirdperson(1);
        self setclientuivisibilityflag("hud_visible", 1);
        self thread DamageMonitor();
    }
}
onDeath() {
	self endon("disconnect");
	self endon("spawned_player");
	self waittill("death");
	self DeleteAllCustomEntities();
	self thread SpawnPlayerDeathDrop();
	self.inthisgame = false;
}
onDisconnect() {
	self endon("death");
	self endon("spawned_player");
	self waittill("disconnect");
	self DeleteAllCustomEntities();
	self.inthisgame = false;
}
printIntro() {
	iprintln("^2This is ^5Fortnite Battle Royal ^3V" + level.versionID);
	wait 2;
	iprintln("^2Developed by: ^6Nothingbutbread");
	wait 1;
	iprintln("^3If you enjoy this gamemode, Subscribe to the developer on ^1Youtube");
	iprintln("^5www.youtube.com/channel/4Nothingbutbread4");
	wait 3;
	iprintln("^3Thank you, and have a awesome match!");
}
gameManager() {
	level endon("game_ended");
	level waittill("prematch_over");
	level UnpackageAndSetSettings();
	wait .5;
	level PublicMatchVerification();
	wait .5;
	level thread init_MapEdit();
	level StormCenterIcon();
	if (level.debugger) {
		level thread DammageTestBotSpawn();
		level thread LootSpawnerGeneator();
		level.entitiesperplayer = 200;
		level.hostinHostMenu = -1;
		//level thread printIntro();
		//return;
	}
	level thread onGameEnded();
	for(x = 20; x > 0; x--) {
		iprintln("Fortnite Battle Royal Starting in " + x + " seconds!");
		foreach(player in level.players) { 
			if (IsAlive(player)) { 
				player AdjustLoadout(0);
			}
		}
		if (level.debugger) {
			//return;
			break;
		}
		wait 1;
	}
	while(level.hostinHostMenu > 0) {
		iprintln("Waiting for host to finish editing game settings!");
		wait 1;
	}
	level.hostinHostMenu = -1;
	if (level.debugger) {
		return;
	}
	iprintln("^6All aboard the battle bus!");
	wait 1;
	level thread TeleportToBattleBus();
	initcount = 0;
	foreach(player in level.players) { 
		if (IsAlive(player)) { 
			player DisableInvulnerability(); 
			player AdjustLoadout(0);
			initcount++;
		} 
	}
	level.entitiesperplayer = int(level.mapcustomentitylimit / initcount);
	level.playersalive = initcount;
	wait 1;
	foreach(player in level.players) { 
		if (IsAlive(player)) { 
			player DisableInvulnerability(); 
			player AdjustLoadout(0);
			player.forthealth = 100;
			player.fortshield = 0;
		} 
	}
	wait 3;
	level thread LootSpawnerGeneator();
	if (level.debugger) {
		return;
	}
	stormid = -1;
	stormmove = false;
	stormdelay = stormDelayAmmout(0);
	stormdamage = stormDammageAmmout(0);
	tick = 0;
	while(true) {
		if (tick == 30) {
			iprintln("^5[Anoucement] ^3Stuck? Open the menu and use the unstuck command");
		} else if (tick == 60) {
			iprintln("^5[Anoucement] ^3This is Fortnite V" + level.versionID + " Developed by Nothingbutbread");
		} else if (tick == 100) {
			tick = 0;
			iprintln("^5[Anoucement] ^3Lots of loot is often found inside the map and on outskirts of the out-of-map.");
		}
		playersalivee = 0;
		foreach(player in level.players) {
			if (player.inthisgame) {
				playersalivee++;
				d = DistanceToStormCol(player);
				if (d >= level.stormstartingradius) {
					player ApplyStormDammage(stormdamage);
				}
				if (player.origin[2] < level.belowmapdeathbarrier) {
					if (player.unstuckability) {
						player setorigin(player.spawnorigin);
						player.unstuckability = false;
					} else {
						iprintln(player.name + " fell out of the map!");
						player killMySelf();
						playersalivee--;
					}
				}
				if (player.forthealth <= 0) {
					player killMySelf();
					playersalivee--;
				}
			}
		}
		level.playersalive = playersalivee;
		///////////////////////////////////
		if (stormmove) {
			if (level.blitz) {
				level.stormstartingradius -= 180;
			} else {
				level.stormstartingradius -= 80;
			}
			if (stormid < 3) {
				if (level.stormstartingradius < level.stormcircles[stormid]) {
					level.stormstartingradius = level.stormcircles[stormid];
					stormmove = false;
				}
			} else {
				if (level.stormstartingradius < 150) {
					level.stormstartingradius = 150;
					stormmove = false;
				}
			}
			stormdelay = stormDelayAmmout(stormid);
			stormdamage = stormDammageAmmout(stormid);
		} else if (stormid < 3) {
			stormdelay--;
			if (stormdelay <= 0) {
				iprintln("^1The Storm Eye is Shrinking!");
				stormid++;
				stormmove = true;
			}
		}
		tick++;
		wait 1;
	}
}
onGameEnded() {
	level waittill("game_ended"); 
	playersalivee = 0;
	nameofwinner = "";
	foreach(player in level.players) {
		if (player.inthisgame) {
			playersalivee++;
			nameofwinner = player.name;
		}
	}
	if (playersalivee == 1) {
		// SpawnText(item, fontScale, x, y, color, alpha, sort, text, allpeeps, foreground, normal)
		tmp = level SpawnText("^5" + nameofwinner + " ^2Victory Royal!", 3, 260,150, (1,1,1), 1, 100, true, true, true, true);
	}
}
init_player_vars()
{
	self.inv = self createInventory();
	self.ammotypes = [];
	for(x = 0; x < 5; x++) { 
		self.ammotypes[x] = 0; 
	}
	
	self.lastusedinvslotindex = 0;
	self.activeweapon = "knife_held_mp";
	self.activerarity = 0;
	self.activetype = 0;
	self.amholdinggun = true;
	
	self.forthealth = 100;
    self.fortshield = 0;
    
    self.selectorpos = 0;
    self.menuselectorpos = 0;
	self.curmenu = 0;
	self.menuopen = false;
	
	self.status = 0;
	self.spawnorigin = (0,0,0);
	self.canteleport = true;
	self.unstuckability = true;
	
	self.buildentites = [];
	self.activebuildindex = 0;
	self.hastodeleteentities = false;
	self.canbuild = false;
	self.lastplacedramp = false;
	self.lastdammagedby = self;
	self.lastdammagedbyWeapon = "knife_mp";
	self.hasjetpack = false;
}

PublicMatchVerification() {
	if (!level.debugger) {
		if (getDvar("g_gametype") != "dm") {
        	//thread maps/mp/gametypes/_globallogic::endgame("tie", "The Fortnite Gamemode must be used in ^1Free For All");
        	iprintln("^1Warning: ^7This Gamemode is not surported, ^3This may cause unwanted issues!");
        	iprintln("^1Warning: ^7Continue playing at your own risk!");
        }
        if (getDvar("mapname") == "mp_dockside") {
			return;
		} else if(getDvar("mapname") == "mp_village") {
			return;
		} else if (getDvar("mapname") == "mp_drone") {
			return;
		} else if (getDvar("mapname") == "mp_socotra") {
			return;
		} else if (getDvar("mapname") == "mp_nuketown_2020") {
			return;
		} else if (getDvar("mapname") == "mp_socotra") {
			return;
		} else if (getDvar("mapname") == "mp_nightclub") {
			return;
		}
		// If we haven't returned at this point, then we have an invalid map but valid gamemode.
		// Randomly selecting and changing to a valid map.
		n = RandomIntRange(0,7);
		if (n == 0) {
			changemap("mp_dockside");
		} else if(n == 1) {
			changemap("mp_village");
		} else if(n == 2) {
			changemap("mp_drone");
		} else if(n == 3) {
			changemap("mp_socotra");
		} else if(n == 4) {
			changemap("mp_nuketown_2020");
		} else if(n == 5) {
			changemap("mp_socotra");
		} else if(n == 6) {
			changemap("mp_nightclub");
		}
	}
}
// Extracted from the Preditor Menu, This not my function.
changemap( mapname ) {
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































