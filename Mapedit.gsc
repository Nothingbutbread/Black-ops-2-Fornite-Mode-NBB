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
Yemen() { 
	level thread DeleteDeathBarriers();	
	level.stormcenterpoint = (273,-885,200);
	level.stormcircles = (10000,3500,1250);
	level.belowmapdeathbarrier = -1080;
	level.mapcustomentitylimit = 500;
	level.stormstartingradius = 24000;
	level.battlebusendorigin = (-4190,-4092,4000);
	level.battlebustimetotarget = 18;
	ACL((-753,-1848,208));
	ACL((-199,-1760,216));
	ACL((7,-1490,264));
	ACL((434,-1311,264));
	ACL((-1208,-1103,200));
	ACL((-1405,-484,207));
	ACL((-686,-1036,288));
	ACL((-195,-351,216));
	ACL((160,-351,216));
	ACL((160,-628,216));
	ACL((-32,-664,216));
	ACL((-195,-610,216));
	ACL((-322,-573,216));
	ACL((-551,-64,106));
	ACL((239,486,152));
	ACL((383,318,154));
	ACL((1233,360,44));
	ACL((1725,759,208));
	ACL((2213,376,216));
	ACL((1886,-122,162));
	ACL((1907,-541,264));
	ACL((1419,-1152,107));
	ACL((422,-1502,114));
	ACL((-552,1232,169));
	ACL((-528,903,320));
	ACL((119,1256,176));
	ACL((795,2234,315));
	ACL((1144,791,283));
	ACL((636,2942,283));
	ACL((-372,2490,360));
	ACL((-1940,3544,442));
	ACL((-908,3488,618));
	ACL((469,3280,703));
	ACL((-1424,5322,779));
	ACL((-847,-2028,201));
	ACL((-1578,-1094,-120));
	ACL((-1725,234,-78));
	ACL((-1611,2267,-155));
	ACL((-3089,4581,114));
	ACL((-3121,4052,85));
	ACL((-3507,1925,-494));
	ACL((-1840,1631,-1043));
	ACL((-3836,275,-1031));
	ACL((-2814,-1879,-1047));
	ACL((-1900,-2286,-1019));
	ACL((760,-929,-875));
	ACL((2115,-201,-1012));
	ACL((-3629,4856,-1012));
	ACL((-938,5345,-1021));
	
	AAL((2042,1064,208));
	AAL((1506,1772,259));
	AAL((1092,1973,315));
	AAL((716,2025,285));
	AAL((420,1587,287));
	AAL((1239,975,209));
	AAL((1644,328,216));
	AAL((1044,624,42));
	AAL((607,782,67));
	AAL((304,1072,113));
	AAL((-332,1170,169));
	AAL((-720,903,169));
	AAL((-1052,100,191));
	AAL((-1112,-769,200));
	AAL((-552,-855,288));
	AAL((-432,-1189,177));
	AAL((7,-1263,264));
	AAL((396,-922,123));
	AAL((704,-604,122));
	AAL((1145,-75,79));
	AAL((1698,-684,240));
	AAL((249,-1309,121));
	AAL((-244,-1492,244));
	AAL((-2000,-941,-160));
	AAL((-2497,25,-121));
	AAL((-1384,415,-937));
	AAL((-2085,2347,-1018));
	AAL((-2231,2955,-826));
	AAL((-3503,1574,-983));
	AAL((-4467,4742,-1041));
	AAL((-2354,5437,-1041));
	AAL((665,551,154));
	AAL((1186,-1144,-1011));
	AAL((386,-2072,-1007));
	AAL((-2696,-1266,-1048));
	AAL((-3204,-243,-1029));
	AAL((-336,2976,359));
	AAL((-855,4669,692));
	
	ASIL((-672,-508,151));
	ASIL((37,-923,128));
	ASIL((363,-416,113));
	ASIL((823,551,39));
	ASIL((121,874,112));
	ASIL((43,1525,238));
	ASIL((527,2206,279));
	ASIL((1215,1652,266));
	ASIL((621,1212,235));
	ASIL((-58,203,75));
	ASIL((-727,-493,152));
	ASIL((-1036,-813,197));
	ASIL((-440,-1532,204));
	ASIL((-516,-2110,204));
	ASIL((-82,-2176,241));
	ASIL((402,-1816,119));
	ASIL((-1205,-2170,57));
	ASIL((-1492,-1259,-119));
	ASIL((-2395,-338,-121));
	ASIL((-1565,552,-121));
	ASIL((-1260,1660,-119));
	ASIL((-2164,2384,-159));
	ASIL((-2036,1044,-1022));
	ASIL((-3422,-1076,-1027));
	ASIL((-1907,-2798,-1051));
	ASIL((-2235,-1875,-1050));
	ASIL((-4536,2830,-1031));
	ASIL((-3473,5020,-1031));
	ASIL((-1595,5351,-1030));
	ASIL((-50,2738,316));
	ASIL((-1219,2839,315));
	
	ASDL((608,1771,279));
	ASDL((1569,1144,244));
	ASDL((2070,157,274));
	ASDL((1923,199,274));
	ASDL((1683,-203,236));
	ASDL((1438,-737,242));
	ASDL((-69,-2280,241));
	ASDL((-430,-1460,203));
	ASDL((-777,-450,152));
	ASDL((-64,861,175));
	ASDL((1021,704,283));
	ASDL((467,-477,139));
	ASDL((-1337,-2244,44));
	ASDL((-1730,-978,-127));
	ASDL((-2895,1154,-1015));
	ASDL((-3192,560,-1027));
	ASDL((-4176,1274,-1032));
	ASDL((-4643,3238,-1030));
	level thread DoNotBuildZone((-1157,-2856,0), (2094,2179,1000));
	level thread Forge_Teleport((-544,-2307,204), (-691,-2407,204));
	level thread Forge_Teleport((468,575,154), (-1136,5515,-1038));
	level thread Forge_Teleport((453,2410,279), (502,2672,279));
	level thread Forge_Teleport((-1665,1288,-1031), (-1090,1293,-119));
	level thread Forge_Teleport((1999,-775,144), (1571,-995,-1014));
	level thread Forge_CreateBattleBus((4528,5183,4000));
}
Drone() { 
	level thread DeleteDeathBarriers();
	level.belowmapdeathbarrier = -325;
	level.stormcircles = (8000,2500,1000);
	level.stormcenterpoint = (-210,-320,76);
	level.battlebusendorigin = (-11267,-12396,3000);
	level.stormstartingradius = 22000;
	level.mapcustomentitylimit = 500;
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
	level thread DeleteDeathBarriers();
	level.belowmapdeathbarrier = -100;
	level.battlebusendorigin = (-2201,-2411,300);
	level.battlebustimetotarget = 15;
	level.stormcenterpoint = (108,344,-37);
	level.stormstartingradius = 13000;
	level.stormcircles = (5000,2250,1000);
	level.mapcustomentitylimit = 400;
	level thread DoNotBuildZone((-1629,-238,-1000), (1409,1687,1000));
	level thread Forge_CreateBattleBus((4141,5050,300));
	
	level spawnObject("collision_clip_wall_512x512x10", (90,-1225,-60), (0,0,0));
	level spawnObject("collision_clip_wall_512x512x10", (602,-1225,-60), (0,0,0));
	level spawnObject("collision_clip_wall_512x512x10", (1114,-1225,-60), (0,0,0));
	level spawnObject("collision_clip_wall_512x512x10", (1370,-1225,-60), (0,0,0));
	level spawnObject("collision_clip_wall_512x512x10", (-422,-1225,-60), (0,0,0));
	level spawnObject("collision_clip_wall_512x512x10", (-934,-1225,-60), (0,0,0));
	level spawnObject("collision_clip_wall_512x512x10", (-1190,-1225,-60), (0,0,0));
	level spawnObject("collision_clip_wall_512x512x10", (-1273,-1043,-60), (0,90,0));
	level spawnObject("collision_clip_wall_512x512x10", (-1513,-535,-60), (0,135,0));
	level spawnObject("collision_clip_wall_512x512x10", (-1650,-221,-60), (0,90,0));
	level spawnObject("collision_clip_wall_512x512x10", (-1231,-540, 275), (0,135,0));
	level spawnObject("collision_clip_wall_512x512x10", (1594,-980,-60), (0,90,0));
	level spawnObject("collision_clip_wall_512x512x10", (1594,-570,-60), (0,90,0));
	level spawnObject("collision_clip_wall_512x512x10", (1594,-250,-60), (0,90,0));
	level spawnObject("collision_clip_wall_512x512x10", (1250,-980,-60), (0,90,0));
	level spawnObject("collision_clip_wall_512x512x10", (1250,-703,-60), (0,90,0));
	level spawnObject("collision_clip_wall_512x512x10", (980,-1053,-60), (0,90,0));
	level spawnObject("collision_clip_wall_256x256x10", (739,-631,-60), (0,90,0));
	level thread Forge_Teleport((1463,25,-63),(1429,-1092,-60));
	level thread Forge_Teleport((-1631,108,-64),(-1622,-12,-64));
	level thread Forge_Teleport((-226,-334,-60),(-241,-743,-60));
	level thread Forge_Teleport((-1229,993,-63),(-1151,1169,-60));
	level thread Forge_Teleport((1330,1066,-63),(1263,1209,-60));
	level spawnObject("collision_clip_wall_512x512x10", (150,1765,-60), (0,0,90));
	level spawnObject("collision_clip_wall_512x512x10", (-390,1686,-60), (0,0,90));
	
	ACL((1573,-1204,-62));
	ACL((1573,-78,-63));
	ACL((1270,-587,-63));
	ACL((548,-239,-60));
	ACL((404,-807,-61));
	ACL((718,-631,-63));
	ACL((959,-858,-63));
	ACL((24,-1204,-65));
	ACL((-1252,-1204,-60));
	ACL((-1401,-618,-62));
	ACL((-1629,-224,-62));
	ACL((-571,-224,-58));
	ACL((304,-1051,-60));
	ACL((544,1184,-62));
	ACL((265,1615,-54));
	ACL((-329,1609,-54));
	ACL((-484,1206,-62));
	ACL((-1666,1378,-62));
	ACL((-1375,1911,-62));
	ACL((1495,1714,-62));
	
	ACL((-683,67,-56));
	ACL((-835,298,-56));
	ACL((-1391,66,-48));
	ACL((-1892,145,-63));
	ACL((-2088,209,-63));
	ACL((-1918,678,-63));
	ACL((-1594,551,-63));
	ACL((-1771,841,-63));
	ACL((-1638,1203,-63));
	ACL((-948,796,-63));
	ACL((-756,516,-56));
	ACL((-515,259,-61));
	ACL((-1022,529,79));
	ACL((-626,484,79));
	ACL((-401,1008,-63));
	ACL((108,1069,-62));
	ACL((7,524,-37));
	ACL((153,313,-37));
	ACL((683,727,-54));
	ACL((1024,495,-56));
	ACL((885,173,-56));
	ACL((1069,467,79));
	ACL((730,361,79));
	ACL((726,47,79));
	ACL((1214,504,78));
	ACL((1748,714,-63));
	ACL((1247,898,-63));
	ACL((1192,173,-62));
	ACL((1814,90,-63));
	ACL((1917,687,-63));
	
	AAL((-1639,1201,-63));
	AAL((-1588,781,-63));
	AAL((-1076,501,-58));
	AAL((-938,10,-61));
	AAL((-522,222,-10));
	AAL((-573,293,-56));
	AAL((-954,713,79));
	AAL((-567,603,79));
	AAL((-818,736,-63));
	AAL((-151,190,-69));
	AAL((687,323,-54));
	AAL((861,411,-22));
	AAL((1375,498,-62));
	AAL((1821,322,-62));
	AAL((988,54,-62));
	AAL((447,1759,-62));
	AAL((-535,1777,-54));
	AAL((-1053,-192,-60));
	AAL((859,-858,-63));
	AAL((985,-387,-63));
	AAL((1270,-1204,-63));
	
	ASDL((1480,-244,-63));
	ASDL((568,-521,-61));
	ASDL((491,-1066,-12));
	ASDL((33,-893,-6));
	ASDL((-617,-973,-60));
	ASDL((-742,-476,-59));
	ASDL((-1063,-711,-62));
	ASDL((-1349,-315,-62));
	ASDL((-1462,427,-63));
	ASDL((-1162,743,77));
	ASDL((-429,-71,-59));
	ASDL((-195,550,63));
	ASDL((315,430,-63));
	ASDL((1668,253,-62));
	ASDL((1488,877,-55));
	ASDL((532,2036,-62));
	ASDL((-703,1974,-62));
	ASDL((-1269,1450,-62));
	
	ASIL((-1411,123,-62));
	ASIL((-937,1435,-62));
	ASIL((47,1944,-54));
	ASIL((841,2008,-62));
	ASIL((1117,1328,-62));
	ASIL((1613,234,-62));
	ASIL((1928,405,-60));
	ASIL((1293,427,18));
	ASIL((963,295,79));
	ASIL((598,152,79));
	ASIL((899,98,28));
	ASIL((1007,285,-56));
	ASIL((827,612,-56));
	ASIL((326,671,-61));
	ASIL((-289,751,-63));
	ASIL((-358,196,-60));
	ASIL((25,117,-67));
	ASIL((176,-294,-69));
	ASIL((-862,171,-56));
	ASIL((-1231,578,13));
	ASIL((-845,481,79));
	ASIL((-542,451,79));
	ASIL((-685,610,8));
	ASIL((-901,526,-56));
	ASIL((-1572,862,-63));
	ASIL((-1613,318,-64));
	ASIL((-1379,-418,-62));
	ASIL((-629,-1089,-60));
	ASIL((772,-1026,-63));
	ASIL((1428,-307,-63));
	ASIL((1432,-859,-63));
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
	level.mapcustomentitylimit = 500; // Note to mapediters, The higher you set this, the more objects players can have at once, If you set it too high you will get an entity overflow.
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

Plaza() { 
	level thread DeleteDeathBarriers();
	level deletePreExistingEntites();
	level.stormcenterpoint = ( -18033, 2533, -143 );
	level.stormcircles = ( 10000, 3500, 1250 );
	level.belowmapdeathbarrier = -620;
	level.mapcustomentitylimit = 500;
	level.stormstartingradius = 24000;
	level.battlebusendorigin = ( -10772, 7810, 1500 );
	level.battlebustimetotarget = 18;
	
	level thread DoNotBuildZone( ( -15278, 3980, -250 ), ( -19513, -299, 250 ) );
	level thread Forge_Teleport( ( -15995, 4220, -591 ), ( -16013, 3789, -191 ) );
	level thread Forge_Teleport( ( -18779, 3270, -591 ), ( -18606, 3100, -143 ) );
	level thread Forge_Teleport( ( -19625, 532, -591 ), ( -19330, 504, -191 ) );
	level thread Forge_Teleport( ( -14902, 3089, -191 ), ( -14679, 3086, -192 ) );
	level thread Forge_CreateBattleBus( ( -29333, -1890, 1500 ) );
	ACL( ( -19031, 250, -191 ) );
	ACL( ( -19031, -120, -191 ) );
	ACL( ( -19374, -62, -191 ) );
	ACL( ( -19384, 278, -180 ) );
	ACL( ( -18596, -8, -191 ) );
	ACL( ( -18586, -251, -191 ) );
	ACL( ( -18144, -107, -191 ) );
	ACL( ( -17628, 7, -139 ) );
	ACL( ( -17172, 978, -50 ) );
	ACL( ( -17046, 988, -46 ) );
	ACL( ( -16696, 1546, -46 ) );
	ACL( ( -16384, 1519, -50 ) );
	ACL( ( -16433, 1717, -50 ) );
	ACL( ( -15880, 1834, -137 ) );
	ACL( ( -15697, 2125, -138 ) );
	ACL( ( -15399, 2641, -191 ) );
	ACL( ( -15251, 3084, -191 ) );
	ACL( ( -15494, 3096, -191 ) );
	ACL( ( -15796, 3562, -191 ) );
	ACL( ( -15382, 3530, -191 ) );
	ACL( ( -15382, 3857, -191 ) );
	ACL( ( -15730, 3880, -191 ) );
	ACL( ( -15763, 2776, -139 ) );
	ACL( ( -16546, 2294, -191 ) );
	ACL( ( -16646, 3171, -192 ) );
	ACL( ( -16592, 3704, -191 ) );
	ACL( ( -16519, 3067, -191 ) );
	ACL( ( -16322, 3537, -47 ) );
	ACL( ( -16246, 2959, -63 ) );
	ACL( ( -17188, 2945, -191 ) );
	ACL( ( -17547, 2997, -143 ) );
	ACL( ( -17526, 3741, -143 ) );
	ACL( ( -17766, 2769, -143 ) );
	ACL( ( -18354, 2609, -143 ) );
	ACL( ( -18614, 2642, -143 ) );
	ACL( ( -19033, 2360, -145 ) );
	ACL( ( -19333, 1540, -191 ) );
	ACL( ( -18442, 1684, -190 ) );
	ACL( ( -18526, 1031, -191 ) );
	ACL( ( -19040, 821, -47 ) );
	ACL( ( -18473, 743, -63 ) );
	ACL( ( -17842, 1250, -191 ) );
	ACL( ( -17637, 2025, -87 ) );
	ACL( ( -17625, 2231, -87 ) );
	ACL( ( -17059, 1792, -87 ) );
	ACL( ( -18188, 3431, -591 ) );
	ACL( ( -16571, 3902, -591 ) );
	ACL( ( -15171, 3526, -591 ) );
	ACL( ( -15193, 2445, -591 ) );
	ACL( ( -16378, 530, -591 ) );
	ACL( ( -18146, -696, -591 ) );
	ACL( ( -19030, -527, -591 ) );
	ACL( ( -19399, 1163, -591 ) );
	ACL( ( -20906, 2530, -591 ) );
	ACL( ( -16711, 5268, -591 ) );
	AAL( ( -18703, -108, -191 ) );
	AAL( ( -18494, -138, -191 ) );
	AAL( ( -18183, -352, -191 ) );
	AAL( ( -18361, 624, -191 ) );
	AAL( ( -18773, 796, -191 ) );
	AAL( ( -18608, 1416, -192 ) );
	AAL( ( -19043, 1696, -190 ) );
	AAL( ( -18643, 1805, -181 ) );
	AAL( ( -18844, 2607, -143 ) );
	AAL( ( -18133, 3322, -143 ) );
	AAL( ( -18075, 2814, -143 ) );
	AAL( ( -18251, 2506, -143 ) );
	AAL( ( -17741, 2426, -87 ) );
	AAL( ( -17603, 1739, -87 ) );
	AAL( ( -18028, 1676, -160 ) );
	AAL( ( -17173, 2506, -163 ) );
	AAL( ( -17292, 1510, -87 ) );
	AAL( ( -17163, 643, -87 ) );
	AAL( ( -16686, 806, -79 ) );
	AAL( ( -16324, 1160, -79 ) );
	AAL( ( -16147, 1602, -87 ) );
	AAL( ( -15386, 2165, -191 ) );
	AAL( ( -15392, 2991, -191 ) );
	AAL( ( -15391, 3201, -191 ) );
	AAL( ( -16559, 3292, -63 ) );
	AAL( ( -16507, 2916, -63 ) );
	AAL( ( -16377, 3245, -191 ) );
	AAL( ( -17256, 3771, -191 ) );
	AAL( ( -18524, 3731, -591 ) );
	AAL( ( -19559, 2304, -591 ) );
	AAL( ( -19691, 128, -591 ) );
	AAL( ( -18484, -1087, -591 ) );
	AAL( ( -15789, 1154, -591 ) );
	ASDL( ( -18416, -470, -191 ) );
	ASDL( ( -18841, 376, -191 ) );
	ASDL( ( -18054, 1317, -155 ) );
	ASDL( ( -18003, 1987, -93 ) );
	ASDL( ( -17448, 2520, -110 ) );
	ASDL( ( -16807, 2549, -156 ) );
	ASDL( ( -15929, 2881, -191 ) );
	ASDL( ( -15146, 3283, -191 ) );
	ASDL( ( -14447, 3399, -240 ) );
	ASDL( ( -14127, 3559, -240 ) );
	ASDL( ( -13597, 3284, -240 ) );
	ASDL( ( -13540, 2851, -239 ) );
	ASDL( ( -13871, 2588, -240 ) );
	ASDL( ( -14221, 2581, -240 ) );
	ASDL( ( -14466, 2861, -240 ) );
	ASDL( ( -14201, 3142, -240 ) );
	ASDL( ( -16037, 3647, -156 ) );
	ASDL( ( -17118, 3473, -153 ) );
	ASDL( ( -18828, 1698, -152 ) );
	ASDL( ( -18440, 849, -63 ) );
	ASDL( ( -16331, 2890, -63 ) );
	ASDL( ( -17900, 141, -139 ) );
	ASDL( ( -15657, 2715, -139 ) );
	ASIL( ( -15150, 2788, -191 ) );
	ASIL( ( -15939, 2851, -191 ) );
	ASIL( ( -16520, 2603, -191 ) );
	ASIL( ( -17331, 2620, -171 ) );
	ASIL( ( -16651, 2716, -191 ) );
	ASIL( ( -15958, 2711, -191 ) );
	ASIL( ( -15090, 2910, -191 ) );
	ASIL( ( -15624, 3416, -191 ) );
	ASIL( ( -16878, 3706, -191 ) );
	ASIL( ( -17411, 3288, -168 ) );
	ASIL( ( -17909, 2884, -143 ) );
	ASIL( ( -18441, 2338, -143 ) );
	ASIL( ( -18640, 1582, -192 ) );
	ASIL( ( -19170, 1410, -190 ) );
	ASIL( ( -18868, 187, -191 ) );
	ASIL( ( -18797, -474, -191 ) );
	ASIL( ( -17908, -174, -191 ) );
	ASIL( ( -17485, 469, -139 ) );
	ASIL( ( -16807, 916, -87 ) );
	ASIL( ( -16261, 1662, -85 ) );
	ASIL( ( -16928, 1413, -87 ) );
	ASIL( ( -17469, 1962, -87 ) );
	ASIL( ( -16954, 2556, -191 ) );
	ASIL( ( -15859, 2388, -139 ) );
	ASIL( ( -14262, 3227, -240 ) );
	ASIL( ( -15085, 4312, -591 ) );
	ASIL( ( -17895, 4358, -591 ) );
	ASIL( ( -19750, 1362, -591 ) );
	ASIL( ( -19661, -590, -591 ) );
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




























































