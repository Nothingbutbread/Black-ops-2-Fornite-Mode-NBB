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
	level.WeaponArray2[4] = "satchet_charge_mp";
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
getWeaponAttachments(weapon)
{
	attachments = [];
	items = strtok(weapon, "+");
	x = 0;
	foreach(att in items)
	{
		if (x > 0)
		{ attachments[attachments.size] = att; }
		x++;
	}
	return attachments;
}
// Takes an array and an int.
// Array is that of strings, the id is the id of the attchment in the attachment array.
// Assumes incomeing attachments are each unique

isCompatableWithCurrentGun(attachments, id, gunid)
{
	attachments[attachments.size] = level.AttachmentArray[id];
	if (attachments.size > 3) { return false; }
	// Is the attchements compactable with the guns useable attchments?
	if (gunid < 11 && gunid != 5) { return false; } // Dosn't
	if (gunid > 43) { return false; }
	sights = strtok("dualoptic,holo,mms,rangefinder,acog,ir,is", ",");
	
	if (gunid == 5) // Cross bow
	{
		cb = strtok("reflex,acog,ir,vzoom,stackfire", ",");
		count = 0;
		vzoom = false;
		for(x = 0; x < attachments.size; x++)
		{
			good = false;
			foreach(at in cb) { if (attachments[x] == at) { if (at == "vzoom") { vzoom = true; }good = true; break; } }
			if (!good) { return false; }
		}
		if (attachments.size == 1) { return true; }
		else 
		{
			dualband = false;
			for(x = 0; x < attachments.size; x++) 
			{ 
				foreach(at in sights) 
				{ 
					if (attachments[x] == at) 
					{ 
						count++; 
						if (at == "ir") { dualband = true; } 
						break; 
					} 
				} 
			}
			if (count == 0) { return true; }
			else if (dualband && vzoom && attachments.size == 3) { return true; }
			else if (count == 1 && !vzoom) { return true; }
			return false;
		}
	}
	else if (gunid >= 10 && gunid <= 15) //10 - 15
	{
		// 14 can't use extclip
		pi = strtok("reflex,extbarrel,dualclip,steadyaim,fmj,tacknife,silencer,extclip",",");
		for(x = 0; x < attachments.size; x++) 
		{ 
			good = false;
			foreach(at in pi)  { if (attachments[x] == at) { good = true; break; } }
			if (!good) { return false; }
		}
		haslong = false; hassil = false; hasfmag = false; hasextmag = false;
		for(x = 0; x < attachments.size; x++) 
		{ 
			foreach(at in pi) 
			{
				if (attachments[x] == at)
				{
					if (at == "extbarrel") { haslong = true; }
					else if (at == "silencer") { hassil = true; }
					else if (at == "dualclip") { hasfmag = true; }
					else if (at == "extclip") { hasextmag = true; }
					break;
				}
			}
		}
		if (hasfmag && hasextmag) { return false; }
		if (gunid == 14 && hasextmag) { return false; }
		if (haslong && hassil) { return false; }
		return true;
	}
	else if (gunid >= 16 && gunid <= 19) //16 - 19
	{
		sg = strtok("reflex,extbarrel,dualclip,steadyaim,stalker,silencer,extclip,fastads,mms",",");
		haslong = false; hassil = false; hasfmag = false; hasextmag = false;
		for(x = 0; x < attachments.size; x++) 
		{ 
			good = false;
			foreach(at in sg)  { if (attachments[x] == at) { good = true; break; } }
			if (!good) { return false; }
		}
		for(x = 0; x < attachments.size; x++) 
		{ 
			foreach(at in sg) 
			{
				if (attachments[x] == at)
				{
					if (at == "extbarrel") { haslong = true; }
					else if (at == "silencer") { hassil = true; }
					else if (at == "dualclip") { hasfmag = true; }
					else if (at == "extclip") { hasextmag = true; }
					break;
				}
			}
		}
		count = 0;
		for(x = 0; x < attachments.size; x++) 
		{ 
			foreach(at in sights) 
			{ 
				if (attachments[x] == at) 
				{ 
					count++; 
					break; 
				} 
			} 
		}
		if  (count > 1) { return false; }
		for(x = 0; x < attachments.size; x++) 
		{ 
			foreach(at in sg) 
			{
				if (attachments[x] == at)
				{
					if (at == "extbarrel") { haslong = true; }
					else if (at == "silencer") { hassil = true; }
					else if (at == "dualclip") { hasfmag = true; }
					else if (at == "extclip") { hasextmag = true; }
					break;
				}
			}
		}
		if (hasfmag && hasextmag) { return false; }
		if (haslong && hassil) { return false; }
		return true;
	}
	else if (gunid >= 40 && gunid <= 43) //40 - 43
	{
		sniper = strtok("ir,steadyaim,extclip,acog,fmj,daulclip,vzoom,swayreduc,silencer", ",");
	}
	lmg = strtok("ir,steadyaim,extclip,acog,fmj,vzoom,silencer,holo,grip,reflex,fastads,rangefinder,stalker,rf,dualoptic", ",");
	smg = strtok("steadyaim,extclip,acog,fmj,daulclip,silencer,holo,grip,reflex,fastads,rangefinder,stalker,rf,daulclip,mms,sf,extbarrel", ",");
	ar = strtok("reflex,fastads,dualclip,acog,grip,stalker,rangefinder,steadyaim,sf,gl,holo,silencer,fmj,dualoptic,extclip,mms,extclip", ",");
	// Silencer or Long barrel
	// Hybrid optic or Grenade Launcher or Select fire
	// Grenade Launcher or Foregrip
	// Vzoom requires a Dual band or Default sniper scope.
	// FMJ or MMS sight
	
	
}
/*
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
	level.AttachmentArray[19] = "is"; //Iron sights
	level.AttachmentArray[20] = "swayreduc"; //Ballistics CPU
	level.AttachmentArray[21] = "stackfire"; //Tri-Bolt
	level.AttachmentArray[22] = "sf"; //Select Fire
	level.AttachmentArray[23] = "gl"; //Grenade Launcher
*/




















