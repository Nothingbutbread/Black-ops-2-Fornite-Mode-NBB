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
	level.stormstartingradius = 25000;
	level.belowmapdeathbarrier = -3000;
	level.playersalive = 2;
	level.debugger = true;
	level.solidgold = false;
	level.blitz = false;
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
        	self.status = 3;
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
	self.inthisgame = false;
}
onDisconnect() {
	self endon("death");
	self endon("spawned_player");
	self waittill("disconnect");
	self DeleteAllCustomEntities();
	self.inthisgame = false;
}
gameManager()
{
	level endon("game_ended");
	level waittill("prematch_over");
	level thread init_MapEdit();
	if (level.debugger) {
		//level thread DammageTestBotSpawn();
		level thread LootSpawnerGeneator();
		level.entitiesperplayer = 30;
		return;
	}
	for(x = 20; x > 0; x--) {
		iprintln("Fortnite Battle Royal Starting in " + x + " seconds!");
		foreach(player in level.players) { 
			if (IsAlive(player)) { 
				player AdjustLoadout(0);
			}
		}
		wait 1;
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
	wait 6;
	level thread LootSpawnerGeneator();
	warnrad = level.stormstartingradius - 600;
	while(true) {
		level.playersalive = 0;
		foreach(player in level.players) {
			if (player.inthisgame) {
				level.playersalive++;
				d = Distance(player.origin, level.stormcenterpoint);
				if (d >= level.stormstartingradius) {
					player ApplyStormDammage();
				} else if (d >= warnrad) {
					player iprintlnbold("^3Get closer to the map or you will start to take damage!");
				}
				if (player.origin[2] < level.belowmapdeathbarrier) {
					if (player.unstuckability) {
						player setorigin(player.spawnorigin);
					} else {
						player suicide();
						iprintln(player.name + " fell out of the map!");
					}
				}
			}
		}
		level.gamestatestr = "Players Alive: " + level.playersalive + "\nStorm Width: " + level.stormstartingradius;
		foreach(player in level.players) {
			if (player.inthisgame) {
				player.fortHUDS[17] setSafeText(level.gamestatestr);
			}
		}
		if (level.blitz) {
			level.stormstartingradius -= 200;
			if (level.stormstartingradius < 1500) {
				level.stormstartingradius = 1500;
			}
		} else {
			level.stormstartingradius -= 80;
			if (level.stormstartingradius < 2400) {
				level.stormstartingradius = 2400;
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
	self.useinventorymod = 1;
	
	self.buildentites = [];
	self.activebuildindex = 0;
	self.hastodeleteentities = false;
	self.canbuild = false;
	self.lastplacedramp = false;
}
