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

GiveTestInventory()
{
	for(x = 0; x < self.ammotypes.size; x++) {
		self.ammotypes[x] += 60;
	}
	i1 = createInventorySlotStruct();
	i1.weapon = "mp7_mp+silencer";
	i1.clip = 39;
	i1.rarity = 2;
	i1.ammotype = 0;
	i1.isweapon = true;
	i1.slotfilled = true;
	self addItemToInventory(0, i1);
	
	i2 = createInventorySlotStruct();
	i2.weapon = "Large Shield";
	i2.clip = 1;
	i2.rarity = 2;
	i2.ammotype = -1;
	i2.isweapon = false;
	i2.slotfilled = true;
	self addItemToInventory(1, i2);
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
        	player AdjustLoadout(0);
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
		self AdjustLoadout(0);
        self FreezeControls(true);
        self DisableInvulnerability(); 
	}
}
ToggleNoclip() {
	if (!isDefined(self.noclip)) {
		self.noclip = false;
	}
	if (self.noclip) {
		self.noclip = false;
		self iprintln("Noclip Disabled!");
	} else {
		self.noclip = true;
		self thread Noclip();
	}
}
Noclip() {
	obj = spawn("script_origin", self.origin);
	obj.angles = self.angles;
	self PlayerLinkTo(obj, undefined);
	while(self.noclip) 
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
DEBUG_PRINTITEMS(data) {
	for(x = 0; x < data.size; x++) {
		self iprintlnbold("Found index: ^5" + x + " !");
		self iprintln(self getFullDisplayName(data[x]));
		wait 1;
	}
}










