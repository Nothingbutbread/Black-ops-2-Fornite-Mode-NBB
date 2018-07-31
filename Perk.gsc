Perk_Speedcola()
{
	if (!self.zperks[0])
	{
		self.zperks[0] = true;
		self setperk("specialty_fastreload");
		self setperk("specialty_fastequipmentuse");
		self setperk("specialty_bulletflinch");
		self setperk("specialty_fasttoss");
		self setperk("specialty_fastweaponswitch");
		self iprintln("^2Speed Cola added!");
	}
	else { self iprintln("You were given a perk you already have.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }
}
Perk_Doubletap()
{
	if (!self.zperks[1])
	{
		self.zperks[1] = true;
		self setperk("specialty_rof");
		self setperk("specialty_fastads");
		self setperk("specialty_stalker");
		self iprintln("^2Double tap added!");
	}
	else { self iprintln("You were given a perk you already have.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }

}
Perk_Staminia_up()
{
	if (!self.zperks[2])
	{
		self.zperks[2] = true;
		self setperk("specialty_unlimitedsprint");
		self setperk("specialty_fastladderclimb");
		self setperk("specialty_fastmantle");
		self setperk("specialty_fastmeleerecovery");
		self setperk("specialty_fallheight");
		self setperk("specialty_movefaster");
		self setperk("specialty_nomotionsensor");
		self setperk("specialty_quieter");
		self iprintln("^2Stamina up added!");
	}
	else { self iprintln("You were given a perk you already have.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }

}
Perk_Scrounger()
{
	if (!self.zperks[3])
	{
		self.zperks[3] = true;
		self setperk("specialty_extraammo");
		self setperk("specialty_scavenger");
		self setperk("specialty_deadshot");
		self setperk("specialty_delayexplosive");
		self setperk("specialty_detectexplosive");
		self setperk("specialty_disarmexplosive");
		self iprintln("^2Scrounger added!");
	}
	else { self iprintln("You were given a perk you already have.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }

}
Perk_Resistance()
{
	if (!self.zperks[4])
	{
		self.zperks[4] = true;
		self setperk("specialty_fireproof");
		self setperk("specialty_flakjacket");
		self setperk("specialty_flashprotection");
		self setperk("specialty_immunecounteruav");
		self setperk("specialty_immuneemp");
		self setperk("specialty_immunemms");
		self setperk("specialty_immunenvthermal");
		self setperk("specialty_immunerangefinder");
		self setperk("specialty_stunprotection");
		self setperk("specialty_shellshock");
		self setperk("specialty_noname");
		self setperk("specialty_nottargetedbyairsupport");
		self setperk("specialty_nokillstreakreticle");
		self setperk("specialty_nottargettedbysentry");
		self iprintln("^2Resistance added!");
	}
	else { self iprintln("You were given a perk you already have.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }

}
Perk_Mulekick()
{
	if (!self.zperks[5])
	{
		self.zperks[5] = true;
		self GiveWeapon("knife_held_mp");
		self setperk("specialty_twogrenades");
		self setperk("specialty_twoprimaries");
		self iprintln("^2Mule kick added!");
	}
	else { self iprintln("You were given a perk you already have.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }
}
Perk_sixithsense()
{
	self endon("death");
	self endon("disconnect");
	self endon("perk_stop_sixithsense");
	if (!self.zperks[6])
	{
		self.zperks[6] = true;
		self iprintln("^26th Sense added!");
		while(self.zperks[6])
		{
			foundone = false;
			foreach(player in level.players)
			{
				if (isAlive(player) && Distance(player.origin, self.origin) < 350 && self != player && !foundone)
				{
					self iprintlnbold("^1Nearby players detected!");
					foundone = true;
				}
			}
			wait .5;
		}
	}
	else { self iprintln("You were given a perk you already have.\nThe hearty booster effect was trigerd instead");  self notify("booster_hearty"); self thread Booster_Hearty(); }

}
Reset_Perks()
{
	self.zperks = [];
	for(x = 0 ; x < 7; x++)
		self.zperks[x] = false;
}
Giveallperks()
{
	self ClearPerks();
	self setperk("specialty_bulletflinch");
	self setperk("specialty_bulletpenetration");
	self setperk("specialty_deadshot");
	self setperk("specialty_delayexplosive");
	self setperk("specialty_detectexplosive");
	self setperk("specialty_disarmexplosive");
	self setperk("specialty_earnmoremomentum");
	self setperk("specialty_explosivedamage");
	self setperk("specialty_extraammo");
	self setperk("specialty_fallheight");
	self setperk("specialty_fastads");
	self setperk("specialty_fastequipmentuse");
	self setperk("specialty_fastladderclimb");
	self setperk("specialty_fastmantle");
	self setperk("specialty_fastmeleerecovery");
	self setperk("specialty_fastreload");
	self setperk("specialty_fasttoss");
	self setperk("specialty_fastweaponswitch");
	self setperk("specialty_fireproof");
	self setperk("specialty_flakjacket");
	self setperk("specialty_flashprotection");
	self setperk("specialty_gpsjammer");
	self setperk("specialty_grenadepulldeath");
	self setperk("specialty_healthregen");
	self setperk("specialty_holdbreath");
	self setperk("specialty_immunecounteruav");
	self setperk("specialty_immuneemp");
	self setperk("specialty_immunemms");
	self setperk("specialty_immunenvthermal");
	self setperk("specialty_immunerangefinder");
	self setperk("specialty_killstreak");
	self setperk("specialty_longersprint");
	self setperk("specialty_loudenemies");
	self setperk("specialty_marksman");
	self setperk("specialty_movefaster");
	self setperk("specialty_nomotionsensor");
	self setperk("specialty_noname");
	self setperk("specialty_nottargetedbyairsupport");
	self setperk("specialty_nokillstreakreticle");
	self setperk("specialty_nottargettedbysentry");
	self setperk("specialty_pin_back");
	self setperk("specialty_pistoldeath");
	self setperk("specialty_proximityprotection");
	self setperk("specialty_quickrevive");
	self setperk("specialty_quieter");
	self setperk("specialty_reconnaissance");
	self setperk("specialty_rof");
	self setperk("specialty_scavenger");
	self setperk("specialty_showenemyequipment");
	self setperk("specialty_stunprotection");
	self setperk("specialty_shellshock");
	self setperk("specialty_sprintrecovery");
	self setperk("specialty_showonradar");
	self setperk("specialty_stalker");
	self setperk("specialty_twogrenades");
	self setperk("specialty_twoprimaries");
	self setperk("specialty_unlimitedsprint");
	self setmovespeedscale(1.2);
	self SetClientUIVisibilityFlag("g_compassShowEnemies", 1);
}





























