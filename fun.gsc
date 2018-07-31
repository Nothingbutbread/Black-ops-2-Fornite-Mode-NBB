Fun_Taunt()
{
	self endon("death");
	self endon("disconnect");
	if (self.cantaunt)
	{
		self.cantaunt = false;
		t = RandomIntRange(0,10);
		iprintln("^2" + self.name + ":^" + t + " " + Fun_Taunt_Text());
		wait 7;
		self.cantaunt = true;
	}
	else { self iprintln("You must wait atleast 7 seconds before taunting again."); }
}
Fun_Taunt_Text()
{
	t = RandomIntRange(0,77);
	if (t == 0) { return "it's time to die assholes!"; }
	else if (t == 1) { return "I like the sound your corpse makes when I shoot it!"; }
	else if (t == 2) { return "I will fuck yo moma harder than she did your face!"; }
	else if (t == 3) { return "where the hell you going punk?"; }
	else if (t == 4) { return "where's your moma now pussy?"; }
	else if (t == 5) { return "I like turtles!"; }
	else if (t == 6) { return "overhere num nuts!"; }
	else if (t == 7) { return "come get sum'"; }
	else if (t == 8) { return "what a fucking Donald Trump Surporter!"; }
	else if (t == 9) { return "what a fucking Hillary Clinton Surprter!"; }
	else if (t == 10) { return "sorry about fucking your sister " + level.lastkilled.name; }
	else if (t == 11) { return "eat a dick!"; }
	else if (t == 12) { return "eat my moose cock!"; }
	else if (t == 13) { return "cunt fuckers!"; }
	else if (t == 14) { return "I like big grey elephants that sniff my dogs ass!"; }
	else if (t == 15) { return "doink!"; }
	else if (t == 16) { return "java.lang.nullPointerException"; }
	else if (t == 17) { return "big big small small grampa dick!"; }
	else if (t == 18) { return "want to hear a joke about my dick? Sorry it's too long!"; }
	else if (t == 19) { return "ahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh!"; }
	else if (t == 20) { return "surprise motherfuckers!"; }
	else if (t == 21) { return "the only way you win is by not playing!"; }
	else if (t == 22) { return "here piggy piggy!"; }
	else if (t == 23) { return "i'm so hot you'd get roasted just looking at me!"; }
	else if (t == 24) { return "Have you seen " + level.lastkilled.name + "'s dick? You'll need a microscope to see it"; }
	else if (t == 25) { return "I used to be an adventurer like you, then I took an arrow to the knee."; }
	else if (t == 26) { return "I used to be an adventurer like you, then I stuck my dick in " + level.lastkilled.name; }
	else if (t == 27) { return "why the fuck am I here? You'll so dumb!"; }
	else if (t == 28) { return "man who sit on toliet is high on pot."; }
	else if (t == 29) { return "get the fuck outa here kid!"; }
	else if (t == 30) { return "<-- is a retard!"; }
	else if (t == 31) { return "bomb! crack! ... sorry my dick is going at it!"; }
	else if (t == 32) { return "I like ass!"; }
	else if (t == 33) { return "your are so dumb, your playing Black ops 2!"; }
	else if (t == 34) { return "fuck fuck fuck fuck fuck fuck fuck fuck you!"; }
	else if (t == 35) { return "fuck you you you you you you you you you you!"; }
	else if (t == 36) { return "come get me you bitches!"; }
	else if (t == 37) { return "stop camping like a little bitch and bring some heat!"; }
	else if (t == 38) { return "fucking campers!"; }
	else if (t == 39) { return "congrats kid, do you want a cookie!"; }
	else if (t == 40) { return "the beef is so raw in here it's mooing!"; }
	else if (t == 41) { return "hey guys I am gay as fuck!"; }
	else if (t == 42) { return "Why so much salt?"; }
	else if (t == 43) { return "come rub me, I like it!"; }
	else if (t == 44) { return "come and line up, little kids! I'll make this quick."; }
	else if (t == 45) { return "I would lend a hand but you're already down all limbs!"; }
	else if (t == 46) { return "hey your dad called, he needs a hole to get into!"; }
	else if (t == 47) { return "hey " + level.lastkilled.name + " I will bury you in dog poop!"; }
	else if (t == 48) { return "Go to hell: " + level.lastkilled.name; }
	else if (t == 49) { return "Go back to preschool, get outta the genepool, try your best to not drool!"; }
	else if (t == 50) { return "Hey guys this is an M rated game and y'all sound like your under 17!"; }
	else if (t == 51) { return "$ python3 fuckdisshit.py go kill yourself >> Good!"; }
	else if (t == 52) { return "Subscribe to Nothingbutbread on youtube, he made this!"; }
	else if (t == 53) { return "Goodbye douches!"; }
	else if (t == 54) { return "I am the ^1H^2A^3C^1K^2E^3R ^1M^2A^3N^4!"; }
	else if (t == 55) { return "No kid, I'm not using aimbot you just suck!"; }
	else if (t == 56) { return "Time to push your buttons!\n^7[{+usereload}] [{+gostand}] [{+actionslot 1}] [{+actionslot 2}] [{+actionslot 3}] [{+actionslot 4}]"; }
	else if (t == 57) { return "Press [{+actionslot 1}] for free dick in yo face!"; }
	else if (t == 58) { return "Bitch please!"; }
	else if (t == 59) { return "This lobby is full of incest kids!"; }
	else if (t == 60) { return "Damn kids, lay off the sour cream!"; }
	else if (t == 61) { return "Have you guys see " + level.lastkilled.name + "'s face? It'd kill ya!"; }
	else if (t == 62) { return "My speling is like your skilz, non exisnt!"; }
	else if (t == 63) { return "Hey guys, I love chipmonks!"; }
	else if (t == 64) { return "I ^1F^2U^3C^1K^2E^3D ^5Y^4O ^1M^2O^3M^4!"; }
	else if (t == 65) { return "Wow, just wow, wow wow!"; }
	else if (t == 66) { return "I like spongbob!"; }
	else if (t == 67) { return "tried to swim in lava."; }
	else if (t == 68) { return "I'm going to drop you all like I did you skilz!"; }
	else if (t == 69) { return "The ammout of new taunts is over 9000!"; }
	else if (t == 70) { return "This is a generic taunt at id 70."; }
	else if (t == 71) { return "Let me add a few 0's the end of my paycheck!"; }
	else if (t == 72) { return "Now now little kids I've got candy. Come here with your hands up!"; }
	else if (t == 73) { return "Host, please send trained players next time, these are are fucking joke!"; }
	else if (t == 74) { return "Host, give me my aimbot so I can pwn these nOObs in style!"; }
	else if (t == 75) { return "Aimbot [*] | Skill [*] | You're Fucked [*]!"; }
	else if (t == 76) { return "I get laid all day unlike you!"; }
	
}
// A is the attacker
// v in the victem
Fun_taunt_trap(a, v)
{
	t = RandomIntRange(0,13);
	if (t == 0) { return a.name + ": where is your moma now " + v.name + " ?"; }
	else if (t == 1) { return a.name + ": eat lead " + v.name + "!"; }
	else if (t == 2) { return a.name + ": I just fucked you up boi!"; }
	else if (t == 3) { return a.name + ": did you really think I'd let you go there " + v.name + " ?"; }
	else if (t == 4) { return a.name + ": hey " + v.name + " I thought you were tougher than that!"; }
	else if (t == 5) { return a.name + ": I like the smell of roast beef!"; }
	else if (t == 6) { return a.name + ": You were on fire " + v.name + " and i'm being literal here!"; }
	else if (t == 7) { return a.name + ": another day, another dead corpse to burn!"; }
	else if (t == 8) { return a.name + ": eat it " + v.name + "!"; }
	else if (t == 9) { return a.name + ": I would tee bag your corpse " + v.name + " but I'm straight unlike you!"; }
	else if (t == 10) { return a.name + ": i'm so lazy I set explosives that dumb people like " + v.name + " detonate!"; }
	else if (t == 11) { return a.name + ": hey " + v.name + " your brains are missing!"; }
	else if (t == 12) { return a.name + ": hey " + v.name + " you're dead again!"; }
}























