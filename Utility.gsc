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
	else if (id == 1) { return 43; }
	else if (id == 2) { return 44; }
	else if (id == 3) { return 25; }
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
getFullDisplayName(item) {
	if (!item.slotfilled) {
		return "";
	} else if (item.weapon == "Ammo") {
		return "" + ammoTypeToString(item.ammotype, item.clip);
	} else {
		return "" + teirIDToStringColor(item.rarity) + "" + getDisplayName(item.weapon);
	}
}
getDisStrItemInv(items) {
	retval = "";
	for(x = 0; x < items.size; x++) {
		retval += "\n" + getFullDisplayName(items[x]) + "";
	}
	return retval;
}
createAmmoItem(type, amout) {
	retval = createInventorySlotStruct();
	retval.weapon = "Ammo";
	retval.clip = amout;
	retval.rarity = 0;
	retval.ammotype = type;
	retval.isweapon = false;
	retval.slotfilled = true; //This is an ammo type in this instance
	return retval;
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
isAWeapon(weap) {
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
isNotEquipment(weap) {
	if (weap == "frag_grenade_mp" || weap == "sticky_grenade_mp" || weap == "satchel_charge_mp") {
		return false;
	}
	return true;
}
GetRandomAmmoAmmout(type) {
	// Type: 0 Small bullets  (SMGs, SemiAuto Pistols, Minigun)
	// Type: 1 Medium bullets (ARs, LMG, Revolovers/Hand Cannon) 
	// Type: 2 Large bullets (Snipers, Semiauto riffle)
	// Type: 3 Shotgun shells (Shotguns)
	// Type: 4 Explosive Shells (RPG/War Machine) 
	ammo = 2;
	if (type == 0) {
		ammo = RandomIntRange(30, 80);
	} else if (type == 1) {
		ammo = RandomIntRange(25, 65);
	} else if (type == 2) {
		ammo = RandomIntRange(6, 20);
	} else if (type == 3) {
		ammo = RandomIntRange(6, 30);
	} else if (type == 4) {
		ammo = RandomIntRange(2, 6);
	}
	return ammo;
}
getItemShader(weap)
{
	// Burst rifle
	if (weap == "sig556_mp" || weap == "sig556_mp+stalker") {
		return "menu_mp_weapons_sig556";
	}
	// Thermal AR
	else if (weap == "svu_mp+ir") {
		return "menu_mp_weapons_svu";
	}
	// Auto rifle
	else if (weap == "scar_mp" || weap == "scar_mp+extclip" || weap == "scar_mp+silencer") {
		return "menu_mp_weapons_scar";
	}
	// Scoped rifle
	else if (weap == "sa58_mp+acog") {
		return "menu_mp_weapons_sa58";
	}
	else if (weap == "peacekeeper_mp+rf") {
		return "menu_mp_weapons_pm";
	}
	// Silenced SMG
	else if (weap == "mp7_mp+silencer") {
		return "menu_mp_weapons_mp7";
	}
	// Hand Canon
	else if (weap == "fnp45_mp+dualclip+fmj") {
		return "menu_mp_weapons_fnp45";
	}
	// pistol
	else if (weap == "fiveseven_mp" || weap == "fiveseven_mp+silencer") {
		return "menu_mp_weapons_five_seven";
	}
	// Compact SMG
	else if (weap == "evoskorpion_mp+extclip") {
		return "menu_mp_weapons_evoskorpion";
	}
	// Pumpaction Shotgun
	else if (weap == "ksg_mp"){
		return "menu_mp_weapons_ksg";
	}
	// Assuming 8 pelets, Tatical Shotgun
	else if (weap == "870mcs_mp+extbarrel"){
		return "menu_mp_weapons_870mcs"; // 8 may be more accurate but 9 to keep the dammage consitant.
	}
	else if (weap == "saiga12_mp+extbarrel") {
		return "menu_mp_weapons_saiga12";
	}
	// Assuming 8 pelets, heavy shotgun .. Dammage at Gold end is VERY high
	else if (weap == "srm1216_mp") {
		return "menu_mp_weapons_srm";
	}
	// Bolt action sniper
	else if (weap == "dsr50_mp+vzoom") {
		return "menu_mp_weapons_dsr1";
	}
	// Semi-auto sniper
	else if (weap == "as50_mp+extclip") {
		return "menu_mp_weapons_as50";
	}
	else if (weap == "saritch_mp+dualclip") {
		return "menu_mp_weapons_saritch";
	}
	// Hunting Rifle
	else if (weap == "ballista_mp+dualclip") {
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
	else if (weap == "Jet Pack") {
		return "hud_remote_missile_target";
	} else if (weap == "Port-a-Rift") {
		return "rank_prvt";
	}
	return "white";
}
getDisplayName(weap)
{
	if (weap == "sig556_mp") {
		return "Burst Assult Rifle";
	}
	else if (weap == "svu_mp+ir") {
		return "Thermal Scoped Assult Riffle";
	}
	else if (weap == "sig556_mp+stalker") {
		return "Famas";
	}
	// Auto rifle
	else if (weap == "scar_mp") {
		return "Automatic Assult Rifle";
	}
	else if (weap == "scar_mp+extclip") {
		return "Scar";
	}
	else if (weap == "scar_mp+silencer") {
		return "Surpressed Scar";
	}
	// Scoped rifle
	else if (weap == "sa58_mp+acog") {
		return "Scoped Rifle";
	}
	else if (weap == "peacekeeper_mp+rf") {
		return "Submachine Gun";
	}  
	// Compact SMG
	else if (weap == "evoskorpion_mp+extclip") {
		return "Compact SMG";
	}
	// Silenced SMG
	else if (weap == "mp7_mp+silencer") {
		return "Silenced Submachine Gun";
	}
	// Revolver / Hand Cano
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
	else if (weap == "saiga12_mp+extbarrel") { 
		return "Double Barrel Shotgun";
	}
	// Assuming 8 pelets, heavy shotgun .. Dammage at Gold end is VERY high
	else if (weap == "srm1216_mp") {
		return "Heavy Shotgun";
	}
	// Heavy Sniper
	else if (weap == "dsr50_mp+vzoom") {
		return "Heavy Sniper";
	}
	// Semi-auto sniper
	else if (weap == "as50_mp+extclip") {
		return "Semi-automatic Sniper";
	}
	// Hunting Rifle
	else if (weap == "saritch_mp+dualclip") {
		return "Hunting Rifle";
	}
	// Bolt action sniper
	else if (weap == "ballista_mp+dualclip") {
		return "Bolt-action Sniper";
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
	else if (weap == "svu_mp+ir") {
		return 1;
	}
	// Auto rifle
	else if (weap == "scar_mp" || weap == "scar_mp+extclip" || weap == "scar_mp+silencer") {
		return 1;
	}
	// Scoped rifle
	else if (weap == "sa58_mp+acog") {
		return 1;
	}
	else if (weap == "peacekeeper_mp+rf") {
		return 0;
	}
	// Compact SMG
	else if (weap == "evoskorpion_mp+extclip") {
		return 0;
	}
	// Silenced SMG
	else if (weap == "mp7_mp+silencer") {
		return 0;
	}
	// Revolver
	else if (weap == "fnp45_mp+dualclip") {
		return 1;
	}
	// Hand Cannon
	else if (weap == "fnp45_mp+dualclip+fmj") {
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
	else if (weap == "saiga12_mp+extbarrel") {
		return 3;
	}
	// Hunting Rifle
	else if (weap == "saritch_mp+dualclip") {
		return 2;
	}
	// Heavy sniper
	else if (weap == "dsr50_mp+vzoom") {
		return 2;
	}
	// Semi-auto sniper
	else if (weap == "as50_mp+extclip") {
		return 2;
	}
	// Bolt action snniper
	else if (weap == "ballista_mp+dualclip") {
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
	return -1;
}

PrecacheAll()
{
	shaders = strtok("870mcs,fnp45,rpg,scar,fnp45,rpg,sig556,sa58,evoskorpion,mp7,five_seven,ksg,srm,dsr1,as50,ballista,lsat,smaw,svu,pm,saiga12,saritch",",");
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
	Precacheshader("hud_remote_missile_target");
	Precacheshader("rank_prvt");
	//Precacheshader("menu_mp_drone_map_select_final");
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
	PrecacheModel("p6_dockside_container_lrg_red");
	PrecacheModel("p6_dockside_container_lrg_orange");
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
		self iprintln("^2Added ^7" + ammout + " ^2small bullets!");
	} else if (type == 1) {
		self iprintln("^2Added ^7" + ammout + " ^2medium bullets!");
	} else if (type == 2) {
		self iprintln("^2Added ^7" + ammout + " ^2large bullets!");
	} else if (type == 3) {
		self iprintln("^2Added ^7" + ammout + " ^2shotgun shells!");
	} else if (type == 4) {
		self iprintln("^2Added ^7" + ammout + " ^2explosive ammo!");
	}
}
ammoTypeToString(type, ammout)
{
	// Type: 0 Small bullets  (SMGs, SemiAuto Pistols, Minigun)
	// Type: 1 Medium bullets (ARs, LMG, Revolovers/Hand Cannon) 
	// Type: 2 Large bullets (Snipers, Semiauto riffle)
	// Type: 3 Shotgun shells (Shotguns)
	// Type: 4 Explosive Shells (RPG/War Machine) 
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

DisTraceShot(in) {
	return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), in), false, self)["position"];
}

fetchClantag(n) {
	if (n[0] == "[") {
		i = "[";
		for(a=1;a<7;a++) {
			if (n[a] != "]") {
				i += n[a];
			} else {
				i += "]";
				return i;
			}
		}
	} else {
		return "";
	}
}
kickAFKPlayers() {
	self endon("disconnect");
	self endon("death");
	ref = self.origin;
	tick = 0;
	while(tick < 60) {
		wait 1;
		if (self.origin != ref) {
			return;
		}
		tick++;
	}
	if (IsAlive(self)) {
		iprintln("^3[Info]: ^7Kicked " + self.name + " for being AFK");
		kick(self GetEntityNumber());
	}
}
stormDelayAmmout(id) {
	if (level.blitz) {
		if (id == 0) {
			return 20;
		} else if (id == 1) {
			return 30;
		} else if (id == 2) {
			return 20;
		}
		return 20;
	} else {
		if (id == 0) {
			return 25;
		} else if (id == 1) {
			return 40;
		} else if (id == 2) {
			return 35;
		}
		return 25;
	}
	return 20;
}
stormDammageAmmout(id) {
	if (level.blitz) {
		if (id == 0) {
			return 5;
		} else if (id == 1) {
			return 10;
		} else if (id == 2) {
			return 20;
		}
		return 30;
	} else {
		if (id == 0) {
			return 2;
		} else if (id == 1) {
			return 5;
		} else if (id == 2) {
			return 10;
		}
		return 20;
	}
	return 5;
}

doOR(a,b) {
	if (a || b) {
		return true;
	}
	return false;
}
doAND(a,b) {
	if (a && b) {
		return true;
	}
	return false;
}
doXOR(a,b)  {
	if (a && b) {
		return false;
	} else if (!a && !b) {
		return false;
	}
	return true;
}
// This stores the xp lobby settings to dvars
setSettingsOnGameStart() {
    setDvar("fortniteSavedSettings", "yes");
    a = "";
    if (level.solidgold) {
        a += "t";
    } else {
        a += "f";
    }
    if (level.blitz) {
        a += "t";
    } else {
        a += "f";
    }
    if (level.fantasy) {
        a += "t";
    } else {
        a += "f";
    }
    if (level.flyexplosives) {
        a += "t";
    } else {
        a += "f";
    }
    if (level.snipershootout) {
        a += "t";
    } else {
        a += "f";
    }
    setDvar("fortniteSavedData", a);
    self iprintln("^2Fortnite settings will auto-apply to any new fortnite matches!");
}
// This runs on start of game and applies any saved xp lobby settings.
UnpackageAndSetSettings() {
    if (isDefined(GetDvar("fortniteSavedSettings"))) { 
        if (GetDvar("fortniteSavedSettings") == "yes") {
            a = GetDvar("fortniteSavedData");
            if (a[0] == "t") {
                level.solidgold = true;
            } else {
                level.solidgold = false;
            }
            if (a[1] == "t") {
                level.blitz = true;
            } else {
                level.blitz = false;
            }
            if (a[2] == "t") {
                level.fantasy = true;
            } else {
                level.fantasy = false;
            }
            if (a[3] == "t") {
                level.flyexplosives = true;
            } else {
                level.flyexplosives = false;
            }
            if (a[4] == "t") {
                level.snipershootout = true;
            } else {
                level.snipershootout = false;
            }
            iprintln("Fortnite game settings updated from previous game!");
        } 
    }
}
ModTraceShots()
{
	angle = self getPlayerAngles();
	adjustx = RandomIntRange(-1, 1);
	adjusty = RandomIntRange(-1, 1);
	temp = angle[0] + adjustx;
	if (temp < 0)
	{
		temp = NoN(temp);
		temp = 360 - temp;
	}
	else if (temp >= 360)
		temp -= 360;
	adjustx = temp;
	temp = angle[1] + adjusty;
	if (temp < 0)
	{
		temp = NoN(temp);
		temp = 360 - temp;
	}
	else if (temp >= 360)
		temp -= 360;
	adjusty = temp;
	angle = (adjustx, adjusty, angle[2]);
	return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(angle), 1000000), false, self)["position"];
}
NoN(in) {
	if (in < 0) {
		in *= -1;
	}
	return in;
}
StopMomentum() {
	obj = spawn("script_origin", self.origin);
	obj.angles = self.angles;
	self PlayerLinkTo(obj, undefined);
	wait .05;
	obj moveTo(obj.origin + (0,0,10), .05);
	wait .05;
	self unlink();
    obj delete();
}




