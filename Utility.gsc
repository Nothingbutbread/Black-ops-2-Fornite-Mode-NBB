// Returns a color vector for a speific ID.
teirIDToColor(id)
{
	if (id == 0) { return (0.56,0.604,0.682); }
	else if (id == 1) { return (0.027,0.737,0.38); }
	else if (id == 2) { return (0.082,0.655,0.875); }
	else if (id == 3) { return (0.596,0.208,0.769); }
	return (0.871,0.4,0.075);
}
teirIDtoCamo(id)
{
	if (id == 0) { return 1; }
	else if (id == 1) { return 44; }
	else if (id == 2) { return 29; }
	else if (id == 3) { return 15; }
	return 16;
}
teirIDToStringColor(id)
{
	if (id == 0) { return "^7"; }
	else if (id == 1) { return "^2"; }
	else if (id == 2) { return "^5"; }
	else if (id == 3) { return "^6"; }
	return "^1";
}
removeColorCode(str) {
	if (str.size < 3) { return str; }
	if (str[0] == "^") {
		retval = "";
		for(x = 2; x < str.size; x++) {
			retval += str[x];
		}
		return retval;
	}
	return retval;
}
getItemShader(weap)
{
	// Burst rifle
	if (weap == "sig556_mp" || weap == "sig556_mp+stalker") {
		return "menu_mp_weapons_sig556";
	}
	// Auto rifle
	else if (weap == "scar_mp" || weap == "scar_mp+extclip") {
		return "menu_mp_weapons_scar";
	}
	// Scoped rifle
	else if (weap == "sa58_mp+acog") {
		return "menu_mp_weapons_sa58";
	}
	// Tatical SMG
	else if (weap == "insas_mp" || weap == "insas_mp+stalker") {
		return "menu_mp_weapons_insas";
	}
	// Silenced SMG
	else if (weap == "mp7_mp+silencer") {
		return "menu_mp_weapons_mp7";
	}
	// Revolver / Hand Canon
	else if (weap == "fnp45_mp+dualclip" || weap == "fnp45_mp+dualclip+fmj") {
		return "menu_mp_weapons_fnp45";
	}
	// pistol
	else if (weap == "fiveseven_mp" || weap == "fiveseven_mp+silencer") {
		return "menu_mp_weapons_five_seven";
	}
	// Pumpaction Shotgun
	else if (weap == "ksg_mp"){
		return "menu_mp_weapons_ksg";
	}
	// Assuming 8 pelets, Tatical Shotgun
	else if (weap == "870mcs_mp+extbarrel"){
		return "menu_mp_weapons_870mcs"; // 8 may be more accurate but 9 to keep the dammage consitant.
	}
	// Assuming 8 pelets, heavy shotgun .. Dammage at Gold end is VERY high
	else if (weap == "srm1216_mp") {
		return "menu_mp_weapons_srm";
	}
	// Bolt action sniper
	else if (weap == "dsr50_mp+dualclip") {
		return "menu_mp_weapons_dsr1";
	}
	// Semi-auto sniper
	else if (weap == "as50_mp+extclip") {
		return "menu_mp_weapons_as50";
	}
	// Hunting Rifle
	else if (weap == "ballista_mp+is") {
		return "menu_mp_weapons_ballista";
	}
	// Minigun
	else if (weap == "minigun_wager_mp") {
		return "hud_icon_minigun";
	}
	// LMG
	else if (weap == "lsat_mp+steadyaim") {
		return "menu_mp_weapons_lsat";
	}
	// Rocket Launcher
	else if (weap == "smaw_mp") {
		return "menu_mp_weapons_smaw";
	}
	// Grenade Launcher
	else if (weap == "m32_wager_mp") {
		return "hud_grenade_launcher";
	}
	// Grenade
	else if (weap == "frag_grenade_mp") {
		return "hud_grenadeicon";
	}
	// Clinger
	else if (weap == "sticky_grenade_mp") {
		return "hud_icon_sticky_grenade";
	}
	// Remote Explosives
	else if (weap == "satchel_charge_mp") {
		return "hud_icon_c4";
	}
	else if (weap == "Bandage") {
		return "perk_scavenger";
	}
	else if (weap == "Medkit") {
		return "perk_hardline";
	}
	else if (weap == "Small Shield") {
		return "perk_tactical_mask";
	}
	else if (weap == "Large Shield") {
		return "perk_flak_jacket";
	}
	else if (weap == "Slurp Juice") {
		return "perk_awareness";
	}
	else if (weap == "Chug Jug") {
		return "perk_warrior";
	}
	return "menu_mp_weapons_ballistic_knife";
}
SetandChangeInventoryToDefaultWeapon(index) {
	//self iprintln("Attempted to Delete item at index: " + index);
	self DeleteItemInInventory(index);
	self.activeweapon = "knife_held_mp";
	self.activerarity = 0;
	self.activetype = 0;
	self.amholdinggun = true;
	self AdjustLoadout(index);
	self updateInvHudShader(index, 0, "knife_held_mp");
	//self iprintln(self.fortHUDS[index].color);
}
DeleteItemInInventory(index) {
	self.inv[index][0] = "knife_held_mp";
	self.inv[index][1] = "0";
	self.inv[index][2] = "0";
	self.inv[index][3] = "0";
	self.inv[index][4] = "t";
}
IsEmpty(index) {
	if (self.inv[index][0] != "knife_held_mp" || self.inv[index][1] != "0" || self.inv[index][2] != "0" || self.inv[index][3] != "0" || self.inv[index][4] != "t"){ 
		return false;
	}
	return true;
}
SetLoadout(id) 
{
	self notify("new_item_at_" + id);
	self TakeAllWeapons();
   	self ClearPerks();
   	self fadeOutItemToolTip();
   	//self.fortHUDS[16] destroyElem();
   	self fadeOutProgressBar();
   	self SetActionSlot(1, "");
	self SetActionSlot(2, "");
	self SetActionSlot(3, "");
	self SetActionSlot(4, "");
	self setperk("specialty_unlimitedsprint");
	self setperk("specialty_fastweaponswitch");
	self setperk("specialty_fallheight");
	//self setclientthirdperson(1);
	self.lastusedinvslotindex = id;
	self.activeweapon = self.inv[id][0];
	self.activerarity = int(self.inv[id][2]);
	self.activetype = int(self.inv[id][3]);
	if (self.activeweapon == "frag_grenade_mp" || self.activeweapon == "sticky_grenade_mp" || self.activeweapon == "satchel_charge_mp") {
		//self iprintln("Tried to add a grenade: " + self.activeweapon);
		self.amholdinggun = false;
		self giveWeapon("knife_held_mp",0,true(teirIDtoCamo(4),0,0,0,0));
		self thread GrenadeInventoryUpdator(self.activeweapon, id);
		
	} else if (self.inv[id][4] == "t") {
		//self iprintln("Weapon ran!");
		self.amholdinggun = true;
		if (isSingleShot(self.activeweapon)) {
			self thread WeaponMod_SingleShot(self.activeweapon, id);
		} /*
		else if (isScropedNotSniper(self.activeweapon)) {
			self thread WeaponMod_Scoped(self.activeweapon, id);
		} */
		self giveWeapon(self.activeweapon,0,true(teirIDtoCamo(int(self.inv[id][2])),0,0,0,0));
	} else {
		//self iprintln("Item ran!");
		self.amholdinggun = false;
		self giveWeapon("knife_held_mp");
		self thread ActivateItem(id);
	}
	self giveWeapon("knife_mp");
	self SwitchToWeapon(self.activeweapon);
	if (!self.amholdinggun) {
		return;
	}
	// Setting ammo 
	self giveMaxAmmo(self.activeweapon);
	maxstock = self getweaponammostock(self.activeweapon);

	self setWeaponAmmoClip(self.activeweapon, int(self.inv[id][1]));
	ammo = self.ammotypes[int(self.inv[id][3])];
	if (ammo > maxstock)
	{
		self.ammotypes[int(self.inv[id][3])] -= maxstock;
		self setWeaponAmmoStock(self.activeweapon, maxstock);
	}
	else 
	{ 
		self.ammotypes[int(self.inv[id][3])] = 0;
		self setWeaponAmmoStock(self.inv[id][0], ammo);
	}
}
// Adjusts the players loadout from inventory index.
AdjustLoadout(id)
{
	self notify("new_item_at_" + id);
	if (id < 0 || id > 4) { self iprintln("^1Error: AdjustLoadout invalid index"); return; }
	// 0 = Weapon, 1 = Clip, 2 = Rarity, 3 = Type
	if (self.inv[id][0] == "") { self iprintln("^1Error: Tried to change to a null weapon!\n^1Reset it!");
		wait .5;
		self thread SetandChangeInventoryToDefaultWeapon(id);
		return;
	}
	
	// Good to go, all prelimarly checks completed!
	if (self.lastusedinvslotindex >= 0)
	{
		if (self.inv[id][4] == "t" && self.amholdinggun) {
			self.ammotypes[self.activetype] += self getweaponammostock(self.activeweapon);
			self.inv[self.lastusedinvslotindex][0] = self.activeweapon;
			self.inv[self.lastusedinvslotindex][1] = "" + self getweaponammoclip(self.activeweapon);
			self.inv[self.lastusedinvslotindex][2] = "" + self.activerarity;
			self.inv[self.lastusedinvslotindex][3] = "" + self.activetype;
		} else { // We are not dealing with guns here ... grenades and items ...
			self.inv[self.lastusedinvslotindex][0] = self.activeweapon;
			self.inv[self.lastusedinvslotindex][2] = "" + self.activerarity;
		}
	}
	SetLoadout(id);
}

// Takes a size value and two intergers for the range.
// Returns an array of values that fall in the range and are unique.
RandIntArrayNoDupe(size, min, max)
{
	nums = [];
	if ((max - min) < size) { return nums; } // When the size is larger than the range, the function breaks.
	while(nums.size < size)
	{
		n = RandomIntRange(min, max);
		x = 0;
		while(x < nums.size)
		{
			if (nums[x] == n)
			{ 
				n++;
				if (n >= max) { n = min; }
				x = 0;
			}
			else { x++; }
		}
		nums[nums.size] = n;
	}
	return nums;
}
isAWeapon(weap)
{
	w = getRawWeapon(weap);
	if (w.size < 3) { return false; }
	start = w.size - 3;
	test = "";
	test += w[start];
	test += w[start + 1];
	test += w[start + 2];
	if (test == "_mp") { return true; }
	return false;
}
isAGun(weap) {
	if (isAWeapon(weap)) {
		if (weap == "frag_grenade_mp" || weap == "sticky_grenade_mp" || weap == "satchel_charge_mp") {
			return false;
		}
		return true;
	}
	return false;
}
getDisplayName(weap)
{
	if (weap == "sig556_mp") {
		return "Burst Assult Rifle";
	}
	else if (weap == "sig556_mp+stalker") {
		return "Famas";
	}
	// Auto rifle
	else if (weap == "scar_mp") {
		return "Automatic Assult Rifle";
	}
	else if (weap == "scar_mp+extclip") {
		return "ScarH";
	}
	// Scoped rifle
	else if (weap == "sa58_mp+acog") {
		return "Scoped Rifle";
	}
	// Tatical SMG
	else if (weap == "insas_mp" || weap == "insas_mp+stalker") {
		return "Tatical Submachine Gun";
	}
	// Silenced SMG
	else if (weap == "mp7_mp+silencer") {
		return "Silenced Submachine Gun";
	}
	// Revolver / Hand Canon
	else if (weap == "fnp45_mp+dualclip") {
		return "Revolver";
	}
	else if (weap == "fnp45_mp+dualclip+fmj") {
		return "Hand Cannon";
	}
	// pistol
	else if (weap == "fiveseven_mp") {
		return "Pistol";
	}
	else if (weap == "fiveseven_mp+silencer") {
		return "Silenced Pistol";
	}
	// Pumpaction Shotgun
	else if (weap == "ksg_mp"){
		return "Pumpaction Shotgun";
	}
	// Assuming 8 pelets, Tatical Shotgun
	else if (weap == "870mcs_mp+extbarrel"){
		return "Tatical Shotgun"; // 8 may be more accurate but 9 to keep the dammage consitant.
	}
	// Assuming 8 pelets, heavy shotgun .. Dammage at Gold end is VERY high
	else if (weap == "srm1216_mp") {
		return "Heavy Shotgun";
	}
	// Bolt action sniper
	else if (weap == "dsr50_mp+dualclip") {
		return "Bolt-action Sniper";
	}
	// Semi-auto sniper
	else if (weap == "as50_mp+extclip") {
		return "Semi-automatic Sniper";
	}
	// Hunting Rifle
	else if (weap == "ballista_mp+is") {
		return "Hunting Rifle";
	}
	// Minigun
	else if (weap == "minigun_wager_mp") {
		return "Minigun";
	}
	// LMG
	else if (weap == "lsat_mp+steadyaim") {
		return "Light Machine Gun";
	}
	// Rocket Launcher
	else if (weap == "smaw_mp") {
		return "Rocket Launcher";
	}
	// Grenade Launcher
	else if (weap == "m32_wager_mp") {
		return "Grenade Launcher";
	}
	// Grenade
	else if (weap == "frag_grenade_mp") {
		return "Grenade";
	}
	// Clinger
	else if (weap == "sticky_grenade_mp") {
		return "Clinger";
	}
	// Remote Explosives
	else if (weap == "satchel_charge_mp") {
		return "Remote Explosives";
	}
    return weap;
}
getAmmoType(weap)
{
	// Type: 0 Small bullets  (SMGs, SemiAuto Pistols, Minigun)
	// Type: 1 Medium bullets (ARs, LMG, Revolovers/Hand Cannon) 
	// Type: 2 Large bullets (Snipers, Semiauto riffle)
	// Type: 3 Shotgun shells (Shotguns)
	// Type: 4 Explosive Shells (RPG/War Machine) 
	// Burst rifle
	if (weap == "sig556_mp" || weap == "sig556_mp+stalker") {
		return 1;
	}
	// Auto rifle
	else if (weap == "scar_mp" || weap == "scar_mp+extclip") {
		return 1;
	}
	// Scoped rifle
	else if (weap == "sa58_mp+acog") {
		return 1;
	}
	// Tatical SMG
	else if (weap == "insas_mp" || weap == "insas_mp+stalker") {
		return 0;
	}
	// Silenced SMG
	else if (weap == "mp7_mp+silencer") {
		return 0;
	}
	// Revolver / Hand Canon
	else if (weap == "fnp45_mp+dualclip" || weap == "fnp45_mp+dualclip+fmj") {
		return 2;
	}
	// pistol
	else if (weap == "fiveseven_mp" || weap == "fiveseven_mp+silencer") {
		return 0;
	}
	// Pumpaction Shotgun
	else if (weap == "ksg_mp"){
		return 3;
	}
	// Assuming 8 pelets, Tatical Shotgun
	else if (weap == "870mcs_mp+extbarrel"){
		return 3; // 8 may be more accurate but 9 to keep the dammage consitant.
	}
	// Assuming 8 pelets, heavy shotgun .. Dammage at Gold end is VERY high
	else if (weap == "srm1216_mp") {
		return 3;
	}
	// Bolt action sniper
	else if (weap == "dsr50_mp+dualclip") {
		return 2;
	}
	// Semi-auto sniper
	else if (weap == "as50_mp+extclip") {
		return 2;
	}
	// Hunting Rifle
	else if (weap == "ballista_mp+is") {
		return 2;
	}
	// Minigun
	else if (weap == "minigun_wager_mp") {
		return 0;
	}
	// LMG
	else if (weap == "lsat_mp+steadyaim") {
		return 1;
	}
	// Rocket Launcher
	else if (weap == "smaw_mp") {
		return 4;
	}
	// Grenade Launcher
	else if (weap == "m32_wager_mp") {
		return 4;
	}
	// Grenade / Clinger / Remote Explosives
	else if (weap == "frag_grenade_mp" || weap == "sticky_grenade_mp" || weap == "satchel_charge_mp") {
		return -1;
	}
	return 2;
}
PrecacheAll()
{
	shaders = strtok("870mcs,fnp45,rpg,scar,fnp45,rpg,sig556,sa58,insas,mp7,five_seven,ksg,srm,dsr1,as50,ballista,lsat,smaw,ballistic_knife",",");
	foreach(shader in shaders) { Precacheshader("menu_mp_weapons_" + shader); }
	Precacheshader("hud_icon_minigun");
	Precacheshader("hud_grenadeicon");
	Precacheshader("hud_icon_c4");
	Precacheshader("hud_icon_sticky_grenade");
	Precacheshader("hud_grenade_launcher");
	Precacheshader("perk_flak_jacket");
	Precacheshader("perk_awareness");
	Precacheshader("perk_tactical_mask");
	Precacheshader("perk_scavenger");
	Precacheshader("perk_hardline");
	Precacheshader("perk_warrior");
	PrecacheItem("minigun_wager_mp");
	PrecacheItem("m32_wager_mp");
	PrecacheItem("an94_mp");
	PrecacheModel("mp_flag_green");
	PrecacheModel("mp_flag_red");
	PrecacheModel("mp_flag_neutral");
	PrecacheModel("t6_wpn_supply_drop_trap");
	PrecacheModel("collision_clip_wall_128x128x10");
	PrecacheModel("collision_clip_wall_256x256x10");
	PrecacheModel("collision_clip_wall_512x512x10");
}
boolToString(bool)
{
	if (bool) { return "t"; }
	return "f";
}
addAmmo(type, ammout)
{
	// Type: 0 Small bullets  (SMGs, SemiAuto Pistols, Minigun)
	// Type: 1 Medium bullets (ARs, LMG, Revolovers/Hand Cannon) 
	// Type: 2 Large bullets (Snipers, Semiauto riffle)
	// Type: 3 Shotgun shells (Shotguns)
	// Type: 4 Explosive Shells (RPG/War Machine) 
	if (type < 0 || type > 4) { 
		return;
	}
	self.ammotypes[type] += ammout;
	if (type == 0){
		self iprintln("Added " + ammout + " small bullets!");
	} else if (type == 1) {
		self iprintln("Added " + ammout + " medium bullets!");
	} else if (type == 2) {
		self iprintln("Added " + ammout + " large bullets!");
	} else if (type == 3) {
		self iprintln("Added " + ammout + " shotgun shells!");
	} else if (type == 4) {
		self iprintln("Added " + ammout + " explosive ammo!");
	}
}
ammoTypeToString(type, ammout)
{
	// Type: 0 Small bullets  (SMGs, SemiAuto Pistols, Minigun)
	// Type: 1 Medium bullets (ARs, LMG, Revolovers/Hand Cannon) 
	// Type: 2 Large bullets (Snipers, Semiauto riffle)
	// Type: 3 Shotgun shells (Shotguns)
	// Type: 4 Explosive Shells (RPG/War Machine) 
	// 7 = Grenade, 8 = Semtex, 9 = C4
	if (type == 0){
		return ammout + " small bullets!";
	} else if (type == 1) {
		return ammout + " medium bullets!";
	} else if (type == 2) {
		return ammout + " large bullets!";
	} else if (type == 3) {
		return ammout + " shotgun shells!";
	} else if (type == 4) {
		return ammout + " explosive ammo!";
	}
}
// Takes a string and returns the number that is within in. 
// If no number is present, returns 0. Also returns if returned number is an int.
get_num(str)
{
	self endon("disconnect");
	isint = true;
	hadanumber = false;
	dec = 0;
	curnum = 0;
	for(x=0;x<str.size;x++) {
		if (str[x] == "0" || str[x] == "1" || str[x] == "2" || str[x] == "3" || str[x] == "4" || str[x] == "5" || str[x] == "6" || str[x] == "7" || str[x] == "8" || str[x] == "9") {
			hadanumber = true;
			num = int(str[x]);
			if (isint) {
				curnum *= 10;
				curnum += num;
			} else {
				dec++;
				for(y=0;y<dec;y++) { curnum *= 10; }
				curnum += num;
				curnum = int(curnum);
				for(y=0;y<dec;y++) { curnum /= 10; }
			}
		} else if (str[x] == "." && isint) { 
			isint = false; 
		} else { 
			break; 
		}
	}
	data = [];
	data[0] = hadanumber;
	data[1] = isint;
	data[2] = curnum;
	return data;
}
CanuseAddShieldAndHealthPotions() {
	if (self.forthealth < 100 || self.fortshield < 100) {
		return true;
	}
	return false;
}
FlyToGroundMoreAgreesiveSideways()
{
	return bulletTrace(self.origin, self.origin+vectorScale(anglesToForward(self.angles), 50), false, self)["position"];
}
DisToGround()
{
	target = bulletTrace(self.origin, self.origin+vectorScale(anglesToForward((90,0,0)), 1000000), false, self)["position"];
	return int(Distance(self.origin, target));
}
playerAnglesToForward(player, distance)
{
	return player.origin + VectorScale(AnglesToForward(player getPlayerAngles(), distance));
}
ToggleClassicInvControls() {
	if (self.useinventorymod == 0) {
		self.useinventorymod = 1;
		self iprintlnbold("Auto-Changeto Controls ^2Enabled!");
		return;
	} else if (self.useinventorymod == 1) {
		self.useinventorymod = 2;
		self iprintlnbold("Auto-Close Controls ^2Enabled!");
		return;
	}
	self.useinventorymod = 0;
	self iprintlnbold("Classic Controls ^2Enabled!");
}

DisTraceShot(in) {
	return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), in), false, self)["position"];
}



















