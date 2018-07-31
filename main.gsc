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
	level.versionID = "^11.1.4 Public Beta";
	level.debugger = true;
	level.solidgold = false;
	level.blitz = false;
	// DO NOT ENABLE TEAMS IN THIS VERSION, UNSTABLE!!!!!
	level.allowteams = false;
	level.maxperteam = 2; // Setting to < 2 will result it being set to 2;
	// Do not change anything else ...
	level.mapcustomentitylimit = 440;
	level.entitiesperplayer = 30;
	level.gamestatestr = "Players Alive: Unknown\nStorm Width: 25000";
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
        	//self.status = 3;
        	//self thread VarPrinter();
        	//self GiveTestInventory();
        	//self thread printOrigin();
        }
        self AdjustLoadout(0);
        self EnableInvulnerability();
        
        //self setclientthirdperson(1);
        //self setclientuivisibilityflag("hud_visible", 1);
        self thread DamageMonitor();
        self thread WeaponMod_RefreshStock();
    }
}
onDeath() {
	self endon("disconnect");
	self endon("spawned_player");
	self waittill("death");
	self DeleteAllCustomEntities();
	//self thread SpawnPlayerDeathDrop();
	self thread DeathandDisconnectCheckTeamDownedPlayers();
	self.inthisgame = false;
}
onDisconnect() {
	self endon("death");
	self endon("spawned_player");
	self waittill("disconnect");
	self DeleteAllCustomEntities();
	self thread DeathandDisconnectCheckTeamDownedPlayers();
	self.inthisgame = false;
}
printIntro() {
	iprintln("^2This is ^5Fortnite Battle Royal ^3V" + level.versionID);
	wait 2;
	iprintln("^2Developed by: ^6Nothingbutbread");
	wait 1;
	iprintln("^3If you enjoy this gamemode, Subscribe to the developer on ^1Youtube");
	iprintln("^5https://www.youtube.com/channel/UCkoRr0Ye4If_Wc24KQBgloQ");
	wait 3;
	iprintln("^3Thank you, and have a awesome match!");
	iprintln("^5Features such as teaming, new weapons and mapedits coming in the next update!");
	wait 4;
	iprintln("^1Note to host: ^3If this download was obtained via an adfly link");
	iprintln("^3Please report the person who provided it to ^6Nothingbutbread");
}
gameManager()
{
	level endon("game_ended");
	level waittill("prematch_over");
	level thread init_MapEdit();
	if (level.debugger) {
		//level thread DammageTestBotSpawn();
		//level thread LootSpawnerGeneator();
		//level.entitiesperplayer = 200;
		//level thread printIntro();
		//return;
	}
	level thread prepForTeamBasedFortnite();
	for(x = 20; x > 5; x--) {
		iprintln("Fortnite Battle Royal Starting in " + x + " seconds!");
		foreach(player in level.players) { 
			if (IsAlive(player)) { 
				player AdjustLoadout(0);
			}
		}
		wait 1;
	}
	wait 5;
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
	wait 6;
	level thread LootSpawnerGeneator();
	if (level.debugger) {
		//return;
	}
	warnrad = level.stormstartingradius - 500;
	stormid = -1;
	stormmove = false;
	stormdelay = stormDelayAmmout(0);
	stormdamage = stormDammageAmmout(0);
	while(true) {
		level.playersalive = 0;
		foreach(player in level.players) {
			if (player.inthisgame) {
				level.playersalive++;
				d = Distance(player.origin, level.stormcenterpoint);
				if (d >= level.stormstartingradius) {
					player ApplyStormDammage(stormdamage);
				} else if (d >= warnrad) {
					player iprintlnbold("^3Get closer to the map or you will start to take damage!");
				}
				if (player.origin[2] < level.belowmapdeathbarrier) {
					if (player.unstuckability) {
						player setorigin(player.spawnorigin);
					} else {
						player killMySelf();
						iprintln(player.name + " fell out of the map!");
					}
				}
				if (player.forthealth <= 0) {
					player killMySelf();
				}
			}
		}
		level.gamestatestr = "Players Alive: " + level.playersalive + "\nStorm Width: " + level.stormstartingradius;
		foreach(player in level.players) {
			if (player.inthisgame) {
				player.fortHUDS[17] setSafeText(level.gamestatestr);
			}
		}
		///////////////////////////////////
		if (stormmove) {
			//iprintln("DEBUG 1");
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
			//iprintln("DEBUG 2");
			stormdelay--;
			if (stormdelay <= 0) {
				iprintln("^1The Storm Eye is Shrinking!");
				stormid++;
				stormmove = true;
			}
		}
	
		wait 1;
		warnrad = level.stormstartingradius - 750;
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
	self.canteleport = true;
	self.spawnorigin = (0,0,0);
	self.unstuckability = true;
	
	self.buildentites = [];
	self.activebuildindex = 0;
	self.hastodeleteentities = false;
	self.canbuild = false;
	self.lastplacedramp = false;
	self.lastdammagedby = self;
	//V1.2 Update
	self.teamtag = "";
	self.isonteam = false;
	self.downed = false;
	self.closestally = self;
	self.isbeingrevived = false;
	if (level.allowteams) {
		self init_Teams_Client();
	}
}






