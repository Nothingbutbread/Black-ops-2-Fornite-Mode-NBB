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

Nuketown()
{ 
	level thread DeleteDeathBarriers();
	level thread BlackListedZone((761.5,-827,-1000),(1214,-424,1000)); // Patches a fallout area
	// East side out of map blockers
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (90,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (602,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1114,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1370,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-422,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-934,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1190,-1225,-60), (0,0,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1273,-1043,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1513,-535,-60), (0,135,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1650,-221,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-1231,-540, 275), (0,135,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1594,-980,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1594,-570,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1594,-250,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1250,-980,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (1250,-703,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (980,-1053,-60), (0,90,0));
	level Forge_Spawn_Object("collision_clip_wall_256x256x10", (739,-631,-60), (0,90,0));
	level thread Forge_Teleport((1463,25,-63),(1429,-1092,-60));
	level thread Forge_Teleport((-1631,108,-64),(-1622,-12,-64));
	level thread Forge_Teleport((-226,-334,-60),(-241,-743,-60));
	// West side out of map blockers
	level thread Forge_Teleport((-1229,993,-63),(-1151,1169,-60));
	level thread Forge_Teleport((1330,1066,-63),(1263,1209,-60));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (150,1765,-60), (0,0,90));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-390,1686,-60), (0,0,90));
	
	level.finalspawnpoint = (108,344,-37);
	level.deadmansskybarrier = 1000;
	level.belowmapdeathbarrier = -100;
	
	ACL((534,1160,-62));
	ACL((374,1570,-54));
	ACL((-361,1595,-54));
	ACL((-445,1114,-62));
	ACL((-1509,1643,-62));
	ACL((1348,1750,-62));
	
	ACL((1597,1074,-55));
	ACL((1917,678,-64));
	ACL((1574,26,-62));
	ACL((807,6,-62));
	ACL((940,115,-56));
	ACL((871,453,-56));
	ACL((729,47,80));
	ACL((1107,475,80));
	ACL((494,296,90));
	ACL((682,723,-54));
	
	ACL((-39,1105,-47));
	ACL((33,426,-16));
	ACL((-44,-284,-67));
	ACL((-557,824,-63));
	ACL((-1771,841,-63));
	ACL((-1918,678,-64));
	ACL((-1932,158,-61));
	ACL((-1390,70,-48));
	ACL((-832,15,-56));
	ACL((-727,526,-56));
	ACL((-698,548,80));
	ACL((-171,562,73));
	ACL((1270,-1204,-63));
	ACL((1573,-81,-64));
	ACL((477,-415,-61));
	ACL((959,-858,-64));
	ACL((180,-1204,-65));
	ACL((-7,-844,-66));
	ACL((-446,-552,-60));
	ACL((-1314,-717,-62));
}

Hijacked()
{ 
	level thread DeleteDeathBarriers();
	level.finalspawnpoint = (1198,395,20);
	level.deadmansskybarrier = 1000;
	level.belowmapdeathbarrier = -350;
	ACL((2721,-1,20));
	ACL((2139,-132,20));
	ACL((2157,146,20));
	ACL((1570,0,12));
	ACL((1198,395,20));
	ACL((550,395,20));
	ACL((874,184,20));
	ACL((955,-356,20));
	ACL((494,112,20));
	ACL((712,-252,20));
	ACL((893,-218,156));
	ACL((404,105,164));
	ACL((396,-216,164));
	ACL((1256,-456,20));
	ACL((363,-460,20));
	ACL((-65,-518,80));
	ACL((-366,-518,80));
	ACL((-380,-81,12));
	ACL((-59,96,12));
	ACL((-750,307,20));
	ACL((-310,515,30));
	ACL((89,496,20));
	ACL((-795,-290,-20));
	ACL((-1027,-395,-43));
	ACL((-1386,-395,-43));
	ACL((-1080,-116,20));
	ACL((-1226,-3,-43));
	ACL((-1196,258,-43));
	ACL((-968,395,-43));
	ACL((-177,649,-49));
	ACL((-1926,245,-104));
	ACL((-1913,-328,-107));
	ACL((-2428,3,-91));
	ACL((-2841,-386,-171));
	ACL((-2871,167,-171));
	ACL((-3434,51,-288));
	ACL((-3284,-257,-288));
	ACL((-1638,-23,92));
	ACL((-1240,-98,92));
	ACL((-1058,85,170));
	ACL((-1021,-121,-171));
	ACL((-592,236,-171));
	ACL((-221,-81,-171));
	ACL((112,269,-171));
	ACL((311,-29,-105));
}

Express()
{ }

Meltdown()
{ 
	level.finalspawnpoint = (772,1682,56);
	level.deadmansskybarrier = 1000;
	level.belowmapdeathbarrier = -300;
	ACL((20,4390,-139));
	ACL((-119,3241,-63));
	ACL((-464,2934,-63));
	ACL((-399,1832,52));
	ACL((-255,993,-55));
	ACL((155,265,-63));
	ACL((-242,-408,-63));
	ACL((79,-1017,-127));
	ACL((944,-1285,-135));
	ACL((1501,-339,-135));
	ACL((2088,457,-135));
	ACL((2401,1713,-111));
	ACL((1664,2528,-111));
	ACL((1781,3248,-135));
	ACL((1179,4252,-139));
	ACL((623,3932,-70));
	ACL((383,3107,-63));
	ACL((611,3116,72));
	ACL((1340,2724,-63));
	ACL((516,1898,56));
	ACL((1076,1437,56));
	ACL((1430,2312,56));
	ACL((888,1691,-72));
	ACL((504,427,-63));
	ACL((510,267,72));
	ACL((183,1024,-63));
	ACL((1335,667,-63));
	ACL((162,2367,-63));
}

Drone()
{ 
	level thread DeleteDeathBarriers();
	level.finalspawnpoint = (-655,-706,-24);
	level.deadmansskybarrier = 1000;
	level.belowmapdeathbarrier = -325;
	ACL((-1212,-2464,65));
	ACL((-15,-1483,5));
	ACL((507,-386,20));
	ACL((834,-880,240));
	ACL((17,-685,240));
	ACL((-808,-1657,164));
	ACL((-1071,-687,265));
	ACL((-1922,-443,96));
	ACL((-890,-208,98));
	ACL((-1098,772,96));
	ACL((-1030,968,264));
	ACL((144,1214,267));
	ACL((817,1051,264));
	ACL((818,1065,124));
	ACL((1408,1862,60));
	ACL((100,1827,141));
	ACL((-531,3021,346));
	ACL((1266,2922,320));
	ACL((-1022,1336,136));
	ACL((-536,2441,307));
	ACL((659,1906,210));
	ACL((1112,3782,311));
	level thread Forge_Teleport((968,3684,299), (985,4017,303));
	level thread Forge_Teleport((-2006,-1949,80), (-2013,-2268,80));
	//Outside of map
	//level thread BlackListedZone((-4253,-2073,500),(-2790,-1000,-9999)); // Patches a fallout area
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-606,-2150,105), (0,0,90)); // Patches another fall out area
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (-241,-1849,105), (0,0,90));
	level Forge_Spawn_Object("collision_clip_wall_512x512x10", (319,-1749,90), (0,0,90));
	ACL((978,5133,660));
	ACL((-1323,3269,441));
	ACL((-8182,2150,80));
	ACL((-4282,1117,80));
	ACL((-6040,-1664,120));
	ACL((-9527,350,45));
	ACL((-13512,4581,1017));
	ACL((-2384,-2793,75));
	ACL((-3243,-3873,82));
	ACL((-7383,-4130,145));
	ACL((-9477,-6515,195));
	ACL((-12751,-7853,88));
	ACL((-15757,-6432,285));
	ACL((-15892,-9221,912));
	ACL((-10619,-10132,630));
	ACL((-9465,-13279,902));
	ACL((-6518,-12663,784));
	ACL((-3957,-14254,551));
	ACL((-3691,-11076,374));
	ACL((-5338,-8893,790));
	ACL((-6072,-6863,706));
	ACL((-3081,-6372,348));
	ACL((-761,-6885,401));
	ACL((2731,-10466,256));
	ACL((1688,-7252,35));
	ACL((180,-4687,121));
	ACL((560,-3083,82));
	ACL((1313,-1767,94));
	ACL((2624,-3586,603));
	ACL((4646,-9100,28));
}

Carrier()
{ }

Overflow()
{ }

Slums()
{ }

Turbine()
{ 
	level.finalspawnpoint = (721,1564,243);
	level.deadmansskybarrier = 4300;
	level.belowmapdeathbarrier = -5000;
	level thread Forge_Teleport((-348,-2237,149), (-489,-2501,163));
	level thread Forge_Teleport((-1199,-4274,637), (-1933,-4542,9));
	level thread Forge_Teleport((-1146,3312,268), (-1157,3552,265));
	level thread Forge_Teleport((-3213,5788,-425), (-4145,5298,-1133));
	
	ACL((545,5358,-272));
	ACL((668,4261,-160));
	ACL((1951,3152,173));
	ACL((797,3155,175));
	ACL((-83,3878,6));
	ACL((-324,3857,89));
	ACL((-912,2860,291));
	ACL((-72,1845,207));
	ACL((-404,610,287));
	ACL((-443,-340,272));
	ACL((-1013,809,413));
	ACL((-560,1679,461));
	ACL((-1128,2164,429));
	ACL((-1565,1952,336));
	ACL((-1414,584,328));
	ACL((-556,-1157,165));
	ACL((121,-1591,162));
	ACL((578,-1349,401));
	ACL((934,-488,369));
	ACL((1688,503,288));
	ACL((1606,1549,203));
	ACL((2136,2138,162));
	ACL((1615,2681,187));
	ACL((2118,2639,28));
	ACL((1462,2383,30));
	ACL((1064,2948,-160));
	ACL((890,1916,15));
	ACL((389,1100,217));
	ACL((583,516,172));
	ACL((97,803,573));
	ACL((846,2156,176));
	
	ACL((-514,-2774,241));
	ACL((-1167,-4835,636));
	ACL((-1893,-6706,330));
	ACL((-3362,-3801,-635));
	ACL((-2016,-3217,-314));
	ACL((-1539,4212,208));
	ACL((-3339,5467,-385));
	ACL((-5009,5634,-1240));
	ACL((-5583,4490,-1538));
	ACL((-4615,2682,-1466));
	ACL((-2145,2738,-560));
}

Raid() 
{ 
	level.finalspawnpoint = (2193,3009,60);
	level.deadmansskybarrier = 4300;
	level.belowmapdeathbarrier = -3000;
	ACL((-432,2963,116));
	ACL((-305,3321,112));
	ACL((940,3313,114));
	ACL((531,2805,148));
	ACL((1110,2320,168));
	ACL((35,2561,176));
	ACL((703,1455,168));
	ACL((1047,1890,168));
	ACL((1412,2146,168));
	ACL((1406,1842,232));
	ACL((1579,1585,112));
	ACL((2383,911,110));
	ACL((2234,1578,78));
	ACL((1710,2344,146));
	ACL((2594,2241,110));
	ACL((3016,2312,180));
	ACL((3240,2188,192));
	ACL((3129,1918,180));
	ACL((3511,1990,39));
	ACL((3381,2718,32));
	ACL((4064,2583,36));
	ACL((4141,2695,32));
	ACL((3909,2311,32));
	ACL((4505,2670,32));
	ACL((4184,3574,32));
	ACL((4195,3733,26));
	ACL((3753,3606,30));
	ACL((3585,3773,30));
	ACL((2792,3887,-3));
	ACL((3256,4427,148));
	ACL((2992,4079,148));
	ACL((2731,4409,148));
	ACL((2612,3831,-3));
	ACL((2242,4546,-40));
	ACL((1723,4361,0));
	ACL((1063,4796,-3));
	ACL((1008,3843,-3));
	ACL((231,4662,-3));
	ACL((767,3741,114));
	ACL((1111,3360,116));
	ACL((1420,3010,116));
	ACL((1731,2703,108));
	ACL((2420,2486,112));
	ACL((2396,2843,56));
	ACL((2038,3105,56));
	ACL((3140,2831,102));
}

Aftermath()
{ 
	level thread DeleteDeathBarriers();
	level.finalspawnpoint = (-562,2279,-209);
	level.deadmansskybarrier = 700;
	level.belowmapdeathbarrier = -400;
	ACL((-600,2091,-231));
	ACL((-373,2435,-245));
	ACL((546,2227,-278));
	ACL((-46,1168,-178));
	ACL((220,335,-198));
	ACL((-458,-269,-259));
	ACL((-941,-1123,-259));
	ACL((-720,-198,-35));
	ACL((-62,284,-43));
	ACL((-811,-200,-259));
	ACL((-1632,-805,-267));
	ACL((-2631,-199,-200));
	ACL((-2061,723,-206));
	ACL((-2074,-14,-60));
	ACL((-1846,-39,-194));
	ACL((-2581,1414,-134));
	ACL((-2483,2116,-26));
	ACL((-1529,2352,-156));
	ACL((-2278,3108,-193));
	ACL((-2469,4024,-137));
	ACL((-2030,5233,-198));
	ACL((-1517,4999,-64));
	ACL((-1689,4284,-64));
	ACL((-1953,4340,-64));
	ACL((-864,4510,-262));
	ACL((-733,5474,-262));
	ACL((-169,4611,-198));
	ACL((-781,4112,-158));
	ACL((-130,4511,-198));
	ACL((-362,3333,-188));
	ACL((-1040,3703,-198));
	ACL((-1491,2871,7));
	ACL((-1504,1798,-15));
	ACL((-375,2020,35));
	ACL((-99,3004,-10));
	
	ACL((1705,1587,-198));
	ACL((3345,1592,-198));
	ACL((609,271,-43));
	ACL((-300,-413,-43));
	ACL((1261,-1564,-43));
	ACL((-1028,-239,-43));
	ACL((-1023,-2228,-43));
	ACL((1273,-1599,-43));
	ACL((205,-1380,-267));
	ACL((-390,-2240,-197));
	ACL((-941,-2240,-267));
	
	ACL((-3941,-10141,-207));
	ACL((-2910,-7321,-207));
	ACL((-2937,-3265,-206));
	ACL((-2923,-1227,-200));
	ACL((-3096,1226,-53));
	
	
	level thread Forge_Teleport((-2546,132,-292), (-3025,164,-206));
	level thread Forge_Teleport((-86,-1023,-267), (-101,-1331,-267));
	level thread Forge_Teleport((1099,-2153,-43), (-335,-2037,-216));
	level thread Forge_Teleport((705,-1124,-43), (-700,-385,-43));
	
	level thread Forge_Teleport((-122,-70,-43), (93,-121,-43));
	level thread Forge_Teleport((600,848,-206), (342,848,-206));
}

Cargo()
{ 
	level thread DeleteDeathBarriers();
	level.finalspawnpoint = (-58,1401,-100);
	level.deadmansskybarrier = 800;
	level.belowmapdeathbarrier = -150;
	
	level thread Forge_Teleport((-2496,4145,-67), (-949,3471,-67));
	ACL((-964,3738,-67));
	ACL((-583,3546,-35));
	ACL((-175,4080,-67));
	ACL((303,3065,-68));
	ACL((669,3292,-67));
	ACL((1056,2758,-67));
	ACL((0,3135,-72));
	ACL((-649,2824,-67));
	ACL((-297,2355,68));
	ACL((-992,2198,78));
	ACL((-897,2366,-67));
	ACL((-1702,1743,-34));
	ACL((-901,1252,-57));
	ACL((-1834,1365,-62));
	ACL((-1450,867,-65));
	ACL((-1648,-178,-62));
	ACL((-674,529,-67));
	ACL((-626,635,67));
	ACL((-1023,998,67));
	ACL((-836,-833,-64));
	ACL((-219,-1203,-67));
	ACL((564,-450,69));
	ACL((-38,114,-20));
	ACL((-227,-201,78));
	ACL((815,-607,-67));
	ACL((1140,335,-67));
	ACL((1055,482,-67));
	ACL((825,1077,-97));
	ACL((1093,1705,-97));
	ACL((936,1577,62));
	ACL((945,1224,62));
	ACL((393,555,-67));
	ACL((441,2154,-67));
	
	ACL((-2107,3064,-65));
	ACL((-3457,3850,-67));
	ACL((-3474,4897,-67));
	ACL((-3214,5818,-67));
	ACL((-4998,5864,-67));
	ACL((-5450,4924,-67));
	ACL((-7119,3507,-67));
	ACL((-8311,4893,-67));
	ACL((-8259,5691,-67));
	ACL((-9547,5739,-67));
	ACL((-11770,4089,-67));
	ACL((-13590,5063,-67));
	ACL((-15726,3756,-67));
	ACL((-14502,6456,-67));
}

Standoff()
{ 
	level thread DeleteDeathBarriers();
	level.finalspawnpoint = (-442,-500,10);
	level.deadmansskybarrier = 4300;
	level.belowmapdeathbarrier = -3000;
	ACL((489,-188,16));
	ACL((69,-513,16));
	ACL((-361,414,12));
	ACL((249,-538,155));
	ACL((-595,-1307,40));
	ACL((577,-1144,5));
	ACL((1195,-1006,10));
	ACL((1656,403,10));
	ACL((995,1067,10));
	ACL((724,2001,10));
	ACL((188,1362,10));
	ACL((149,928,150));
	ACL((-1346,644,10));
	ACL((-1578,-326,10));
	ACL((-1810,-1700,10));
	ACL((-866,-1306,10));
	ACL((-442,-247,10));
	ACL((-1313,1615,10));
	ACL((-1041,3782,5));
	ACL((1977,4285,5));
	ACL((1994,1603,5));
	ACL((1233,1645,10));
	ACL((1818,898,90));
	ACL((1791,-1215,10));
	Forge_Spawn_Object("collision_clip_wall_256x256x10", (594,-1615, -5), (0,0,90)); // Patches an exploitable hole in the map.
	ACL((729,-1796,10));
	ACL((-775,-2062,10));
	ACL((-2036,-1512,10));
	ACL((-1987,430,10));
	ACL((-4493,1215,10));
	ACL((-4860,2813,-45));
	ACL((-4805,4726,30));
	ACL((-7384,5239,1025));
	ACL((-9802,8688,585));
	ACL((-11917,12524,1762));
	ACL((-10576,16536,4248));
	ACL((-6860,15923,2195));
	ACL((-849,11350,1615));
	ACL((2390,10880,45));
	ACL((8683,12526,305));
	ACL((8477,17431,2537));
	ACL((9540,10507,295));
	//ACL((16234,5538,25));
	ACL((413,-4508,10));
	ACL((7647,2239,45));
	ACL((6709,4835,80));
	ACL((3363,3481,-154));
	ACL((4467,5862,-85));
	ACL((-248,1704,11));
	ACL((680,3180,8));
	ACL((2280,591,62));
	ACL((120,7458,0));
	ACL((-2540,8795,14));
	ACL((-5224,8272,115));
	ACL((-8014,6903,4));
	ACL((-9064,-3967,-58));
	ACL((-7079,263,-152));
	ACL((-3622,-1219,-7));
	
	level thread Forge_Teleport((-1584,-2376,0), (-1676,-2647,0));
	level thread Forge_Teleport((-1137,867,0), (-1488,888,0));
	level thread Forge_Teleport((817,1976,10), (803,2205,3));
	level thread Forge_Teleport((1537,-316,0), (1916,-357,42));
	level thread SetDistanceCap(20300);
}

Plaza()
{ }

Yemen()
{ 
	level thread DeleteDeathBarriers();
	level.finalspawnpoint = (273,-885,200);
	level.deadmansskybarrier = 1500;
	level.belowmapdeathbarrier = -1080;
	ACL((-493,-855,288));
	ACL((-1208,-1103,200));
	ACL((-753,-1848,208));
	ACL((-1112,-473,201));
	ACL((-567,806,150));
	ACL((-402,1248,170));
	ACL((-528,903,320));
	ACL((-288,1256,313));
	ACL((-240,831,118));
	ACL((-36,1407,414));
	ACL((-168,1632,258));
	ACL((1092,1981,315));
	ACL((708,2370,283));
	ACL((1140,1371,283));
	ACL((886,1008,283));
	ACL((1112,671,283));
	ACL((1239,1104,208));
	ACL((1954,1211,208));
	ACL((2391,504,208));
	ACL((1711,422,208));
	ACL((1439,311,216));
	ACL((2086,-215,237));
	ACL((1863,-532,240));
	ACL((1872,-919,104));
	ACL((1441,-362,106));
	ACL((1378,-1173,105));
	ACL((837,-1516,104));
	ACL((-104,-1996,107));
	ACL((-104,-2201,241));
	ACL((78,-1516,264));
	ACL((329,-1694,269));
	ACL((-364,-527,147));
	ACL((104,-205,182));
	ACL((704,-553,122));
	ACL((804,773,46));
	ACL((239,486,152));
	ACL((381,238,151));
	
	level thread Forge_Teleport((-544,-2307,204), (-691,-2407,204));
	level thread Forge_Teleport((468,575,154), (-1136,5515,-1038));
	level thread Forge_Teleport((453,2410,279), (502,2672,279));
	level thread Forge_Teleport((-1665,1288,-1031), (-1090,1293,-119));
	level thread Forge_Teleport((1999,-775,144), (1571,-995,-1014));
	ACL((-1134,-1526,103));
	ACL((-1419,-2301,42));
	ACL((-728,-2579,208));
	ACL((-1875,1636,-1045));
	ACL((-2464,2398,-1024));
	ACL((-2230,2961,-825));
	ACL((-1846,2050,-1053));
	ACL((-1735,373,-861));
	ACL((-1237,462,-905));
	ACL((-4019,530,-1034));
	ACL((-3942,3294,-977));
	ACL((-4600,4639,-1043));
	ACL((-942,5254,-987));
	ACL((-233,-2490,345));
	ACL((664,2993,283));
	ACL((-185,2992,339));
	ACL((-1234,2649,315));
	ACL((-1598,4102,555));
	ACL((656,3286,719));
	ACL((-129,5236,815));
	ACL((1788,5615,957));
	ACL((1649,3003,1023));
	ACL((2339,-307,-1045));
	ACL((748,-941,-877));
	ACL((738,-1665,-995));
	ACL((-924,-2680,-1006));
	ACL((-1693,-1891,-872));
	ACL((-2734,-1812,-1047));
	ACL((-1904,249,-121));
	ACL((-867,921,-95));
	ACL((-1269,1946,-119));
	ACL((-1906,2487,-161));
	ACL((-2960,3104,-30));
	ACL((-2710,4889,134));
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





























