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
	level.stormcenterpoint = (-169,-160,50);
	level.stormstartingradius = 25000;
	level.stormcircles = (8000,2500,1000);
	level.mapcustomentitylimit = 426; // Note to mapediters, The higher you set this, the more objects players can have at once, If you set it too high you will get an entity overflow.
	level thread spawnObject("collision_clip_wall_256x256x10", (594,-1615, -5), (0,0,90)); // Patches an exploitable hole in the map.
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
	level thread DoNotBuildZone((2010,2200,-1000), (-2080,-2900,500));
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
	level deletePreExistingEntites();
	level.stormcenterpoint = (-58,1401,-100);
	level.stormcircles = (10000,2800,500);
	level.belowmapdeathbarrier = -140;
	level.battlebusendorigin = (4356,-5434,3700);
	level.battlebustimetotarget = 15;
	level.stormstartingradius = 20000;
	level.mapcustomentitylimit = 400; // Note to mapediters, The higher you set this, the more objects players can have at once, If you set it too high you will get an entity overflow.
	level thread Forge_Teleport((-2496,4145,-67), (-949,3471,-67));
	level thread Forge_CreateBattleBus((-11639,8083,3700));
	level thread DoNotBuildZone((2312,3761,-1000), (-1577,-350,250));
	// Area added in Turned V2.1
	level spawnObject("p6_dockside_container_lrg_red", (-410,-1600,-200), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-1940,-200), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-2280,-200), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-2620,-200), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-2960,-200), (0,0,0));
	
	level spawnObject("p6_dockside_container_lrg_red", (-540,-2620,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-540,-2960,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-280,-2620,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-280,-2960,-60), (0,0,0));
	
	
	// Elevator
	level spawnObject("p6_dockside_container_lrg_red", (-540,-3300,-60), (0,0,0));
	
	level thread Forge_Elevator("p6_dockside_container_lrg_red", (-410,-3300,-200), (-410,-3300,-60), (0,0,0), 2, 4);
	level thread Forge_Elevator("p6_dockside_container_lrg_red", (-410,-1940,80), (-410,-1940,220), (0,0,0), 2, 4);
	
	level thread Forge_Elevator("p6_dockside_container_lrg_red", (-540,-2280,-60), (-540,-2280,80), (0,0,0), 2, 4);
	level thread Forge_Elevator("p6_dockside_container_lrg_red", (-280,-2280,-60), (-280,-2280,80), (0,0,0), 2, 4);
	
	level spawnObject("p6_dockside_container_lrg_red", (-670,-2280,80), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-2280,80), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-150,-2280,80), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-1600,220), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-1260,220), (0,0,0));
	
	
	level spawnObject("p6_dockside_container_lrg_red", (-280,-3300,-60), (0,0,0));
	
	level spawnObject("p6_dockside_container_lrg_red", (-540,-3650,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-3650,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-280,-3650,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-670,-3650,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-150,-3650,-60), (0,0,0));
	
	level spawnObject("p6_dockside_container_lrg_red", (-540,-4000,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-410,-4000,-60), (0,0,0));
	level spawnObject("p6_dockside_container_lrg_red", (-280,-4000,-60), (0,0,0));
	
	ACL((945,1224,62));
	ACL((847,1675,62));
	ACL((1160,1017,-57));
	ACL((1093,1705,-97));
	ACL((1090,2796,-67));
	ACL((1434,3292,-67));
	ACL((499,3313,-68));
	ACL((9,3240,35));
	ACL((118,4407,-67));
	ACL((338,5058,-67));
	ACL((1338,3932,-67));
	ACL((-503,3482,-35));
	ACL((-760,3130,-37));
	ACL((-297,2355,68));
	ACL((-1000,1986,-67));
	ACL((-1726,2374,-65));
	ACL((-884,926,-67));
	ACL((-1252,14,-67));
	ACL((-262,-642,-67));
	ACL((419,-515,69));
	ACL((1039,-600,-67));
	ACL((837,-26,-67));
	ACL((451,715,-67));
	ACL((373,1193,-100));
	ACL((-480,1622,-100));
	ACL((-952,-258,-67));
	ACL((-2107,3037,-65));
	ACL((-2180,5690,-67));
	ACL((-5048,6701,-67));
	ACL((-9556,5280,-67));
	
	ACL((-711,-3509,76));
	ACL((-702,-3805,76));
	ACL((-593,-4155,76));
	ACL((-215,-4155,76));
	ACL((-94,-3812,76));
	ACL((-94,-3488,76));
	ACL((-234,-2763,76));
	ACL((-565,-2765,76));
	ACL((-402,-2431,216));
	ACL((-406,-1093,356));
	ACL((-736,-989,205));
	
	AAL((-81,-1418,-64));
	AAL((-74,-1014,-65));
	AAL((-39,-560,-67));
	AAL((306,-88,-20));
	AAL((736,-120,-40));
	AAL((793,584,-67));
	AAL((825,1077,-97));
	AAL((1256,1518,62));
	AAL((639,1409,62));
	AAL((1083,1875,62));
	AAL((836,2262,-99));
	AAL((1124,3292,-67));
	AAL((596,2760,-73));
	AAL((281,3417,-67));
	AAL((-175,4018,-67));
	AAL((164,4464,-67));
	AAL((490,4316,-75));
	AAL((614,3846,-67));
	AAL((-565,2931,-67));
	AAL((-1167,2761,-67));
	AAL((-1826,2231,-64));
	AAL((-1532,1427,-65));
	AAL((-1127,1065,67));
	AAL((-240,1004,-100));
	AAL((-128,2092,-67));
	AAL((-3436,4031,-67));
	AAL((-5591,4786,-67));
	AAL((-6910,5956,-67));
	AAL((-9603,4883,-67));
	
	ASIL((-3030,4558,-67));
	ASIL((-364,3140,-74));
	ASIL((-887,2158,78));
	ASIL((-1321,1380,-67));
	ASIL((-1480,23,-67));
	ASIL((-1079,627,-56));
	ASIL((-365,-148,78));
	ASIL((-131,-163,78));
	ASIL((543,-797,69));
	ASIL((-392,-1736,-63));
	ASIL((-303,-2844,-63));
	ASIL((-344,-3873,76));
	ASIL((-311,-3391,76));
	ASIL((-555,-3350,76));
	ASIL((-243,-908,-67));
	ASIL((809,-303,-67));
	ASIL((409,985,-67));
	ASIL((-59,1629,-100));
	ASIL((920,1452,-97));
	ASIL((1365,2812,-67));
	ASIL((66,3715,-75));
	ASIL((685,4624,-75));
	ASIL((1239,4510,-75));
	ASIL((-52,4691,-75));
	ASIL((-1265,3170,-8));
	ASIL((-1837,2548,-61));
	ASIL((-1689,1758,-34));
	
	ASDL((-619,808,67));
	ASDL((-55,1426,-100));
	ASDL((151,3629,-75));
	ASDL((-834,3672,-67));
	ASDL((-1396,2691,-67));
	ASDL((-2513,5285,-67));
	ASDL((-4916,4717,-67));
	ASDL((-704,1831,67));
	ASDL((-784,1657,67));
	ASDL((-50,690,-67));
	ASDL((232,-565,-67));
	ASDL((-701,-2430,216));
	ASDL((-726,-2124,216));
	ASDL((-102,-2434,216));
	ASDL((-103,-2134,216));
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




































