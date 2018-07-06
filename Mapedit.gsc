init_MapEdit()
{
	if(getDvar("mapname") == "mp_nuketown_2020")
		level thread Nuketown();
	if(getDvar("mapname") == "mp_hijacked")
		level thread Hijacked();
	if(getDvar("mapname") == "mp_express")
		level thread Express();
	if(getDvar("mapname") == "mp_meltdown")
		level thread Meltdown();
	if(getDvar("mapname") == "mp_drone")
		level thread Drone();
	if(getDvar("mapname") == "mp_carrier")
		level thread Carrier();
	if(getDvar("mapname") == "mp_overflow")
		level thread Overflow();
	if(getDvar("mapname") == "mp_slums")
		level thread Slums();
	if(getDvar("mapname") == "mp_turbine")
		level thread Turbine();
	if(getDvar("mapname") == "mp_raid")
		level thread Raid();
	if(getDvar("mapname") == "mp_la")
		level thread Aftermath();	
	if(getDvar("mapname") == "mp_dockside") 
		level thread Cargo();	
	if(getDvar("mapname") == "mp_village")
		level thread Standoff();
	if(getDvar("mapname") == "mp_nightclub")
		level thread Plaza();	
	if(getDvar("mapname") == "mp_socotra")
		level thread Yemen();
	if(getDvar("mapname") == "mp_dig")
		level thread Dig();	
	if(getDvar("mapname") == "mp_pod")
		level thread Pod();	
	if(getDvar("mapname") == "mp_takeoff")
		level thread Takeoff();	
	if(getDvar("mapname") == "mp_frostbite")
		level thread Frost();	
	if(getDvar("mapname") == "mp_mirage")
		level thread Mirage();	
	if(getDvar("mapname") == "mp_hydro")
		level thread Hydro();	
	if(getDvar("mapname") == "mp_skate")
		level thread Grind();	
	if(getDvar("mapname") == "mp_downhill")
		level thread Downhill();	
	if(getDvar("mapname") == "mp_concert")
		level thread Encore();	
	if(getDvar("mapname") == "mp_vertigo")
		level thread Vertigo();	
	if (getDvar("mapname") == "mp_magma")
		level thread Magma();
	if(getDvar("mapname") == "mp_studio")
		level thread Studio();	
	if(getDvar("mapname") == "mp_paintball")
		level thread Rush();	
	if(getDvar("mapname") == "mp_castaway")
		level thread Cove();	
	if(getDvar("mapname") == "mp_bridge")
		level thread Detour();
	if(getDvar("mapname") == "mp_uplink")
		level thread Uplink();
}
Standoff()
{ 
	level thread DeleteDeathBarriers();
	level.belowmapdeathbarrier = -3000;
	level.battlebusendorigin = (-11290,-7950,6000);
	level.battlebustimetotarget = 15;
	level.stormcenterpoint = (-169,-160,10);
	level.stormstartingradius = 25000;
	level.mapcustomentitylimit = 426;
	level thread spawnObject("collision_clip_wall_256x256x10", (594,-1615, -5), (0,0,90)); // Patches an exploitable hole in the map.
	/*
	if (level.debugger) {
		level thread SpawnChest((-752,-786,0),(0,0,0));
		level thread SpawnChest((-681,-459,0),(0,0,0));
		level thread SpawnChest((-690,-92,0),(0,0,0));
		level thread SpawnChest((-660,352,0),(0,0,0));
		level thread SpawnChest((-834,-121,0),(0,0,0));
		level thread SpawnItemDrop((-1454,-2283,0));
		level thread SpawnItemDrop((-1669,-1429,5));
		level thread SpawnItemDrop((-1194,-1253,8));
		level thread SpawnItemDrop((-1092,-932,8));
		level thread SpawnItemDrop((-1569,-505,8));
		
		level thread SpawnAmmoCrate((-452,918,10), (0,90,0));
		level thread SpawnAmmoCrate((-921,966,8), (0,90,0));
		level thread SpawnAmmoCrate((-735,657,0), (0,90,0));
	}
	*/
	ACL((-1584,1226,10));
	ACL((-2158,-2698,-5));
	ACL((-750,-2047,8));
	ACL((797,-1717,-1));
	ACL((2192,-1827,64));
	ACL((3975,-2454,-432));
	ACL((8853,-611,8));
	ACL((7583,2252,41));
	ACL((2410,5050,3));
	ACL((-1044,3796,4));
	ACL((-4729,2907,-49));
	ACL((210,12862,1074));
	ACL((6816,10514,918));
	ACL((1416,1460,8));
	
	AAL((-1492,506,8));
	AAL((-3476,8032,82));
	AAL((-6795,6898,63));
	AAL((-5816,3856,78));
	AAL((-4825,1126,0));
	AAL((-4533,-2382,0));
	AAL((-665,-4488,8));
	AAL((98,-4761,8));
	AAL((467,-4742,8));
	AAL((339,-2687,-5));
	AAL((1907,37,3));
	AAL((1737,1097,7));
	
	ASIL((1368,2943,11));
	ASIL((-2838,2249,8));
	ASIL((-3332,-264,0));
	ASIL((-427,-3495,9));
	ASIL((2856,-1721,-126));
	ASIL((4209,1946,-341));
	ASIL((-2041,-1326,6));
	// Inside the map
	ACL((-961,-1341,8));
	ACL((-921,-1021,155));
	ACL((245,-506,16));
	ACL((57,-271,165));
	ACL((-1262,-23,8));
	ACL((-187,1169,8));
	ACL((-112,1048,142));
	ACL((1072,752,144));
	ACL((873,-997,8));
	ACL((-261,-1298,40));
	
	ACL((-716,-1375,6));
	ACL((-155,-903,-3));
	ACL((890,-665,8));
	ACL((1257,-79,10));
	ACL((336,-386,152));
	ACL((515,380,8));
	ACL((531,874,57));
	ACL((761,1662,8));
	ACL((118,1159,8));
	ACL((-184,875,10));
	ACL((-1037,179,8));
	ACL((-992,620,80));
	ACL((-1499,-676,0));
	
	AAL((-151,1608,96));
	AAL((-308,1456,144));
	AAL((-561,567,4));
	AAL((-1591,354,8));
	AAL((-1543,-228,8));
	AAL((-1637,-1229,109));
	AAL((-1159,-1040,157));
	AAL((-391,-256,24));
	
	ASIL((-1385,-747,100));
	ASIL((-586,-703,79));
	ASIL((-545,-125,35));
	ASIL((-59,764,60));
	
	AAL((-248,-265,8));
	AAL((335,-183,16));
	AAL((880,312,8));
	AAL((992,1067,8));
	AAL((278,1082,8));
	AAL((-154,1474,8));
	AAL((-769,1067,8));
	AAL((-1015,470,8));
	AAL((-1796,-45,10));
	AAL((-1356,-463,13));
	AAL((-707,-1040,8));
	AAL((-863,-1669,144));
	AAL((-1169,1129,8));
	AAL((99,367,16));
	
	ASIL((-1537,-1510,0));
	ASIL((-47,-1366,-23));
	ASIL((1420,-336,0));
	ASIL((775,-271,0));
	ASIL((621,651,0));
	ASIL((1296,543,2));
	ASIL((-766,817,0));
	ASIL((-753,-326,0));
	ASIL((16,-538,156));
	
	ASDL((-1641,-2076,0));
	ASDL((656,-2157,-7));
	ASDL((302,587,0));
	ASDL((-633,568,75));
	ASDL((-91,-416,8));
	ASDL((718,1578,8));
	ASDL((-543,1898,12));
	ASDL((-1861,1067,4));
	ASDL((-2222,-1214,0));
	ASDL((3026,-295,-173));
	ASDL((-30,-1058,23));
	ASDL((746,-1110,8));
	ASDL((1632,-760,8));
	ASDL((-3170,1740,8));
	ASDL((1325,394,3));
	
	wait .1;
	level thread Forge_Teleport((-1584,-2376,0), (-1676,-2647,0));
	level thread Forge_Teleport((-1137,867,0), (-1488,888,0));
	level thread Forge_Teleport((817,1976,10), (803,2205,3));
	level thread Forge_Teleport((1537,-316,0), (1916,-357,42));
	level thread DoNotBuildZone((2010,2200,-10), (-2080,-2900,400));
	level thread Forge_CreateBattleBus((-3605,16736,6000));
}
Nuketown()
{ 
}

Hijacked()
{ 
}

Express()
{ }

Meltdown()
{ 
}

Drone()
{ 
}

Carrier()
{ }

Overflow()
{ }

Slums()
{ }

Turbine()
{ 
}

Raid() 
{ 
}

Aftermath()
{ 
}

Cargo()
{ 
}

Plaza()
{ }

Yemen()
{ 
}

Dig()
{ }

Pod()
{ }

Takeoff()
{ }

Frost()
{ }

Mirage()
{ }

Hydro()
{ }

Grind()
{ }

Downhill()
{ }

Encore()
{ }

Vertigo()
{ }

Magma()
{ }

Studio()
{ }

Rush()
{ }

Cove()
{ }

Detour()
{ }

Uplink()
{ }





























