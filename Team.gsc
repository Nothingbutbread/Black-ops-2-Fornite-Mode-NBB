// Client Calls
init_Teams_Client() {
	tag = self fetchClantag(self.name);
	if (tag.size >= 4) {
		self.teamtag += tag[1];
		self.teamtag += tag[2];
	}
}
OnPlayerDowned(attacker) {
	self endon("death");
	self endon("disconnect");
	self.fortshield = 0;
	self.forthealth = 100;
	self.downed = true;
	self disableWeapons();
	self updateControlsInfo("You must be revived to\nuse your inventory!");
	self setStance("prone");
	self setMoveSpeedScale(0.3);
	self closeInventory(true);
		
	tick = 0;
	while(self.forthealth > 0) {
		self setStance("prone");
		if (tick >= 7) {
			self.forthealth--;
			tick = 0;
		}
		tick++;
		wait .1;
	}
}
CarryOutReviving() {
	self endon("disconnect");
	self endon("death");
	while(true) {
		if (isDefined(self.closestally)) {
			if (Distance(self.closestally.origin, self.origin) < 60 && self.closestally.downed && self.inv[self.lastusedinvslotindex].isweapon && !startedreviving && !self.menuopen) {
				self fadeInItemToolTip("Hold [{+usereload}] to use revive " + self.closestally.name);
				if (self usebuttonpressed()) {
					self.ItemUseText = "Hold [{+usereload}] to use revive " + self.closestally.name;
					self.fortHUDS[15] setSafeText(self.ItemUseText);
					self.fortHUDS[16].bar.color = HUD_RTG(100, time);
					self fadeInProgressBar();
					self.fortHUDS[16] updateBar(0);
					time = 0;
					while(self usebuttonpressed() && Distance(self.closestally.origin, self.origin) < 60 && self.closestally.downed && self.inv[self.lastusedinvslotindex].isweapon && !startedreviving && !self.menuopen && time < 40) {
						self.fortHUDS[16] updateBar(time / 40);
						self.fortHUDS[16].bar.color = HUD_RTG(40, time);
						time++;
						wait .25;
					}
					if (time >= 39) {
						self.closestally thread OnPlayerRevived();
						self fadeOutItemToolTip();
						self fadeOutProgressBar();
						self iprintlnbold("Revive successful!");
					} else {
						self fadeOutProgressBar();
					}
				}
			} else {
				self fadeOutItemToolTip();
			}
		}
		wait .25;
	}
}
NearestTeammate() {
	self endon("disconnect");
	self endon("death");
	if (!isDefined(level.teamsmap[self.teamtag])) {
		return;
	}
	if (level.teamsmap[self.teamtag].size == 1) {
		return;
	}
	team = level.teamsmap[self.teamtag];
	while(true) {
		close = 999999;
		for(x = 0; x < team.size; x++) {
			if (team[x] != self) {
				if (Distance(self.origin, player.origin) < close && player.inthisgame) {
					self.closestally = player;
					close = Distance(self.origin, player.origin);
				}
			}
		}
		wait 1.25;
	}
}
OnPlayerRevived() {
	self.forthealth = 30;
	self.downed = false;
	self updateControlsInfo("[{+actionslot 1}] Open Menu");
	self enableWeapons();
	self setStance("stand");
	self setMoveSpeedScale(1);
}
shouldDealDamage(attacker) {
	if (attacker != self && attacker.teamtag == self.teamtag) {
		return false;
	}
	return true;
}
hasTeamatesAlive() {
	if (!isDefined(level.teamsmap[self.teamtag])) {
		return false;
	}
	for(x = 0; x < level.teamsmap[self.teamtag]; x++) {
		if (isDefined(level.teamsmap[self.teamtag][x])) {
			if (level.teamsmap[self.teamtag].inthisgame && !level.teamsmap[self.teamtag].downed) {
				return true;
			}
		}
	}
	return false;
}
// Level calls
// Forms the teamsmap array (where indexes are strings)
// This array is the refernce array for the teams, each index is an array of its members.
formTheTeams() {
	level.teamsmap = [];
	for(x = 0; x < level.players.size; x++) {
		if (isDefined(level.players[x])) {
			if (level.players[x].teamtag != "") {
				if (!isDefined(level.teamsmap[level.players[x].teamtag])) {
					level.teamsmap[level.players[x].teamtag] = [];
					level.teamsmap[level.players[x].teamtag][0] = level.players[x];
				} else if (level.maxperteam > level.teamsmap[level.players[x].teamtag].size) {
					level.teamsmap[level.players[x].teamtag][level.teamsmap[level.players[x].teamtag].size] = level.players[x];
				} else {
					// Too many players on that team, disableing that players team tag.
					level.players[x].teamtag = "";
				}
			}
		}
	}
}
personalPrintTeamMates() {
	if (self.teamtag != "") {
		for(x = 0; x < level.teamsmap[self.teamtag].size; x++) {
			if (level.teams[self.teamtag][x] != self) {
				self iprintln("^5" + level.teams[self.teamtag][x].name + " ^7is on your team!");
			}
		}
	} else {
		self iprintln("^1No one is on your team!");
	}
}
printAllTeams() {
	index = 1;
	foreach(team in level.teamsmap) {
		foreach(player in team) {
			iprintln("Team: " + index + " = ^5" + player.name);
		}
		index++;
	}
}
prepForTeamBasedFortnite() {
	if (!level.allowteams) {
		level.maxperteam = 1;
		return;
	}
	if (level.maxperteam < 2) {
		level.maxperteam = 2;
	}
	// Vars checked and cleaned.
	wait 15; // Wait to final 5 seconds of countdown, then prepare teams.
	iprintln("^3[Info]: ^7Preparing teams!");
	level formTheTeams();
	wait 15;
	// Now we check every 2 seconds to see if we have a winning team.
	// This should be completed after the loot locations have finished being generated.
	while(true) {
		aliveteams = 0;
		foreach(team in level.teamsmap) {
			foreach(player in team) {
				if (isDefined(player)) {
					if (player.inthisgame && !player.downed) {
						aliveteams++;
						break;
					}
				}
			}
			if (aliveteams >= 2) {
				break;
			}
		}
		if (aliveteams <= 1) {
			winningteam = "UNDEFINED TEAM";
			foreach(team in level.teamsmap) {
				foreach(player in team) {
					if (isDefined(player)) {
						if (player.inthisgame && !player.downed) {
							winningteam = player.teamtag;
							break;
						}
					}
				}
				if (winningteam != "UNDEFINED TEAM") {
					break;
				}
			}
			level thread maps/mp/gametypes/_globallogic::endgame("tie", "^2Team ^3" + winningteam + " ^6victory royal!");
		}
		wait 2;
	}
}
/*
	self.teamtag = "";
	self.downed = false;
	level.allowteams = false;
	level.maxperteam
*/