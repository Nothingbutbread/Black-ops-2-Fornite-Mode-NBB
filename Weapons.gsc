getRawWeapon(str)
{
	retval = "";
	for(x = 0; x < str.size; x++)
	{
		if (str[x] == "+") { break; }
		retval += str[x];
	}
	return retval;
}

DefineWeapondataarray()
{
	level.AttachmentArray = [];
	level.AttachmentArray[0] = "dualoptic"; //Hybrid Optic
	level.AttachmentArray[1] = "extbarrel"; //Long Barrel  
	level.AttachmentArray[2] = "fastads"; //Quickdraw
	level.AttachmentArray[3] = "grip"; //Fore Grip
	level.AttachmentArray[4] = "holo"; //EOTech
	level.AttachmentArray[5] = "mms"; //MMS
	level.AttachmentArray[6] = "rangefinder"; //Target Finder
	level.AttachmentArray[7] = "reflex"; //Reflex Sight
	level.AttachmentArray[8] = "rf"; //Rapid Fire
	level.AttachmentArray[9] = "tacknife"; //Tactical Knife
	level.AttachmentArray[10] = "stalker"; //Stock 
	level.AttachmentArray[11] = "silencer"; //Suppressor
	level.AttachmentArray[12] = "extclip"; //Extended Clip
	level.AttachmentArray[13] = "fmj"; //FMJ 
	level.AttachmentArray[14] = "steadyaim"; //Laser
	level.AttachmentArray[15] = "acog"; //ACOG
	level.AttachmentArray[16] = "dualclip"; //Fast Mag
	level.AttachmentArray[17] = "vzoom"; //Variable Zoom
	level.AttachmentArray[18] = "ir"; //Dual Band
	level.AttachmentArray[19] = "is"; //?
	level.AttachmentArray[20] = "swayreduc"; //Ballistics CPU
	level.AttachmentArray[21] = "stackfire"; //Tri-Bolt
	//level.AttachmentArray[22] = "sf"; //Select Fire
	//level.AttachmentArray[23] = "gl"; //Grenade Launcher
	level.WeaponArray2 = [];
	level.WeaponArray2[0] = "frag_grenade_mp";
	level.WeaponArray2[1] = "sticky_grenade_mp";
	level.WeaponArray2[2] = "hatchet_mp";
	level.WeaponArray2[3] = "bouncingbetty_mp";
	level.WeaponArray2[4] = "satchel_charge_mp";
	level.WeaponArray2[5] = "claymore_mp";
	
	level.WeaponArray3 = [];
	level.WeaponArray3[0] = "concussion_grenade_mp";
	level.WeaponArray3[1] = "willy_pete_mp";
	level.WeaponArray3[2] = "sensor_grenade_mp";
	level.WeaponArray3[3] = "emp_grenade_mp";
	level.WeaponArray3[4] = "proximity_grenade_mp";
	level.WeaponArray3[5] = "pda_hack_mp";
	level.WeaponArray3[6] = "flash_grenade_mp";
	level.WeaponArray3[7] = "trophy_system_mp";
	level.WeaponArray3[8] = "tactical_insertion_mp";
	
	level.WeaponArray = [];
	level.WeaponArray[0] = "smaw_mp";
	level.WeaponArray[1] = "usrpg_mp";
	level.WeaponArray[3] = "knife_ballistic_mp";
	level.WeaponArray[4] = "riotshield_mp";
	level.WeaponArray[5] = "crossbow_mp";
	
	level.WeaponArray[6] = "fiveseven_dw_mp";
	level.WeaponArray[7] = "fnp45_dw_mp";
	level.WeaponArray[8] = "beretta93r_dw_mp";
	level.WeaponArray[9] = "judge_dw_mp";
	level.WeaponArray[10] = "kard_dw_mp";
	level.WeaponArray[11] = "kard_mp";	
	level.WeaponArray[12] = "fnp45_mp";
	level.WeaponArray[13] = "beretta93r_mp";
	level.WeaponArray[14] = "judge_mp";
	level.WeaponArray[15] = "fiveseven_mp";
	
	level.WeaponArray[16] = "870mcs_mp";
	level.WeaponArray[17] = "saiga12_mp";
	level.WeaponArray[18] = "ksg_mp";
	level.WeaponArray[19] = "srm1216_mp";
	
	
	level.WeaponArray[20] = "mp7_mp";
	level.WeaponArray[21] = "pdw57_mp";
	level.WeaponArray[22] = "vector_mp";
	level.WeaponArray[23] = "insas_mp";
	level.WeaponArray[24] = "qcw05_mp";
	level.WeaponArray[25] = "evoskorpion_mp";
	level.WeaponArray[26] = "peacekeeper_mp";
	
	level.WeaponArray[27] = "tar21_mp";
	level.WeaponArray[28] = "type95_mp";
	level.WeaponArray[29] = "sig556_mp";
	level.WeaponArray[30] = "sa58_mp";
	level.WeaponArray[31] = "hk416_mp";
	level.WeaponArray[32] = "scar_mp";
	level.WeaponArray[33] = "saritch_mp";
	level.WeaponArray[34] = "xm8_mp";
	level.WeaponArray[35] = "an94_mp";
	
	level.WeaponArray[36] = "mk48_mp";
	level.WeaponArray[37] = "qbb95_mp";
	level.WeaponArray[38] = "lsat_mp";
	level.WeaponArray[39] = "hamr_mp";
	
	level.WeaponArray[40] = "svu_mp";
	level.WeaponArray[41] = "dsr50_mp";
	level.WeaponArray[42] = "as50_mp";
	level.WeaponArray[43] = "ballista_mp";
	
	level.WeaponArray[44] = "minigun_wager_mp";
	level.WeaponArray[45] = "m32_wager_mp";
	
	//level.WeaponArray[41] = "riotshield_mp";
}
isSingleShot(weap) {
	// Hand Cannon
	if (weap == "fnp45_mp+dualclip" || weap == "fnp45_mp+dualclip+fmj") {
		return true;
	}
	// Bolt action sniper
	else if (weap == "dsr50_mp+dualclip") {
		return true;
	}
	// Hunting Rifle
	else if (weap == "ballista_mp+is") {
		return true;
	}
	return false;
}
isScropedNotSniper(weap) {
	if (weap == "sa58_mp+acog") {
		return true;
	}
	return false;
}
WeaponMod_SingleShot(weap, index) {
	self endon("death");
	self endon("disconnect");
	self endon("new_item_at_" + index);
	while(weap == self.activeweapon) {
		self waittill("weapon_fired");
		if (weap != self.activeweapon) {
			break;
		}
		self.ammotypes[self.activetype] += self getweaponammoclip(self.activeweapon);
		self setWeaponAmmoClip(self.activeweapon, 0);
	}
}
WeaponMod_Scoped(weap, index) {
	// self setclientthirdperson(1);
	self endon("death");
	self endon("disconnect");
	self endon("new_item_at_" + index);
	while(weap == self.activeweapon) {
		if (self adsbuttonpressed())  {
			self setclientthirdperson(0);
			wait .1;
		} else {
			self setclientthirdperson(1);
		}
		wait .1;
	}
}
WeaponMod_RefreshStock() {
	self endon("death");
	self endon("disconnect");
	while(true) {
		if (self.amholdinggun) {
			stock = self getweaponammostock(self.activeweapon);
			self setWeaponAmmoStock(self.activeweapon, (stock + self.ammotypes[self.activetype]));
			newstock = self getweaponammostock(self.activeweapon);
			r = newstock - stock;
			if (r > 0) {
				self.ammotypes[self.activetype] -= r;
			}
		} else {
			wait .4;
		}
		wait .1;
	}
}

































