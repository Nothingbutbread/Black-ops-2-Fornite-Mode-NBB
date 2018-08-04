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
Drone()
{ 
	level thread DeleteDeathBarriers();
	level.belowmapdeathbarrier = -325;
	level.stormstartingradius = 25000;
	level.stormcircles = (8000,2500,1000);
	level.stormcenterpoint = (-2248,-2251,82);
	level.battlebusendorigin = (-11267,-12396,3000);
	level.stormstartingradius = 22000;
	level.mapcustomentitylimit = 225;
	level.battlebustimetotarget = 20;
	level spawnObject("collision_clip_wall_512x512x10", (-606,-2150,105), (0,0,90)); // Patches another fall out area
	level spawnObject("collision_clip_wall_512x512x10", (-241,-1849,105), (0,0,90));
	level spawnObject("collision_clip_wall_512x512x10", (319,-1749,90), (0,0,90));
	level spawnObject("p6_dockside_container_lrg_orange", (2543, -6265, -130), (0, 0, 0));
    level spawnObject("p6_dockside_container_lrg_orange", (2546, -6617, -130), (0, 180, 0));
    level spawnObject("p6_dockside_container_lrg_orange", (2543, -6973, -130), (0, 0, 0));
    level spawnObject("p6_dockside_container_lrg_orange", (2546, -7324, -130), (0, 180, 0));
   // level spawnObject("p6_dockside_container_lrg_orange", (), (0, 0, -35));
    ACL((1008,-1118,240));
    ACL((834,-880,240));
    ACL((425,-616,240));
    ACL((-448,-716,263));
    ACL((25,-803,-32));
    ACL((714,730,61));
    ACL((1408,1862,59));
    ACL((1265,2923,320));
    ACL((367,2902,346));
    ACL((83,3057,353));
    ACL((-531,2847,324));
    ACL((-554,2433,307));
    ACL((-380,1513,132));
    ACL((529,1409,120));
    ACL((383,840,264));
    ACL((-233,781,264));
    ACL((-982,643,264));
    ACL((-1364,1441,136));
    ACL((-885,-2464,96));
    ACL((-1557,-1847,120));
    ACL((-2358,-2104,90));
    ACL((-516,-2198,157));
    ACL((396,-1652,95));
    ACL((752,-1943,96));
    ACL((934,-2064,94));
    ACL((1369,-1808,112));
    ACL((1215,-1607,108));
    ACL((1318,-59,311));
    ACL((1758,1963,437));
    ACL((1599,4395,618));
    
    ACL((-572,8630,322));
    ACL((-290,8859,322));
    ACL((7,8556,322));
    ACL((-314,8347,322));
    ACL((15,7826,322));
    ACL((334,8092,322));
    ACL((-1590,2869,538));
    ACL((-4282,774,80));
    ACL((-6524,-1229,108));
    ACL((-8706,158,50));
    
    ACL((-5361,-8850,795));
    ACL((-6747,-8170,802));
    ACL((-6571,-7000,706));
    ACL((-5268,-7661,783));
    ACL((-4773,-7464,710));
    ACL((-2006,-7909,315));
    
    ASIL((-2277,-3807,79));
    ASIL((-1360,-2654,44));
    ASIL((1125,-3215,110));
    ASIL((2356,-1939,565));
    ASIL((2636,1006,714));
    ASIL((2173,3976,934));
    ASIL((976,5149,661));
    ASIL((-297,4297,804));
    ASIL((-3091,2601,832));
    ASIL((-5890,2069,80));
    ASIL((-5930,-350,80));
    ASIL((-5035,-1497,80));
    ASIL((-4590,-2315,62));
    ASIL((-2367,-4870,103));
    ASIL((-2463,-6869,159));
    ASIL((-3098,-9082,218));
    ASIL((-4887,-11799,363));
    ASIL((-6857,-11274,944));
    ASIL((-6331,-8704,877));
    ASIL((-5051,-6392,659));
    ASIL((-439,-6381,366));
    ASIL((2539,-7330,6));
    ASIL((2540,-6267,6));
    ASIL((5237,-6590,444));
    ASIL((-1844,-554,96));
    ASIL((-850,197,184));
    ASIL((-545,779,264));
    ASIL((-27,1518,113));
    ASIL((-82,424,112));
    ASIL((-661,-834,-25));
    ASIL((-1046,-1011,264));
    ASIL((-688,1812,136));
    ASIL((592,2391,155));
    ASIL((1068,1216,57));
    ASIL((699,-96,6));
    
    ASDL((-61,-1186,240));
    ASDL((-273,-905,240));
    ASDL((81,-100,94));
    ASDL((900,1503,120));
    ASDL((451,2394,151));
    ASDL((-303,2395,307));
    ASDL((110,1226,267));
    ASDL((-436,558,164));
    ASDL((-1206,-1638,64));
    ASDL((-2361,-3215,79));
    ASDL((-3955,-5964,505));
    ASDL((-5224,-6664,693));
    ASDL((-5284,-8342,787));
    ASDL((-6362,-8694,875));
    ASDL((-6684,-7572,747));
    ASDL((-5795,-7160,735));
    ASDL((-2114,-10345,951));
    ASDL((-4451,-9780,548));
    ASDL((2253,-709,624));
    
    AAL((1418,-804,322));
    AAL((1097,4922,319));
    AAL((815,4493,323));
    AAL((927,2198,218));
    AAL((842,1886,210));
    AAL((284,1395,120));
    AAL((-258,1303,131));
    AAL((144,1044,120));
    AAL((130,459,120));
    AAL((-34,-476,90));
    AAL((-357,-817,12));
    AAL((-11,-1434,-7));
    AAL((-1212,-645,96));
    AAL((-938,176,98));
    AAL((-1620,736,96));
    AAL((-783,823,96));
    AAL((-1237,1164,200));
    AAL((-728,896,264));
    AAL((-506,102,264));
    AAL((-558,-567,264));
    AAL((139,-1310,240));
    AAL((1062,-517,72));
    AAL((555,264,38));
    AAL((524,1065,124));
    AAL((782,775,264));
    AAL((-3270,-5251,313));
    AAL((-6334,-4980,446));
    AAL((-9274,-6509,250));
    AAL((-9784,-10922,779));
    AAL((-6603,-10837,923));
    AAL((-2691,-11123,787));
	level thread DoNotBuildZone((1475,2751,-1000), (-2329,-2312,1000));
	level thread Forge_Teleport((968,3684,299), (985,4017,303));
	level thread Forge_Teleport((-2006,-1949,80), (-2013,-2268,80));
	level thread Forge_CreateBattleBus((3441,9200,3000));
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









































