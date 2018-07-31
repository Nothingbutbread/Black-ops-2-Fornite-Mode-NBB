giveSupplyDrop()
{
	self.loot = [];
	for(x=0;x<7;x++) { self.loot[x] = ""; }
	luck = RandomIntRange(0,100);
	teir = 1;
	if (self.occupation == "Bookie" && !self.occupation_bonus)
	{
		if (luck < 45) { teir = 1; }
		else if (luck < 80) { teir = 2; }
		else { teir = 3; }
	}
	else if (self.occupation == "Bookie" && self.occupation_bonus) { teir = 3; self.occupation_bonus = false; }
	else
	{
		if (luck < 65) { teir = 1; }
		else if (luck < 90) { teir = 2; }
		else { teir = 3; }
	}
	if (level.debugger) { self thread LB_DEBUG(); }
	else
	{
		if (teir == 1) { self thread LB_Common(); }
		else if(teir == 2) { self thread LB_Uncommon(); }
		else { self thread LB_Rare(); }
	}
}
Generate_Common_Loot()
{
	luck = RandomIntRange(0,100);
	retval = "";
	if (self.occupation == "Specialist")
	{
		if (luck < 50){ retval = Loot_Common_gun(); } // 50% chance of gun
		else if (luck < 70) { retval = Loot_Booster(); } // 20% chance of Booster
		else if (luck < 80) { retval = Loot_Perk(); } // 10% chance of a perk
		else if (luck < 85) { retval = Loot_SP_Common(); } // 5% of some SP
		else { retval = Loot_AAT(); } // 15% chance for an AAT
	}
	else if (self.occupation == "Warrior")
	{
		if (luck < 65){ retval = Loot_Common_gun(); } // 65% chance of gun
		else if (luck < 75) { retval = Loot_Booster(); } // 10% chance of Booster
		else if (luck < 80) { retval = Loot_SP_Common(); } // 5% of some SP
		else if (luck < 90) { retval = Loot_Perk(); } // 10% chance of a perk
		else { retval = Loot_AAT(); } // 10% chance for an AAT
	}
	else if (self.occupation == "Addict")
	{
		if (luck < 40) { retval = Loot_Common_gun(); } // 40% chance of a gun
		else if (luck < 75) { retval = Loot_Booster(); } // 35% chance of a booster
		else if (luck < 85) { retval = Loot_Perk(); }  // 10% chance of a perk
		else if (luck < 90) { retval = Loot_AAT(); } // 5% chance of a AAT
		else { retval = Loot_Ability(); } // 10% chance for an ability
	}
	else if (self.occipation == "Secret Shopper")
	{
		if (luck < 50){ retval = Loot_Common_gun(); } // 50% chance of gun
		else if (luck < 75) { retval = Loot_Booster(); } // 25% chance of Booster
		else if (luck < 85) { retval = Loot_Perk(); } // 10% chance of a perk
		else if (luck < 95) { retval = Loot_SP_Common(); } // 10% chance at some SP
		else { retval = Loot_AAT(); } // 5% chance for an AAT
	}
	else
	{
		if (luck < 55){ retval = Loot_Common_gun(); } // 55% chance of gun
		else if (luck < 80) { retval = Loot_Booster(); } // 25% chance of Booster
		else if (luck < 90) { retval = Loot_Perk(); } // 10% chance of a perk
		else if (luck < 95) { retval = Loot_SP_Common(); } // 5% of some SP
		else { retval = Loot_AAT(); } // 5% chance for an AAT
	}
	return retval;
}
Generate_Uncommon_Loot()
{
	luck = RandomIntRange(0,100);
	retval = "";
	if (self.occupation == "Specialist")
	{
		if (luck < 30) { retval = Loot_Uncommon_gun(); } // 30% chance of a gun
		else if (luck < 45) { retval = Loot_Booster(); } // 15% chance of a booster
		else if (luck < 55) { retval = Loot_Perk(); }  // 10% chance of a perk
		else if (luck < 65) { retval = Loot_SP_Uncommon(); } // 10% chance at some SP
		else if (luck < 90) { retval = Loot_AAT(); } // 25% chance of a AAT
		else { retval = Loot_Ability(); } // 10% chance for an ability
	}
	else if (self.occupation == "Warrior")
	{
		if (luck < 45) { retval = Loot_Uncommon_gun(); } // 45% chance of a gun
		else if (luck < 55) { retval = Loot_Booster(); } // 10% chance of a booster
		else if (luck < 65) { retval = Loot_Perk(); }  // 10% chance of a perk
		else if (luck < 80) { retval = Loot_AAT(); } // 15% chance of a AAT
		else if (luck < 90) { retval = Loot_SP_Uncommon(); } // 10% chance at some SP
		else { retval = Loot_Ability(); } // 10% chance for an ability
	}
	else if (self.occupation == "Addict")
	{
		if (luck < 30) { retval = Loot_Uncommon_gun(); } // 30% chance of a gun
		else if (luck < 60) { retval = Loot_Booster(); } // 30% chance of a booster
		else if (luck < 70) { retval = Loot_Perk(); }  // 10% chance of a perk
		else if (luck < 80) { retval = Loot_AAT(); } // 10% chance of a AAT
		else if (luck < 85) { retval = Loot_SP_Uncommon(); } // 5% chance at some SP
		else { retval = Loot_Ability(); } // 15% chance for an ability
	}
	else if (self.occipation == "Secret Shopper")
	{
		if (luck < 30) { retval = Loot_Uncommon_gun(); } // 30% chance of a gun
		else if (luck < 50) { retval = Loot_Booster(); } // 20% chance of a booster
		else if (luck < 65) { retval = Loot_SP_Uncommon(); } // 15% chance at some SP
		else if (luck < 80) { retval = Loot_AAT(); } // 15% chance of a AAT
		else if (luck < 90) { retval = Loot_Perk(); }  // 10% chance of a perk
		else { retval = Loot_Ability(); } // 10% chance for an ability
	}
	else
	{
		if (luck < 35) { retval = Loot_Uncommon_gun(); } // 35% chance of a gun
		else if (luck < 60) { retval = Loot_Booster(); } // 25% chance of a booster
		else if (luck < 70) { retval = Loot_Perk(); }  // 10% chance of a perk
		else if (luck < 75) { retval = Loot_SP_Uncommon(); } // 5% chance at some SP
		else if (luck < 90) { retval = Loot_AAT(); } // 15% chance of a AAT
		else { retval = Loot_Ability(); } // 10% chance for an ability
	}
	return retval;
}
Generate_Rare_Loot()
{
	luck = RandomIntRange(0,100);
	retval = "";
	if (self.occupation == "Specialist")
	{
		if (luck < 20) { retval = Loot_Rare_gun(); } // 20% chance of a gun
		else if (luck < 25) { retval = Loot_Booster(); } // 5% chance of a booster
		else if (luck < 30) { retval = Loot_Perk(); }  // 5% chance of a perk
		else if (luck < 65) { retval = Loot_AAT(); } // 35% chance of a AAT
		else if (luck < 75) { retval = Loot_SP_Rare(); } // 10% chance at some SP
		else { retval = Loot_Ability(); } // 25% chance for an ability
	}
	else if (self.occupation == "Warrior")
	{
		if (luck < 35) { retval = Loot_Rare_gun(); } // 35% chance of a gun
		else if (luck < 40) { retval = Loot_Perk(); } // 5% chance of a perk
		else if (luck < 50) { retval = Loot_SP_Rare(); } // 10% chance at some SP
		else if (luck < 70) { retval = Loot_AAT(); } // 20% chance of a AAT
		else { retval = Loot_Ability(); } // 30% chance for an ability
	}
	else if (self.occupation == "Addict")
	{
		if (luck < 15) { retval = Loot_Rare_gun(); } // 15% chance of a gun
		else if (luck < 35) { retval = Loot_Booster(); } // 20% chance of a booster
		else if (luck < 45) { retval = Loot_Perk(); }  // 10% chance of a perk
		else if (luck < 55) { retval = Loot_AAT(); } // 10% chance of a AAT
		else if (luck < 65) { retval = Loot_SP_Rare(); } // 10% chance at some SP
		else { retval = Loot_Ability(); } // 35% chance for an ability
	}
	else if (self.occipation == "Secret Shopper")
	{
		if (luck < 20) { retval = Loot_Uncommon_gun(); } // 20% chance of a gun
		else if (luck < 40) { retval = Loot_Booster(); } // 20% chance of a booster
		else if (luck < 60) { retval = Loot_SP_Rare(); } // 20% chance at some SP
		else if (luck < 75) { retval = Loot_AAT(); } // 15% chance of a AAT
		else if (luck < 90) { retval = Loot_Perk(); }  // 10% chance of a perk
		else { retval = Loot_Ability(); } // 15% chance for an ability
	}
	else
	{
		if (luck < 25) { retval = Loot_Rare_gun(); } // 25% chance of a gun
		else if (luck < 35) { retval = Loot_Booster(); } // 10% chance of a booster
		else if (luck < 45) { retval = Loot_Perk(); }  // 10% chance of a perk
		else if (luck < 65) { retval = Loot_AAT(); } // 20% chance of a AAT
		else if (luck < 75) { retval = Loot_SP_Rare(); } // 10% chance at some SP
		else { retval = Loot_Ability(); } // 25% chance for an ability
	}
	return retval;
}
LB_Common()
{
	if (self.occupation != "Bookie") { items = RandomIntRange(1,4); }
	else { items = RandomIntRange(2,4); }
	for(x=0;x<items;x++) { self.loot[x] = self thread Generate_Common_Loot(); }
	if (self.occupation == "Warrior" && self.occupation_bonus)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Warrior_First();
		items++;
	}
	if (self.occupation == "Scout" && self.occupation_bonus)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Scout_First();
		items++;
	}
	if (self.occupation == "Specialist" && self.occupation_bonus)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_AAT();
		items++;
	}
	self.lootboxrarity = "Common";
	self.lootboxitemcount = items;
	self.inventory_menu_BG.color = (.2,.2,.2);
	self.loot_menu_Scroller.color = (1,1,1);
	self.inventory_menu_HUD.color = (0,.7,0);
	self thread Menu_Loot_Open();
}
LB_Uncommon()
{
	if (self.occupation != "Bookie") { items = RandomIntRange(2,5); }
	else { items = RandomIntRange(3,5); }
	for(x=0;x<items;x++) { self.loot[x] = self thread Generate_Uncommon_Loot(); }
	if (self.occupation == "Warrior" && self.occupation_bonus)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Warrior_First();
		items++;
	}
	if (self.occupation == "Scout" && self.occupation_bonus)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Scout_First();
		items++;
	}
	if (self.occupation == "Specialist" && self.occupation_bonus)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_AAT();
		items++;
	}
	self.lootboxrarity = "Uncommon";
	self.lootboxitemcount = items;
	self.inventory_menu_BG.color = (0,0,.5);
	self.loot_menu_Scroller.color = (.5,0,0);
	self.inventory_menu_HUD.color = (0,.5,0);
	self thread Menu_Loot_Open();
}
LB_Rare()
{
	if (self.occupation != "Bookie") { items = RandomIntRange(3,8); }
	else { items = RandomIntRange(4,8); }
	for(x=0;x<items;x++) { self.loot[x] = self thread Generate_Rare_Loot(); }
	if (self.occupation == "Warrior" && self.occupation_bonus && items < 7)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Warrior_First();
		items++;
	}
	if (self.occupation == "Scout" && self.occupation_bonus && items < 7)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_Scout_First();
		items++;
	}
	if (self.occupation == "Specialist" && self.occupation_bonus && items < 7)
	{
		self.occupation_bonus = false;
		self.loot[items] = Loot_AAT();
		items++;
	}
	self.lootboxrarity = "Rare";
	self.lootboxitemcount = items;
	self.inventory_menu_BG.color = (0,0,1);
	self.loot_menu_Scroller.color = (1,0,0);
	self.inventory_menu_HUD.color = (0,1,0);
	self thread Menu_Loot_Open();
}
Menu_Loot_Open()
{
	self.loot_menu_open = true;
	self.inventory_menu_HUD FadeOverTime(.5);
	self.inventory_menu_BG FadeOverTime(.5);
	self.loot_menu_Scroller FadeOverTime(.5);
	self.inventory_menu_HUD.alpha = 1;
	self.inventory_menu_BG.alpha = 1;
	self.loot_menu_Scroller.alpha = 1;
	wait .5;
	self Menu_Inventory_Info_Bar_Update_Mapping();
	self thread Menu_Loot_Controls();
}
Menu_Loot_Close()
{
	self.inventory_menu_HUD FadeOverTime(.5);
	self.inventory_menu_BG FadeOverTime(.5);
	self.loot_menu_Scroller FadeOverTime(.5);
	self.inventory_menu_HUD.alpha = 0;
	self.inventory_menu_BG.alpha = 0;
	self.loot_menu_Scroller.alpha = 0;
	wait .5;
	self.infobarstr1 = "Press ADS and [{+melee}] to open the menu";
	self.infobarstr2 = "The Survival Games " + level.versionid + " by ^2Nothingbutbread";
	self.infobar_text_1 setSafeText(self.infobarstr1);
	self.infobar_text_2 setSafeText(self.infobarstr2);
	self.loot_menu_open = false;
}
Menu_Loot_Claim(index)
{
	if (self.loot[index] == "") { return; }
	type = whatisthatobject(self.loot[index]);
	if (type == 9) { self Give_Cool_Perk(self.loot[index]); }
	else if (type == 8) { self Claim_SP_From_Loot_Box(self.loot[index]); }
	else  { self add_Thing_To_Inventory(type, self.loot[index], true); }
	self.loot[index] = "";
}
Menu_Loot_Controls()
{
	self endon("death");
	self endon("disconnect");
	self Menu_Loot_Update_Menu();
	while(self.loot_menu_open)
	{
		if (self actionslotonebuttonpressed() && self.loot_menu_pos > 0)
		{
			self.loot_menu_Scroller moveOverTime(.05);
			self.loot_menu_Scroller.y -= 24;
			self.loot_menu_pos--;
			self Menu_Inventory_Info_Bar_Update_Mapping();
			wait .05;
		}
		else if (self actionslottwobuttonpressed()  && self.loot_menu_pos < 7)
		{
			self.loot_menu_Scroller moveOverTime(.05);
			self.loot_menu_Scroller.y += 24;
			self.loot_menu_pos++;
			self Menu_Inventory_Info_Bar_Update_Mapping();
			wait .05;
		}
		else if (self jumpbuttonpressed()) // Takes all items
		{
			for(x=0;x<self.loot.size;x++) { self Menu_Loot_Claim(x); }
			self Menu_Loot_Close();
			wait .05;
		}
		else if (self usebuttonpressed())
		{
			if (self.loot_menu_pos == 7) { self Menu_Loot_Close(); return; }
			else { self Menu_Loot_Claim(self.loot_menu_pos); self.lootboxitemcount--; self Menu_Loot_Update_Menu(); }
			if (self.lootboxitemcount < 2) 
			{
				// Patch V1.1, Added code checks for any remaining items in the loot box.
				// If any are found, Close Loot menu is aborted.
				for(i = 0; i < 8; i++) 
				{ 
					if (isDefined(self.loot[i])) 
					{ 
						if (self.loot[i] != "") 
						{ 
							break; 
						} 
					}
					if (i == 7)  { self Menu_Loot_Close(); return; }
				}
			}
			self Menu_Inventory_Info_Bar_Update_Mapping();
			wait .1;
		}
		wait .05;
	}
}
Menu_Loot_Update_Menu()
{ 
	str = self.lootboxrarity;
	for(x=0;x<7;x++)
	{
		luck = RandomIntRange(0,2);
		if (self.loot[x] != "") 
		{ 
			str += "\n";
			if (self.eastereggeffect && luck == 0)
			{ str += "<Corrupted data>"; }
			else { str += DisplayStringMod(self.loot[x], 16); }
		}
		else { if (self.eastereggeffect && luck == 0) { str += "\n<Corrupted data>"; } else { str += "\n>--------<"; } }
	}
	str += "\nExit Menu";
	self.inventory_display_string = str; 
	self.inventory_menu_HUD setSafeText(self.inventory_display_string);
}
LootBox_Spawner()
{
	level endon("game_ended");
	if (level.lc.size < 8) { return; } // 8 points must be defined to work.
	index = -1;
	fakeindex = 0;
	while(true)
	{
		if (level.activelootboxes < 8)
		{
			index++;
			if (index >= 8) { index = 0; }
			if (isTheTrapQueueEmpty(fakeindex))
			{
				location = RandomIntRange(0, level.lc.size); // Is atleast 8.
				level thread Spawn_LootCrate(index, location);
			}
			else
			{
				level thread AAT_Spawn_FakeLootCrate(index, level.trapsqueue[fakeindex], level.trapsqueueplayers[fakeindex]);
				fakeindex++;
			}
			wait .5;
		}
		else { wait 8; }
	}
}
isTheTrapQueueEmpty(i)
{
	if (!isDefined(level.trapsqueue[i])) { return true; }
	return false;
}
LB_DEBUG()
{
	for(x=0;x<7;x++) { self.loot[x] = self thread Generate_DEBUG_Loot(); }
	self.lootboxrarity = "Debugger";
	self.lootboxitemcount = items;
	self.inventory_menu_BG.color = (0,0,1);
	self.loot_menu_Scroller.color = (1,0,0);
	self.inventory_menu_HUD.color = (0,1,0);
	self thread Menu_Loot_Open();
}
Generate_DEBUG_Loot()
{
	luck = RandomIntRange(0,100);
	retval = "";
	if (luck < 25) { retval = Loot_Uncommon_gun(); } // 25% chance of a gun
	else if (luck < 35) { retval = Loot_Booster(); } // 10% chance of a booster
	else if (luck < 50) { retval = Loot_Perk(); }  // 15% chance of a perk
	else if (luck < 75) { retval = Loot_AAT(); } // 25% chance of a AAT
	else { retval = Loot_Ability(); } // 25% chance for an ability
	retval = Loot_SP_Rare();
	return retval;
}
Claim_SP_From_Loot_Box(str)
{
	// Format: '[SP] <num>'
	num = 0;
	if (str.size < 6) { self iprintlnbold("Code Error: Tried to claim SP from an invalid string!"); return; }
	for(x = 5; x < str.size; x++)
	{
		num *= 10;
		if (str[x] == "0" || str[x] == "1" || str[x] == "2" || str[x] == "3" || str[x] == "4" || str[x] == "5" || str[x] == "6" || str[x] == "7" || str[x] == "8" || str[x] == "9")
		{
			num += int(str[x]);
		}
		else { break; } // Not a number
	}
	self.sp += num;
	self iprintln("Claimed " + num + " survivor points!");
}


