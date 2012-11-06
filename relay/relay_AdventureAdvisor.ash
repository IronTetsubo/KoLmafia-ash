script "AdventureAdvisor.ash";
notify Bale;
string thisver = "2.7.8"; 				// This is the script's version!
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
string [string] purpose;
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
	case $monster[Larval Filthworm]:
	case $monster[Filthworm Drone]:
	case $monster[Filthworm Royal Guard]:
	case $monster[The Queen Filthworm]:
	case $monster[Lord Spookyraven]:
	case $monster[Dr. Awkward]: return monster_attack(m) * mod;
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
boolean need_outfit(string gear) {
	foreach x,it in outfit_pieces(gear)
		if(available_amount(it) < 1) return true;
	return false;
}

void useful(string loc, string reason) {
	if(purpose contains loc)
		purpose[loc] = purpose[loc]+ ", " + reason;
	else purpose[loc] = reason;
	kingdom[loc].useful = true;
}

void useful(string loc) {useful(loc, "Quest");}

void useful(string loc, boolean need, string reason) {
	if(need) useful(loc, reason);
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
	if(!($strings[Bees Hate You, Avatar of Boris, Zombie Slayer] contains my_path()) && full_amount($item[Wand of Nagamar]) < 1) {
		if(full_amount($item[WA]) < 1 && full_amount($item[WANG]) < 1) {
			useful("Pandamonium Slums", my_level() >= 6 && full_amount($item[ruby W]) < 1, "wand of Nagamar");
			useful("Fantasy Airship", my_level() >= 10 && full_amount($item[metallic A]) < 1, "wand of Nagamar");
		}
		useful("Orc Chasm", my_level() >= 9 && availableN < 1, "wand of Nagamar");
		availableN -= 1;
		useful("Giant's Castle", my_level() >= 10 && full_amount($item[heavy D]) < 1 && full_amount($item[ND]) < 1, "wand of Nagamar");
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
			tower["see some pipes with steam shooting out of them"] = new lair("Pyramid Upper Chamber", $item[powdered organs], 11);
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
	
	void look_low(lair [string] l, string sight, string q) {
		if(l contains sight)
			useful(l[sight].where, my_level() >= l[sight].level && full_amount(l[sight].kill) < 1, l[sight].kill+q);
		else if(sight == "see what appears to be the North Pole") {
			useful("Orc Chasm", my_level() >= 9 && availableN < 1, "NG"+q);
			useful("Giant's Castle", my_level() >= 10 && full_amount($item[original G]) < 1 && full_amount($item[NG]) < 1, "NG"+q);
		} else if(sight == "a rose" && my_level() >= 10) {
			foreach key in $effect[Sugar Rush].all 
				if(full_amount(substring(key,4).to_item()) > 0) return;
			useful("Giant's Castle", "candy"+q);
		}
	}
	void look_low(lair [string] l, string sight) { look_low(l, sight, ""); }
	#void look_low(lair [string] l, string sight, boolean [string] n) { look_low(l, sight, n contains sight? "": "?"); }

	if(my_path() == "Bees Hate You") {
		useful("The Shore, Inc.", full_amount($item[packet of orchid seeds]) < 1 && full_amount($item[tropical orchid]) < 6, "orchids");
		useful("Haunted Bedroom", full_amount($item[antique hand mirror]) < 1 && get_property("lastSecondFloorUnlock").to_int() == my_ascensions(), "Kill Guy Made of Bees");
	} else {
		if(get_property("telescopeUpgrades").to_int() >= 7)
			look_low(top, get_property("telescope7"));
		else foreach sight in top
			look_low(top, sight, "?");

		if(get_property("telescopeUpgrades").to_int() >= 6)
			for x from 2 to 6
				look_low(tower, get_property("telescope"+x));
		else {
			boolean [string] need;
			if(get_property("telescopeUpgrades").to_int() > 1)
				for x from 2 to get_property("telescopeUpgrades").to_int()
					need[get_property("telescope"+x)] = true;
			foreach sight in tower
				look_low(tower, sight, need contains sight? "": "?");
			look_low(tower, "see what appears to be the North Pole", to_boolean(need["see what appears to be the North Pole"])? "": "?");
		}
		
		// If passed the entrance cavern, get out.
		if(towerDone > 1) return;

		if(get_property("telescopeUpgrades").to_int() >= 1)
			look_low(entrance, get_property("telescope1"));
		else {
			foreach sight in entrance
				look_low(entrance, sight);
			look_low(entrance, "a rose", "?");
		}
		
	}
}
	
void bounty() {
	int b = get_property("currentBountyItem").to_int();
	if(b == 2470)
		useful("Haunted Wine Cellar", "Bounty");
	else if(b != 0)
		useful(to_string(b.to_item().bounty), "Bounty");
}

void comma(buffer b, string s) {
	if(length(b) > 0)
		b.append(", ");
	b.append(s);
}

string need_items(boolean [item] list) {
	buffer need;
	foreach it in list
		if(available_amount(it) < 1)
			need.comma(to_string(it));
	return need;
}

string need_items(boolean [item] list, string done) {
	string need = need_items(list);
	return length(need) == 0? done
		: " ("+ need +")";
}

string castle_items() {
	return need_items($items[awful poetry journal, furry fur, giant needle], " (use castle map)");
}
string palindome_items() {
	return need_items($items[photograph of God, hard rock candy, ketchup hound, hard-boiled ostrich egg], " (need to shelve items)");
}
string fcle_items() {
	return need_items($items[ball polish, rigging shampoo, Mizzenmast mop], " (Have all items)");
}

string star_items() {
	buffer need;
	// All paths need a star key and star hat!
	if(item_amount($item[Richard's star key]) < 1)
		need.comma("Richard's star key");
	if(item_amount($item[star hat]) < 1)
		need.comma("star hat");
	// No starfish is needed if you are Avatar of Boris or Zombie Slayer
	if(!(have_familiar($familiar[Star Starfish]) || $strings[Avatar of Boris, Zombie Slayer] contains my_path()))
		need.comma("Star Starfish");
	// Do we need a star weapon?
	if(!(item_amount($item[star sword]) + item_amount($item[star crossbow]) + item_amount($item[star staff]) > 0
	  || $strings[Master of the Surprising Fist, Avatar of Boris] contains my_path()))
		need.comma("a star weapon");
	return to_string(need);
}

void set_useful() {
	foreach l,p in kingdom
		p.useful = false;
		
	// Spookyraven Manor
	if(get_property("lastManorUnlock").to_int() < 0 && my_ascensions() > 0) {
		// The lastManorUnlock preference is new, so some people might need to get it updated from -1 to current.
		if(visit_url("town_right.php").contains_text("manor.gif"))
			set_property("lastManorUnlock", my_ascensions());
		else
			set_property("lastManorUnlock", (my_ascensions() - 1));
	}
	if(get_property("lastManorUnlock").to_int() != my_ascensions()) {
		useful("Haunted Pantry", "Unlock Manor");
		kingdom["Haunted Pantry"].zonephp = "town_right.php";
		kingdom["Haunted Pantry"].zone = "Seaside Town";
	}
	else {
		if(item_amount($item[Spookyraven library key]) < 1)
			useful("Haunted Billiards Room", "Unlock Library");
		if((my_primestat() == $stat[muscle] || my_path() == "Bugbear Invasion") && item_amount($item[Spookyraven gallery key]) < 1)
			useful(get_property("lastGalleryUnlock").to_int() == my_ascensions()? "Haunted Conservatory"
			  : "Haunted Library", "Unlock Gallery");
		if(get_property("lastSecondFloorUnlock").to_int() != my_ascensions()) {
			useful("Haunted Library", "Unlock 2nd floor of Manor");
		} else {
			useful("Haunted Bedroom", item_amount($item[Lord Spookyraven's spectacles]) < 1, "Lord Spookyraven's spectacles");
			useful("Haunted Bedroom", item_amount($item[Spookyraven ballroom key]) < 1, "Unlock Ballroom");
			useful("Haunted Ballroom", get_property("lastQuartetAscension").to_int() != my_ascensions(), "Set Quartet song");
		}
	}

	// Quest Locations based on completion.
	if(get_property("questL03Rat") == "started")
		useful("Tavern Cellar");

	switch(get_property("questL04Bat")) {
	case "unstarted": if(my_level() < 4) break;
	case "started":
		if(numeric_modifier("stench resistance") <= 0 && !have_skill($skill[Astral Shell]) && !have_skill($skill[Elemental Saucesphere]))
			useful("Bat Hole Entryway");
	case "step1":
	case "step2":
		useful("Guano Junction");
		useful("Batrat and Ratbat Burrow");
		useful("Beanbat Chamber");
	case "step3":
		useful("Boss Bat's Lair");
	case "step4":
	case "finished":
	}

	switch(get_property("questL05Goblin")) {
	case "unstarted":
		useful("Outskirts of the Knob", item_amount($item[Knob Goblin encryption key]) < 1, "Encryption key");
		break;
	case "started":
		useful("Outskirts of the Knob"
		  , item_amount($item[Cobb's Knob map]) > 0 && item_amount($item[Knob Goblin encryption key]) < 1
		  , "encryption key");
		useful("Cobb's Knob Harem");
		useful("Cobb's Knob Barracks");
		useful("Cobb's Knob Kitchens");
		useful("Throne Room");
	}

	switch(get_property("questL06Friar")) {
	case "unstarted": if(my_level() < 6) break;
	case "started":
		if(item_amount($item[eldritch butterknife]) < 1)
			useful("Dark Elbow of the Woods");
		if(item_amount($item[box of birthday candles]) < 1)
			useful("Dark Heart of the Woods");
		if(item_amount($item[dodecagram]) < 1)
			useful("Dark Neck of the Woods");
		if(item_amount($item[eldritch butterknife]) + item_amount($item[box of birthday candles]) + item_amount($item[dodecagram]) == 3)
			useful("Deep Fat Friar's Gate", "Peform Ritual to complete Quest");
	}

	switch(get_property("questM10Azazel")) {
	case "unstarted": if(my_level() < 6) break;
	case "started":
		useful("Hey Deze Arena", "Gain Steel Organ");
		useful("Belilafs Comedy Club", "Gain Steel Organ");
		if(item_amount($item[imp air]) >=5 && item_amount($item[bus pass]) >=5)
			useful("Moaning Panda Square", "Gain Steel Organ");
	}

	switch(get_property("questL07Cyrptic")) {
	case "unstarted": if(my_level() < 7) break;
	case "started":
		if(get_property("cyrptCrannyEvilness") != "0")
			useful("Defiled Cranny");
		if(get_property("cyrptNookEvilness") != "0")
			useful("Defiled Nook");
		if(get_property("cyrptAlcoveEvilness") != "0")
			useful("Defiled Alcove");
		if(get_property("cyrptNicheEvilness") != "0")
			useful("Defiled Niche");
		useful("Haert of the Cyrpt");
		break;
	case "finished":
		if( in_hardcore() && (have_skill($skill[Advanced Saucecrafting]) && !(get_campground() contains $item[chef-in-the-box]) && available_amount($item[chef's hat]) > 0)
		  || (have_skill($skill[Advanced Cocktailcrafting]) && !(get_campground() contains $item[bartender-in-the-box]) && (available_amount($item[beer goggles]) > 0 || available_amount($item[beer lens]) > 1)) )
			useful("Post-Cyrpt Cemetary", "Create in-a-box");
	}

	switch(get_property("questL08Trapper")) {
	case "unstarted": if(my_level() < 8) break;
	case "started":
		useful("Trapper's Cabin", "Open Mine and Goatlet");
	case "step1":
		boolean ore = get_property("trapperOre").to_item().available_amount() >= 3;
		boolean cheese = available_amount($item[goat cheese]) >= 3;
		useful("Itznotyerzitz Mine", !ore, "Get "+get_property("trapperOre"));
		useful("Goatlet", !cheese, "Quest");
		if(ore && cheese)
			useful("Trapper's Cabin", "Give him cheese and ore");
		break;
	case "step2":
		useful("eXtreme Slope");
		useful("Ninja Snowmen");
		break;
	case "step3":
		useful("Ascend the Mist-Shrouded Peak");
	}

	switch(get_property("questL09Lol")) {
	case "unstarted": if(my_level() < 9) break;
	case "started":
		if(!have_outfit("Swashbuckling Getup") && available_amount($item[pirate fledges]) < 1) {
			useful("Pirate's Cove", "abridged dictionary");
			break;
		}
	case "step1":
		useful("Orc Chasm");
	}

	int count_immateria() {
		int tot;
		foreach i in $items[Tissue Paper Immateria, Tin Foil Immateria, Gauze Immateria, Plastic Wrap Immateria]
			tot += item_amount(i);
		return tot;
	}
	
	switch(get_property("questL10Garbage")) {
	case "unstarted":
		if(full_amount($item[enchanted bean]) < 1 && get_property("questL04Bat") != "unstarted")
			useful("Beanbat Chamber", "enchanted bean");
		if(my_level() < 10) break;
	case "started":
		if(item_amount($item[giant castle map]) < 1)
			useful("Fantasy Airship", item_amount($item[Tissue Paper Immateria]) < 1? "Quest": "Quest (Have "+count_immateria()+"/4 Immateria)");
		useful("Giant's Castle");
	case "finished":
		if(my_path() != "Bugbear Invasion") {
			if((in_hardcore() || my_path() == "Zombie Slayer") && item_amount($item[intragalactic rowboat]) + item_amount($item[quantum egg]) < 1)
				useful("Giant's Castle", "Unlock Hole in the Sky" + castle_items());
			string needstar = star_items();
			if(needstar != "")
				useful("Hole in the Sky", needstar);
		}
	}

	switch(get_property("questL11MacGuffin")) {
	case "unstarted": if(my_level() < 11) break;
	case "started":
		useful("Black Forest");
	case "step1":
		if(black_market_available() && item_amount($item[forged identification documents]) == 0) {
			if(my_path() == "Way of the Surprising Fist") {
				kingdom["Black Market"].boss = $monster[Wu Tang the Betrayer];
				kingdom["Black Market"].bossnick = "Wu&nbsp;Tang";
				kingdom["Black Market"].bossonly = true;
			}
			useful("Black Market", "identification documents");
		} else if(get_property("questL11MacGuffin") == "step1")
			useful("The Shore, Inc.", "MacGuffin diary");
	case "step2":
		if(black_market_available() && get_property("questL11Pyramid") == "unstarted")
			useful("Black Market", item_amount($item[can of black paint]) < 1, "can of black paint");
		break;
	}

	switch(get_property("questL11Manor")) {
	case "started":
		useful("Haunted Ballroom", "Unlock Basement");
	case "step1":
		useful("Haunted Wine Cellar");
	case "step2":
		useful("Summoning Chamber");
	case "finished":
	}

	if(my_level() >= 2) {
		if(get_property("questL02Larva") != "finished")
			useful("Spooky Forest", "Mosquito Larva");
		useful("Spooky Forest", !hidden_temple_unlocked(), "Unlock Temple");
	}
	switch(get_property("questL11Worship")) {
	case "unstarted":
		if(available_amount($item[the Nostril of the Serpent]) < 1)
			useful("Hidden Temple", "Nostril of the Serpent");
		break;
	case "started":
	case "step1":
	case "step2":
		useful("Hidden Temple");
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
			useful("Hidden City");
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
			useful("Smallish Temple");
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
			useful("Poop Deck");
			useful("Belowdecks");
		}
		kingdom["Palindome"].locphp = "plains.php";
		useful("Palindome");
		break;
	case "step2":
	case "step3":
		useful("Cobb's Knob Laboratory", "mega gem");
		if(creatable_amount($item[wet stew]) + creatable_amount($item[wet stunt nut stew])
		  + available_amount($item[wet stew]) + available_amount($item[wet stunt nut stew]) < 1)
			useful("Whitey's Grove", "wet stew");
	case "step1":
	case "step4":
		useful("Palindome", 
		  available_amount($item[mega gem])> 0? "Kill Dr. Awkward"
		  : item_amount($item[I Love Me, Vol. I]) > 0? "Need Megagem"
		  : "Quest" + palindome_items());
	case "finished":
	}

	switch(get_property("questL11Pyramid")) {
	case "started":
		useful("Unhydrated Desert");
		useful("Black Market", item_amount($item[can of black paint]) < 1, "can of black paint");
		break;
	case "step1":
	case "step2":
	case "step3":
		useful("Black Market", item_amount($item[can of black paint]) < 1, "can of black paint");
	case "step4":
	case "step5":
	case "step6":
	case "step7":
	case "step8":
	case "step9":
		useful("Oasis in the Desert");
		useful("Arid Extra-Dry Desert");
	case "step10":
	case "step11":
		// Haven't yet opened the Pyramid, so give the link to open it if possible
		foreach loc in $strings[Pyramid Upper Chamber, Pyramid Middle Chamber, Pyramid Lower Chamber] {
			kingdom[loc].locphp = "beach.php?action=woodencity";
			kingdom[loc].zonephp = "beach.php?action=woodencity";
			useful(loc, "Open Pyramid");
		}
		break;
	case "step12":
		boolean pyramidBombUsed = get_property("pyramidBombUsed").to_boolean();
		if(!pyramidBombUsed) {
			useful("Pyramid Upper Chamber");
			useful("Pyramid Middle Chamber");
		}
		useful("Pyramid Lower Chamber", pyramidBombUsed? "Kill Ed": "Quest");
	case "finished":
	}

	switch(get_property("questL12War")) {
	case "unstarted":
	case "started":
		if(need_outfit("Frat Boy Ensemble") && need_outfit("Frat Warrior Fatigues") &&
		  need_outfit("Filthy Hippy Disguise") && need_outfit("War Hippy Fatigues")) {
			useful("Frat House", "Outfit");
			useful("Hippy Camp", "Outfit");
		}
		if(my_level() < 12) break;
		if(have_outfit("Frat Warrior Fatigues") || have_outfit("Frat Boy Ensemble"))
			useful("Pre-War Hippy Camp", "Start the war");
		if(have_outfit("War Hippy Fatigues") || have_outfit("Filthy Hippy Disguise"))
			useful("Pre-War Frat House", "Start the war");
		break;
	case "step1":
		if(have_outfit("Frat Warrior Fatigues")) {
			if(get_property("hippiesDefeated") == "1000") {
				kingdom["Battlefield (Frat Uniform)"].locphp = "bigisland.php?place=camp&whichcamp=1";
				useful("Battlefield (Frat Uniform)", "Kill the Big Wisniewski!");
			} else
				useful("Battlefield (Frat Uniform)");
		}
		if(have_outfit("War Hippy Fatigues")) {
			if(get_property("fratboysDefeated") == "1000") {
				kingdom["Battlefield (Hippy Uniform)"].locphp = "bigisland.php?place=camp&whichcamp=2";
				useful("Battlefield (Hippy Uniform)", "Kill the Man!");
			} else
				useful("Battlefield (Hippy Uniform)");
		}
		if(get_property("sidequestFarmCompleted") == "none")
			useful("McMillicancuddy's Farm", "sidequest");
		if(get_property("sidequestNunsCompleted") == "none")
			useful("Themthar Hills", "sidequest");
		if(get_property("sidequestOrchardCompleted") == "none") {
			// Hide rooms if I have the scent to get someplace better. (Avoid accidental wasted turns)
			if(have_effect($effect[Filthworm Guard Stench]) < 1) {
				if(have_effect($effect[Filthworm Drone Stench]) < 1) {
					if(have_effect($effect[Filthworm Larva Stench]) < 1)
						useful("Orchard Hatching Chamber", "sidequest");
					useful("Orchard Feeding Chamber", "sidequest");
				}
				useful("Orchard Guards' Chamber", "sidequest");
			}
			useful("Orchard Queen's Chamber", "sidequest");
		}
		if(get_property("sidequestLighthouseCompleted") == "none") {
			if(available_amount($item[barrel of gunpowder]) >= 5) {
				kingdom["Sonofa Beach"].locphp = "bigisland.php?place=lighthouse&action=pyro&pwd=x";
				useful("Sonofa Beach", "turn in barrels");
			} else
				useful("Sonofa Beach", "sidequest");
		}
		if(get_property("sidequestJunkyardCompleted") == "none") {
			switch(get_property("currentJunkyardLocation")) {
			case " next to that barrel with something burning in it":
			case "next to that barrel with something burning in it":
				useful("Junkyard: Burning Barrel");
				break;
			case "over where the old tires are":
				useful("Junkyard: Old Tires");
				break;
			case "near an abandoned refrigerator":
				useful("Junkyard: Refrigerator");
				break;
			case "out by that rusted-out car":
 				if(available_amount($item[molybdenum screwdriver]) == 0) {
					useful("Junkyard: Rusted Car");
					break;
				}
			case "":
			case "Yossarian":
				useful("Junkyard: Yossarian", "check Junkyard location");
				break;
			}
		}
		if(get_property("sidequestArenaCompleted") == "none") {
			int flyeredML = get_property("flyeredML").to_int();
			if(flyeredML > 0)
				useful("Mysterious Island Arena", to_string(flyeredML/100.0)+"% Complete");
			else
				useful("Mysterious Island Arena", "sidequest");
		}
	}

	string questL13Final= get_property("questL13Final");
	switch(questL13Final) {
	case "unstarted": break;
	case "started":
	case "step1":
		useful("Entrance Cavern");
		break;
	case "step2":
		if(questL13Final == "step2");
			useful("Entrance Cavern 2");
	case "step3":
		useful("Hedge Maze");
		break;
	case "step4":
		useful("Tower (Floors 1-3)");
		useful("Tower (Floors 4-6)");
		break;
	case "step5":
	case "step6":
	case "step7":
	case "step8":
	case "step9":
		useful("Tower (Top)");
		break;
	case "step10":
		useful("Prism");
	case "finished":
	}

	switch(get_property("questG02Whitecastle")) {
	case "started":
		useful("Whitey's Grove", "Find Road to White Citadel");
	case "step1":
	case "step2":
	case "step3":
	case "step4":
		useful("Road to White Citadel", "Find White Citadel");
	case "step5":
	case "step6":
	case "finished":
	}

	// Set special location for each class:
	switch(my_class()) {
	case $class[Seal Clubber]:
		useful("Broodling Grounds", "Nemesis");
		break;
	case $class[Turtle Tamer]:
		useful("Stella's Outer Compound", "Nemesis");
		break;
	case $class[Pastamancer]:
		useful("Temple Portico", "Nemesis");
		break;
	case $class[Sauceror]:
		useful("Convention Hall Lobby", "Nemesis");
		break;
	case $class[Disco Bandit]:
		useful("Outside the Club", "Nemesis");
		break;
	case $class[Accordion Thief]:
		useful("Island Barracks", "Nemesis");
		break;
	case $class[Avatar of Boris]:
		switch(minstrel_level() - numeric_modifier("Minstrel Level")) {
		case 1.0:
			if(my_level() >= 3)
				useful("Barroom Brawl", "Clancy's Quest");
			break;
		case 2.0:
			if(get_property("questL05Goblin") != "unstarted")
				useful("Knob Shaft", "Clancy's Quest");
			break;
		case 3.0:
			if(my_level() >= 7 && available_amount($item[Clancy's Lute]) < 1 && minstrel_instrument() != $item[Clancy's Lute])
				useful("Luter's Grave", "Clancy's Lute");
			else if(get_property("questL08Trapper") == "step3" || get_property("questL08Trapper") == "finished")
					useful("Icy Peak", "Clancy's Quest");
			break;
		case 4.0:
			if(my_level() >= 11 && get_property("questL11Pyramid") != "unstarted")
				useful("Pyramid Middle Chamber", "Clancy's Quest");
		}
		break;
	}

	// Check what's needed to defeat the End Boss Zone. (Usually the Naughty Sorceress' Tower)
	int biodata(string loc) {
		if(item_amount($item[key-o-tron]) < 1) return 0;
		return get_property("biodata"+loc).to_int();
	}
	if(my_path() == "Bugbear Invasion") {
		useful("Bugbear Mothership", "Defeat the Invaders");
		// The first three zones are good place to earn a key-o-tron
		int data = biodata("WasteProcessing");
		useful("Sleazy Back Alley", data < 3, "scavenger bugbear bio-data "+ data +"/3");
		data = biodata("Medbay");
		if(data < 3 && my_level() >= 2)
			useful("Spooky Forest", "hypodermic bugbear bio-data "+ data +"/3");
		data = biodata("Sonar");
		if(data < 3 && my_level() >= 4) {
			if(numeric_modifier("stench resistance") <= 0 && !have_skill($skill[Astral Shell]) && !have_skill($skill[Elemental Saucesphere]))
				useful("Bat Hole Entryway", "batbugbear bio-data "+ data +"/3");
			useful("Guano Junction", "batbugbear bio-data "+ data +"/3");
			useful("Batrat and Ratbat Burrow", "batbugbear bio-data "+ data +"/3");
			useful("Beanbat Chamber", "batbugbear bio-data "+ data +"/3");
		}
		data = biodata("ScienceLab");
		if(data < 6 && my_level() >= 5)
			useful("Cobb's Knob Laboratory", "bugbear scientist bio-data "+ data +"/6");
		data = biodata("Morgue");
		if(data < 6 ) {
			if(get_property("questL07Cyrptic") == "unstarted")
				useful("Pre-Cyrpt Cemetary", "bugaboo bio-data "+ data +"/6");
			else if(get_property("questL07Cyrptic") == "finished")
				useful("Post-Cyrpt Cemetary", "bugaboo bio-data "+ data +"/6");
			else
				useful("Defiled Nook", "bugaboo bio-data "+ data +"/6");
		}
		data = biodata("SpecialOps");
		if(data < 6 && my_level() >= 8)
			useful("Ninja Snowmen", "Black Ops Bugbear bio-data "+ data +"/6");
		useful("Pirate's Cove", item_amount($item[flaregun]) < 1, "flaregun for Black Ops");
		data = biodata("Engineering");
		if(data < 9 && my_level() >= 10)
			useful("Fantasy Airship", "Battlesuit Bugbear Type bio-data "+ data +"/9");
		data = biodata("Navigation");
		if(data < 9 && item_amount($item[gallery key]) > 0)
			useful("Haunted Gallery", "ancient unspeakable bugbear bio-data "+ data +"/9");
		data = biodata("Galley");
		if(data < 9 && my_level() >= 12) {
			if(get_property("questL12War") == "finished") {
				if(get_property("sideDefeated") == "hippies")
					useful("Stone Age Hippy Camp", "trendy bugbear chef bio-data "+ data +"/9");
				else
					useful("Hippy Camp", "trendy bugbear chef bio-data "+ data +"/9");
			} else
				useful("Battlefield (Frat Uniform)", "trendy bugbear chef bio-data "+ data +"/9");
		}
		useful("Bugbear Bridge", item_amount($item[Jeff Goldblum larva]) > 0, "Defeat the Captain");
	} else  // Check the Tower
		telescope();

	// Need bounty location
	bounty();

	// Set quest status and leveling zone, based on class (Sea has three zones of which only 1 is relevant to the character.)
	switch(my_primestat()) {
	case $stat[muscle]:
		// Gallery quest is only relevant for muscle classes
		#kingdom["Haunted Conservatory"].useful = true;
		useful("Haunted Gallery", my_level() < 13, "Level Up");
		if(my_level() > 13 && item_amount($item[makeshift scuba gear])>0) useful("Anemone Mine", "Sea Monkies");
		break;
	case $stat[mysticality]:
		useful("Haunted Bathroom", my_level() < 13, "Level Up");
		if(my_level() > 13 && item_amount($item[makeshift scuba gear])>0) useful("Marinara Trench", "Sea Monkies");
		break;
	case $stat[moxie]:
		useful("Haunted Ballroom", my_level() < 13, "Level Up");
		if(my_level() > 13 && item_amount($item[makeshift scuba gear])>0) useful("The Dive Bar", "Sea Monkies");
	}
	
	// Low level Clan dungeon leveling!
	if(my_level() < 6)
		useful("A Maze of Sewer Tunnels", "Level Up");
	
	// Get to the Beach!
	if(item_amount($item[bitchin' meatcar]) + item_amount($item[desert bus pass]) + item_amount($item[pumpkin carriage]) < 1) {
		if(knoll_available())
			useful("General Store", "Bitchin' Meatcar");
		else useful("Degrassi Knoll", "Bitchin' Meatcar");
	} else if(item_amount($item[dingy dinghy]) < 1)
		useful("The Shore, Inc.", "Unlock Island");

	// If Bees Hate you, you will never use an item from South of the Border to beat the tower. Ignore in softcore
	// G-string is accounted for in telescope()
	if(!($strings[Bees Hate You, Bugbear Invasion] contains my_path())
	  && !gnomads_available() && in_hardcore() && item_amount($item[handsomeness potion]) < 1)
		useful("South of the Border", "handsomeness potion?");

	if(my_path() != "Bugbear Invasion" && item_amount($item[digital key]) < 1 && my_basestat(my_primestat()) >= 20) {
		if(creatable_amount($item[digital key]) < 1)
			useful("8-Bit Realm", "digital key");
		else
			useful("Crackpot Mystic's Shed", "digital key");
	} else if(have_equipped($item[continuum transfunctioner]))
		useful("8-Bit Realm", "Transfuctioner equipped");

	// Check for Daily Dungeon
	if(my_path() != "Bugbear Invasion") {
		int keys, wand;
		foreach i in $items[Boris's key, Jarlsberg's key, Sneaky Pete's key, fat loot token]
			keys += item_amount(i);
		for i from 1268 to 1272 // Check for wand!
			if(item_amount(to_item(i)) > 0) wand = i;
		if(keys + (wand > 0? 1: 0) < 3 && !get_property("dailyDungeonDone").to_boolean())
			useful("Daily Dungeon", "Daily Key");
	}
	
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
	if(my_path() != "Bugbear Invasion" && in_hardcore() && my_basestat(my_primestat()) >= 45 && need_bangs()) {
		useful("Greater-Than Sign", "need ! potions");
		useful("Dungeons of Doom", "need ! potions");
	}

	switch(get_property("questG03Ego")) {
	case "unstarted":
		#if(my_basestat(my_primestat()) >= 11 && my_path() != "Avatar of Boris" &&  get_property("questL07Cyrptic") != "finished")
		#	useful("Pre-Cyrpt Cemetary", "Wizard of Ego");
		break;
	case "started":
		useful("Pre-Cyrpt Cemetary", "Find Key to Ruins");
	case "step1":
	case "step2":
	case "step3":
	case "step4":
	case "step5":
	case "step6":
		if(my_basestat(my_primestat()) >= 18)
			useful("Fernswarthy's Ruins", "Find Dusty Book");
	}
	
	switch(get_property("questG04Nemesis")) {
	case "finished":
	case "unstarted":
		break;
	case "started":
	default:
		useful("'Fun' House", "Nemesis Quest");
		useful("Nemesis Cave", "Nemesis Quest");
		useful("The Nemesis' Lair", "Nemesis Quest");
	}
	
	// These locations can BECOME useful locations if you accept the quest
	if(get_property("questM02Artist") == "started") {
		useful("Haunted Pantry", item_amount($item[Pretentious Palette]) == 0, "Pretentious Palette");
		useful("Sleazy Back Alley", item_amount($item[pail of pretentious paint]) == 0, "Pretentious Paint");
		useful("Outskirts of The Knob", item_amount($item[Pretentious Paintbrush]) == 0, "Pretentious Paintbrush");
	}

	//Pirate's Cove Quest
	switch(get_property("questM12Pirate")) {
	case "unstarted":
		if(need_outfit("Swashbuckling Getup")) {
			if(my_buffedstat(my_primestat()) >= 45)
				useful("Pirate's Cove", "Outfit");
			break;
		}
	case "started":
		// Barrrtleby's Barrrgain Books: buy dictionary or book of insults?
		item book = my_path() == "Bees Hate You"? $item[Massive Manual of Marauder Mockery]
			: $item[The Big Book of Pirate Insults];
		string shop = "abridged dictionary";
		foreach d in $items[abridged dictionary, facsimile dictionary, dictionary]
			if(item_amount(d) + closet_amount(d) > 0) shop = "";
		if(item_amount(book) + closet_amount(book) < 1) {
			if(shop != "") shop += ", ";
			shop += to_string(book);
		}
		useful("Barrrtleby's Books", shop != "", "buy "+shop);
	case "step1":
	case "step2":
	case "step3":
	case "step4":
		useful("Barrrney's Barrr", "Unlock F'c'le");
	case "step5":
		useful("F'c'le", "Unlock Poop Deck" + fcle_items());
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
		write("</td><td align=right>>");
	else
		write("</td><td align=right>"+print_level(kingdom[where].level));
	write("&nbsp;</td><td title=\""+purpose[where]+"\">"+link_loc(where)+ "</td><td>" +link_zone(where)+ "</td>");
	
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

