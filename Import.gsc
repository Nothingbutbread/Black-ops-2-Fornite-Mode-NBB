DeploySpiningItemDrop(item, disname, modelref, mag, rarity, ammotype, isweapon)
{
	level endon("game_ended");
	level.activespiningitems++;
	isgun = isAGun(item);
	trig = spawn("trigger_radius", modelref.origin, 1, 60, 60);
	trig setCursorHint("HINT_NOICON", trig);
	if (isgun) {
		trig setHintString("Hold [{+usereload}] to pick up " + teirIDToStringColor(int(rarity)) + "" + disname + "\n^1Will delete currently held item!\n^7Hold [{+gostand}] to only take the Ammo.");
	} else {
		trig setHintString("Hold [{+usereload}] to pick up " + teirIDToStringColor(int(rarity)) + "" + disname + "\n^1Will delete currently held item!");
	}
	ammo = RandomIntRange(3, 25);
	while(true) {
		trig waittill("trigger", player);
		if (player useButtonPressed() && isAlive(player) && !player.menuopen) {
			if (player.lastusedinvslotindex == -1) { 
				player thread addItemToInventory(0, item, int(mag), int(rarity), int(ammotype), isweapon);
			} else { 
				player thread addItemToInventory(player.lastusedinvslotindex, item, int(mag), int(rarity), int(ammotype), isweapon);
			}
			if (isgun) {
				player addAmmo(getAmmoType(item), ammo);
			}
			trig triggerOff();
			modelref delete();
			break;
		} else if (player useButtonPressed() && isAlive(player) && player.menuopen) {
			player iprintlnbold("^1Your inventory must be closed to use this!");
		} else if (player jumpbuttonpressed() && isAlive(player) && isgun) {
			player addAmmo(getAmmoType(item), ammo);
			trig triggerOff();
			modelref delete();
			break;
		}
		wait .05;
	}
	level.activespiningitems--;
	trig delete();
}
// Taken from Avalanche
spinWeaponDrop()
{
	while(isDefined(self)) {
		self rotateTo((self.angles[0], self.angles[1]+90, self.angles[2]), .3);
		wait .3;
	}
}

























