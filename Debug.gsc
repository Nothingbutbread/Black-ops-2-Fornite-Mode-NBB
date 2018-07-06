// All functions here are for debuging, should not be put into release versions.
GunFunctionsTest()
{
	self endon("death");
	self endon("disconnect");
	while(true)
	{
		self iprintln("Weapon: " + self getcurrentweapon());
		self iprintln("Mag: " + self getweaponammoclip(self getcurrentweapon()));
		self iprintln("Stock: " + self getweaponammostock(self getcurrentweapon()));
		self iprintln("Offhand: " + self getcurrentoffhand());
		wait 1;
	}
}
	// Types: 0 = Auto/Bust AR's, 1 = SemiAuto weapons (Snipers and FAL/SMR)
	// 2 = SMG, 3 = LMG/Death machine, 4 = Shotgun, 5 = Explosives (Launchers and Warmachines)
	// 6 = Pistols (not inculuding the executioner)
GiveTestInventory()
{
	for(x = 0; x < self.ammotypes.size; x++) {
		self.ammotypes[x] += 1000;
	}
	// addItemToInventory(index, weap, mag, rarity, ammotype, isweapon)
	addItemToInventory(1, "m32_wager_mp", 6, 4, 5, true);
	addItemToInventory(2, "dsr50_mp+dualclip", 0, 2, 1, true);
	addItemToInventory(3, "smaw_mp", 1, 2, 5, true);
	addItemToInventory(4, "fiveseven_mp", 14, 3, 6, true);
}
Test_GetShader()
{
	for(x = 0; x < 5; x++) {
		self iprintln("Testing Getshader() in " + x);
		wait 2;
	}
	self iprintln("In: srm1216_mp : Out: " + getItemShader("srm1216_mp"));
	wait 1;
	self iprintln("In: dsr50_mp+dualclip : Out: " + getItemShader("dsr50_mp+dualclip"));
	wait 1;
	self iprintln("In: as50_mp+extclip : Out: " + getItemShader("as50_mp+extclip"));
	wait 1;
	self iprintln("In: ballista_mp : Out: " + getItemShader("ballista_mp"));
	wait 1;
	self iprintln("In: minigun_wager_mp : Out: " + getItemShader("minigun_wager_mp"));
	wait 1;
	self iprintln("In: lsat_mp+steadyaim : Out: " + getItemShader("lsat_mp+steadyaim"));
}
printOrigin()
{
	self endon("death");
	self endon("disconnect");
	while(true){
		self iprintln(self.origin);
		wait 2;
	}
}
test123()
{
	self endon("death");
	self endon("disconnect");
	while(true) {
		self iprintlnbold("Chests active: " + level.chestsactive);
		wait 2;
	}
}
DammageTestBotSpawn() {
	foreach(player in level.players) {
		if (player is_bot())
        {
        	player AdjustLoadout(4);
        	player FreezeControls(true);
        	player thread FreezeBotOnSpawn();
        	player DisableInvulnerability(); 
        }
	}
}
FreezeBotOnSpawn() {
	self endon("disconnect");
	while(true) {
		self waittill("spawned_player");
		wait 1;
		self AdjustLoadout(4);
        self FreezeControls(true);
        self DisableInvulnerability(); 
	}
}
Noclip() {
	obj = spawn("script_origin", self.origin);
	obj.angles = self.angles;
	self PlayerLinkTo(obj, undefined);
	while(true) 
	{
		if (self adsbuttonpressed()) 
		{ 
			obj moveTo(playerAnglesToForward(self, 20), 0.05); 
		}
		wait .05; 
	}
	self unlink();
    obj delete();
}
/*
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
*/
DisToGroundChest() {
	self endon("death");
	while(true) {
		self iprintln("Distance to ground: " + self DisToGround());
		self iprintln("Angles: " + self.angles);
		wait 1;
	}
}
ForgePlacerTest() {
	self endon("death");
	while(true) {
		//self iprintln("Angle: " + self.angles);
		self iprintln("Dirrection: " + self PlayerGetDirrection());
		wait 1;
	}
}
VarPrinter() {
	self endon("death");
	while(true) {
		self iprintln("AT: " + self.activetype);
		self iprintln("I have " + self.ammotypes[self.activetype] + " ammo for this weapon");
		wait 2;
	}
}








