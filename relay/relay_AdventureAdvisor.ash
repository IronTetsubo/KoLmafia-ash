script "AdventureAdvisor.ash";
notify Bale;
string thisver = "2.6.1"; 				// This is the script's version!
string thread = "http://kolmafia.us/showthread.php?4367-Adventure-Advisor&p=30941&viewfull=1#post30941";
string mfname = "AdventureAdvisor"; 	// This is the name of the map file.

// Information on every place worth visiting
record place {
	location loc;
	string locphp;
	boolean hide;
	string zone;
	string zonephp;
	int level;
	monster boss;
	string bossnick;
	int bosslevel;
	boolean bossonly;
	boolean aftercore;
	boolean useful;
};
place [string] kingdom;
string [int] order;

string title = "<a href='"+thread+"' target='_blank'>Adventure Advisor</a> version "+thisver+", by <a href='showplayer.php?who=754005'>Bale</a>";
string level1 = "background-color:66FFCC; color:black;";	// Green
string level2 = "background-color:CCFF99; color:black;";	// Yellow
string level3 = "background-color:FF9966; color:white;";	// Orange
string level4 = "background-color:CC0033; color:white;";	// Red

// Some global variables modified by form submission
stat stat_choice = weapon_type(equipped_item($slot[weapon]));
if(stat_choice == $stat[none]) stat_choice = $stat[muscle];
else if(stat_choice == $stat[Mysticality]) stat_choice = $stat[moxie];
#string max_min = "min";
boolean hide_after = (!get_property("kingLiberated").to_boolean());
string [string] vars;

// Beginning of form functions based strongly on jasonharper's htmlform.ash from http://kolmafia.us/showthread.php?3842
////////// GLOBAL VARIABLES

string[string] fields;	// shared result from form_fields()
boolean success;	// form successfully submitted

string write_radio(string ov, string name, string label, string value) {
	if(fields contains name) ov = fields[name];
	if(label != "") write("<label>");
	write("<input type='radio' name='" + name + "' value='" + entity_encode(value) + "'");
	if(value == ov) write(" checked");
	write(">");
	if(label != "" ) write(label+ "</label>");
	return ov;
}

string write_select(string ov, string name, string label) {
	write("<label>" +label);
	if(fields contains name) ov = fields[name];
	write("<select name='" +name);
	if(label == "") write("' id='" +name);
	write("'>");
	return ov;
}

void finish_select() {
	writeln("</select></label>");
}

void write_option(string ov, string label, string value) {
	write("<option value='" + entity_encode(value)+ "'");
	if(value == ov) write(" selected");
	writeln(">" +label+ "</option>");
}

boolean test_button(string name) {
	if(name == "")	return false;
	return success && fields contains name;
}

boolean write_button(string name, string label) {
	write("<input type='submit' name='");
	write(name+ "' value='");
	write(label+ "'>");
	return test_button(name);
}

// Reverse checkbox based on jason's write_check()
boolean write_rcheck(boolean ov, string name, string label) {
	if(label != "" ) write("<label>");
	if(fields contains name) ov = true;
	else if(count(fields) > 0) ov = false;
	write("<input id=\""+ name +"\" type='checkbox' name=\"" + name + "\"");
	if(ov) write(" checked");
	write(">");
	if(label != "" ) write(label+ "</label>");
	return ov;
}
string write_rcheck(string ov, string name, string label) {
	return write_rcheck(ov.to_boolean(), name, label).to_string();
}

// end of jasonharper's htmlform.ash

// Modified from zarqon's zlib
string check_version() {
 	string soft = "Adventure Advisor";
	string page; matcher find_ver; boolean first = false;
	record {
	   string ver;
	   string vdate;
	} [string] zv;
	file_to_map("zversions.txt", zv);
	boolean sameornewer(string local, string server) {
		if(local == server) return true;
		string[int] loc = split_string(local,"\\.");
		string[int] ser = split_string(server,"\\.");
		for i from 0 to max(count(loc)-1, count(ser)-1) {
			if(i+1 > count(loc)) return false; if (i+1 > count(ser)) return true;
			if(loc[i].to_int() < ser[i].to_int()) return false;
			if(loc[i].to_int() > ser[i].to_int()) return true;
		}
		return true;
	}
	// Execute the following only once per day.
	if(zv[soft].vdate != today_to_string()) {
		first = true;
		// 1. Check program version info
		print("Checking for updates (running "+soft+" ver. "+thisver+")...");
		page = visit_url("http://kolmafia.us/showthread.php?t="+thread);
		find_ver = create_matcher("<b>"+soft+" (.+?)</b>",page);
		zv[soft].vdate = today_to_string();
		if (!find_ver.find()) { 
			print("Unable to load current version info.");
			map_to_file(zv, "zversions.txt");
			return "";
		}
		zv[soft].ver = find_ver.group(1);
		// 2. Now check to see if the data map is current
		string mkey = "map_Bale"+mfname+".txt";
		file_to_map(mfname+".txt", kingdom);
		if(zv[mkey].vdate != today_to_string()) {
			zv[mkey].vdate = today_to_string();
			string rem = visit_url("http://zachbardon.com/mafiatools/autoupdate.php?f="+mfname+"&act=getver");
			if(zv[mkey].ver == rem && count(kingdom) > 0) {
				print("You have the latest "+mfname+".txt.  Will not check again today.", "gray");
			} else {
				print("Updating "+mfname+".txt from '"+zv[mkey].ver+"' to '"+rem+"'...");
				if(file_to_map("http://zachbardon.com/mafiatools/autoupdate.php?f="+mfname+"&act=getmap", kingdom) && count(kingdom) > 0) {
					map_to_file(kingdom, mfname+".txt");
					zv[mkey].ver = rem;
					print("..."+mfname+".txt updated.");
				} else
					print("Error loading "+mfname+".txt from the Map Manager.","red");
			}
		}
		// 3. Save current version information.
		map_to_file(zv,"zversions.txt");
	}
	if(sameornewer(thisver,zv[soft].ver))
		return ""; 
	string msg = "<div style='font-size:140%; font-weight:bold; color:red; font-family:Arial,Helvetica,sans-serif'>New Version of "+soft+" Available: "+zv[soft].ver+"</div>"+
	  "<div style='color:red; font-family:Arial,Helvetica,sans-serif'><a href='http://kolmafia.us/showthread.php?t="+thread+"' target='_blank'><u>Upgrade from "+thisver+" to "+zv[soft].ver+" here!</u></a><br>";
	#find_ver = create_matcher("\\[requires revision (.+?)\\]",page);
	#if(find_ver.find() && find_ver.group(1).to_int() > get_revision())
	#	msg += " (Note: you will also need to <a href='http://builds.kolmafia.us/' target='_blank'>update mafia to r"+find_ver.group(1)+" or higher</a> to use this update.)";
	msg += "</div>";
	if(first) print_html(msg);
	return msg;
}

int monster_level(monster m) {
	float mod = 0.9;
	if(stat_choice == $stat[moxie]) mod = 1;
	switch(m) {
	// These are a whole bunch of monsters with missing data. Return an approximation of correctness.
	case $monster[Drunk Duck]:
	case $monster[Fire-Breathing Duck]:
	case $monster[Rotund Duck]:
	case $monster[Vampire Duck]:
	case $monster[Caveman Frat Boy]:
	case $monster[Caveman Frat Pledge]:
	case $monster[Caveman Sorority Girl]:
	case $monster[War Hippy Drill Sergeant]:
	case $monster[Frat Warrior Drill Sergeant]:
	case $monster[Ed the Undying (1)]:
	case $monster[Larval Filthworm]:
	case $monster[Filthworm Drone]:
	case $monster[Filthworm Royal Guard]:
	case $monster[The Queen Filthworm]:
	case $monster[Lord Spookyraven]:
	case $monster[Dr. Awkward]: return monster_attack(m) * mod;
	case $monster[Protector Spectre]: return monster_defense(m) / mod;
	case $monster[The Man]:
	case $monster[The Big Wisniewski]:
		return 255+ monster_level_adjustment() * mod;
	}
	if(stat_choice == $stat[moxie]) return monster_attack(m);
	return monster_defense(m);
}

// returns safe moxie or muscle to hit for a given location (includes +ML and MCD, skips bosses)
place get_level(string l) {
	place here = kingdom[l];
	location loc = here.loc;
	int high;
	if(here.bosslevel > 0) {
		if(stat_choice == $stat[muscle])
			here.bosslevel = here.bosslevel * 0.9;
		here.bosslevel += monster_level_adjustment() + 9;
	}
	if(here.level > 0) {
		if(stat_choice == $stat[muscle])
			here.level = here.level * 0.9;
		here.level += monster_level_adjustment() + 9;
	}
	if(loc == $location[none]) {
		if(here.bossnick != "") {
			if(here.bosslevel == 0)
				here.bosslevel = monster_level(here.boss) + 9;
			if(here.level == 0)
				here.level = here.bosslevel;
		}
		return here;
	} else if(loc.zone == "Volcano" && loc != $location[The Temple Portico]) {
		// These locations don't have monster data yet
		high = monster_level_adjustment() + 170;
	/*
	} else if(loc == $location[the lower chamber]) {   // Ed not listed in the location
		here.boss = $monster[Ed the Undying (1)];
		here.level = monster_level(here.boss) + 9;
		here.bosslevel = here.level;
		return here;
	*/
	} else foreach m,r in appearance_rates(loc) {
		if(m != here.boss && r > 0
		  && !($monsters[clan of cave bars, Protector Spectre] contains m))
			high = max(monster_level(m),high);
	}
#ash foreach m,r in appearance_rates($location[   ]) print(monster_defense(m) +" - "+ monster_attack(m) + " : " + m + " " + r);
	#if(high != 0 && high != monster_level_adjustment()&& high != monster_level_adjustment() * .9)
	if(high != 0)
		here.level = high + 9;
	if(here.bossonly) {
		if(here.bossnick == "")
			foreach key, mob in get_monsters(loc) here.boss = mob;
		if(here.bosslevel == 0) {
			if(here.boss != $monster[none])
				here.bosslevel = monster_level(here.boss) + 9;
			else
				here.bosslevel = here.level;
		}
		if(here.level == 0)
			here.level = here.bosslevel;
	}
	if(here.boss != $monster[none] && here.bosslevel == 0)
		here.bosslevel = monster_level(here.boss) + 9;
	return here;
}

int full_amount(item it) {
	return item_amount(it) + closet_amount(it);
}

// have_outfit() returns false if you cannot equip the outfit. I want this to be useful for softcore.
boolean need_outfit(boolean [item] gear) {
	foreach i in gear
		if(available_amount(i) < 1) return true;
	return false;
}

void telescope() {
	string questL13Final= get_property("questL13Final");
	int towerDone;
	if(questL13Final.contains_text("step"))
		towerDone = questL13Final.substring(4).to_int();
	else if(questL13Final == "finished")
		towerDone = 10;
	
	// If the NS was beaten... Get out.
	if(towerDone > 9) return;
	
	// Check for Wand of Nagamar also!
	int availableN = full_amount($item[WANG]) + full_amount($item[NG]) + full_amount($item[ND]) + full_amount($item[lowercase N]);
	if(!($strings[Avatar of Boris, Bees Hate You] contains my_path()) && full_amount($item[Wand of Nagamar]) < 1) {
		if(full_amount($item[WA]) < 1 && full_amount($item[WANG]) < 1) {
			kingdom["Pandamonium Slums"].useful = my_level() >= 6 && full_amount($item[ruby W]) < 1;
			kingdom["Fantasy Airship"].useful = my_level() >= 10 && full_amount($item[metallic A]) < 1;
		}
		kingdom["Orc Chasm"].useful = my_level() >= 9 && availableN < 1;
		availableN -= 1;
		kingdom["Giant's Castle"].useful = my_level() >= 10 && full_amount($item[heavy D]) < 1 && full_amount($item[ND]) < 1;
	}

	// If all the tower monster have been defeated get out.
	if(towerDone > 4) return;

	record lair {
		string where;
		item kill;
		int level;
	};
	
	static {
		lair [string] entrance;
			entrance["an armchair"] = new lair("Hidden City", $item[pygmy pygment], 11);
			entrance["a cowardly-looking man"] = new lair((get_property("questL06Friar") == "finished"? "Pandamonium Slums": "Dark Neck of the Woods"), $item[wussiness potion], 6);
			entrance["a banana peel"] = new lair((get_property("warProgress") == "finished"? "Junkyard": "Junkyard: need gremlin juice"), $item[gremlin juice], 12);
			entrance["a coiled viper"] = new lair("Black Forest", $item[adder bladder], 11);
			entrance["a glum teenager"] = new lair("Giant's Castle", $item[thin black candle], 10);
			entrance["a hedgehog"] = new lair("Fantasy Airship", $item[super-spiky hair gel], 10);
			entrance["a raven"] = new lair("Black Forest", $item[Black No. 2], 11);
			entrance["a smiling man smoking a pipe"] = new lair("Giant's Castle", $item[Mick's IcyVapoHotness Rub], 10);
			# entrance["a rose"] = new lair("Giant's Castle", $item[Angry Farmer candy]);
			# entrance["a mass of bees"] = new lair("", $item[honeypot]);

		lair [string] tower;
			tower["catch a glimpse of a flaming katana"] = new lair("Ninja Snowmen", $item[frigid ninja stars], 8);
			tower["catch a glimpse of a translucent wing"] = new lair("Sleazy Back Alley", $item[spider web], 1);
			tower["see a fancy-looking tophat"] = new lair("Guano Junction", $item[sonar-in-a-biscuit], 4);
			tower["see a flash of albumen"] = new lair("Black Forest", $item[black pepper], 11);
			tower["see a giant white ear"] = new lair("Hidden City", $item[pygmy blowgun], 11);
			tower["see a huge face made of Meat"] = new lair("Orc Chasm", $item[meat vortex], 9);
			tower["see a large cowboy hat"] = new lair("Giant's Castle", $item[chaos butterfly], 10);
			tower["see a periscope"] = new lair("Fantasy Airship", $item[photoprotoneutron torpedo], 10);
			tower["see a slimy eyestalk"] = new lair("Haunted Bathroom", $item[fancy bath salts], 6);
			tower["see a strange shadow"] = new lair("Haunted Library", $item[inkwell], 4);
			tower["see part of a tall wooden frame"] = new lair("Cobb's Knob Harem", $item[disease], 5);
			tower["see some amber waves of grain"] = new lair("Arid Extra-Dry Desert", $item[bronzed locust], 11);
			tower["see some long coattails"] = new lair("Outskirts of the Knob", $item[Knob Goblin firecracker], 1);
			tower["see some pipes with steam shooting out of them"] = new lair("Pyramid Middle Chamber", $item[powdered organs], 11);
			tower["see some sort of bronze figure holding a spatula"] = new lair("Haunted Kitchen", $item[leftovers of indeterminate origin], 1);
			tower["see the neck of a huge bass guitar"] = new lair("South of the Border", $item[mariachi G-string], 1);
			tower["see what looks like a writing desk"] = new lair("Giant's Castle", $item[plot hole], 10);
			tower["see the tip of a baseball bat"] = new lair("Guano Junction", $item[baseball], 4);
			tower["see what seems to be a giant cuticle"] = new lair("Haunted Pantry", $item[razor-sharp can lid], 1);
			# tower["see moonlight reflecting off of what appears to be ice"] = new lair("Demon Market", $item[hair spray]);
			# tower["see what appears to be the North Pole"] = new lair("Giant's Castle", $item[NG]);

		lair [string] top;
			top["see a pair of horns"] = new lair("The Shore, Inc.", $item[barbed-wire fence], 1);
			top["see a formidable stinger"] = new lair("The Shore, Inc.", (full_amount($item[packet of orchid seeds]) > 0? $item[packet of orchid seeds]: $item[tropical orchid]), 1);
			top["see a wooden beam"] = new lair("The Shore, Inc.", $item[stick of dynamite], 1);
	}
	
	void look_low(lair [string] l, string sight) {
		if(l contains sight)
			kingdom[ l[sight].where ].useful = my_level() >= l[sight].level && full_amount(l[sight].kill) < 1;
		else if(sight == "see what appears to be the North Pole") {
			kingdom["Orc Chasm"].useful = my_level() >= 9 && availableN < 1;
			kingdom["Giant's Castle"].useful = my_level() >= 10 && full_amount($item[original G]) < 1 && full_amount($item[NG]) < 1;
		} else if(sight == "a rose" && my_level() >= 10) {
			foreach key in $effect[Sugar Rush].all 
				if(full_amount(substring(key,4).to_item()) > 0) return;
			kingdom["Giant's Castle"].useful = true;
		}
	}

	if(my_path() == "Bees Hate You") {
		kingdom["The Shore, Inc."].useful = full_amount($item[packet of orchid seeds]) < 1 && full_amount($item[tropical orchid]) < 6;
		kingdom["Haunted Bedroom"].useful = full_amount($item[antique hand mirror]) < 1 && get_property("lastSecondFloorUnlock").to_int() == my_ascensions();
	} else {
		if(get_property("telescopeUpgrades").to_int() >= 7)
			look_low(top, get_property("telescope7"));
		else foreach sight in top
			look_low(top, sight);

		if(get_property("telescopeUpgrades").to_int() >= 6)
			for x from 2 to 6
				look_low(tower, get_property("telescope"+x));
		else {
			foreach sight in tower
				look_low(tower, sight);
			look_low(tower, "see what appears to be the North Pole");
		}
		
		// If passed the entrance cavern, get out.
		if(towerDone > 1) return;

		if(get_property("telescopeUpgrades").to_int() >= 1)
			look_low(entrance, get_property("telescope1"));
		else {
			foreach sight in entrance
				look_low(entrance, sight);
			look_low(entrance, "a rose");
		}
		
	}
}
	
void bounty() {
	int b = get_property("currentBountyItem").to_int();
	if(b == 2470)
		kingdom["Haunted Wine Cellar"].useful = true;
	else if(b != 0)
		kingdom[to_string(b.to_item().bounty)].useful = true;
}

void set_useful() {
	foreach l,p in kingdom
		p.useful = false;
		
	// Set special location for each class:
	switch(my_class()) {
	case $class[Seal Clubber]:
		kingdom["Broodling Grounds"].useful = true;
		break;
	case $class[Turtle Tamer]:
		kingdom["Stella's Outer Compound"].useful = true;
		break;
	case $class[Pastamancer]:
		kingdom["Temple Portico"].useful = true;
		break;
	case $class[Sauceror]:
		kingdom["Convention Hall Lobby"].useful = true;
		break;
	case $class[Disco Bandit]:
		kingdom["Outside the Club"].useful = true;
		break;
	case $class[Accordion Thief]:
		kingdom["Island Barracks"].useful = true;
		break;
	case $class[Avatar of Boris]:
		switch(minstrel_level() - numeric_modifier("Minstrel Level")) {
		case 1.0:
			if(get_property("questL03Rat") != "unstarted")
				kingdom["Barroom Brawl"].useful = true;
			break;
		case 2.0:
			if(get_property("questL05Goblin") != "unstarted")
				kingdom["Knob Shaft"].useful = true;
			break;
		case 3.0:
			if(my_level() >= 7 && available_amount($item[Clancy's Lute]) < 1 && minstrel_instrument() != $item[Clancy's Lute])
				kingdom["Luter's Grave"].useful = true;
			else if(get_property("questL08Trapper") == "step3" || get_property("questL08Trapper") == "finished")
					kingdom["Icy Peak"].useful = true;
			break;
		case 4.0:
			if(my_level() >= 11 && get_property("questL11Pyramid") != "unstarted")
				kingdom["Pyramid Middle Chamber"].useful = true;
		}
		break;
	}

	// Check telescope to see if more zones can be ruled useful.
	telescope();

	// Need bounty location
	bounty();

	// Set quest status and leveling zone, based on class (Sea has three zones of which only 1 is relevant to the character.)
	switch(my_primestat()) {
	case $stat[muscle]:
		// Gallery quest is only relevant for muscle classes
		#kingdom["Haunted Conservatory"].useful = true;
		kingdom["Haunted Gallery"].useful = true;
		if(my_level() > 13) kingdom["Anemone Mine"].useful = true;
		break;
	case $stat[mysticality]:
		kingdom["Haunted Bathroom"].useful = true;
		if(my_level() > 13) kingdom["Marinara Trench"].useful = true;
		break;
	case $stat[moxie]:
		kingdom["Haunted Ballroom"].useful = true;
		if(my_level() > 13) kingdom["The Dive Bar"].useful = true;
	}
	
	// Low level Clan dungeon leveling!
	if(my_level() < 6)
		kingdom["A Maze of Sewer Tunnels"].useful = true;
	
	// Get to the Beach!
	if(item_amount($item[bitchin' meatcar]) + item_amount($item[desert bus pass]) + item_amount($item[pumpkin carriage]) < 1) {
		if(!knoll_available())
			kingdom["Degrassi Knoll"].useful = true;
	} else if(item_amount($item[dingy dinghy]) < 1)
		kingdom["The Shore, Inc."].useful = true;

	// If Bees Hate you, you will never use an item from South of the Border to beat the tower. Ignore in softcore
	// G-string is accounted for in telescope()
	if(my_path() != "Bees Hate You" && !gnomads_available() && in_hardcore() && item_amount($item[handsomeness potion]) < 1)
		kingdom["South of the Border"].useful = true;

	if(item_amount($item[digital key]) < 1 && my_basestat(my_primestat()) >= 20) {
		if(creatable_amount($item[digital key]) < 1)
			kingdom["8-Bit Realm"].useful = true;
		else
			kingdom["Crackpot Mystic's Shed"].useful = true;
	} else if(have_equipped($item[continuum transfunctioner]))
		kingdom["8-Bit Realm"].useful = true;

	// Check for Daily Dungeon
	int keys, wand;
	foreach i in $items[Boris's key, Jarlsberg's key, Sneaky Pete's key, fat loot token]
		keys += item_amount(i);
	for i from 1268 to 1272 // Check for wand!
		if(item_amount(to_item(i)) > 0) wand = i;
	if(keys + (wand > 0? 1: 0) < 3 && !get_property("dailyDungeonDone").to_boolean())
		kingdom["Daily Dungeon"].useful = true;
	
	// Check for Dungeons of Doom
	boolean need_bangs() {
		int gate_potions, missing_potions;
		boolean inebriety, teleportitis, need_extra;
		for i from 819 to 827 {
			switch(get_property("lastBangPotion"+i)) {
			case "teleportitis":
				teleportitis = true;
			case "blessing": case "detection": case "mental acuity": case "ettin strength":
				if(available_amount(to_item(i)) == 0)
					missing_potions = missing_potions + 1;
				else gate_potions = gate_potions + 1;
				break;
			case "":
				if(available_amount(to_item(i)) == 0)
					missing_potions = missing_potions + 1;
				if(available_amount(to_item(i)) < 2)
					need_extra = true;
				break;
			case "inebriety":
				inebriety = true;
			//case "healing": case "sleepiness": case "confusion":
			}
			if(gate_potions == 5) return false;
		}
		if(teleportitis && inebriety && missing_potions == 0) return false;
		if(need_extra) return true;
		return false;
	}
	if(in_hardcore() && my_basestat(my_primestat()) >= 45 && need_bangs()) {
		kingdom["Greater-Than Sign"].useful = true;
		kingdom["Dungeons of Doom"].useful = true;
	}

	// Spookyraven Manor
	if(get_property("lastManorUnlock").to_int() < 0 && my_ascensions() > 0) {
		// The lastManorUnlock preference is new, so some people might need to get it updated from -1 to current.
		if(visit_url("town_right.php").contains_text("manor.gif"))
			set_property("lastManorUnlock", my_ascensions());
		else
			set_property("lastManorUnlock", (my_ascensions() - 1));
	}
	if(get_property("lastManorUnlock").to_int() != my_ascensions()) {
		kingdom["Haunted Pantry"].useful = true;
		kingdom["Haunted Pantry"].zonephp = "town_right.php";
		kingdom["Haunted Pantry"].zone = "Seaside Town";
	}
	else {
		if(item_amount($item[Spookyraven library key]) < 1)
			kingdom["Haunted Billiards Room"].useful = true;
		if(my_primestat() == $stat[muscle] && item_amount($item[Spookyraven gallery key]) < 1) {
			if(get_property("lastGalleryUnlock").to_int() == my_ascensions())
				kingdom["Haunted Conservatory"].useful = true;
			else
				kingdom["Haunted Library"].useful = true;
		}
		if(get_property("lastSecondFloorUnlock").to_int() != my_ascensions()) {
			kingdom["Haunted Library"].useful = true;
		} else {
			kingdom["Haunted Bedroom"].useful = item_amount($item[Spookyraven ballroom key]) < 1;
			kingdom["Haunted Ballroom"].useful = get_property("lastQuartetAscension").to_int() != my_ascensions();
		}
	}

	// Quest Locations based on completion.
	switch(get_property("questL03Rat")) {
	case "unstarted": if(my_level() < 3) break;
		kingdom["Tavern Cellar"].locphp = "tavern.php?place=barkeep";
	case "started":
		kingdom["Tavern Cellar"].useful = true;
	}

	switch(get_property("questL04Bat")) {
	case "unstarted": if(my_level() < 4) break;
	case "started":
		if(numeric_modifier("stench resistance") <= 0 && !have_skill($skill[Astral Shell]) && !have_skill($skill[Elemental Saucesphere]))
			kingdom["Bat Hole Entryway"].useful = true;
	case "step1":
	case "step2":
		kingdom["Guano Junction"].useful = true;
		kingdom["Beanbat Chamber"].useful = true;
		kingdom["Batrat and Ratbat Burrow"].useful = true;
	case "step3":
		kingdom["Boss Bat's Lair"].useful = true;
	case "step4":
	case "finished":
	}

	switch(get_property("questL05Goblin")) {
	case "unstarted":
		if(item_amount($item[Knob Goblin encryption key]) < 1)
			kingdom["Outskirts of the Knob"].useful = true;
		if(my_level() < 5) break;
	case "started":
		if(item_amount($item[Cobb's Knob map]) > 0)
			kingdom["Outskirts of the Knob"].useful = true;
		kingdom["Cobb's Knob Harem"].useful = true;
		kingdom["Cobb's Knob Barracks"].useful = true;
		kingdom["Cobb's Knob Kitchens"].useful = true;
		kingdom["Throne Room"].useful = true;
	}

	switch(get_property("questL06Friar")) {
	case "unstarted": if(my_level() < 6) break;
	case "started":
		if(item_amount($item[eldritch butterknife]) < 1)
			kingdom["Dark Elbow of the Woods"].useful = true;
		if(item_amount($item[box of birthday candles]) < 1)
			kingdom["Dark Heart of the Woods"].useful = true;
		if(item_amount($item[dodecagram]) < 1)
			kingdom["Dark Neck of the Woods"].useful = true;
		if(item_amount($item[eldritch butterknife]) + item_amount($item[box of birthday candles]) + item_amount($item[dodecagram]) == 3)
			kingdom["Deep Fat Friar's Gate"].useful = true;
	}

	switch(get_property("questM10Azazel")) {
	case "unstarted": if(my_level() < 6) break;
	case "started":
		kingdom["Hey Deze Arena"].useful = true;
		kingdom["Belilafs Comedy Club"].useful = true;
		if(item_amount($item[imp air]) >=5 && item_amount($item[bus pass]) >=5)
			kingdom["Moaning Panda Square"].useful = true;
	}

	switch(get_property("questL07Cyrptic")) {
	case "unstarted": if(my_level() < 7) break;
	case "started":
		if(get_property("cyrptCrannyEvilness") != "0")
			kingdom["Defiled Cranny"].useful = true;
		if(get_property("cyrptNookEvilness") != "0")
			kingdom["Defiled Nook"].useful = true;
		if(get_property("cyrptAlcoveEvilness") != "0")
			kingdom["Defiled Alcove"].useful = true;
		if(get_property("cyrptNicheEvilness") != "0")
			kingdom["Defiled Niche"].useful = true;
		kingdom["Haert of the Cyrpt"].useful = true;
		break;
	case "finished":
		if( (have_skill($skill[Advanced Saucecrafting]) && !(get_campground() contains $item[chef-in-the-box]) && available_amount($item[chef's hat]) > 0)
		  || (have_skill($skill[Advanced Cocktailcrafting]) && !(get_campground() contains $item[bartender-in-the-box]) && (available_amount($item[beer goggles]) > 0 || available_amount($item[beer lens]) > 1)) )
			kingdom["Post-Cyrpt Cemetary"].useful = true;
	}

	switch(get_property("questL08Trapper")) {
	case "unstarted": if(my_level() < 8) break;
	case "started":
		kingdom["L33t Trapper's Cabin"].useful = true;
	case "step1":
		if(get_property("trapperOre").to_item().available_amount() < 3)
			kingdom["Itznotyerzitz Mine"].useful = true;
		else
			kingdom["L33t Trapper's Cabin"].useful = true;
		kingdom["Goatlet"].useful = true;
		if(numeric_modifier("cold resistance") <= 0 && !have_outfit("eXtreme Cold-Weather Gear")
		  && !have_skill($skill[Astral Shell]) && !have_skill($skill[Elemental Saucesphere]))
			kingdom["eXtreme Slope"].useful = true;
		break;
	case "step2":
		if(available_amount($item[goat cheese]) < 6)
			kingdom["Goatlet"].useful = true;
		else
			kingdom["L33t Trapper's Cabin"].useful = true;
		if(numeric_modifier("cold resistance") <= 0 && !have_outfit("eXtreme Cold-Weather Gear")
		  && !have_skill($skill[Astral Shell]) && !have_skill($skill[Elemental Saucesphere]))
			kingdom["eXtreme Slope"].useful = true;
		break;
	case "step3":
		if(numeric_modifier("cold resistance") <= 0 && !have_outfit("eXtreme Cold-Weather Gear")
		  && !have_skill($skill[Astral Shell]) && !have_skill($skill[Elemental Saucesphere]))
			kingdom["eXtreme Slope"].useful = true;
		if(numeric_modifier("cold resistance") > 0)
			kingdom["L33t Trapper's Cabin"].useful = true;
	}

	switch(get_property("questL09Lol")) {
	case "unstarted": if(my_level() < 9) break;
	case "started":
		if(!have_outfit("Swashbuckling Getup") && available_amount($item[pirate fledges]) < 1) {
			kingdom["Pirate's Cove"].useful = true;
			break;
		}
	case "step1":
		kingdom["Orc Chasm"].useful = true;
	}

	switch(get_property("questL10Garbage")) {
	case "unstarted":
		if(full_amount($item[enchanted bean]) < 1)
			kingdom["Beanbat Chamber"].useful = true;
		if(my_level() < 10) break;
	case "started":
		if(item_amount($item[giant castle map]) < 1)
			kingdom["Fantasy Airship"].useful = true;
		kingdom["Giant's Castle"].useful = true;
	case "finished":
		if(in_hardcore() && item_amount($item[intragalactic rowboat]) + item_amount($item[quantum egg]) < 1)
			kingdom["Giant's Castle"].useful = true;
		if(item_amount($item[Richard's star key]) < 1 || item_amount($item[star hat]) < 1 || 
		  !($strings[Master of the Surprising Fist, Avatar of Boris] contains my_path() ||
		  item_amount($item[star sword]) + item_amount($item[star crossbow]) + item_amount($item[star staff]) > 0))
			kingdom["Hole in the Sky"].useful = true;
	}

	switch(get_property("questL11MacGuffin")) {
	case "unstarted": if(my_level() < 11) break;
	case "started":
		kingdom["Black Forest"].useful = true;
	case "step1":
		if(black_market_available() && item_amount($item[forged identification documents]) == 0) {
			if(my_path() == "Way of the Surprising Fist") {
				kingdom["Black Market"].boss = $monster[Wu Tang the Betrayer];
				kingdom["Black Market"].bossnick = "Wu&nbsp;Tang";
				kingdom["Black Market"].bossonly = true;
			}
			kingdom["Black Market"].useful = true;
		} else if(get_property("questL11MacGuffin") == "step1")
			kingdom["The Shore, Inc."].useful = true;
	case "step2":
	}

	switch(get_property("questL11Manor")) {
	case "started":
		kingdom["Haunted Ballroom"].useful = true;
	case "step1":
		kingdom["Haunted Wine Cellar"].useful = true;
	case "step2":
		kingdom["Summoning Chamber"].useful = true;
	case "finished":
	}

	if(!hidden_temple_unlocked() && my_level() >=2)
		kingdom["Spooky Forest"].useful = true;
	switch(get_property("questL11Worship")) {
	case "unstarted":
		if(available_amount($item[the Nostril of the Serpent]) < 1)
			kingdom["Hidden Temple"].useful = true;
		break;
	case "started":
	case "step1":
	case "step2":
		kingdom["Hidden Temple"].useful = true;
	case "step3":
		string hiddenCityLayout = get_property("hiddenCityLayout");
		int found;
		if(get_property("lastHiddenCityAscension") == my_ascensions()) {
			foreach c in $strings[T, N, W, L, F]
				if(hiddenCityLayout.contains_text(c)) found += 1;
			// Count spheres. If a sphere was placed, it is gone so also check if its ID was discovered.
			for s from 2174 to 2177
				if(item_amount(to_item(s)) > 0 || get_property("lastStoneSphere"+s) != "")
					found += 1;
		}
		if(found < 9) {
			kingdom["Hidden City"].useful = true;
			if(get_property("lastHiddenCityAscension") == my_ascensions()) {
				if(hiddenCityLayout.contains_text("0"))
					kingdom["Hidden City"].locphp = "hiddencity.php?which="+index_of(hiddenCityLayout, "0");
				else if(hiddenCityLayout.contains_text("P"))
					kingdom["Hidden City"].locphp = "hiddencity.php?which="+index_of(hiddenCityLayout, "P");
			}
		}
		if(get_property("lastHiddenCityAscension") == my_ascensions() && hiddenCityLayout.contains_text("T")) {
			// Let's move the boss to the Smallish Temple we found!!
			kingdom["Hidden City"].bossnick = "";
			kingdom["Hidden City"].boss = $monster[none];
			kingdom["Smallish Temple"].useful = true;
			kingdom["Smallish Temple"].locphp = "hiddencity.php?which="+index_of(hiddenCityLayout, "T");
		}
	case "finished":
		// Hidden City might be useful because of a need for pygmy pigment or blowgun.
		if(kingdom["Hidden City"].locphp == "hiddencity.php" && hiddenCityLayout.contains_text("E"))
			kingdom["Hidden City"].locphp = "hiddencity.php?which="+index_of(hiddenCityLayout, "E");
	}

	switch(get_property("questL11Palindome")) {
	case "started":
		if(available_amount($item[Talisman o' Nam]) < 1) {
			kingdom["Poop Deck"].useful = true;
			kingdom["Belowdecks"].useful = true;
		}
		kingdom["Palindome"].locphp = "plains.php";
		kingdom["Palindome"].useful = true;
		break;
	case "step2":
	case "step3":
		kingdom["Cobb's Knob Laboratory"].useful = true;
		if(creatable_amount($item[wet stew]) + creatable_amount($item[wet stunt nut stew])
		  + available_amount($item[wet stew]) + available_amount($item[wet stunt nut stew]) < 1)
			kingdom["Whitey's Grove"].useful = true;
	case "step1":
	case "step4":
		kingdom["Palindome"].useful = true;
	case "finished":
	}

	switch(get_property("questL11Pyramid")) {
	case "started":
		kingdom["Unhydrated Desert"].useful = true;
		break;
	case "step1":
	case "step2":
	case "step3":
	case "step4":
	case "step5":
	case "step6":
	case "step7":
	case "step8":
	case "step9":
		kingdom["Oasis in the Desert"].useful = true;
		kingdom["Arid Extra-Dry Desert"].useful = true;
	case "step10":
	case "step11":
		// Haven't yet opened the Pyramid, so give the link to open it if possible
		kingdom["Pyramid Upper Chamber"].locphp = "beach.php?action=woodencity";
		kingdom["Pyramid Middle Chamber"].locphp = "beach.php?action=woodencity";
		kingdom["Pyramid Lower Chamber"].locphp = "beach.php?action=woodencity";
		kingdom["Pyramid Upper Chamber"].zonephp = "beach.php?action=woodencity";
		kingdom["Pyramid Middle Chamber"].zonephp = "beach.php?action=woodencity";
		kingdom["Pyramid Lower Chamber"].zonephp = "beach.php?action=woodencity";
	case "step12":
		kingdom["Pyramid Upper Chamber"].useful = true;
		kingdom["Pyramid Middle Chamber"].useful = true;
		kingdom["Pyramid Lower Chamber"].useful = true;
	case "finished":
	}

	switch(get_property("questL12War")) {
	case "unstarted":
	case "started":
		if(need_outfit($items[Orcish baseball cap, homoerotic frat-paddle, Orcish cargo shorts]) && 
		  need_outfit($items[beer helmet, distressed denim pants, bejeweled pledge pin]) &&
		  need_outfit($items[filthy knitted dread sack, filthy corduroys]) &&
		  need_outfit($items[reinforced beaded headband, bullet-proof corduroys, round purple sunglasses])) {
			kingdom["Frat House"].useful = true;
			kingdom["Hippy Camp"].useful = true;
		}
		if(my_level() < 12) break;
		if(have_outfit("Frat Warrior Fatigues") || have_outfit("Frat Boy Ensemble"))
			kingdom["Pre-War Hippy Camp"].useful = true;
		if(have_outfit("War Hippy Fatigues") || have_outfit("Filthy Hippy Disguise"))
			kingdom["Pre-War Frat House"].useful = true;
		break;
	case "step1":
		if(have_outfit("Frat Warrior Fatigues"))
			kingdom["Battlefield (Frat Uniform)"].useful = true;
		if(have_outfit("War Hippy Fatigues"))
			kingdom["Battlefield (Hippy Uniform)"].useful = true;
		if(get_property("sidequestFarmCompleted") == "none")
			kingdom["McMillicancuddy's Farm"].useful = true;
		if(get_property("sidequestNunsCompleted") == "none")
			kingdom["Themthar Hills"].useful = true;
		if(get_property("sidequestOrchardCompleted") == "none") {
			// Hide rooms if I have the scent to get someplace better. (Avoid accidental wasted turns)
			if(have_effect($effect[Filthworm Guard Stench]) < 1) {
				if(have_effect($effect[Filthworm Drone Stench]) < 1) {
					if(have_effect($effect[Filthworm Larva Stench]) < 1)
						kingdom["Orchard Hatching Chamber"].useful = true;
					kingdom["Orchard Feeding Chamber"].useful = true;
				}
				kingdom["Orchard Guards' Chamber"].useful = true;
			}
			kingdom["Orchard Queen's Chamber"].useful = true;
		}
		if(get_property("sidequestLighthouseCompleted") == "none") {
			kingdom["Sonofa Beach"].useful = true;
			if(available_amount($item[barrel of gunpowder]) >= 5)
				kingdom["Sonofa Beach"].locphp = "bigisland.php?place=lighthouse&action=pyro&pwd=x";
		}
		if(get_property("sidequestJunkyardCompleted") == "none") {
			switch(get_property("currentJunkyardLocation")) {
			case " next to that barrel with something burning in it":
			case "next to that barrel with something burning in it":
				kingdom["Junkyard: Burning Barrel"].useful = true;
				break;
			case "over where the old tires are":
				kingdom["Junkyard: Old Tires"].useful = true;
				break;
			case "near an abandoned refrigerator":
				kingdom["Junkyard: Refrigerator"].useful = true;
				break;
			case "out by that rusted-out car":
 				if(available_amount($item[molybdenum screwdriver]) == 0) {
					kingdom["Junkyard: Rusted Car"].useful = true;
					break;
				}
			case "":
			case "Yossarian":
				kingdom["Junkyard: Yossarian"].useful = true;
				break;
			}
		}
		if(get_property("sidequestArenaCompleted") == "none")
			kingdom["Mysterious Island Arena"].useful = true;
		if(get_property("hippiesDefeated") == "1000")
			kingdom["Battlefield (Frat Uniform)"].locphp = "bigisland.php?place=camp&whichcamp=1";
		if(get_property("fratboysDefeated") == "1000")
			kingdom["Battlefield (Hippy Uniform)"].locphp = "bigisland.php?place=camp&whichcamp=2";
	}

	string questL13Final= get_property("questL13Final");
	switch(questL13Final) {
	case "unstarted": break;
	case "started":
	case "step1":
		kingdom["Entrance Cavern"].useful = true;
		break;
	case "step2":
		if(questL13Final == "step2");
			kingdom["Entrance Cavern 2"].useful = true;
	case "step3":
		kingdom["Hedge Maze"].useful = true;
		break;
	case "step4":
		kingdom["Tower (Floors 1-3)"].useful = true;
		kingdom["Tower (Floors 4-6)"].useful = true;
		break;
	case "step5":
	case "step6":
	case "step7":
	case "step8":
	case "step9":
		kingdom["Tower (Top)"].useful = true;
		break;
	case "step10":
		kingdom["Prism"].useful = true;
	case "finished":
	}

	switch(get_property("questG02Whitecastle")) {
	case "started":
		kingdom["Whitey's Grove"].useful = true;
	case "step1":
	case "step2":
	case "step3":
	case "step4":
		kingdom["Road to White Citadel"].useful = true;
	case "step5":
	case "step6":
	case "finished":
	}

	switch(get_property("questG03Ego")) {
	case "unstarted":
		if(my_basestat(my_primestat()) >= 11 && my_path() != "Avatar of Boris")
			kingdom["Pre-Cyrpt Cemetary"].useful = true;
		break;
	case "started":
		kingdom["Pre-Cyrpt Cemetary"].useful = true;
	case "step1":
	case "step2":
	case "step3":
	case "step4":
	case "step5":
	case "step6":
		if(my_basestat(my_primestat()) >= 18)
			kingdom["Fernswarthy's Ruins"].useful = true;
	}
	
	switch(get_property("questG04Nemesis")) {
	case "finished":
	case "unstarted":
		break;
	case "started":
	default:
		kingdom["'Fun' House"].useful = true;
		kingdom["Nemesis Cave"].useful = true;
		kingdom["The Nemesis' Lair"].useful = true;
	}
	
	// These locations can BECOME useful locations if you accept the quest
	if(get_property("questM02Artist") == "started") {
		if(item_amount($item[Pretentious Palette]) == 0)       kingdom["Haunted Pantry"].useful = true;
		if(item_amount($item[pail of pretentious paint]) == 0) kingdom["Sleazy Back Alley"].useful = true;
		if(item_amount($item[Pretentious Paintbrush]) == 0)    kingdom["Outskirts of The Knob"].useful = true;
	}

	//Dequest Pirate's Cove
	switch(get_property("questM12Pirate")) {
	case "unstarted":
		if(need_outfit($items[eyepatch, swashbuckling pants, stuffed shoulder parrot])) {
			if(my_buffedstat(my_primestat()) >= 45)
				kingdom["Pirate's Cove"].useful = true;
			break;
		}
	case "started":
	case "step1":
	case "step2":
	case "step3":
	case "step4":
		kingdom["Barrrney's Barrr"].useful = true;
	case "step5":
		kingdom["F'c'le"].useful = true;
	case "finished":
	}

	// Check to see if special content is active
	if(have_effect($effect[Half-Astral]) > 0) {
		kingdom["Astral Mushroom (Bad Trip)"].useful = true;
		kingdom["Astral Mushroom (Great Trip)"].useful = true;
		kingdom["Astral Mushroom (Mediocre Trip)"].useful = true;
	}
	if(have_effect($effect[Absinthe-Minded]) > 0) {
		kingdom["Stately Pleasure Dome"].useful = true;
		kingdom["Mouldering Mansion"].useful = true;
		kingdom["Rogue Windmill"].useful = true;
	}
	if(have_effect($effect[Shape of...Mole!]) > 0)
		kingdom["Mt. Molehill"].useful = true;
	if(item_amount($item[empty agua de vida bottle]) > 0) {
		kingdom["Primordial Soup"].useful = true;
		kingdom["Jungles of Ancient Loathing"].useful = true;
		kingdom["Seaside Megalopolis"].useful = true;
	}
	if(have_effect($effect[Dis Abled]) > 0) {
		kingdom["Clumsiness Grove"].useful = true;
		kingdom["Maelstrom of Lovers"].useful = true;
		kingdom["Glacier of Jerks"].useful = true;
		kingdom["Alter of Dis"].useful = true;
	}
}

void populate_kingdom() {
	// Set Kingdom locations from an external file.
	if(!file_to_map(mfname+".txt",kingdom) || count(kingdom) == 0)
		if(!file_to_map("http://zachbardon.com/mafiatools/autoupdate.php?f="+mfname+"&act=getmap", kingdom) && count(kingdom) == 0)
			abort("Kingdom location data is corrupted or missing. Troublesome!");
	
	// Remove all adventuring locations that are flatly impossible for the character.
	if(knoll_available()) {
		remove kingdom["Degrassi Knoll"];
	} else {
		remove kingdom["Bugbear Pens"];
		remove kingdom["Spooky Gravy Barrow"];
	}
	if(!canadia_available()) {
		remove kingdom["Outskirts of Logging Camp"];
		remove kingdom["Camp Logging Camp"];
	}
	if(!gnomads_available())
		remove kingdom["Thugnderdome"];
	
	// Set Nemesis location for each class:
	string [class] nemesis;
		nemesis[$class[Seal Clubber]] = "Broodling Grounds";
		nemesis[$class[Turtle Tamer]] = "The Outer Compound";
		nemesis[$class[Pastamancer]] = "The Temple Portico";
		nemesis[$class[Sauceror]] = "Convention Hall Lobby";
		nemesis[$class[Disco Bandit]] = "Outside the Club";
		nemesis[$class[Accordion Thief]] = "The Barracks";
	foreach cl, loc in nemesis
		if(my_class() != cl) remove kingdom[loc];
	switch(my_class()) {
	case $class[Seal Clubber]:
		kingdom["The Nemesis' Lair"].boss = $monster[Gorgolok, the Infernal Seal];
		kingdom["The Nemesis' Lair"].bossnick = "Gorgolok";
		break;
	case $class[Turtle Tamer]:
		kingdom["The Nemesis' Lair"].boss = $monster[Stella, the Turtle Poacher];
		kingdom["The Nemesis' Lair"].bossnick = "Stella";
		break;
	case $class[Pastamancer]:
		kingdom["The Nemesis' Lair"].boss = $monster[Spaghetti Elemental];
		kingdom["The Nemesis' Lair"].bossnick = "Spaghetti&nbsp;Elemental";
		break;
	case $class[Sauceror]:
		kingdom["The Nemesis' Lair"].boss = $monster[Lumpy, the Sinister Sauceblob];
		kingdom["The Nemesis' Lair"].bossnick = "Lumpy";
		break;
	case $class[Disco Bandit]:
		kingdom["The Nemesis' Lair"].boss = $monster[The Spirit of New Wave];
		kingdom["The Nemesis' Lair"].bossnick = "Spirit of New Wave";
		break;
	case $class[Accordion Thief]:
		kingdom["The Nemesis' Lair"].boss = $monster[Somerset Lopez, Dread Mariachi];
		kingdom["The Nemesis' Lair"].bossnick = "Somerset Lopez";
		break;
	case $class[Avatar of Boris]:
		kingdom["Itznotyerzitz Mine"].boss = $monster[Mountain Man];
		kingdom["Itznotyerzitz Mine"].bossnick = "Mountain&nbsp;Man";
		break;
	}

	if(!can_interact() && available_amount($item[El Vibrato trapezoid]) < 1)
		remove kingdom["Shimmering Portal"];
	if(!have_familiar($familiar[Astral Badger]) && !can_interact() && available_amount($item[astral mushroom]) < 1
	  && have_effect($effect[Half-Astral]) < 1) {
		remove kingdom["Astral Mushroom (Bad Trip)"];
		remove kingdom["Astral Mushroom (Great Trip)"];
		remove kingdom["Astral Mushroom (Mediocre Trip)"];
	}
	if(!have_familiar($familiar[Green Pixie]) && !can_interact() && available_amount($item[absinthe]) < 1
	  && have_effect($effect[Absinthe-Minded]) < 1) {
		remove kingdom["Stately Pleasure Dome"];
		remove kingdom["Mouldering Mansion"];
		remove kingdom["Rogue Windmill"];
	}
	if(!have_familiar($familiar[Llama Lama]) && !can_interact() && available_amount($item[llama lama gong]) < 1
	  && have_effect($effect[Shape of...Mole!]) < 1)
		remove kingdom["Mt. Molehill"];
	if(!have_familiar($familiar[Baby Sandworm]) && !can_interact() && available_amount($item[agua de vida]) < 1
	  && available_amount($item[empty agua de vida bottle]) < 1) {
		remove kingdom["Primordial Soup"];
		remove kingdom["Jungles of Ancient Loathing"];
		remove kingdom["Seaside Megalopolis"];
	}
	if(!have_familiar($familiar[Blavious Kloop]) && !can_interact() && available_amount($item[devilish folio]) < 1
	  && have_effect($effect[Dis Abled]) < 1) {
		remove kingdom["Clumsiness Grove"];
		remove kingdom["Maelstrom of Lovers"];
		remove kingdom["Glacier of Jerks"];
		remove kingdom["Alter of Dis"];
	}

	if(my_level() > 5) remove kingdom["Cola Battlefield"];

	set_useful();

}

void zone_sort() {
	sort order by kingdom[value].zone;
	void bubble(int first, int last) {  // bubble sort based on moxie
		boolean swapped;
		string temp;
		repeat {
			swapped = false;
			last = last - 1;
			for k from first upto last
				if(kingdom[order[k]].level > kingdom[order[k+1]].level) {
					temp = order[k];
					order[k] = order[k+1];
					order[k+1] = temp;
					swapped = true;
				}
		} until(!swapped);
	}

	int i, j;
	i = 0;
	while(i < count(order) -1) {
		j = i;
		while(j < count(order) -1 && kingdom[order[i]].zone == kingdom[order[j+1]].zone)
			j +=1;
		if(j > i) bubble(i, j);
		i = j + 1;
	}
}

string zone_to_url(string where) {
	switch(where) {
	case "Haunted Pantry":
		if(available_amount($item[Spookyraven library key]) > 0)
			return "manor.php";
		break;
	case "Outskirts of the Knob":
		if(get_property("questL05Goblin") != "unstarted" && item_amount($item[Cobb's Knob map]) < 1)
			return "cobbsknob.php";
		break;
	case "Junkyard":
		if(get_property("warProgress") != "finished")
			return "bigisland.php?place=junkyard";
		break;
	case "McMillicancuddy's Farm":
		if(get_property("warProgress") != "finished")
			return "bigisland.php?place=farm";
		break;
	case "Sonofa Beach":
		if(get_property("warProgress") != "finished")
			return "bigisland.php?place=lighthouse";
		break;
	}
	if(kingdom[where].zonephp.contains_text("pwd=x"))
		return kingdom[where].zonephp.replace_string("pwd=x", "pwd="+my_hash());
	return kingdom[where].zonephp;
}

string loc_to_url(string where) {
	switch(where) {
	case "Haunted Wine Cellar":
		return "manor3.php";
	case "Orc Chasm":
		if(item_amount($item[bridge]) > 0)
			return "mountains.php?orcs=1&pwd="+my_hash();
		break;
	case "McMillicancuddy's Farm":
		if(get_property("warProgress") == "finished")
			return $location[McMillicancuddy's Farm].to_url();
		break;
	case "Sonofa Beach":
		if(get_property("warProgress") == "finished")
			return $location[Post-War Sonofa Beach].to_url();
		break;
	case "Junkyard":
		if(get_property("warProgress") != "finished")
			return "bigisland.php?place=junkyard";
		break;
	}
	if(kingdom[where].locphp == "")
		return kingdom[where].loc.to_url();
	if(kingdom[where].locphp.contains_text("pwd=x"))
		return kingdom[where].locphp.replace_string("pwd=x", "pwd="+my_hash());
	return kingdom[where].locphp;
}

string level_color(int ml) {
	int pl = my_buffedstat(stat_choice);
	if(stat_choice == $stat[muscle] && equipped_item($slot[weapon]) == $item[none] && equipped_item($slot[offhand]) == $item[none]
	  && have_skill($skill[master of the surprising fist]))
		pl += 20;
	if(have_skill($skill[sick pythons]))
		pl += 20;
	if(ml < 0 || ml > pl +16)
		return level4; 		// Red
	else if(ml <= pl)
		return level1; 		// Green
	else if(ml <= pl + 8)
		return level2; 		// Yellow
	return level3; 			// Orange (ml <= pl+16)
}

string print_level(int ml) {
	#return (ml > monster_level_adjustment() + 9 && ml < 10000)? to_string(ml):"--";
	return (ml > 9 && ml < 10000)? to_string(ml):"--";
}

void table_line(string where) {
	string color = level_color(kingdom[where].level);
	if(color == level1 && test_button("checkgreen")) {
		vars[where] = "true";
		fields["check"+where] = "on";
	}

	string link(string link, string label) {
		string foreground = "white";
		if(color == level1 || color == level2) foreground = "black";
		return "<a class='"+ foreground +"' href='"+link+"'>"+label+"</a>";
	}
	string link_loc(string w) {
		return link(loc_to_url(w), w);
	}
	string link_zone(string w) {
		return link(zone_to_url(w), kingdom[w].zone);
	}

	write("<tr id=\"tr"+ where +"\" style='");
	if((vars["hide_done"] == "true" && (fields contains ("check"+where) || (count(fields) == 0 && vars[where] == "true")))
	  || (!kingdom[where].useful && (kingdom[where].hide || (hide_after && kingdom[where].aftercore)
	  || (vars["ascension_advice"] == "true" && !to_boolean(get_property("kingLiberated"))) )))
		write("display:none; ");
	write(color +"'><td>");
	vars[where] = write_rcheck(vars[where], "check"+where, "");
	if(kingdom[where].bossonly)
		write("</td><td align=right>>&nbsp;</td><td>");
	else
		write("</td><td align=right>"+print_level(kingdom[where].level)+"&nbsp;</td><td>");
	write(link_loc(where)+ "</td><td>" +link_zone(where)+ "</td>");
	
	if(kingdom[where].boss != $monster[none] || kingdom[where].bossnick != "") {
		string bosscolor = level_color(kingdom[where].bosslevel);
		write("<td style='text-align:center; "+bosscolor+"'>"+print_level(kingdom[where].bosslevel)+"</td>");
		write("<td style='"+bosscolor+"'>"+kingdom[where].bossnick+"</td>");
	}
	else write("<td></td><td></td>");
	writeln("</tr>");
}

void write_locations() {
	// Set order[]
	foreach loc, where in kingdom {
		kingdom[loc] = get_level(loc);
		#if(kingdom[loc].level == 0) remove kingdom[loc];
		#else order[count(order)] = loc;
		order[count(order)] = loc;
	}

	if(vars["sort_type"] == "zone") zone_sort();
	else if(vars["sort_type"] == "loc") sort order by value;
	else sort order by kingdom[value].level;
	
	writeln("<center><table border=0 cellpadding=1>");
	write("<tr><td colspan='3'><div style='font-family:Arial,Helvetica,sans-serif;'>");
	if(stat_choice == $stat[moxie])
		 write("Minimum moxie to always evade");
	else write("Minimum muscle to always hit");
	writeln("</div></td></tr>");
	writeln("<tr><th></th><th>"+stat_choice+"</th><th>Location</th><th>Zone</th><th>"+stat_choice+"</th><th>Boss</th></tr>");
	boolean atleast_one = false;
	foreach key, where in order {
		if(test_button("uncheck")) {
			vars[where.to_string()] = "false";
			remove fields["check"+where];
		} else if(test_button("check")) {
			vars[where.to_string()] = "true";
			fields["check"+where] = "on";
		}
		table_line(where);
		atleast_one = true;
	}
	if(!atleast_one)
		write("<tr style='background-color:CC0033; color:white'><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td align=center>--</td><td>No Locations Selected</td><td></td><td align=center>---</td><td></td></tr>");
	writeln("</table></center>");
}

int write_mcd() {
	string mcd = write_select(current_mcd().to_string(), "mcd", "Set MCD: ");
	write_option(mcd, "Off", "0");
	for i from 1 to (10 + to_int(canadia_available()))
		write_option(mcd, i.to_string(), i.to_string());
	finish_select();
	return mcd.to_int();
}

void set_mcd(int mcd) {
	if(mcd != current_mcd()) {
		print("Setting MCD to "+mcd, "olive");
		change_mcd(mcd);
	}
}

void legend() {
	writeln("<table border=0 cellpadding=1>");
	writeln("<tr><td>&nbsp;</td></tr>");
	writeln("<tr><th>Legend:</th></tr>");
	if(stat_choice == $stat[moxie]) {
		writeln("<tr style='"+level1+"'><td>Safe adventuring</td></tr>");
		writeln("<tr style='"+level2+"'><td>Won't get hit much</td></tr>");
		writeln("<tr style='"+level3+"'><td>Won't always get hit</td></tr>");
		writeln("<tr style='"+level4+"'><td>Monsters will smack you up!</td></tr>");
	} else {
		writeln("<tr style='"+level1+"'><td>You smack those monsters around!</td></tr>");
		writeln("<tr style='"+level2+"'><td>You can usually hit the monster</td></tr>");
		writeln("<tr style='"+level3+"'><td>You can sometimes hit</td></tr>");
		writeln("<tr style='"+level4+"'><td>Can only hit with a critical!</td></tr>");
	}
	writeln("</table>");
}

void hide_opts() {
	write("<table border=2 rules=none frame=box cellpadding=2 align=center style='border-color:blue;'><tr><th>");
	vars["hide_done"] = write_rcheck(vars["hide_done"], "hide_done", "Hide Checked Locations");
	write("</th><td>");
	write_button("check", "Check All");
	write_button("uncheck", "Un-check All");
	write_button("checkgreen", "Check Green Locations");
	writeln("</td></tr></table>");
}

void main() {
	file_to_map(mfname+"_"+my_name()+".txt", vars);
	// First check to see if done zones are current ascension. Reset if not.
	if(vars["knownAscensions"].to_int() != my_ascensions()) {
		foreach key in vars remove vars[key];
		vars["knownAscensions"]= my_ascensions();
		vars["hide_done"] = "true";
		vars["ascension_advice"] = "true";
		vars["sort_type"] = "stat";
		map_to_file(vars, mfname+"_"+my_name()+".txt");
	}
	#version_update();
	write(check_version());
	// write_page()
	fields = form_fields();
	success = count(fields) > 0;
	writeln("<html><head></head><body><form name='relayform' method='POST' action=''>");

	writeln("<style type='text/css'>th {background-color:blue; color:white; font-family:Arial,Helvetica,sans-serif;}</style>");
	writeln("<style type='text/css'>a:link {color:#0000CD}");
	writeln("a:visited {color:#0000CD}");
	writeln("a:hover {color:red;}");
	writeln("a.black:link {color:black; text-decoration:none;}");
	writeln("a.black:visited {color:black; text-decoration:none;}");
	writeln("a.black:hover {color:red; text-decoration:underline}");
	writeln("a.white:link {color:white; text-decoration:none;}");
	writeln("a.white:visited {color:white; text-decoration:none;}");
	writeln("a.white:hover {color:FFFF99; text-decoration:underline;}</style>");
	// write_box()
	writeln("<fieldset><legend>"+title+"</legend>");
	write("<table border=0 cellpadding=1><tr><td colspan='3'>Choose a Stat: ");
	
	// Display options
	stat_choice = write_radio(stat_choice.to_string(), "stat_choice", "Check Moxie to Evade ", "moxie").to_stat();
	#write("</td><td>");
	write_radio(stat_choice.to_string(), "stat_choice", "Check Muscle to Hit ", "muscle");
	write("</td></tr><tr><td colspan='3'>Sort by: &nbsp;");
	vars["sort_type"] = write_radio(vars["sort_type"], "sort_type", "Stat &nbsp;", "stat");
	#write("</td><td>");
	write_radio(vars["sort_type"], "sort_type", "Location &nbsp;", "loc");
	#write("</td><td>");
	write_radio(vars["sort_type"], "sort_type", "Zone ", "zone");
	writeln("</td></tr><tr><td>");
	hide_after = write_rcheck(hide_after, "hide_after", "Hide Aftercore Locations");
	write("</td><td>");
	vars["ascension_advice"] = write_rcheck(vars["ascension_advice"], "hide_nonquest", "Ascension Advisor");
	write("</td></tr><tr><td colspan='3'>");
	hide_opts();
	write("</td></tr><tr><td>");
	set_mcd(write_mcd());
	write("</td><td>Currently at +"+monster_level_adjustment()+" Monster Level</td></tr><tr><td>");
	writeln("</td></tr></table>");
	writeln("</fieldset>"); 	// finish_box()
	
	writeln("<br />");
	write_button("upd", "Update Locations");
	write(" ");
	if(write_button("upquest", "Check Quest Status"))
		cli_execute("refresh quests");
	populate_kingdom();
	write_locations();
	legend();
	#Adjust done locations...
	map_to_file(vars, mfname+"_"+my_name()+".txt");
	writeln("</form></body></html>"); 	// finish_page()
}

