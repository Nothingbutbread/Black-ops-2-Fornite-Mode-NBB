DeadMan_Spectate()
{
	self endon("disconnect");
	self hide();
	self SetClientUIVisibilityFlag("g_compassShowEnemies", 1);
	self iprintln("^1You're dead, Hold ADS to move around freely above the map!");
	obj = spawn("script_origin", self.origin);
	obj.angles = self.angles;
	self PlayerLinkTo(obj, undefined);
	while(true) 
	{
		if (self adsbuttonpressed()) 
		{ 
			obj moveTo(playerAnglesToForward(self, 50), 0.1); 
		}
		if (self.origin[2] < level.deadmansskybarrier)
		{
			obj moveTo((level.finalspawnpoint[0], level.finalspawnpoint[1], level.deadmansskybarrier + 100), 0.1); 
			// 
			self iprintln("^1You can not go there!");
			wait .1;
		}
		wait .1; 
	}
	self unlink();
    obj delete();
}

Host_Toggle_GodMode()
{
	if (!isDefined(self.godmode)){ self.godmode = false; }
	if (self.godmode)
	{
		self.godmode = false;
		self DisableInvulnerability();
		self iprintln("Godmode ^1Disabled");
		return;
	}
	self.godmode = true;
	self EnableInvulnerability();
	self iprintln("Godmode ^2Enabled");
}
Host_Toggle_Noclip(play)
{
    if (!isDefined(play)) { play = self; }
	if (play != self) { self iprintln("Toggled Noclip for " + play.name); }
	
	if (!isDefined(play.noclip)) { play.noclip = false; }
	if (!play.noclip)
	{
		play.noclip = true;
		play thread Dev_Noclip();
		play iprintln("Noclip ^2Enabled!. Press [{+gostand}] to move");
	}
	else
	{
		play.noclip = false;
		play iprintln("Noclip ^1Disabled!");
	}
}
Host_Toggle_OriginPrint()
{
	if (!isDefined(self.printorigin)) { self.printorigin = false; }
	if (self.printorigin)
	{
		self notify("stop_origin_printing");
		self.printorigin = false;
		self iprintln("Print Origin ^1Disabled!");
		return;
	}
	self thread getOrigin();
	self.printorigin = true;
	self iprintln("Print Origin ^2Enabled!");
}

Dev_Noclip()
{
	self endon("disconnect");
	obj = spawn("script_origin", self.origin);
	obj.angles = self.angles;
	self PlayerLinkTo(obj, undefined);
	while(self.noclip) { if (self jumpbuttonpressed()) { obj moveTo(playerAnglesToForward(self, 50), 0.1); } wait .1; }
	self unlink();
    obj delete();
}
getOrigin()
{
	self endon("disconnect");
	self endon("stop_origin_printing");
	while(true)
	{
		self iprintln(self.origin);
		wait 3;
	}
}
GiveCommonLootBox()
{
	self.loot = [];
	for(x=0;x<7;x++) { self.loot[x] = ""; }
	self Menu_Inventory_Close();
	self.inventory_menu_menu = 0;
	wait .1;
	self thread LB_Common();
}
GiveUncommonLootBox()
{
	self.loot = [];
	for(x=0;x<7;x++) { self.loot[x] = ""; }
	self Menu_Inventory_Close();
	self.inventory_menu_menu = 0;
	wait .1;
	self thread LB_Uncommon();
}
GiveRareLootBox()
{
	self.loot = [];
	for(x=0;x76;x++) { self.loot[x] = ""; }
	self Menu_Inventory_Close();
	self.inventory_menu_menu = 0;
	wait .1;
	self thread LB_Rare();
}













